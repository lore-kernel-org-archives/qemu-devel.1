Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6912CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCF920786
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCF920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm9co-00009S-Ct
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 01:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jm9bY-000720-8y; Fri, 19 Jun 2020 01:30:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jm9bW-0000WD-9E; Fri, 19 Jun 2020 01:30:19 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05J53VhQ147622; Fri, 19 Jun 2020 01:30:15 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rpvr0g8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 01:30:13 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05J5TNm4011104;
 Fri, 19 Jun 2020 05:30:11 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02dal.us.ibm.com with ESMTP id 31q6c8quyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 05:30:11 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05J5U9bF22151552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2020 05:30:09 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DA7C6A057;
 Fri, 19 Jun 2020 05:30:10 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFABC6A051;
 Fri, 19 Jun 2020 05:30:09 +0000 (GMT)
Received: from [9.160.87.86] (unknown [9.160.87.86])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri, 19 Jun 2020 05:30:09 +0000 (GMT)
From: Lijun Pan <ljp@linux.vnet.ibm.com>
Message-Id: <B805D51A-00EA-4A6F-92BC-A30B7F3D2B41@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_95276640-FDA2-4A85-A869-A0319E35BA2F"
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/6] target/ppc: add vmulld instruction
Date: Fri, 19 Jun 2020 00:30:08 -0500
In-Reply-To: <4341c9e1-162f-d640-e733-d69d2f894353@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-3-ljp@linux.ibm.com>
 <4341c9e1-162f-d640-e733-d69d2f894353@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_01:2020-06-18,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 cotscore=-2147483648 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 spamscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190029
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:10:12
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_95276640-FDA2-4A85-A869-A0319E35BA2F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On Jun 18, 2020, at 6:27 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 6/12/20 9:20 PM, Lijun Pan wrote:
>> vmulld: Vector Multiply Low Doubleword.
>>=20
>> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
>> ---
>> target/ppc/helper.h                 | 1 +
>> target/ppc/int_helper.c             | 1 +
>> target/ppc/translate/vmx-impl.inc.c | 1 +
>> target/ppc/translate/vmx-ops.inc.c  | 1 +
>> 4 files changed, 4 insertions(+)
>>=20
>> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> index 2dfa1c6942..c3f087ccb3 100644
>> --- a/target/ppc/helper.h
>> +++ b/target/ppc/helper.h
>> @@ -185,6 +185,7 @@ DEF_HELPER_3(vmuloub, void, avr, avr, avr)
>> DEF_HELPER_3(vmulouh, void, avr, avr, avr)
>> DEF_HELPER_3(vmulouw, void, avr, avr, avr)
>> DEF_HELPER_3(vmuluwm, void, avr, avr, avr)
>> +DEF_HELPER_3(vmulld, void, avr, avr, avr)
>> DEF_HELPER_3(vslo, void, avr, avr, avr)
>> DEF_HELPER_3(vsro, void, avr, avr, avr)
>> DEF_HELPER_3(vsrv, void, avr, avr, avr)
>> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
>> index be53cd6f68..afbcdd05b4 100644
>> --- a/target/ppc/int_helper.c
>> +++ b/target/ppc/int_helper.c
>> @@ -533,6 +533,7 @@ void helper_vprtybq(ppc_avr_t *r, ppc_avr_t *b)
>>         }                                                             =
  \
>>     }
>> VARITH_DO(muluwm, *, u32)
>> +VARITH_DO(mulld, *, s64)
>=20
>> =46rom this implementation, I would say that both vmuluwm and vmulld =
can be
> implemented with tcg_gen_gvec_mul().
>=20
> I guess vmuluwm was missed when many of the other vmx operations were =
converted
> to gvec.
>=20
> Please first convert vmuluwm to tcg_gen_gvec_mul, then implement =
vmulld in the
> same manner.

I did a grep in git repo, and found out only arm use this =
tcg_gen_gvec_mul.
The original implementation is very straightforward, and being adopted =
at many places
all over target/ppc/int_helper.c. Why do we need to convert
to tcg_gen_gvec_mul, which seems to me very convoluted?

Thanks,
Lijun=

--Apple-Mail=_95276640-FDA2-4A85-A869-A0319E35BA2F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jun 18, 2020, at 6:27 PM, Richard Henderson &lt;<a =
href=3D"mailto:richard.henderson@linaro.org" =
class=3D"">richard.henderson@linaro.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">On 6/12/20 9:20 PM, Lijun Pan =
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
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">vmulld:=
 Vector Multiply Low Doubleword.<br class=3D""><br =
class=3D"">Signed-off-by: Lijun Pan &lt;<a =
href=3D"mailto:ljp@linux.ibm.com" class=3D"">ljp@linux.ibm.com</a>&gt;<br =
class=3D"">---<br class=3D"">target/ppc/helper.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| 1 +<br class=3D"">target/ppc/int_helper.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
1 +<br class=3D"">target/ppc/translate/vmx-impl.inc.c | 1 +<br =
class=3D"">target/ppc/translate/vmx-ops.inc.c &nbsp;| 1 +<br class=3D"">4 =
files changed, 4 insertions(+)<br class=3D""><br class=3D"">diff --git =
a/target/ppc/helper.h b/target/ppc/helper.h<br class=3D"">index =
2dfa1c6942..c3f087ccb3 100644<br class=3D"">--- a/target/ppc/helper.h<br =
class=3D"">+++ b/target/ppc/helper.h<br class=3D"">@@ -185,6 +185,7 @@ =
DEF_HELPER_3(vmuloub, void, avr, avr, avr)<br =
class=3D"">DEF_HELPER_3(vmulouh, void, avr, avr, avr)<br =
class=3D"">DEF_HELPER_3(vmulouw, void, avr, avr, avr)<br =
class=3D"">DEF_HELPER_3(vmuluwm, void, avr, avr, avr)<br =
class=3D"">+DEF_HELPER_3(vmulld, void, avr, avr, avr)<br =
class=3D"">DEF_HELPER_3(vslo, void, avr, avr, avr)<br =
class=3D"">DEF_HELPER_3(vsro, void, avr, avr, avr)<br =
class=3D"">DEF_HELPER_3(vsrv, void, avr, avr, avr)<br class=3D"">diff =
--git a/target/ppc/int_helper.c b/target/ppc/int_helper.c<br =
class=3D"">index be53cd6f68..afbcdd05b4 100644<br class=3D"">--- =
a/target/ppc/int_helper.c<br class=3D"">+++ b/target/ppc/int_helper.c<br =
class=3D"">@@ -533,6 +533,7 @@ void helper_vprtybq(ppc_avr_t *r, =
ppc_avr_t *b)<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;\<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;}<br =
class=3D"">VARITH_DO(muluwm, *, u32)<br class=3D"">+VARITH_DO(mulld, *, =
s64)<br class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">=46rom this implementation, I would =
say that both vmuluwm and vmulld can be<br class=3D""></blockquote><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">implemented with =
tcg_gen_gvec_mul().</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">I guess vmuluwm was missed when many of the other vmx =
operations were converted</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">to gvec.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Please first convert vmuluwm to tcg_gen_gvec_mul, then =
implement vmulld in the</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">same manner.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote><div><br =
class=3D""></div><div>I did a grep in git repo, and found out only arm =
use this tcg_gen_gvec_mul.</div><div>The original implementation is very =
straightforward, and being adopted at many places</div><div>all over =
target/ppc/int_helper.c. Why do we need to convert</div><div>to =
tcg_gen_gvec_mul, which seems to me very convoluted?</div><div><br =
class=3D""></div><div>Thanks,</div><div>Lijun</div></div></body></html>=

--Apple-Mail=_95276640-FDA2-4A85-A869-A0319E35BA2F--


