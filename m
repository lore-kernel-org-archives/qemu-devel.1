Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21B8C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C1520700
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C1520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCIiu-0001Kp-Np
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 02:53:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@linux.ibm.com>) id 1hCH8f-0007o5-32
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@linux.ibm.com>) id 1hCH1u-00016w-VE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:04:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aik@linux.ibm.com>) id 1hCH1u-0000YB-D8
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:04:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x354xY7f048828
	for <qemu-devel@nongnu.org>; Fri, 5 Apr 2019 01:04:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rny4qk01m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 01:04:35 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aik@linux.ibm.com>;
	Fri, 5 Apr 2019 06:04:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 5 Apr 2019 06:04:30 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3554TID45220090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 5 Apr 2019 05:04:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82C01AE04D;
	Fri,  5 Apr 2019 05:04:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 389ADAE05F;
	Fri,  5 Apr 2019 05:04:29 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2019 05:04:29 +0000 (GMT)
Received: from [10.61.2.175] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CB1F9A00D1;
	Fri,  5 Apr 2019 16:04:27 +1100 (AEDT)
To: David Gibson <david@gibson.dropbear.id.au>,
	Aravinda Prasad <aravinda@linux.vnet.ibm.com>
References: <155323635511.18748.18133954505098138975.stgit@aravinda>
	<155323643836.18748.13006461397179281455.stgit@aravinda>
	<20190325062256.GO29295@umbus>
	<1fdde5df-408a-f81d-d9ac-eb9636324b54@linux.vnet.ibm.com>
	<20190404231707.GB25513@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@linux.ibm.com>
Date: Fri, 5 Apr 2019 16:04:27 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404231707.GB25513@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040505-4275-0000-0000-000003247D55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040505-4276-0000-0000-000038338B8E
Message-Id: <cd08ddbc-d289-04a5-c9ae-d7618fc22308@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-05_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904050037
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-Mailman-Approved-At: Fri, 05 Apr 2019 02:51:02 -0400
Subject: Re: [Qemu-devel] [PATCH v7 3/6] target/ppc: Handle NMI guest exit
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, aik@au1.ibm.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405050427.yPUatZVkv25QbF7XNc1HUvkSTspS8H57aFP-zv2y2iY@z>



On 05/04/2019 10:17, David Gibson wrote:
> On Thu, Apr 04, 2019 at 02:40:45PM +0530, Aravinda Prasad wrote:
>>
>>
>> On Monday 25 March 2019 11:52 AM, David Gibson wrote:
>>> On Fri, Mar 22, 2019 at 12:03:58PM +0530, Aravinda Prasad wrote:
>>>> Memory error such as bit flips that cannot be corrected
>>>> by hardware are passed on to the kernel for handling.
>>>> If the memory address in error belongs to guest then
>>>> the guest kernel is responsible for taking suitable action.
>>>> Patch [1] enhances KVM to exit guest with exit reason
>>>> set to KVM_EXIT_NMI in such cases. This patch handles
>>>> KVM_EXIT_NMI exit.
>>>>
>>>> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
>>>>     (e20bbd3d and related commits)
>>>>
>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>> ---
>>>>  hw/ppc/spapr_events.c  |   22 ++++++++++++++++++++++
>>>>  include/hw/ppc/spapr.h |    1 +
>>>>  target/ppc/kvm.c       |   16 ++++++++++++++++
>>>>  target/ppc/kvm_ppc.h   |    2 ++
>>>>  4 files changed, 41 insertions(+)
>>>>
>>
>> [...]
>>
>>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>>>> index 2427c8e..a593448 100644
>>>> --- a/target/ppc/kvm.c
>>>> +++ b/target/ppc/kvm.c
>>>> @@ -1738,6 +1738,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>>>>          ret = 0;
>>>>          break;
>>>>  
>>>> +    case KVM_EXIT_NMI:
>>>> +        DPRINTF("handle NMI exception\n");
>>>
>>> tracepoints are generally preferred to new DPRINTFs.
>>
>> I see DPRINTFs used in all other exit reasons in this function. Do you
>> want me to change this particular exit case to tracepoints? I think it
>> is better to keep this DPRINTF as of now and change all the DPRINTFs to
>> tracepoints in a separate patch set.
> 
> Ah, good point. 

imho not. The kvm.c already knows about traces (there are two) and even
if every other trace in kvm_arch_handle_exit() is DPRINTF (enabled all
at once), having at least one which can be enabled without QEMU
recompile and separately from the others is a small but nice bonus
before someone gets rid of DPRINTF.


> Tracepoints are generally preferred, but since
> DPRINTFs are in use here, stick with that (at some point it would be
> good to change the whole file, but that's out of scope here).


-- 
Alexey Kardashevskiy
IBM OzLabs, LTC Team

e-mail: aik@linux.ibm.com


