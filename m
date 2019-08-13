Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28D1C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DBF20679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DBF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxTEM-0007gr-NE
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 05:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54382)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hxTDq-0006tS-T8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hxTDp-0007Wp-Sn
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:36:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hxTDp-0007WZ-MS
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:36:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3A72C0578FA
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 09:36:04 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 823E05D71C;
 Tue, 13 Aug 2019 09:35:52 +0000 (UTC)
Date: Tue, 13 Aug 2019 11:35:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190813113550.3a782910.cohuck@redhat.com>
In-Reply-To: <20190813064549.hpcdpwjg57obdsyr@jenstp.localdomain>
References: <20190802150605.5880-1-jfreimann@redhat.com>
 <20190802150605.5880-4-jfreimann@redhat.com>
 <20190812171854.1c47ddfa.cohuck@redhat.com>
 <20190812152252.2578e60c@x1.home>
 <20190813064549.hpcdpwjg57obdsyr@jenstp.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 13 Aug 2019 09:36:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/9] vfio: unplug failover primary device
 before migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>, laine@redhat.com,
 ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Aug 2019 08:45:49 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> On Mon, Aug 12, 2019 at 03:22:52PM -0600, Alex Williamson wrote:
> >On Mon, 12 Aug 2019 17:18:54 +0200
> >Cornelia Huck <cohuck@redhat.com> wrote:
> >  
> >> On Fri,  2 Aug 2019 17:05:59 +0200
> >> Jens Freimann <jfreimann@redhat.com> wrote:
> >>  
> >> > As usual block all vfio-pci devices from being migrated, but make an
> >> > exception for failover primary devices. This is achieved by setting
> >> > unmigratable to 0 but also add a migration blocker for all vfio-pci
> >> > devices except failover primary devices. These will be unplugged before
> >> > migration happens by the migration handler of the corresponding
> >> > virtio-net standby device.
> >> >
> >> > Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> >> > ---
> >> >  hw/vfio/pci.c | 24 +++++++++++++++++++++++-
> >> >  hw/vfio/pci.h |  1 +
> >> >  2 files changed, 24 insertions(+), 1 deletion(-)

> >> This patch interacts with support for vfio migration (last posted in
> >> <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>, I've not seen
> >> a later version yet.)
> >>
> >> With that, we'd have three cases to consider:
> >> 1) device is a failover primary
> >> 2) device has a migration region
> >> 3) none of the above
> >>
> >> Can 1) and 2) happen simultaneously? If yes, what should take
> >> precedence?  
> >
> >Great questions.  I would assume that a user specifying this option
> >intends the behavior here regardless of the device's support for
> >migration, which could be made more clear and easier to test by adding
> >this option to other, otherwise migratable, QEMU NICs.  
> 
> I agree and think it makes sense that if a user intentionally marks a
> device as a primary device of a failover pair then it should override
> the use of an existing migration region of the device.

Yes, that makes sense to me as well.

