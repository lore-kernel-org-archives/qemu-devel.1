Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78305C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F4B20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F4B20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqDw-0001Qz-79
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAqAS-0002yt-EV; Wed, 26 Aug 2020 03:48:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2927 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAqAP-00029D-Pd; Wed, 26 Aug 2020 03:48:24 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id F07332A389C98D44DB1F;
 Wed, 26 Aug 2020 15:48:17 +0800 (CST)
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.252]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 15:48:09 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH V2 08/10] disas/: fix some comment spelling errors
Thread-Topic: [PATCH V2 08/10] disas/: fix some comment spelling errors
Thread-Index: AdZ7fHEkBA11lOjFQXKj/DOJbVxiRg==
Date: Wed, 26 Aug 2020 07:48:09 +0000
Message-ID: <640CDEE67BE2784FAE298BB2517210E48AC415@dggemi522-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.186.227]
Content-Type: multipart/alternative;
 boundary="_000_640CDEE67BE2784FAE298BB2517210E48AC415dggemi522mbschina_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:46:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhaolichang <zhaolichang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_640CDEE67BE2784FAE298BB2517210E48AC415dggemi522mbschina_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the disas folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
disas/hppa.c | 2 +-
disas/m68k.c | 8 ++++----
disas/ppc.c  | 2 +-
3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index 2dbd1fc445..dcf9a47f34 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -2021,7 +2021,7 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *i=
nfo)
                            fput_fp_reg (GET_FIELD (insn, 6, 10), info);
                         break;

-                       /* 'fA' will not generate a space before the regsit=
er
+                      /* 'fA' will not generate a space before the registe=
r
                            name.  Normally that is fine.  Except that it
                            causes problems with xmpyu which has no FP form=
at
                            completer.  */
diff --git a/disas/m68k.c b/disas/m68k.c
index 863409c67c..aefaecfbd6 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -70,7 +70,7 @@ struct floatformat
   unsigned int exp_start;
   unsigned int exp_len;
   /* Bias added to a "true" exponent to form the biased exponent.  It
-     is intentionally signed as, otherwize, -exp_bias can turn into a
+     is intentionally signed as, otherwise, -exp_bias can turn into a
      very large number (e.g., given the exp_bias of 0x3fff and a 64
      bit long, the equation (long)(1 - exp_bias) evaluates to
      4294950914) instead of -16382).  */
@@ -479,7 +479,7 @@ struct m68k_opcode_alias
       and remaining 3 bits of register shifted 9 bits in first word.
       Indicate upper/lower in 1 bit shifted 7 bits in second word.
       Use with `R' or `u' format.
-   n  `m' withouth upper/lower indication. (For M[S]ACx; 4 bits split
+   n  `m' without upper/lower indication. (For M[S]ACx; 4 bits split
       with MSB shifted 6 bits in first word and remaining 3 bits of
       register shifted 9 bits in first word.  No upper/lower
       indication is done.)  Use with `R' or `u' format.
@@ -854,7 +854,7 @@ fetch_arg (unsigned char *buffer,

/* Check if an EA is valid for a particular code.  This is required
    for the EMAC instructions since the type of source address determines
-   if it is a EMAC-load instruciton if the EA is mode 2-5, otherwise it
+   if it is a EMAC-load instruction if the EA is mode 2-5, otherwise it
   is a non-load EMAC instruction and the bits mean register Ry.
    A similar case exists for the movem instructions where the register
    mask is interpreted differently for different EAs.  */
@@ -1080,7 +1080,7 @@ print_indexed (int basereg,

/* Returns number of bytes "eaten" by the operand, or
    return -1 if an invalid operand was found, or -2 if
-   an opcode tabe error was found.
+   an opcode table error was found.
    ADDR is the pc for this arg to be relative to.  */

static int
diff --git a/disas/ppc.c b/disas/ppc.c
index 63e97cfe1d..02be878198 100644
--- a/disas/ppc.c
+++ b/disas/ppc.c
@@ -5226,7 +5226,7 @@ operand_value_powerpc (const struct powerpc_operand *=
operand,
       if ((operand->flags & PPC_OPERAND_SIGNED) !=3D 0)
         {
           /* BITM is always some number of zeros followed by some
-             number of ones, followed by some numer of zeros.  */
+            number of ones, followed by some number of zeros.  */
           unsigned long top =3D operand->bitm;
           /* top & -top gives the rightmost 1 bit, so this
              fills in any trailing zeros.  */
--
2.26.2.windows.1


--_000_640CDEE67BE2784FAE298BB2517210E48AC415dggemi522mbschina_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">I found that there are many spe=
lling errors in the comments of qemu,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">so I used the spellcheck tool t=
o check the spelling errors<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">and finally found some spelling=
 errors in the disas folder.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: zhaolichang &lt;=
zhaolichang@huawei.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">disas/hppa.c | 2 &#43;-<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">disas/m68k.c | 8 &#43;&#43;&#43=
;&#43;----<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">disas/ppc.c&nbsp; | 2 &#43;-<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">3 files changed, 6 insertions(&=
#43;), 6 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/disas/hppa.c b/dis=
as/hppa.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 2dbd1fc445..dcf9a47f34 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/disas/hppa.c<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/disas/hppa.c<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -2021,7 &#43;2021,7 @@ print=
_insn_hppa (bfd_vma memaddr, disassemble_info *info)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fput_fp_reg (GET_F=
IELD (insn, 6, 10), info);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* 'fA' will not generate a space before the regsite=
r<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /* 'fA' will not generate a space before the register<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name.&nbsp; Normal=
ly that is fine.&nbsp; Except that it<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; causes problems wi=
th xmpyu which has no FP format<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; completer.&nbsp; *=
/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/disas/m68k.c b/dis=
as/m68k.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 863409c67c..aefaecfbd6 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/disas/m68k.c<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/disas/m68k.c<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -70,7 &#43;70,7 @@ struct fl=
oatformat<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; unsigned int exp_s=
tart;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; unsigned int exp_l=
en;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; /* Bias added to a=
 &quot;true&quot; exponent to form the biased exponent.&nbsp; It<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; is in=
tentionally signed as, otherwize, -exp_bias can turn into a<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; i=
s intentionally signed as, otherwise, -exp_bias can turn into a<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
very large number (e.g., given the exp_bias of 0x3fff and a 64<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
bit long, the equation (long)(1 - exp_bias) evaluates to<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4294950914) instead of -16382).&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -479,7 &#43;479,7 @@ struct =
m68k_opcode_alias<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; and remaining 3 bits of register shifted 9 bits in first word.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; Indicate upper/lower in 1 bit shifted 7 bits in second word.<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; Use with `R' or `u' format.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp; n&nbsp; `m' witho=
uth upper/lower indication. (For M[S]ACx; 4 bits split<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp; n&nbsp; `m' w=
ithout upper/lower indication. (For M[S]ACx; 4 bits split<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; with MSB shifted 6 bits in first word and remaining 3 bits of<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; register shifted 9 bits in first word.&nbsp; No upper/lower<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; indication is done.)&nbsp; Use with `R' or `u' format.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -854,7 &#43;854,7 @@ fetch_a=
rg (unsigned char *buffer,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/* Check if an EA is valid for =
a particular code.&nbsp; This is required<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; for the EMAC=
 instructions since the type of source address determines<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp; if it is a EMAC-l=
oad instruciton if the EA is mode 2-5, otherwise it<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp; if it is a EM=
AC-load instruction if the EA is mode 2-5, otherwise it<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; is a non-load EMAC=
 instruction and the bits mean register Ry.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; A similar ca=
se exists for the movem instructions where the register<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; mask is inte=
rpreted differently for different EAs.&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1080,7 &#43;1080,7 @@ print=
_indexed (int basereg,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/* Returns number of bytes &quo=
t;eaten&quot; by the operand, or<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; return -1 if=
 an invalid operand was found, or -2 if<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp; an opcode tabe er=
ror was found.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp; an opcode tab=
le error was found.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; ADDR is the =
pc for this arg to be relative to.&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">static int<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/disas/ppc.c b/disa=
s/ppc.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 63e97cfe1d..02be878198 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/disas/ppc.c<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/disas/ppc.c<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -5226,7 &#43;5226,7 @@ opera=
nd_value_powerpc (const struct powerpc_operand *operand,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if ((operand-&gt;flags &amp; PPC_OPERAND_SIGNED) !=3D 0)<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &nbsp; /* BITM is always some number of zeros followed by=
 some<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; number of ones, followed by some nume=
r of zeros.&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; number of ones, followed by some number=
 of zeros.&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &nbsp; unsigned long top =3D operand-&gt;bitm;<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &nbsp; /* top &amp; -top gives the rightmost 1 bit, so th=
is<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; fills in any trailing zeros.&nbs=
p; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.26.2.windows.1<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_640CDEE67BE2784FAE298BB2517210E48AC415dggemi522mbschina_--

