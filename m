Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFD7C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C63C2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C63C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51870 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEcX8-0001HR-E3
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 12:26:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hEcWL-0000qe-W5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hEcWL-0005lE-38
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:25:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1hEcWK-0005kq-Nl
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:25:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BGMXRV131551
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 12:25:46 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rt686k685-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 12:25:46 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Thu, 11 Apr 2019 17:25:44 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
	by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 11 Apr 2019 17:25:40 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
	[9.57.199.108])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x3BGPdco34275382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 11 Apr 2019 16:25:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE7C8B206B;
	Thu, 11 Apr 2019 16:25:39 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 545CEB2065;
	Thu, 11 Apr 2019 16:25:39 +0000 (GMT)
Received: from [9.80.220.2] (unknown [9.80.220.2])
	by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 11 Apr 2019 16:25:39 +0000 (GMT)
To: Halil Pasic <pasic@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
	<20190410013434.7cea1971@oc2783563651>
	<4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
	<20190411175831.7be345f4@oc2783563651>
From: Eric Farman <farman@linux.ibm.com>
Date: Thu, 11 Apr 2019 12:25:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411175831.7be345f4@oc2783563651>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041116-2213-0000-0000-00000375111A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010909; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000284; SDB=6.01187605; UDB=6.00622090;
	IPR=6.00968368; 
	MB=3.00026395; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 16:25:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041116-2214-0000-0000-00005DFC7A9E
Message-Id: <72385d8c-a050-67e7-85cf-bc804f941137@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-11_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904110109
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Message-ID: <20190411162538.jwPIDEHEemkYcshp-Ks5FjWZv4m4MHgFwm71Dgxii9E@z>



On 4/11/19 11:58 AM, Halil Pasic wrote:
> On Wed, 10 Apr 2019 22:59:41 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> r the next release :) It would be one thing less on my plate...
>>>>   
>>>
>>> Sorry I was not able to spend any significant amount of time on this
>>> lately.
>>>
>>> Gave the combined set (this + Farhans fio-ccw fixes for kernel
>>> stacktraces v2) it a bit of smoke testing after some minor adjustments
>>> to make it compile:
>>>
>>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>>> @@ -13,6 +13,7 @@
>>>    #include <linux/vfio.h>
>>>    #include <linux/mdev.h>
>>>    #include <linux/nospec.h>
>>> +#include <linux/slab.h>
>>>    
>>>    #include "vfio_ccw_private.h"
>>>
>>>    
>>
>> Hrm...  Taking today's master, and the two series you mention (slight
>> adjustment to apply patch 3 of Connie's series, because part of it was
>> split out a few weeks ago), and I don't encounter this.  Tried switching
>> between SLUB/SLAB, but still compiles fine.
> 
> Let me guess: you have CONFIG_PCI in our .config, right?
> 
> In arch/s390/include/asm/pci_io.h we have
> 
> #ifndef _ASM_S390_PCI_IO_H
> #define _ASM_S390_PCI_IO_H
> 
> #ifdef CONFIG_PCI
> 
> #include <linux/kernel.h>
> #include <linux/slab.h>
> 
> and pci_io.h comes in via
> 
> include/linux/vfio.h
> include/linux/iommu.h
> include/linux/scatterlist.h
> arch/s390/include/asm/io.h
> arch/s390/include/asm/pci_io.h
> 
> 
> Figured it out with help from Farhan. Took me quite some time.

That would have been useful information up front.

> 
> Regards,
> Halil
> 
> 


