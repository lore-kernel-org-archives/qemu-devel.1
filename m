Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49860C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 05:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAC020843
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 05:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAC020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQPfF-0002cl-5e
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 01:07:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hQPeK-0002GC-DS
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hQPeG-0005rF-MN
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:06:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hQPeB-0005Hw-QL
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:06:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4E53KBw045137
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 01:06:26 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sfjwjg9cx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 01:06:26 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Tue, 14 May 2019 06:06:24 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
	by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 14 May 2019 06:06:21 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x4E56K8v29098010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 14 May 2019 05:06:20 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C63D1AE068;
	Tue, 14 May 2019 05:06:20 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD698AE062;
	Tue, 14 May 2019 05:06:18 +0000 (GMT)
Received: from [9.199.60.51] (unknown [9.199.60.51])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2019 05:06:18 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
	<20190513133053.4d900d4a@bahia.lan>
	<20190514000819.GA6441@umbus.fritz.box>
	<9eb7a5a6-a018-d08a-4556-26da0b6cc3ca@linux.vnet.ibm.com>
	<20190514044005.GH6441@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Tue, 14 May 2019 10:36:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190514044005.GH6441@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051405-0052-0000-0000-000003BEED9A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011095; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01203036; UDB=6.00631444;
	IPR=6.00983959; 
	MB=3.00026878; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-14 05:06:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051405-0053-0000-0000-000060E37FD2
Message-Id: <2cc48944-4ad7-6fd6-7d59-f041339fc6ec@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-14_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905140035
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 4/6] target/ppc: Build rtas
 error log upon an MCE
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
Cc: aik@au1.ibm.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tuesday 14 May 2019 10:10 AM, David Gibson wrote:
> On Tue, May 14, 2019 at 09:56:41AM +0530, Aravinda Prasad wrote:
>>
>>
>> On Tuesday 14 May 2019 05:38 AM, David Gibson wrote:
>>> On Mon, May 13, 2019 at 01:30:53PM +0200, Greg Kurz wrote:
>>>> On Mon, 22 Apr 2019 12:33:26 +0530
>>>> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
>>>>
>>>>> Upon a machine check exception (MCE) in a guest address space,
>>>>> KVM causes a guest exit to enable QEMU to build and pass the
>>>>> error to the guest in the PAPR defined rtas error log format.
>>>>>
>>>>> This patch builds the rtas error log, copies it to the rtas_addr
>>>>> and then invokes the guest registered machine check handler. The
>>>>> handler in the guest takes suitable action(s) depending on the type
>>>>> and criticality of the error. For example, if an error is
>>>>> unrecoverable memory corruption in an application inside the
>>>>> guest, then the guest kernel sends a SIGBUS to the application.
>>>>> For recoverable errors, the guest performs recovery actions and
>>>>> logs the error.
>>>>>
>>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>>> ---
>>>>>  hw/ppc/spapr.c         |    4 +
>>>>>  hw/ppc/spapr_events.c  |  245 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  include/hw/ppc/spapr.h |    4 +
>>>>>  3 files changed, 253 insertions(+)
>>>>>
>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>> index 2779efe..ffd1715 100644
>>>>> --- a/hw/ppc/spapr.c
>>>>> +++ b/hw/ppc/spapr.c
>>>>> @@ -2918,6 +2918,10 @@ static void spapr_machine_init(MachineState *machine)
>>>>>          error_report("Could not get size of LPAR rtas '%s'", filename);
>>>>>          exit(1);
>>>>>      }
>>>>> +
>>>>> +    /* Resize blob to accommodate error log. */
>>>>> +    spapr->rtas_size = spapr_get_rtas_size(spapr->rtas_size);
>>>>> +
>>>>
>>>> This is the only user for spapr_get_rtas_size(), which is trivial.
>>>> I suggest you simply open-code it here.
>>>
>>> I agree.
>>
>> Sure.
>>
>>>
>>>> But also, spapr->rtas_size is a guest visible thing, "rtas-size" prop in the
>>>> DT. Since existing machine types don't do that, I guess we should only use
>>>> the new size if cap-fwnmi-mce=on for the sake of compatibility.
>>>
>>> Yes, that's a good idea.  Changing this is very unlikely to break a
>>> guest, but it's easy to be safe here so let's do it.
>>
>> I did it like that because the rtas_blob is allocated based on rtas_size
>> in spapr_machine_init(). During spapr_machine_init() it is not know if
>> the guest calls "ibm, nmi-register". So if we want to use the new size
>> only when cap_fwnmi=on, then we have to realloc the blob in "ibm,
>> nmi-register".
> 
> What?  Just always allocate the necessary space in
> spapr_machine_init() if cap_fwnmi=on, it'll be wasted if
> ibm,nmi-register is never called, but it's not that much space so we
> don't really care.

Yes, not that much space, and ibm,nmi-register is called when the Linux
kernel boots. I guess, even though other OSes might not call
ibm,nmi-register, they do not constitute significant QEMU on Power users.

So I think, I will keep the code as is.

> 

-- 
Regards,
Aravinda


