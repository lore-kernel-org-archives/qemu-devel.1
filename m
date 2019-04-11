Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6C8C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3552133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3552133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEc7Z-0005Tf-4d
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 12:00:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1hEc6h-0005Aa-TV
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1hEc6g-000661-Ub
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:59:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1hEc6g-0005oe-Iw
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:59:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BFwbxd047440
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 11:58:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rt8ng86va-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 11:58:58 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 11 Apr 2019 16:58:37 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 11 Apr 2019 16:58:34 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3BFwXn613303906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 11 Apr 2019 15:58:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEC1CAE055;
	Thu, 11 Apr 2019 15:58:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C9EBAE053;
	Thu, 11 Apr 2019 15:58:32 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.111])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 11 Apr 2019 15:58:32 +0000 (GMT)
Date: Thu, 11 Apr 2019 17:58:31 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
In-Reply-To: <4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
	<20190410013434.7cea1971@oc2783563651>
	<4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041115-0016-0000-0000-0000026DD099
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041115-0017-0000-0000-000032CA076D
Message-Id: <20190411175831.7be345f4@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-11_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904110106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org,
	Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
	qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411155831.La3CVpdeQegnfh91ZLVlGgUh2YXY8AkQYgulaCDvYr0@z>

On Wed, 10 Apr 2019 22:59:41 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> r the next release :) It would be one thing less on my plate...
> >>  
> > 
> > Sorry I was not able to spend any significant amount of time on this
> > lately.
> > 
> > Gave the combined set (this + Farhans fio-ccw fixes for kernel
> > stacktraces v2) it a bit of smoke testing after some minor adjustments
> > to make it compile:
> > 
> > --- a/drivers/s390/cio/vfio_ccw_ops.c
> > +++ b/drivers/s390/cio/vfio_ccw_ops.c
> > @@ -13,6 +13,7 @@
> >   #include <linux/vfio.h>
> >   #include <linux/mdev.h>
> >   #include <linux/nospec.h>
> > +#include <linux/slab.h>
> >   
> >   #include "vfio_ccw_private.h"
> > 
> >   
> 
> Hrm...  Taking today's master, and the two series you mention (slight 
> adjustment to apply patch 3 of Connie's series, because part of it was 
> split out a few weeks ago), and I don't encounter this.  Tried switching 
> between SLUB/SLAB, but still compiles fine.

Let me guess: you have CONFIG_PCI in our .config, right?

In arch/s390/include/asm/pci_io.h we have

#ifndef _ASM_S390_PCI_IO_H
#define _ASM_S390_PCI_IO_H

#ifdef CONFIG_PCI

#include <linux/kernel.h>
#include <linux/slab.h>

and pci_io.h comes in via 

include/linux/vfio.h
include/linux/iommu.h
include/linux/scatterlist.h
arch/s390/include/asm/io.h
arch/s390/include/asm/pci_io.h


Figured it out with help from Farhan. Took me quite some time.

Regards,
Halil



