Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F3EC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AADE52087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADE52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzlIx-0001hb-Qj
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 13:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1hzlE9-0006hJ-C4
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1hzlE5-0003k8-F1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:13:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1hzlE4-0003iG-FZ; Mon, 19 Aug 2019 13:13:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7JHB4ob004023; Mon, 19 Aug 2019 13:13:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ufwgwxsak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2019 13:13:39 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7JHBON5006072;
 Mon, 19 Aug 2019 13:13:39 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ufwgwxs9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2019 13:13:39 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7JH8hwN002308;
 Mon, 19 Aug 2019 17:13:37 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma05wdc.us.ibm.com with ESMTP id 2ue975stut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2019 17:13:37 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7JHDajH47186352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Aug 2019 17:13:37 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF4386A057;
 Mon, 19 Aug 2019 17:13:36 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 212386A051;
 Mon, 19 Aug 2019 17:13:36 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.80.202.43])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 19 Aug 2019 17:13:35 +0000 (GMT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
 <CAL1e-=jy6vggskJ26rTc8dnaqtqCB0SdfpV9p-NvKdjoBk+Vkw@mail.gmail.com>
 <0cfddc22-92ef-3067-9275-8f4f22ca9805@linaro.org>
 <CAL1e-=h=Hzfm8KZ4ebwaBsS6U=KVcReXpOPT2-vy4OeBktjWkQ@mail.gmail.com>
 <20190819062817.GA24503@umbus.fritz.box>
 <CAL1e-=j0w=OasHidP4W4ND-R3p6Ui7MS0iaj7Wk+c1tVyR09+A@mail.gmail.com>
From: Paul Clarke <pc@us.ibm.com>
Message-ID: <1b486ed4-512f-e5b3-bcd7-9385b689b1cb@us.ibm.com>
Date: Mon, 19 Aug 2019 12:13:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=j0w=OasHidP4W4ND-R3p6Ui7MS0iaj7Wk+c1tVyR09+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-19_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190181
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x7JHB4ob004023
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc: Three floating point fixes
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/19 1:44 AM, Aleksandar Markovic wrote:
> 19.08.2019. 08.30, "David Gibson" <david@gibson.dropbear.id.au> =D1=98=D0=
=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> On Sun, Aug 18, 2019 at 10:59:01PM +0200, Aleksandar Markovic wrote:
>>> 18.08.2019. 10.10, "Richard Henderson" <richard.henderson@linaro.org>=
 =D1=98=D0=B5
>>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>>>
>>>> On 8/16/19 11:59 PM, Aleksandar Markovic wrote:
>>>>>> From: "Paul A. Clarke" <pc@us.ibm.com>
>>>> ...
>>>>>>   ISA 3.0B has xscvdpspn leaving its result in word 1 of the targe=
t
>>>>> register,
>>>>>>   and mffprwz expecting its input to come from word 0 of the sourc=
e
>>>>> register.
>>>>>>   This sequence fails with QEMU, as a shift is required between
> those
>>> two
>>>>>>   instructions.  However, the hardware splats the result to both
> word 0
>>>>> and
>>>>>>   word 1 of its output register, so the shift is not necessary.
>>>>>>   Expect a future revision of the ISA to specify this behavior.
>>>>>>
>>>>>
>>>>> Hmmm... Isn't this a gcc bug (using undocumented hardware feature),
>>> given
>>>>> everything you said here?
>>>>
>>>> The key here is "expect a future revision of the ISA to specify this
>>> behavior".
>>>>
>>>> It's clearly within IBM's purview to adjust the specification to
> document
>>> a
>>>> previously undocumented hardware feature.
>>>>
>>>
>>> By no means, yes, the key is in ISA documentation. But, the impressio=
n
> that
>>> full original commit message conveys is that the main reason for chan=
ge
> is
>>> gcc behavior. If we accepted in general that gcc behavior determines
> QEMU
>>> behavior, I am afraid we would be on a very slippery slope - therefor=
e I
>>> think the commit message (and possible code comment) should, in my
> opinion,
>>> mention ISA docs as the central reason for change. Paul, is there any
>>> tentative release date of the new ISA specification?
>>
>> It's not really a question of gcc behaviour, it's a question of actual
>> cpu behaviour versus ISA document.  Which one qemu should follow is
>> somewhat debatable, but it sounds here like the ISA will be updated to
>> match the cpu, which weights it heavily in favour of mimicing the
>> actual cpu.
>>
>=20
> This sounds right to me.

Thanks for the reviews and great discussion.

While not yet part of a published version of the ISA, I did find the beha=
vior documented in the User's Manuals for the POWER8 and POWER9 processor=
s:

https://www-355.ibm.com/systems/power/openpower/
"Public Documents"
- "POWER9 Processor User's Manual"
- "POWER8 Processor User's Manual for the SCM"

POWER9 Processor User's Manual=20
4. Power Architecture Compliance
4.3 Floating-Point Processor (FP, VMX, and VSX)
4.3.7 Floating-Point Invalid Forms and Undefined Conditions

POWER8 Processor User's Manual for the Single-Chip Module
3. Power Architecture Compliance
3.2 Floating-Point Processor (FP, VMX, and VSX)
3.2.9 Floating-Point Invalid Forms and Undefined Conditions

In a bullet:
- VSX scalar convert from double-precision to single-precision (xscvdpsp,=
 xscvdpspn).
VSR[32:63] is set to VSR[0:31].

I have not confirmed when the new revision of the ISA will be published, =
but it's on somebody's "to do" list.

I will respin the patch as 3 independent patches, and include a reference=
 to the above documents for the change under discussion here.  (The other=
 two changes may take a bit more time, because like David, I find the FPU=
 emulation code cryptic.  :-/  )

These issues were found while running Glibc's test suite for "math", and =
there are still a *LOT* of QEMU-only FAILs, so I may be back again with s=
uggested fixes or questions.  :-)

PC

