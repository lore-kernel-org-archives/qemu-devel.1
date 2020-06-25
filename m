Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2467C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B498020768
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B498020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joZDG-0003zT-Vx
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 17:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1joZC8-0002aQ-FE; Thu, 25 Jun 2020 17:14:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1joZC6-0007fN-JF; Thu, 25 Jun 2020 17:14:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PL20XC104081; Thu, 25 Jun 2020 17:13:58 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vts12kga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 17:13:57 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PL66PE021536;
 Thu, 25 Jun 2020 21:13:57 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma01dal.us.ibm.com with ESMTP id 31uurutw7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 21:13:56 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05PLDrch32244038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 21:13:53 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACF7D6E04E;
 Thu, 25 Jun 2020 21:13:55 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCD646E050;
 Thu, 25 Jun 2020 21:13:54 +0000 (GMT)
Received: from [9.160.117.167] (unknown [9.160.117.167])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Jun 2020 21:13:54 +0000 (GMT)
From: Lijun Pan <ljp@linux.vnet.ibm.com>
Message-Id: <A788F4B0-3E48-4F55-9816-0387A7C5A24B@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_4328898D-CD54-42A7-A4EC-1771B91DC396"
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 4/8] target/ppc: add vmulld instruction
Date: Thu, 25 Jun 2020 16:13:54 -0500
In-Reply-To: <b97971e5-43ea-26e4-bd75-7af8d5ae992b@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-5-ljp@linux.ibm.com>
 <b97971e5-43ea-26e4-bd75-7af8d5ae992b@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-25_16:2020-06-25,
 2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250120
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 17:13:06
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_4328898D-CD54-42A7-A4EC-1771B91DC396
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jun 25, 2020, at 1:25 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 6/25/20 10:00 AM, Lijun Pan wrote:
>> vmulld: Vector Multiply Low Doubleword.
>>=20
>> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
>> ---
>> v3: use tcg_gen_gvec_mul()
>>=20
>> target/ppc/translate/vmx-impl.inc.c | 1 +
>> target/ppc/translate/vmx-ops.inc.c  | 4 ++++
>=20
> This part looks fine.
>=20
>> tcg/ppc/tcg-target.h                | 2 ++
>> tcg/ppc/tcg-target.inc.c            | 7 +++++--
>=20
> This part must be a separate patch.
>=20
>=20
>> @@ -3149,6 +3150,7 @@ static void tcg_out_vec_op(TCGContext *s, =
TCGOpcode opc,
>>     static const uint32_t
>>         add_op[4] =3D { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
>>         sub_op[4] =3D { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
>> +        mul_op[4] =3D { 0, 0, VMULUWM, VMULLD },
>>         neg_op[4] =3D { 0, 0, VNEGW, VNEGD },
>>         eq_op[4]  =3D { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
>>         ne_op[4]  =3D { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
>> @@ -3199,8 +3201,9 @@ static void tcg_out_vec_op(TCGContext *s, =
TCGOpcode opc,
>>         a1 =3D 0;
>>         break;
>>     case INDEX_op_mul_vec:
>> -        tcg_debug_assert(vece =3D=3D MO_32 && have_isa_2_07);
>> -        insn =3D VMULUWM;
>> +        tcg_debug_assert((vece =3D=3D MO_32 && have_isa_2_07) ||
>> +                         (vece =3D=3D MO_64 && have_isa_3_10));
>> +        insn =3D mul_op[vece];
>=20
> I think it would be ok to just index mul_op here, since the real isa =
check is
> to be done elsewhere.

Just keep "insn =3D mul_op[vece];"
and remove"        tcg_debug_assert((vece =3D=3D MO_32 && have_isa_2_07) =
||
                         (vece =3D=3D MO_64 && have_isa_3_10));=E2=80=9C?

>=20
> Missing a change to tcg_can_emit_vec_op to do that isa check, and =
allow
> INDEX_op_mul_vec to be used for MO_64.

something like below?
"
@@ -3016,6 +3016,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType =
type, unsigned vece)
             return -1;
         case MO_32:
             return have_isa_2_07 ? 1 : -1;
+        case MO_64:
+            return have_isa_3_10 ? 1 : -1;
         }
"

>=20
> Missing a change to tcg_target_init to test for PPC_FEATURE2_ARCH_3_1.

something like below?
@@ -3712,6 +3712,11 @@ static void tcg_target_init(TCGContext *s)
         have_isa =3D tcg_isa_3_00;
     }
 #endif
+#ifdef PPC_FEATURE2_ARCH_3_10
+    if (hwcap2 & PPC_FEATURE2_ARCH_3_10) {
+        have_isa =3D tcg_isa_3_10;
+    }
+#endif

+++ b/include/elf.h
@@ -554,6 +554,7 @@ typedef struct {
 #define PPC_FEATURE2_HTM_NOSC           0x01000000
 #define PPC_FEATURE2_ARCH_3_00          0x00800000
 #define PPC_FEATURE2_HAS_IEEE128        0x00400000
+#define PPC_FEATURE2_ARCH_3_10          0x00200000


Thanks,
Lijun=

--Apple-Mail=_4328898D-CD54-42A7-A4EC-1771B91DC396
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jun 25, 2020, at 1:25 PM, Richard Henderson &lt;<a =
href=3D"mailto:richard.henderson@linaro.org" =
class=3D"">richard.henderson@linaro.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D"">On =
6/25/20 10:00 AM, Lijun Pan wrote:<br class=3D""><blockquote type=3D"cite"=
 class=3D"">vmulld: Vector Multiply Low Doubleword.<br class=3D""><br =
class=3D"">Signed-off-by: Lijun Pan &lt;<a =
href=3D"mailto:ljp@linux.ibm.com" class=3D"">ljp@linux.ibm.com</a>&gt;<br =
class=3D"">---<br class=3D"">v3: use tcg_gen_gvec_mul()<br class=3D""><br =
class=3D""> target/ppc/translate/vmx-impl.inc.c | 1 +<br class=3D""> =
target/ppc/translate/vmx-ops.inc.c &nbsp;| 4 ++++<br =
class=3D""></blockquote><br class=3D"">This part looks fine.<br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D""> =
tcg/ppc/tcg-target.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| 2 ++<br class=3D""> tcg/ppc/tcg-target.inc.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 7 =
+++++--<br class=3D""></blockquote><br class=3D"">This part must be a =
separate patch.<br class=3D""><br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">@@ -3149,6 +3150,7 @@ static void =
tcg_out_vec_op(TCGContext *s, TCGOpcode opc,<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;static const uint32_t<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;add_op[4] =3D { VADDUBM, =
VADDUHM, VADDUWM, VADDUDM },<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sub_op[4] =3D { VSUBUBM, =
VSUBUHM, VSUBUWM, VSUBUDM },<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mul_op[4] =3D { 0, 0, VMULUWM, =
VMULLD },<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;neg_op[4] =3D { 0, 0, =
VNEGW, VNEGD },<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eq_op[4] &nbsp;=3D { =
VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ne_op[4] &nbsp;=3D { =
VCMPNEB, VCMPNEH, VCMPNEW, 0 },<br class=3D"">@@ -3199,8 +3201,9 @@ =
static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a1 =3D 0;<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;case INDEX_op_mul_vec:<br class=3D"">- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tcg_debug_assert(vece =3D=3D =
MO_32 &amp;&amp; have_isa_2_07);<br class=3D"">- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;insn =3D VMULUWM;<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tcg_debug_assert((vece =3D=3D =
MO_32 &amp;&amp; have_isa_2_07) ||<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(vec=
e =3D=3D MO_64 &amp;&amp; have_isa_3_10));<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;insn =3D mul_op[vece];<br =
class=3D""></blockquote><br class=3D"">I think it would be ok to just =
index mul_op here, since the real isa check is<br class=3D"">to be done =
elsewhere.<br class=3D""></div></div></blockquote><div><br =
class=3D""></div><div>Just keep "insn =3D mul_op[vece];"</div><div>and =
remove" &nbsp; &nbsp; &nbsp; &nbsp;tcg_debug_assert((vece =3D=3D MO_32 =
&amp;&amp; have_isa_2_07) ||</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(vece =3D=3D=
 MO_64 &amp;&amp; have_isa_3_10));=E2=80=9C?</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><div =
class=3D""><br class=3D"">Missing a change to tcg_can_emit_vec_op to do =
that isa check, and allow<br class=3D"">INDEX_op_mul_vec to be used for =
MO_64.<br class=3D""></div></div></blockquote><div><br =
class=3D""></div><div>something like below?</div><div>"</div><div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 13px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures; =
color: #38b9c7" class=3D"">@@ -3016,6 +3016,8 @@</span><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""> int =
tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned =
vece)</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 13px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; return -1;</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 13px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; case =
MO_32:</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 13px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; return have_isa_2_07 ? 1 : -1;</span></div><div style=3D"margin: =
0px; font-stretch: normal; font-size: 13px; line-height: normal; =
font-family: Menlo; color: rgb(57, 192, 38);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">+&nbsp; =
&nbsp; &nbsp; &nbsp; case MO_64:</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 13px; line-height: normal; font-family: =
Menlo; color: rgb(57, 192, 38);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">+&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return have_isa_3_10 ? 1 : =
-1;</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 13px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; =
}</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 13px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">"</span></div></div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><div =
class=3D""><br class=3D"">Missing a change to tcg_target_init to test =
for PPC_FEATURE2_ARCH_3_1.<br class=3D""></div></div></blockquote><div><br=
 class=3D""></div><div>something like below?</div><div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 13px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures; =
color: #38b9c7" class=3D"">@@ -3712,6 +3712,11 @@</span><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""> static =
void tcg_target_init(TCGContext *s)</span></div><div style=3D"margin: =
0px; font-stretch: normal; font-size: 13px; line-height: normal; =
font-family: Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; have_isa =3D =
tcg_isa_3_00;</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 13px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; }</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 13px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;#endif</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 13px; line-height: normal; font-family: =
Menlo; color: rgb(57, 192, 38);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">+#ifdef =
PPC_FEATURE2_ARCH_3_10</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 13px; line-height: normal; font-family: =
Menlo; color: rgb(57, 192, 38);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">+&nbsp; =
&nbsp; if (hwcap2 &amp; PPC_FEATURE2_ARCH_3_10) {</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 13px; =
line-height: normal; font-family: Menlo; color: rgb(57, 192, 38);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">+&nbsp; &nbsp; &nbsp; &nbsp; have_isa =3D =
tcg_isa_3_10;</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 13px; line-height: normal; font-family: Menlo; color: =
rgb(57, 192, 38);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">+&nbsp; &nbsp; }</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 13px; =
line-height: normal; font-family: Menlo; color: rgb(57, 192, 38);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">+#endif</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 13px; line-height: normal; font-family: Menlo; color: =
rgb(57, 192, 38);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D""><br class=3D""></span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 13px; =
line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures;" class=3D""><div =
style=3D"color: rgb(0, 0, 0); margin: 0px; font-stretch: normal; =
line-height: normal;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D""><b class=3D"">+++ =
b/include/elf.h</b></span></div><div style=3D"color: rgb(56, 185, 199); =
margin: 0px; font-stretch: normal; line-height: normal;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">@@ =
-554,6 +554,7 @@</span><span style=3D"font-variant-ligatures: =
no-common-ligatures; color: #000000" class=3D""> typedef struct =
{</span></div><div style=3D"color: rgb(0, 0, 0); margin: 0px; =
font-stretch: normal; line-height: normal;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;#define PPC_FEATURE2_HTM_NOSC &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 0x01000000</span></div><div style=3D"color: rgb(0, 0, 0); =
margin: 0px; font-stretch: normal; line-height: normal;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;#define PPC_FEATURE2_ARCH_3_00&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 0x00800000</span></div><div style=3D"color: rgb(0, 0, 0); =
margin: 0px; font-stretch: normal; line-height: normal;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;#define PPC_FEATURE2_HAS_IEEE128&nbsp; &nbsp; &nbsp; =
&nbsp; 0x00400000</span></div><div style=3D"color: rgb(57, 192, 38); =
margin: 0px; font-stretch: normal; line-height: normal;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">+#define =
PPC_FEATURE2_ARCH_3_10&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
0x00200000</span></div><div style=3D"color: rgb(57, 192, 38); margin: =
0px; font-stretch: normal; line-height: normal;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""><br =
class=3D""></span></div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures;" class=3D""><font color=3D"#fefefe" class=3D""><br =
class=3D""></font></span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures; background-color: =
rgb(254, 254, 254);" class=3D""><font color=3D"#000000" =
class=3D"">Thanks,</font></span></div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures; background-color: =
rgb(254, 254, 254);" class=3D""><font color=3D"#000000" =
class=3D"">Lijun</font></span></div></span></div></div></div></body></html=
>=

--Apple-Mail=_4328898D-CD54-42A7-A4EC-1771B91DC396--


