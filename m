Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76475C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BD520449
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BD520449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51989 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEci4-0005nt-Gx
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 12:37:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEchB-0005QT-BO
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEchA-0008Oo-Bf
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:37:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hEchA-0008Nm-1j; Thu, 11 Apr 2019 12:37:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02373C07DE94;
	Thu, 11 Apr 2019 16:36:58 +0000 (UTC)
Received: from gondolin (ovpn-204-124.brq.redhat.com [10.40.204.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 86F301001E66;
	Thu, 11 Apr 2019 16:36:52 +0000 (UTC)
Date: Thu, 11 Apr 2019 18:36:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Message-ID: <20190411183648.34edf4dd.cohuck@redhat.com>
In-Reply-To: <72385d8c-a050-67e7-85cf-bc804f941137@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
	<20190410013434.7cea1971@oc2783563651>
	<4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
	<20190411175831.7be345f4@oc2783563651>
	<72385d8c-a050-67e7-85cf-bc804f941137@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 11 Apr 2019 16:36:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 1/6] vfio-ccw: make it safe
 to access channel programs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
	Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org,
	Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411163648.ZuYPTg1v8VY3QUB-_m0zPPGw-w4hHOPmAbxnuCchSl8@z>

On Thu, 11 Apr 2019 12:25:38 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 4/11/19 11:58 AM, Halil Pasic wrote:
> > On Wed, 10 Apr 2019 22:59:41 -0400
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> r the next release :) It would be one thing less on my plate...  
> >>>>     
> >>>
> >>> Sorry I was not able to spend any significant amount of time on this
> >>> lately.
> >>>
> >>> Gave the combined set (this + Farhans fio-ccw fixes for kernel
> >>> stacktraces v2) it a bit of smoke testing after some minor adjustments
> >>> to make it compile:
> >>>
> >>> --- a/drivers/s390/cio/vfio_ccw_ops.c
> >>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> >>> @@ -13,6 +13,7 @@
> >>>    #include <linux/vfio.h>
> >>>    #include <linux/mdev.h>
> >>>    #include <linux/nospec.h>
> >>> +#include <linux/slab.h>
> >>>    
> >>>    #include "vfio_ccw_private.h"
> >>>
> >>>      
> >>
> >> Hrm...  Taking today's master, and the two series you mention (slight
> >> adjustment to apply patch 3 of Connie's series, because part of it was
> >> split out a few weeks ago), and I don't encounter this.  Tried switching
> >> between SLUB/SLAB, but still compiles fine.  
> > 
> > Let me guess: you have CONFIG_PCI in our .config, right?
> > 
> > In arch/s390/include/asm/pci_io.h we have
> > 
> > #ifndef _ASM_S390_PCI_IO_H
> > #define _ASM_S390_PCI_IO_H
> > 
> > #ifdef CONFIG_PCI
> > 
> > #include <linux/kernel.h>
> > #include <linux/slab.h>
> > 
> > and pci_io.h comes in via
> > 
> > include/linux/vfio.h
> > include/linux/iommu.h
> > include/linux/scatterlist.h
> > arch/s390/include/asm/io.h
> > arch/s390/include/asm/pci_io.h
> > 
> > 
> > Figured it out with help from Farhan. Took me quite some time.  
> 
> That would have been useful information up front.

Indeed. It's trivial to fold that change in, though :) (Should be in
patch 4, if I see it correctly.)

