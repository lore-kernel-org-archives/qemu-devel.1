Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463F2C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155BC20663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155BC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv40q-0003a1-Cp
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jv40C-0002yS-7B; Mon, 13 Jul 2020 15:20:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jv40A-0006Ki-9S; Mon, 13 Jul 2020 15:20:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06DJ2JkL119658; Mon, 13 Jul 2020 15:20:25 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3278qsqahd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2020 15:20:25 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06DJJLMi023989;
 Mon, 13 Jul 2020 19:20:24 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04dal.us.ibm.com with ESMTP id 327528y0x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2020 19:20:24 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06DJKN6j23134596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jul 2020 19:20:23 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D2836E04E;
 Mon, 13 Jul 2020 19:20:23 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C8AB6E05D;
 Mon, 13 Jul 2020 19:20:22 +0000 (GMT)
Received: from [9.65.204.75] (unknown [9.65.204.75])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 13 Jul 2020 19:20:22 +0000 (GMT)
From: Lijun Pan <ljp@linux.vnet.ibm.com>
Message-Id: <BDB7FF22-BF16-45B7-B67E-94DD415A5E5C@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_245D0A6E-143A-437C-9E43-556D5EF9E0FA"
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4 06/11] Update PowerPC AT_HWCAP2 definition
Date: Mon, 13 Jul 2020 14:20:20 -0500
In-Reply-To: <20200713051400.GA93134@umbus.fritz.box>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
 <20200701234344.91843-7-ljp@linux.ibm.com>
 <20200713051400.GA93134@umbus.fritz.box>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-13_15:2020-07-13,
 2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130132
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 15:20:32
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_245D0A6E-143A-437C-9E43-556D5EF9E0FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On Jul 13, 2020, at 12:14 AM, David Gibson =
<david@gibson.dropbear.id.au> wrote:
>=20
> On Wed, Jul 01, 2020 at 06:43:41PM -0500, Lijun Pan wrote:
>> Add PPC2_FEATURE2_ARCH_3_10 to the PowerPC AT_HWCAP2 definitions.
>>=20
>> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
>> ---
>> v4: add missing changes, and split to 5/11, 6/11, 7/11
>> v3: use tcg_gen_gvec_mul()
>> v2: fix coding style
>>    use Power ISA 3.1 flag
>>=20
>> include/elf.h | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/include/elf.h b/include/elf.h
>> index 8fbfe60e09..1858b95acf 100644
>> --- a/include/elf.h
>> +++ b/include/elf.h
>> @@ -554,6 +554,7 @@ typedef struct {
>> #define PPC_FEATURE2_HTM_NOSC           0x01000000
>> #define PPC_FEATURE2_ARCH_3_00          0x00800000
>> #define PPC_FEATURE2_HAS_IEEE128        0x00400000
>> +#define PPC_FEATURE2_ARCH_3_10          0x00200000
>>=20
>> /* Bits present in AT_HWCAP for Sparc.  */
>=20
>=20
> Um.. in the corresponding #defines in the kernel 0x00200000 is given
> to PPC_FEATURE2_DARN, and several more bits are allocated past that
> point.
>=20

Then what do you recommend to use?

Thanks,
Lijun


--Apple-Mail=_245D0A6E-143A-437C-9E43-556D5EF9E0FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jul 13, 2020, at 12:14 AM, David Gibson &lt;<a =
href=3D"mailto:david@gibson.dropbear.id.au" =
class=3D"">david@gibson.dropbear.id.au</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">On Wed, Jul 01, 2020 at =
06:43:41PM -0500, Lijun Pan wrote:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 14px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">Add PPC2_FEATURE2_ARCH_3_10 to the =
PowerPC AT_HWCAP2 definitions.<br class=3D""><br class=3D"">Signed-off-by:=
 Lijun Pan &lt;<a href=3D"mailto:ljp@linux.ibm.com" =
class=3D"">ljp@linux.ibm.com</a>&gt;<br class=3D"">---<br class=3D"">v4: =
add missing changes, and split to 5/11, 6/11, 7/11<br class=3D"">v3: use =
tcg_gen_gvec_mul()<br class=3D"">v2: fix coding style<br =
class=3D"">&nbsp;&nbsp;&nbsp;use Power ISA 3.1 flag<br class=3D""><br =
class=3D"">include/elf.h | 1 +<br class=3D"">1 file changed, 1 =
insertion(+)<br class=3D""><br class=3D"">diff --git a/include/elf.h =
b/include/elf.h<br class=3D"">index 8fbfe60e09..1858b95acf 100644<br =
class=3D"">--- a/include/elf.h<br class=3D"">+++ b/include/elf.h<br =
class=3D"">@@ -554,6 +554,7 @@ typedef struct {<br class=3D"">#define =
PPC_FEATURE2_HTM_NOSC =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x01000000<br =
class=3D"">#define PPC_FEATURE2_ARCH_3_00 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00800000<br =
class=3D"">#define PPC_FEATURE2_HAS_IEEE128 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00400000<br =
class=3D"">+#define PPC_FEATURE2_ARCH_3_10 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00200000<br =
class=3D""><br class=3D"">/* Bits present in AT_HWCAP for Sparc. =
&nbsp;*/<br class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
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
class=3D"">Um.. in the corresponding #defines in the kernel 0x00200000 =
is given</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">to =
PPC_FEATURE2_DARN, and several more bits are allocated past =
that</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" =
class=3D"">point.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br class=3D""></div></blockquote><br =
class=3D""></div><div>Then what do you recommend to use?</div><div><br =
class=3D""></div><div>Thanks,</div><div>Lijun</div><br =
class=3D""></body></html>=

--Apple-Mail=_245D0A6E-143A-437C-9E43-556D5EF9E0FA--


