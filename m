Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912ECC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB1B2184B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB1B2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOZK-0001Wv-Dd
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55417)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiM9L-0004iu-Qe
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiM9J-0005u8-OB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64379)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiM9J-0005sB-IK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:00:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26B3C5D688;
 Tue,  2 Jul 2019 17:00:56 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
 by smtp.corp.redhat.com (Postfix) with SMTP id 3E0A01017E3A;
 Tue,  2 Jul 2019 17:00:55 +0000 (UTC)
Date: Tue, 2 Jul 2019 13:00:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190702124823-mutt-send-email-mst@kernel.org>
References: <20190702150606.24851-1-mst@redhat.com>
 <CAFEAcA-Qcq1ZmfDO_dkh_H9-aeQVU83ceLKU1NXM3VpW8g5sPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Qcq1ZmfDO_dkh_H9-aeQVU83ceLKU1NXM3VpW8g5sPQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 02 Jul 2019 17:00:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/22] virtio, pc, pci: features, fixes,
 cleanups
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 04:56:05PM +0100, Peter Maydell wrote:
> On Tue, 2 Jul 2019 at 16:06, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 7fec76a02267598a4e437ddfdaeaeb6de09b92f3:
> >
> >   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-06-24' into staging (2019-07-01 11:28:28 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to a360cd11de5ae59db55e128fd209290c777eb177:
> >
> >   docs: avoid vhost-user-net specifics in multiqueue section (2019-07-01 10:39:35 -0400)
> >
> > ----------------------------------------------------------------
> > virtio, pc, pci: features, fixes, cleanups
> >
> > virtio-pmem support.
> > libvhost user mq support.
> > A bunch of fixes all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> > Pankaj Gupta (3):
> >       virtio-pmem: sync linux headers
> 
> Hi. This header sync doesn't look like it was a proper
> sync made with the update-headers script against some
> upstream kernel -- at least the commit message doesn't
> say what the sync was against and the fact that it only
> changes the virtio-pmem headers looks suspicious.
> 
> Can you respin with a proper header sync against upstream
> mainline, please?
> 
> thanks
> -- PMM

This isn't from mainline. We have a bit of a deadlock with linux merge
window opening soon. I think it's reasonable temporarily
and then before release either virtio-pmem gets there or I will
revert it and drop the header.

Updated the commit and re-pushed.

But if you disagree pls let me know.


-- 
MST

