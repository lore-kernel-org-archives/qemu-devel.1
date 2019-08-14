Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3869C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 04:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACA22064A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 04:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACA22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxl0J-00070c-Fw
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 00:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hxkzB-0006Op-TL
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 00:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hxkzA-0007il-Tn
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 00:34:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hxkz8-0007gV-Cb; Wed, 14 Aug 2019 00:34:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7E4WbaD064895; Wed, 14 Aug 2019 00:33:58 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uc9bkc2p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2019 00:33:58 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7E4VGMg031634;
 Wed, 14 Aug 2019 04:33:56 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma05wdc.us.ibm.com with ESMTP id 2u9nj63qrh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2019 04:33:56 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7E4Xu3F51511578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Aug 2019 04:33:56 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A4902805C;
 Wed, 14 Aug 2019 04:33:56 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A39728058;
 Wed, 14 Aug 2019 04:33:55 +0000 (GMT)
Received: from [9.124.31.79] (unknown [9.124.31.79])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 14 Aug 2019 04:33:55 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190719024555.18845-1-aik@ozlabs.ru>
 <ae3e5bd1-c7dd-d893-5c0e-803f4e4f2325@linux.vnet.ibm.com>
 <20190812100849.GF3947@umbus.fritz.box>
 <3722a768-c8bb-ed04-e450-b18cba8e6296@linux.vnet.ibm.com>
 <20190813141755.GN3947@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <a2edbfa3-85fe-6998-ce0c-b97898081822@linux.vnet.ibm.com>
Date: Wed, 14 Aug 2019 10:03:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190813141755.GN3947@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-14_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140041
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [GIT PULL for qemu-pseries REPOST]
 pseries: Update SLOF firmware image
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tuesday 13 August 2019 07:47 PM, David Gibson wrote:
> On Tue, Aug 13, 2019 at 01:00:24PM +0530, Aravinda Prasad wrote:
>>
>>
>> On Monday 12 August 2019 03:38 PM, David Gibson wrote:
>>> On Mon, Aug 05, 2019 at 02:14:39PM +0530, Aravinda Prasad wrote:
>>>> Alexey/David,
>>>>
>>>> With the SLOF changes, QEMU cannot resize the RTAS blob. Resizing is
>>>> required for FWNMI support which extends the RTAS blob to include an
>>>> error log upon a machine check.
>>>>
>>>> The check to valid RTAS buffer fails in the guest because the rtas-size
>>>> updated in QEMU is not reflecting in the guest.
>>>>
>>>> Any workaround for this?
>>>
>>> Well, we should still be able to do it, it just means fwnmi would need
>>> a SLOF change.  It's an inconvenience, but not really a big deal.
>>
>> Yes. Alexey and I were discussing about the following changes to SLOf:
>>
>> diff --git a/lib/libhvcall/hvcall.S b/lib/libhvcall/hvcall.S
>> index b19f6dbeff2c..880d29a29122 100644
>> --- a/lib/libhvcall/hvcall.S
>> +++ b/lib/libhvcall/hvcall.S
>> @@ -134,6 +134,7 @@ ENTRY(hv_rtas)
>>         ori     r3,r3,KVMPPC_H_RTAS@l
>>         HVCALL
>>         blr
>> +    .space 2048
>>         .globl hv_rtas_size
>>  hv_rtas_size:
>>         .long . - hv_rtas;
>>
>>
>> But this will statically reserve space for RTAS even when
>> SPAPR_CAP_FWNMI_MCE is OFF.
> 
> Sure.  We could flag that in the DT somehow, and have SLOF reserve the
> space conditionally.
> 
> Or we could just ignore it. 2 kiB is miniscule compared to our minimum
> guest size, and our current RTAS is microscopic compared to PowerVM.

I also think so, 2kiB is miniscule so we can allocate it statically.

Alexey,

Can you please include the above one line fix to SLOF?

> 
> 

-- 
Regards,
Aravinda

