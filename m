Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81299C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5398C20850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5398C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53079 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEe7v-000188-Hz
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 14:08:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1hEe77-0000WH-0K
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1hEe75-0007J9-Sg
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:07:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41840
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1hEe74-0007IC-GG
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:07:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BI4IY9108035
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 14:07:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rt95emmqr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 14:07:49 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 11 Apr 2019 19:07:47 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 11 Apr 2019 19:07:45 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3BI7hUA32374784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 11 Apr 2019 18:07:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 747595204F;
	Thu, 11 Apr 2019 18:07:43 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.111])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2FFFB52063;
	Thu, 11 Apr 2019 18:07:43 +0000 (GMT)
Date: Thu, 11 Apr 2019 20:07:42 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20190411183648.34edf4dd.cohuck@redhat.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
	<20190410013434.7cea1971@oc2783563651>
	<4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
	<20190411175831.7be345f4@oc2783563651>
	<72385d8c-a050-67e7-85cf-bc804f941137@linux.ibm.com>
	<20190411183648.34edf4dd.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041118-0020-0000-0000-0000032ED863
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041118-0021-0000-0000-000021810A5A
Message-Id: <20190411200742.19b7c476@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-11_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904110121
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
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
	kvm@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
	qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>,
	qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411180742.0ubncmYSOmQrY5STLXNuA36CDCpwRRf7jT51kvuKNJ8@z>

On Thu, 11 Apr 2019 18:36:48 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 11 Apr 2019 12:25:38 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
> > On 4/11/19 11:58 AM, Halil Pasic wrote:
> > > On Wed, 10 Apr 2019 22:59:41 -0400
> > > Eric Farman <farman@linux.ibm.com> wrote:
> > >   
> > >> r the next release :) It would be one thing less on my plate...  
> > >>>>     
> > >>>
> > >>> Sorry I was not able to spend any significant amount of time on this
> > >>> lately.
> > >>>
> > >>> Gave the combined set (this + Farhans fio-ccw fixes for kernel
> > >>> stacktraces v2) it a bit of smoke testing after some minor adjustments
> > >>> to make it compile:
> > >>>
> > >>> --- a/drivers/s390/cio/vfio_ccw_ops.c
> > >>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> > >>> @@ -13,6 +13,7 @@
> > >>>    #include <linux/vfio.h>
> > >>>    #include <linux/mdev.h>
> > >>>    #include <linux/nospec.h>
> > >>> +#include <linux/slab.h>
> > >>>    
> > >>>    #include "vfio_ccw_private.h"
> > >>>
> > >>>      
> > >>
> > >> Hrm...  Taking today's master, and the two series you mention (slight
> > >> adjustment to apply patch 3 of Connie's series, because part of it was
> > >> split out a few weeks ago), and I don't encounter this.  Tried switching
> > >> between SLUB/SLAB, but still compiles fine.  
> > > 
> > > Let me guess: you have CONFIG_PCI in our .config, right?
> > > 
> > > In arch/s390/include/asm/pci_io.h we have
> > > 
> > > #ifndef _ASM_S390_PCI_IO_H
> > > #define _ASM_S390_PCI_IO_H
> > > 
> > > #ifdef CONFIG_PCI
> > > 
> > > #include <linux/kernel.h>
> > > #include <linux/slab.h>
> > > 
> > > and pci_io.h comes in via
> > > 
> > > include/linux/vfio.h
> > > include/linux/iommu.h
> > > include/linux/scatterlist.h
> > > arch/s390/include/asm/io.h
> > > arch/s390/include/asm/pci_io.h
> > > 
> > > 
> > > Figured it out with help from Farhan. Took me quite some time.  
> > 
> > That would have been useful information up front.
> 
> Indeed. It's trivial to fold that change in, though :) (Should be in
> patch 4, if I see it correctly.)
> 

#4 vfio-ccw: add capabilities chain it is!

Cheers,
Halil


