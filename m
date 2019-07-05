Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552F7C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5A520843
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5A520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjKgC-0005MY-Hg
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 05:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hjKfQ-0004uJ-1H
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hjKfO-00061A-VC
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:38:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hjKfO-00060P-Mo
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:38:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4CD285541;
 Fri,  5 Jul 2019 09:37:58 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9DE368C6B;
 Fri,  5 Jul 2019 09:37:57 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 954FE4EBC0;
 Fri,  5 Jul 2019 09:37:56 +0000 (UTC)
Date: Fri, 5 Jul 2019 05:37:56 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <910029117.39249078.1562319476227.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190704172335-mutt-send-email-mst@kernel.org>
References: <20190702150606.24851-1-mst@redhat.com>
 <CAFEAcA8ZAHK4bMMUqNU++9h3AN3arOLMcZgUStd5OP_JCEzObQ@mail.gmail.com>
 <487366787.39086160.1562238222683.JavaMail.zimbra@redhat.com>
 <20190704172335-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.94, 10.4.195.6]
Thread-Topic: virtio, pc, pci: features, fixes, cleanups
Thread-Index: W1dV3RyEtZM78igOmx5X8WhCZxzGQw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 05 Jul 2019 09:38:03 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> > > > The following changes since commit
> > > > 7fec76a02267598a4e437ddfdaeaeb6de09b92f3:
> > > >
> > > >   Merge remote-tracking branch
> > > >   'remotes/maxreitz/tags/pull-block-2019-06-24' into staging
> > > >   (2019-07-01
> > > >   11:28:28 +0100)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > > >
> > > > for you to fetch changes up to
> > > > a360cd11de5ae59db55e128fd209290c777eb177:
> > > >
> > > >   docs: avoid vhost-user-net specifics in multiqueue section
> > > >   (2019-07-01
> > > >   10:39:35 -0400)
> > > >
> > > > ----------------------------------------------------------------
> > > > virtio, pc, pci: features, fixes, cleanups
> > > >
> > > > virtio-pmem support.
> > > > libvhost user mq support.
> > > > A bunch of fixes all over the place.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > >
> > > 
> > > This fails to build on all the non-Linux platforms:
> > > 
> > > In file included from
> > > /Users/pm215/src/qemu-for-merges/hw/virtio/virtio-pmem.c:21:
> > > /Users/pm215/src/qemu-for-merges/include/standard-headers/linux/virtio_pmem.h:13:10:
> > > fatal error: 'linux/types.h' file not found
> > > #include <linux/types.h>
> > >          ^~~~~~~~~~~~~~~
> > 
> > Sorry for this.
> > Can we please apply below patch on top. I only tested this in linux
> > but I think this will solve the issue. Let me know if you want to resend
> > entire series.
> > 
> > Thank you,
> > Pankaj
> > 
> > ===================
> > 
> > From: Pankaj Gupta <pagupta@redhat.com>
> > Date: Thu, 4 Jul 2019 16:27:08 +0530
> > Subject: [PATCH] Sync header and fix non linux build issue
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  include/standard-headers/linux/virtio_pmem.h | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/standard-headers/linux/virtio_pmem.h
> > b/include/standard-headers/linux/virtio_pmem.h
> > index 7a3e2fe524..a60236f63d 100644
> > --- a/include/standard-headers/linux/virtio_pmem.h
> > +++ b/include/standard-headers/linux/virtio_pmem.h
> > @@ -10,14 +10,13 @@
> >  #ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> >  #define _UAPI_LINUX_VIRTIO_PMEM_H
> > 
> > -#include <linux/types.h>
> > -#include <linux/virtio_types.h>
> > -#include <linux/virtio_ids.h>
> > -#include <linux/virtio_config.h>
> > +#include "standard-headers/linux/virtio_types.h"
> > +#include "standard-headers/linux/virtio_ids.h"
> > +#include "standard-headers/linux/virtio_config.h"
> > 
> >  struct virtio_pmem_config {
> > -       __le64 start;
> > -       __le64 size;
> > +       uint64_t start;
> > +       uint64_t size;
> >  };
> > 
> >  #define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> 
> You need to get rid of __virtio things too.
> I fixed up, hopefully well.

o.k. Thank you Michael

Best regards,
Pankaj

> If that's not enough then I will drop pmem for now.
> 
> --
> MST
> 
> 

