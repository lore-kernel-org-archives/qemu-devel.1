Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382FAC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3289206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3289206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bmk-0001uA-83
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1j6bmA-0001MW-0s
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1j6bm8-0006S8-OI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:05:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1j6bm8-0006S0-KG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:05:32 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01PF4GW7136542
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:05:32 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yb00ags0t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:05:31 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Tue, 25 Feb 2020 15:05:27 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 25 Feb 2020 15:05:25 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01PF5OEq39780494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2020 15:05:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A49095204E;
 Tue, 25 Feb 2020 15:05:23 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.53.31])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5427D52065;
 Tue, 25 Feb 2020 15:05:23 +0000 (GMT)
Subject: Re: [PATCH] pc-bios/s390x: Pack ResetInfo struct
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: jjherne@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
References: <20200205182126.13010-1-jjherne@linux.ibm.com>
 <e3baa1e0-e1d3-d67c-cca9-a626d42c5489@de.ibm.com>
 <bf3f44b5-f0fe-59f4-9152-54edd8c9822e@linux.ibm.com>
 <941cc201-4c33-0ad3-ecc8-eab2709d350d@de.ibm.com>
 <91910082-ffeb-c588-7434-3de5fbfcbfa6@linux.ibm.com>
 <ab7de201-f466-b95d-50f0-e6f850eee3cd@de.ibm.com>
 <29aece69-3b53-6c46-f295-cbc4bf93ff95@linux.ibm.com>
 <3dad5712-686f-c05a-b085-d7ee4c389b3c@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Tue, 25 Feb 2020 16:05:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3dad5712-686f-c05a-b085-d7ee4c389b3c@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022515-0016-0000-0000-000002EA28AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022515-0017-0000-0000-0000334D54A3
Message-Id: <f837679c-5b79-a123-5b37-8bb04b0940c6@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-25_05:2020-02-21,
 2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=808 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250118
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 01PF4GW7136542
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 25.02.20 16:00, Christian Borntraeger wrote:
>=20
>=20
> On 25.02.20 13:58, Jason J. Herne wrote:
>> On 2/25/20 6:13 AM, Christian Borntraeger wrote:
>>>
>>>
>>> On 25.02.20 11:23, Jason J. Herne wrote:
>>>> On 2/13/20 1:24 PM, Christian Borntraeger wrote:
>>>> ...
>>>>>>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2=
ipl.c
>>>>>>> index da13c43cc0..8839226803 100644
>>>>>>> --- a/pc-bios/s390-ccw/jump2ipl.c
>>>>>>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>>>>>>> @@ -18,6 +18,7 @@
>>>>>>> =C2=A0=C2=A0=C2=A0 typedef struct ResetInfo {
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t ipl_psw;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t ipl_continue;
>>>>>>> +=C2=A0=C2=A0=C2=A0 uint32_t pad;
>>>>>>> =C2=A0=C2=A0=C2=A0 } ResetInfo;
>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 static ResetInfo save;
>>>>>>>
>>>>>>>
>>>>>>> also work? If yes, both variants are valid. Either packed or expl=
icit padding.
>>>>>>>
>>>>>>
>>>>>> I don't believe this will work. I think the problem is that we're =
overwriting too much memory when we cast address 0 as a ResetInfo and the=
n overwrite it (*current =3D save). I think we need the struct to be size=
d at 12-bytes instead of 16.
>>>>>>
>>>>>
>>>>> The idea of the code is that we _save_ the original content from ad=
dress 0 to save and _restore_ it before jumping into final code. I do not=
 yet understand why this does not work.
>>>>>
>>>>
>>>> I've found the real problem here. Legacy operating systems that expe=
ct to start
>>>> in 32-bit addressing mode can fail if we leave junk in the high halv=
es of our
>>>> 64-bit registers. This is because some instructions (LA for example)=
 are
>>>> bi-modal and operate differently depending on the machine's current =
addressing
>>>> mode.
>>>>
>>>> In the case where we pack the struct, the compiler happens to use th=
e mvc
>>>> instruction to load/store the current/save memory areas.
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *current =3D save;
>>>> =C2=A0=C2=A0 1fc:=C2=A0=C2=A0=C2=A0 e3 10 b0 a8 00 04=C2=A0=C2=A0=C2=
=A0=C2=A0 lg=C2=A0=C2=A0=C2=A0 %r1,168(%r11)
>>>> =C2=A0=C2=A0 202:=C2=A0=C2=A0=C2=A0 c0 20 00 00 00 00=C2=A0=C2=A0=C2=
=A0=C2=A0 larl=C2=A0=C2=A0=C2=A0 %r2,202 <jump_to_IPL_2+0x32>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 204: R_390_PC32DBL=C2=A0=C2=A0=C2=A0 .bss+0x2
>>>> =C2=A0=C2=A0 208:=C2=A0=C2=A0=C2=A0 d2 0b 10 00 20 00=C2=A0=C2=A0=C2=
=A0=C2=A0 mvc=C2=A0=C2=A0=C2=A0 0(12,%r1),0(%r2)
>>>>
>>>> Everything works as expected here, our legacy OS boots without issue.
>>>> However, in the case where we've packed this struct the compiler opt=
imizes the
>>>> code and uses lmg/stmg instead of mvc to copy the data:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *current =3D save;
>>>> =C2=A0=C2=A0 1fc:=C2=A0=C2=A0=C2=A0 e3 10 b0 a8 00 04=C2=A0=C2=A0=C2=
=A0=C2=A0 lg=C2=A0=C2=A0=C2=A0 %r1,168(%r11)
>>>> =C2=A0=C2=A0 202:=C2=A0=C2=A0=C2=A0 c0 20 00 00 00 00=C2=A0=C2=A0=C2=
=A0=C2=A0 larl=C2=A0=C2=A0=C2=A0 %r2,202 <jump_to_IPL_2+0x32>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 204: R_390_PC32DBL=C2=A0=C2=A0=C2=A0 .bss+0x2
>>>> =C2=A0=C2=A0 208:=C2=A0=C2=A0=C2=A0 eb 23 20 00 00 04=C2=A0=C2=A0=C2=
=A0=C2=A0 lmg=C2=A0=C2=A0=C2=A0 %r2,%r3,0(%r2)
>>>> =C2=A0=C2=A0 20e:=C2=A0=C2=A0=C2=A0 eb 23 10 00 00 24=C2=A0=C2=A0=C2=
=A0=C2=A0 stmg=C2=A0=C2=A0=C2=A0 %r2,%r3,0(%r1)
>>>>
>>>> Depending on the data being copied, the high halves of the registers=
 may contain
>>>> non-zero values. Example:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 r2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x108000080000780=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 74309395999098752
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 r3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x601001800004368=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 432627142283510632
>>>>
>>>> So, by sheer luck of the generated assembler, the patch happens to "=
fix" the
>>>> problem.=C2=A0 A real fix might be to insert inline assembler that c=
lears the high
>>>> halves of the registers before we call ipl() in jump_to_IPL_2(). Can=
 we think of
>>>> a better way to do that than 15 LLGTR instructions? :) Let me know y=
our
>>>> thoughts
>>>
>>> Does sam31 before the ipl() work?
>> asm volatile ("sam31\n");
>>
>> Inserting the above right before ipl(); does not change the outcome, t=
he guest still fails.
>>
>> This allows the guest to boot.
>>
>> asm volatile ("llgtr %r2,%r2\n"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "llgtr %r3,%r3\n");
>>
>> My guess as to why sam31 does not work: The legacy OS is eventually do=
ing a sam64 and the high halves of the registers are not subsequently cle=
ared before use. I could be wrong about this though.
>=20
> I think we should rewrite jump_to_IPL_2 is assembler as we cannot clear=
 out all registers
> with just inline assembly (we whould kill the stack and others that the=
 compiler might still want).
>=20
> Do the register clearing in there and then use something like
>=20
> static void jump_to_IPL_2(void)
> {
>     asm volatile(	....clearing...
> 			"llgf 14,8\n"
>                 	"br 14\n");
> }

maybe something like that instead.

    asm volatile(  ...clearing...
		    "llgf 14,%0\n"
                   "br 14\n"::"i" (__builtin_offsetof(ResetInfo, ipl_cont=
inue)));
 }
=20


