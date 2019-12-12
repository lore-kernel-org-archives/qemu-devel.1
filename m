Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E80BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324D9214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324D9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifKEb-0007fR-TH
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 03:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1ifKDe-00077n-1R
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1ifKDc-0003gQ-9r
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:53:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35838
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1ifKDc-0003bR-2i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:53:08 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBC8mNrJ052423
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 03:53:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wu1fn82gg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 03:53:04 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Thu, 12 Dec 2019 08:53:03 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Dec 2019 08:52:59 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBC8qwkS53543020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 08:52:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6DF511C054;
 Thu, 12 Dec 2019 08:52:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E7FC11C04C;
 Thu, 12 Dec 2019 08:52:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.229])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 08:52:57 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] spapr: Add NVDIMM device support
To: Igor Mammedov <imammedo@redhat.com>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107826404.27733.10134514695430511105.stgit@lep8c.aus.stglabs.ibm.com>
 <20191122043045.GD5582@umbus.fritz.box>
 <CAGZKiBo4bdTTbJ82YV92RtTqbhuj_-GRxt6GceWyPbWdr9LGFA@mail.gmail.com>
 <20191206015255.GL5031@umbus.fritz.box>
 <1c24857f-64d4-a14d-1b66-cae2113d53a2@linux.ibm.com>
 <20191211090509.1845b913@redhat.com>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Thu, 12 Dec 2019 14:22:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20191211090509.1845b913@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19121208-0008-0000-0000-000003400E7D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121208-0009-0000-0000-00004A600F09
Message-Id: <463b35ba-c35d-a251-a8ee-c65e5134cf8c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_01:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912120062
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>,
 Bharata B Rao <bharata.rao@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/11/2019 01:35 PM, Igor Mammedov wrote:
> On Wed, 11 Dec 2019 09:44:11 +0530
> Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>
>> On 12/06/2019 07:22 AM, David Gibson wrote:
>>> On Wed, Nov 27, 2019 at 09:50:54AM +0530, Bharata B Rao wrote:
>>>> On Fri, Nov 22, 2019 at 10:42 AM David Gibson
>>>> <david@gibson.dropbear.id.au> wrote:
>>>>> Ok.  A number of queries about this.
>>>>>
>>>>> 1) The PAPR spec for ibm,dynamic-memory-v2 says that the first word in
>>>>> each entry is the number of LMBs, but for NVDIMMs you use the
>>>>> not-necessarily-equal scm_block_size instead.  Does the NVDIMM
>>>>> amendment for PAPR really specify to use different block sizes for
>>>>> these cases?  (In which case that's a really stupid spec decision, but
>>>>> that wouldn't surprise me at this point).
>>>> SCM block sizes can be different from LMB sizes, but here we enforce
>>>> that SCM device size (excluding metadata) to multiple of LMB size so
>>>> that we don't end up memory range that is not aligned to LMB size.
>>> Right, but it still doesn't make sense to use scm_block_size when you
>>> create the dynamic-memory-v2 property.
>> Right, I should use LMB size here as I will be creating holes here to
>> disallow DIMMs
>> to claim those LMBs marking them INVALID as Bharata Suggested before.
>>
>>>    As far as the thing
>>> interpreting that goes, it *must* be LMB size, not SCM block size.  If
>>> those are required to be the same at this point, you should use an
>>> assert().
>> SCM block size should be a multiple for LMB size, need not be equal.
>> I'll add an assert
>> for that, checking if equal. There is no benefit I see as of now having
>> higher
>> SCM block size as the bind/unbind are already done before the bind hcall.
>>
>>>>> 2) Similarly, the ibm,dynamic-memory-v2 description says that the
>>>>> memory block described by the entry has a whole batch of contiguous
>>>>> DRCs starting at the DRC index given and continuing for #LMBs DRCs.
>>>>> For NVDIMMs it appears that you just have one DRC for the whole
>>>>> NVDIMM.  Is that right?
>>>> One NVDIMM has one DRC, In our case, we need to mark the LMBs
>>>> corresponding to that address range in ibm,dynamic-memory-v2 as
>>>> reserved and invalid.
>>> Ok, that fits very weirdly with the DRC allocation for the rest of
>>> pluggable memory, but I suppose that's PAPR for you.
>>>
>>> Having these in together is very inscrutable though, and relies on a
>>> heap of non-obvious constraints about placement of DIMMs and NVDIMMs
>>> relative to each other.  I really wonder if it would be better to have
>>> a completely different address range for the NVDIMMs.
>> The backend object for both DIMM and NVDIMM are memory-backend-*
>> and they use the address from the same space. Separating it would mean
>> using/introducing different backend object. I dont think we have a
>> choice here.
> What address-space(s) are are talking about here exactly?
>  From my point of view memory-backend-* provides RAM block at
> some HVA, which shouldn't not have anything to do with how NVDIMM
> partitions and maps it to GPA.

Ah, you are right! I got confused with the HVA.

Nonetheless, I don't see a need for having vNVDIMM in different
guest physical address range as the existing code has support for marking
memory ranges distinctly for DIMM/NVDIMM.

On another note, the x86 too does it the same way. There is no separate
range defined there.

>
>
>>>>> 3) You're not setting *any* extra flags on the entry.  How is the
>>>>> guest supposed to know which are NVDIMM entries and which are regular
>>>>> DIMM entries?  AFAICT in this version the NVDIMM slots are
>>>>> indistinguishable from the unassigned hotplug memory (which makes the
>>>>> difference in LMB and DRC numbering even more troubling).
>>>> For NVDIMM case, this patch should populate the LMB set in
>>>> ibm,dynamic-memory-v2 something like below:
>>>>               elem = spapr_get_drconf_cell(size /lmb_size, addr,
>>>>                                            0, -1,
>>>> SPAPR_LMB_FLAGS_RESERVED | SPAPR_LMB_FLAGS_DRC_INVALID);
>>>>
>>>> This will ensure that the NVDIMM range will never be considered as
>>>> valid memory range for memory hotplug.
>>> Hrm.  Ok so we already have code that does that for any gaps between
>>> DIMMs.  I don't think there's actually anything that that code will do
>>> differently than the code you have for NVDIMMs, so you could just skip
>>> over the NVDIMMs here and it should do the right thing.
>>>
>>> The *interpretation* of those entries will become different: for space
>>> into which a regular DIMM is later inserted, we'll assume the DRC
>>> index given is a base and there are more DRCs following it, but for
>>> NVDIMMs we'll assume the same DRC throughout.  This is nuts, but IIUC
>>> that's what PAPR says and we can't do much about it.
>> My current patch is buggy as Bharata pointed out. The NVDIMM DRCs
>> are not to be populated here, but mark the LMB DRCs as RESERVED and INVALID
>> so that no malicious attempts to online those LMBs at those NVDIMM address
>> ranges are attempted.
>>
>>>   
>>>>> 4) AFAICT these are _present_ NVDIMMs, so why is
>>>>> SPAPR_LMB_FLAGS_ASSIGNED not set for them?  (and why is the node
>>>>> forced to -1, regardless of di->node).
>>>>>   
>>>>>>            QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
>>>>>>            nr_entries++;
>>>>>>            cur_addr = addr + size;
>>>>>> @@ -1261,6 +1273,85 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
>>>>>>        }
>>>>>>    }
>>>>>>
>>>>>> +static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
>>>>>> +{
>>>>>> +    MachineState *machine = MACHINE(spapr);
>>>>>> +    int i;
>>>>>> +
>>>>>> +    for (i = 0; i < machine->ram_slots; i++) {
>>>>>> +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
>>>>> What happens if you try to plug an NVDIMM to one of these slots, but a
>>>>> regular DIMM has already taken it?
>>>> NVDIMM hotplug won't get that occupied slot.
>>> Ok.
>>>   


