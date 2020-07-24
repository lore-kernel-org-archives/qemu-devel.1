Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88421C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D612065E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D612065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz2ja-0001I1-I3
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jz2ia-0000kl-WE; Fri, 24 Jul 2020 14:46:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jz2iY-0004Nb-PV; Fri, 24 Jul 2020 14:46:52 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06OIbjEr178123; Fri, 24 Jul 2020 14:46:42 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32fb8yr3je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 14:46:42 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06OIja3q028686;
 Fri, 24 Jul 2020 18:46:41 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma05wdc.us.ibm.com with ESMTP id 32brq9ehu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 18:46:41 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06OIkfn442991964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2020 18:46:41 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56057AE05C;
 Fri, 24 Jul 2020 18:46:41 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD472AE060;
 Fri, 24 Jul 2020 18:46:40 +0000 (GMT)
Received: from [9.65.248.129] (unknown [9.65.248.129])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri, 24 Jul 2020 18:46:40 +0000 (GMT)
From: Lijun Pan <ljp@linux.vnet.ibm.com>
Message-Id: <F00F1BBC-881D-4311-9AAA-B4FEBF386DCB@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_BCC87640-53E1-4C03-AEB1-F3B20E46F4EB"
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v5 6/6] target/ppc: add vmsumudm vmsumcud instructions
Date: Fri, 24 Jul 2020 13:46:39 -0500
In-Reply-To: <ca98ae77-d5db-7e22-5cfc-fb855d79fed5@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
References: <20200724045845.89976-1-ljp@linux.ibm.com>
 <20200724045845.89976-7-ljp@linux.ibm.com>
 <ca98ae77-d5db-7e22-5cfc-fb855d79fed5@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-24_07:2020-07-24,
 2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240134
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 14:46:47
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_BCC87640-53E1-4C03-AEB1-F3B20E46F4EB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On Jul 24, 2020, at 1:00 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 7/23/20 9:58 PM, Lijun Pan wrote:
>> vmsumudm (Power ISA 3.0) - Vector Multiply-Sum Unsigned Doubleword =
Modulo
>> VA-form.
>> vmsumcud (Power ISA 3.1) - Vector Multiply-Sum & write Carry-out =
Unsigned
>> Doubleword VA-form.
>>=20
>> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
>> ---
>> v5: update instruction flag for vmsumcud.
>>    integrate into this isa3.1 patch series
>> v3: implement vmsumudm/vmsumcud through int128 functions,
>>    suggested by Richard Henderson.
>>=20
>> disas/ppc.c                         |  2 ++
>> target/ppc/helper.h                 |  4 ++-
>> target/ppc/int_helper.c             | 49 =
++++++++++++++++++++++++++++-
>> target/ppc/translate.c              |  1 -
>> target/ppc/translate/vmx-impl.inc.c | 39 ++++++++++++-----------
>> target/ppc/translate/vmx-ops.inc.c  |  2 ++
>> 6 files changed, 76 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/disas/ppc.c b/disas/ppc.c
>> index 63e97cfe1d..bd76fae4c4 100644
>> --- a/disas/ppc.c
>> +++ b/disas/ppc.c
>> @@ -2261,7 +2261,9 @@ const struct powerpc_opcode powerpc_opcodes[] =3D=
 {
>> { "vmsumshs",  VXA(4,  41), VXA_MASK,	PPCVEC,		{ VD, =
VA, VB, VC } },
>> { "vmsumubm",  VXA(4,  36), VXA_MASK,   PPCVEC,		{ VD, =
VA, VB, VC } },
>> { "vmsumuhm",  VXA(4,  38), VXA_MASK,   PPCVEC,		{ VD, =
VA, VB, VC } },
>> +{ "vmsumudm",  VXA(4,  35), VXA_MASK,   PPCVEC,         { VD, VA, =
VB, VC } },
>> { "vmsumuhs",  VXA(4,  39), VXA_MASK,   PPCVEC,		{ VD, =
VA, VB, VC } },
>> +{ "vmsumcud",  VXA(4,  23), VXA_MASK,   PPCVEC,         { VD, VA, =
VB, VC } },
>> { "vmulesb",   VX(4,  776), VX_MASK,	PPCVEC,		{ VD, VA, VB } =
},
>> { "vmulesh",   VX(4,  840), VX_MASK,	PPCVEC,		{ VD, VA, VB } =
},
>> { "vmuleub",   VX(4,  520), VX_MASK,	PPCVEC,		{ VD, VA, VB } =
},
>> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> index 70a14029ca..00a31d64bc 100644
>> --- a/target/ppc/helper.h
>> +++ b/target/ppc/helper.h
>> @@ -274,10 +274,12 @@ DEF_HELPER_3(vpkpx, void, avr, avr, avr)
>> DEF_HELPER_5(vmhaddshs, void, env, avr, avr, avr, avr)
>> DEF_HELPER_5(vmhraddshs, void, env, avr, avr, avr, avr)
>> DEF_HELPER_5(vmsumuhm, void, env, avr, avr, avr, avr)
>> +DEF_HELPER_5(vmsumudm, void, env, avr, avr, avr, avr)
>> DEF_HELPER_5(vmsumuhs, void, env, avr, avr, avr, avr)
>> DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)
>> DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)
>> -DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)
>> +DEF_HELPER_5(vmsumcud, void, env, avr, avr, avr, avr)
>> +DEF_HELPER_5(vmladduhm, void, env, avr, avr, avr, avr)
>> DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
>> DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, env)
>> DEF_HELPER_3(lvebx, void, env, avr, tl)
>> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
>> index 62b93b4568..2e919a7b8e 100644
>> --- a/target/ppc/int_helper.c
>> +++ b/target/ppc/int_helper.c
>> @@ -913,7 +913,8 @@ void helper_vmhraddshs(CPUPPCState *env, =
ppc_avr_t *r, ppc_avr_t *a,
>>     }
>> }
>>=20
>> -void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, =
ppc_avr_t *c)
>> +void helper_vmladduhm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
>> +                      ppc_avr_t *b, ppc_avr_t *c)
>=20
> Why?
>=20
>> +void helper_vmsumudm(CPUPPCState *env, ppc_avr_t *r,
>> +                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
>> +{
>=20
> ...
>=20
>> +void helper_vmsumcud(CPUPPCState *env, ppc_avr_t *r,
>> +                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
>=20
> You don't actually use env in either helper, so you shouldn't pass it =
in.
>=20
>=20

I just wanted to reuse GEN_VAFORM_PAIRED which has env passed in,=20
rather than creating a GEN_VAFORM_PAIRED_NOENV which does not have env.
I created GEN_VAFORM which includes env so that it can cover both env =
and non-env case.

I re-look at the code, and find out that GEN_**FORM** differentiate in =
env and non-env.
So I can rename current GEN_VAFORM_PAIRED (env passed in) to =
GEN_VAFORM_PAIRED_ENV,
create a new GEN_VAFORM_PAIRED (no env) to cater vmladduhm and vmsumudm
remove the env part code in GEN_VAFORM to have vmsumcud fit into.

What do you think, Richard?
=20
Lijun=

--Apple-Mail=_BCC87640-53E1-4C03-AEB1-F3B20E46F4EB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jul 24, 2020, at 1:00 PM, Richard Henderson &lt;<a =
href=3D"mailto:richard.henderson@linaro.org" =
class=3D"">richard.henderson@linaro.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">On 7/23/20 9:58 PM, Lijun Pan =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D"">vmsumudm (Power ISA 3.0) - Vector Multiply-Sum Unsigned =
Doubleword Modulo<br class=3D"">VA-form.<br class=3D"">vmsumcud (Power =
ISA 3.1) - Vector Multiply-Sum &amp; write Carry-out Unsigned<br =
class=3D"">Doubleword VA-form.<br class=3D""><br class=3D"">Signed-off-by:=
 Lijun Pan &lt;<a href=3D"mailto:ljp@linux.ibm.com" =
class=3D"">ljp@linux.ibm.com</a>&gt;<br class=3D"">---<br class=3D"">v5: =
update instruction flag for vmsumcud.<br =
class=3D"">&nbsp;&nbsp;&nbsp;integrate into this isa3.1 patch series<br =
class=3D"">v3: implement vmsumudm/vmsumcud through int128 functions,<br =
class=3D"">&nbsp;&nbsp;&nbsp;suggested by Richard Henderson.<br =
class=3D""><br class=3D"">disas/ppc.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;2 ++<br class=3D"">target/ppc/helper.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| &nbsp;4 ++-<br class=3D"">target/ppc/int_helper.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
49 ++++++++++++++++++++++++++++-<br class=3D"">target/ppc/translate.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| &nbsp;1 -<br class=3D"">target/ppc/translate/vmx-impl.inc.c | 39 =
++++++++++++-----------<br class=3D"">target/ppc/translate/vmx-ops.inc.c =
&nbsp;| &nbsp;2 ++<br class=3D"">6 files changed, 76 insertions(+), 21 =
deletions(-)<br class=3D""><br class=3D"">diff --git a/disas/ppc.c =
b/disas/ppc.c<br class=3D"">index 63e97cfe1d..bd76fae4c4 100644<br =
class=3D"">--- a/disas/ppc.c<br class=3D"">+++ b/disas/ppc.c<br =
class=3D"">@@ -2261,7 +2261,9 @@ const struct powerpc_opcode =
powerpc_opcodes[] =3D {<br class=3D"">{ "vmsumshs", &nbsp;VXA(4, =
&nbsp;41), VXA_MASK,<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>PPCVEC,<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>{ VD, VA, VB, VC } },<br class=3D"">{ "vmsumubm", =
&nbsp;VXA(4, &nbsp;36), VXA_MASK, &nbsp;&nbsp;PPCVEC,<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>{ VD, VA, =
VB, VC } },<br class=3D"">{ "vmsumuhm", &nbsp;VXA(4, &nbsp;38), =
VXA_MASK, &nbsp;&nbsp;PPCVEC,<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>{ VD, VA, VB, VC } },<br =
class=3D"">+{ "vmsumudm", &nbsp;VXA(4, &nbsp;35), VXA_MASK, =
&nbsp;&nbsp;PPCVEC, &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ =
VD, VA, VB, VC } },<br class=3D"">{ "vmsumuhs", &nbsp;VXA(4, &nbsp;39), =
VXA_MASK, &nbsp;&nbsp;PPCVEC,<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>{ VD, VA, VB, VC } },<br =
class=3D"">+{ "vmsumcud", &nbsp;VXA(4, &nbsp;23), VXA_MASK, =
&nbsp;&nbsp;PPCVEC, &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ =
VD, VA, VB, VC } },<br class=3D"">{ "vmulesb", &nbsp;&nbsp;VX(4, =
&nbsp;776), VX_MASK,<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>PPCVEC,<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>{ VD, VA, VB } },<br class=3D"">{ "vmulesh", =
&nbsp;&nbsp;VX(4, &nbsp;840), VX_MASK,<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>PPCVEC,<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>{ VD, VA, =
VB } },<br class=3D"">{ "vmuleub", &nbsp;&nbsp;VX(4, &nbsp;520), =
VX_MASK,<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>PPCVEC,<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>{ VD, VA, VB } },<br class=3D"">diff --git =
a/target/ppc/helper.h b/target/ppc/helper.h<br class=3D"">index =
70a14029ca..00a31d64bc 100644<br class=3D"">--- a/target/ppc/helper.h<br =
class=3D"">+++ b/target/ppc/helper.h<br class=3D"">@@ -274,10 +274,12 @@ =
DEF_HELPER_3(vpkpx, void, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmhaddshs, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmhraddshs, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmsumuhm, void, env, avr, avr, avr, avr)<br =
class=3D"">+DEF_HELPER_5(vmsumudm, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmsumuhs, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)<br =
class=3D"">-DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)<br =
class=3D"">+DEF_HELPER_5(vmsumcud, void, env, avr, avr, avr, avr)<br =
class=3D"">+DEF_HELPER_5(vmladduhm, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, =
i32)<br class=3D"">DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, =
env)<br class=3D"">DEF_HELPER_3(lvebx, void, env, avr, tl)<br =
class=3D"">diff --git a/target/ppc/int_helper.c =
b/target/ppc/int_helper.c<br class=3D"">index 62b93b4568..2e919a7b8e =
100644<br class=3D"">--- a/target/ppc/int_helper.c<br class=3D"">+++ =
b/target/ppc/int_helper.c<br class=3D"">@@ -913,7 +913,8 @@ void =
helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D"">}<br class=3D""><br =
class=3D"">-void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t =
*b, ppc_avr_t *c)<br class=3D"">+void helper_vmladduhm(CPUPPCState *env, =
ppc_avr_t *r, ppc_avr_t *a,<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ppc_avr_t *b, =
ppc_avr_t *c)<br class=3D""></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 14px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Why?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">+void helper_vmsumudm(CPUPPCState =
*env, ppc_avr_t *r,<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ppc_avr_t *a, ppc_avr_t =
*b, ppc_avr_t *c)<br class=3D"">+{<br class=3D""></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">...</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 14px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">+void =
helper_vmsumcud(CPUPPCState *env, ppc_avr_t *r,<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ppc_avr_t *a, ppc_avr_t =
*b, ppc_avr_t *c)<br class=3D""></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 14px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">You don't actually use env in either helper, so you shouldn't =
pass it in.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""></div></blockquote><div><br class=3D""></div><div>I =
just wanted to reuse GEN_VAFORM_PAIRED which has env passed =
in,&nbsp;</div><div>rather than creating a GEN_VAFORM_PAIRED_NOENV which =
does not have env.</div><div>I created GEN_VAFORM which includes env so =
that it can cover both env and non-env case.</div><div><br =
class=3D""></div><div>I re-look at the code, and find out that =
GEN_**FORM** differentiate in env and non-env.</div><div>So I can rename =
current GEN_VAFORM_PAIRED (env passed in) to =
GEN_VAFORM_PAIRED_ENV,</div><div>create a new GEN_VAFORM_PAIRED (no env) =
to cater vmladduhm and vmsumudm</div><div>remove the env part code in =
GEN_VAFORM to have vmsumcud fit into.</div><div><br =
class=3D""></div><div>What do you think, =
Richard?</div><div>&nbsp;</div><div>Lijun</div></div></body></html>=

--Apple-Mail=_BCC87640-53E1-4C03-AEB1-F3B20E46F4EB--


