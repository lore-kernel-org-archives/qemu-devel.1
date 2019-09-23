Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60B4C432C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9562205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9562205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXee-0007lV-HO
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iCXTt-0006cr-NJ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iCXTs-0006w8-Lz
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:10:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iCXTq-0006ux-9V; Mon, 23 Sep 2019 19:10:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D46918C8902;
 Mon, 23 Sep 2019 23:10:53 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 882135C1B5;
 Mon, 23 Sep 2019 23:10:44 +0000 (UTC)
Date: Mon, 23 Sep 2019 17:10:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 1/2] vfio: Turn the container error into an Error handle
Message-ID: <20190923171043.4de13820@x1.home>
In-Reply-To: <765755f6-4447-9322-d276-567d844ed50c@redhat.com>
References: <20190923065552.10602-1-eric.auger@redhat.com>
 <20190923065552.10602-2-eric.auger@redhat.com>
 <20190923075145.GA12806@xz-x1>
 <765755f6-4447-9322-d276-567d844ed50c@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 23 Sep 2019 23:10:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, mst@redhat.com, aik@ozlabs.ru,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 pbonzini@redhat.com, david@gibson.dropbear.id.au, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 13:43:08 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> On 9/23/19 9:51 AM, Peter Xu wrote:
> > On Mon, Sep 23, 2019 at 08:55:51AM +0200, Eric Auger wrote:  
> >> @@ -1308,9 +1319,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> >>                                       &address_space_memory);
> >>              if (container->error) {
> >>                  memory_listener_unregister(&container->prereg_listener);
> >> -                ret = container->error;
> >> -                error_setg(errp,
> >> -                    "RAM memory listener initialization failed for container");
> >> +                ret = -1;
> >> +                error_propagate_prepend(errp, container->error,
> >> +                    "RAM memory listener initialization failed: ");  
> > 
> > (I saw that we've got plenty of prepended prefixes for an error
> >  messages.  For me I'll disgard quite a few of them because the errors
> >  will directly be delivered to the top level user, but this might be
> >  too personal as a comment)  
> That's true we have a lot of prefix messages.
> 
> The output message now is:
> 
> "vfio 0000:89:00.0: failed
> to setup container for group 2: memory listener initialization failed:
> Region smmuv3-iommu-memory-region-0-6: device 01.00.0 requires iommu MAP
> notifier which is not currently supported"
> 
> Alex, any opinion?

Peter, I don't really understand what the comment is here.  Is it the
number of prepends on the error message?  I don't really have an
opinion on that so long as the end message makes sense.  Seems like if
we're familiar with the error generation it helps to unwind the
context.  Thanks,

Alex

