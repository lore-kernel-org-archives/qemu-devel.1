Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1212C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 05:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED2B20862
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 05:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED2B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50995 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ35d-0005RL-DI
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 01:01:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hQ34Z-0004ik-Bx
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hQ34Y-0001BZ-7M
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:00:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hQ34X-0001Aj-UO
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:00:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4D4vRjf068880
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 01:00:21 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sew3p7wnu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 01:00:20 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 13 May 2019 06:00:20 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
	by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 13 May 2019 06:00:16 +0100
Received: from b03ledav001.gho.boulder.ibm.com
	(b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4D50FIq24576306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 13 May 2019 05:00:15 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 404686E054;
	Mon, 13 May 2019 05:00:15 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C6F16E058;
	Mon, 13 May 2019 05:00:13 +0000 (GMT)
Received: from [9.124.31.31] (unknown [9.124.31.31])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 13 May 2019 05:00:13 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
	<20190510064213.GK20559@umbus.fritz.box>
	<2cf9df3f-c3ea-5a36-e5fc-1a40386d1586@linux.vnet.ibm.com>
	<20190510095201.GA5030@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 13 May 2019 10:30:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190510095201.GA5030@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051305-0036-0000-0000-00000AB899EE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011091; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01202560; UDB=6.00631155;
	IPR=6.00983477; 
	MB=3.00026861; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-13 05:00:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051305-0037-0000-0000-00004BC41914
Message-Id: <8404cefd-cc74-0df4-a863-04572e827eff@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-13_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=762 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905130036
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v8 4/6] target/ppc: Build rtas error log
 upon an MCE
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



On Friday 10 May 2019 03:22 PM, David Gibson wrote:
> On Fri, May 10, 2019 at 12:35:13PM +0530, Aravinda Prasad wrote:
>>
>>
>> On Friday 10 May 2019 12:12 PM, David Gibson wrote:
>>> On Mon, Apr 22, 2019 at 12:33:26PM +0530, Aravinda Prasad wrote:

[...]

>>>> +    /* Save gpr[3] in the guest endian mode */
>>>> +    if ((*pcc->interrupts_big_endian)(cpu)) {
>>>> +        env->gpr[3] = cpu_to_be64(rtas_addr + RTAS_ERRLOG_OFFSET);
>>>
>>> I don't think this is right.  AIUI env->gpr[] are all stored in *host*
>>> endianness (for ease of doing arithmetic).
>>
>> env-gpr[3] is later used by guest to fetch the RTAS log. My guess is
>> that we will not do an endianness change of all the gprs during a switch
>> from host to guest (that will be costly).
> 
> There's no need to "change endianness".  In TCG the host needs to do
> arithmetic on the values and so they are in host endian.  With KVM the
> env values are only synchronized when we enter/exit KVM and they're
> going to registers, not memory and so have no endianness.

Ah.. ok.

> 
>> But let me cross check.
>>
>>>
>>>> +    } else {
>>>> +        env->gpr[3] = cpu_to_le64(rtas_addr + RTAS_ERRLOG_OFFSET);
>>>> +    }
>>>> +
>>>> +    env->nip = spapr->guest_machine_check_addr;
>>>> +}
>>>> +
>>>>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>>>  {
>>>>      SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>>> @@ -640,6 +881,10 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>>>          }
>>>>      }
>>>>      spapr->mc_status = cpu->vcpu_id;
>>>> +
>>>> +    spapr_mce_dispatch_elog(cpu, recovered);
>>>> +
>>>> +    return;
>>>>  }
>>>>  
>>>>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index f7204d0..03f34bf 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -661,6 +661,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>>>  #define DIAGNOSTICS_RUN_MODE_IMMEDIATE 2
>>>>  #define DIAGNOSTICS_RUN_MODE_PERIODIC  3
>>>>  
>>>> +/* Offset from rtas-base where error log is placed */
>>>> +#define RTAS_ERRLOG_OFFSET       0x25
>>>
>>> Is this offset PAPR defined, or chosen here?  Using an entirely
>>> unaliged (odd) address seems a very strange choice.
>>
>> This is not PAPR defined. I will make it 0x30. Or do you prefer any
>> other offset?
> 
> 0x30 should be fine.

ok..

> 

-- 
Regards,
Aravinda


