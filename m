Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A7E20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A7E20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqDF-0008Dy-Dc
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAqAj-0003dC-AW; Wed, 26 Aug 2020 03:48:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2536 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAqAg-0002Ce-SW; Wed, 26 Aug 2020 03:48:41 -0400
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 8A407BF099922FB0D4E4;
 Wed, 26 Aug 2020 15:48:35 +0800 (CST)
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.252]) by
 dggemi405-hub.china.huawei.com ([10.3.17.143]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 15:48:25 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH V2 09/10] qapi/: fix some comment spelling errors
Thread-Topic: [PATCH V2 09/10] qapi/: fix some comment spelling errors
Thread-Index: AdZ7fIS4VeCEoOiiQBiVE5yKhrK1+g==
Date: Wed, 26 Aug 2020 07:48:25 +0000
Message-ID: <640CDEE67BE2784FAE298BB2517210E48AC41F@dggemi522-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.186.227]
Content-Type: multipart/alternative;
 boundary="_000_640CDEE67BE2784FAE298BB2517210E48AC41Fdggemi522mbschina_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:46:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_640CDEE67BE2784FAE298BB2517210E48AC41Fdggemi522mbschina_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the qapi folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
qapi/block-core.json | 4 ++--
qapi/crypto.json     | 4 ++--
2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 197bdc1c36..b0ef7c19d4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1790,7 +1790,7 @@
#
# @block-backend: corresponds to BlockBackend
#
-# @block-job: corresonds to BlockJob
+# @block-job: corresponds to BlockJob
#
# @block-driver: corresponds to BlockDriverState
#
@@ -2061,7 +2061,7 @@
# @target: name of the destination dirty bitmap
#
# @bitmaps: name(s) of the source dirty bitmap(s) at @node and/or fully
-#           specifed BlockDirtyBitmap elements. The latter are supported
+#           specified BlockDirtyBitmap elements. The latter are supported
#           since 4.1.
#
# Since: 4.0
diff --git a/qapi/crypto.json b/qapi/crypto.json
index bb7930d332..2aebe6fa20 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -336,7 +336,7 @@
#                 written into added active keyslots
#
# @old-secret:    Optional (for deactivation only)
-#                 If given will deactive all keyslots that
+#                 If given will deactivate all keyslots that
#                 match password located in QCryptoSecret with this ID
#
# @iter-time:     Optional (for activation only)
@@ -354,7 +354,7 @@
#                 keyslot to deactivate
#
# @secret:        Optional. The ID of a QCryptoSecret object providing the
-#                 password to use to retrive current master key.
+#                 password to use to retrieve current master key.
#                 Defaults to the same secret that was used to open the ima=
ge
#
#
--
2.26.2.windows.1


--_000_640CDEE67BE2784FAE298BB2517210E48AC41Fdggemi522mbschina_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
 errors in the qapi folder.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: zhaolichang &lt;=
zhaolichang@huawei.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Reviewed-by: Markus Armbruster =
&lt;armbru@redhat.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">qapi/block-core.json | 4 &#43;&=
#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">qapi/crypto.json&nbsp;&nbsp;&nb=
sp;&nbsp; | 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2 files changed, 4 insertions(&=
#43;), 4 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/qapi/block-core.js=
on b/qapi/block-core.json<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 197bdc1c36..b0ef7c19d4 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/qapi/block-core.json<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/qapi/block-co=
re.json<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1790,7 &#43;1790,7 @@<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># @block-backend: corresponds t=
o BlockBackend<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-# @block-job: corresonds to Bl=
ockJob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;# @block-job: corresponds =
to BlockJob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># @block-driver: corresponds to=
 BlockDriverState<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -2061,7 &#43;2061,7 @@<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># @target: name of the destinat=
ion dirty bitmap<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># @bitmaps: name(s) of the sour=
ce dirty bitmap(s) at @node and/or fully<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; specifed BlockDirtyBitmap elements. The lat=
ter are supported<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;#&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; specified BlockDirtyBitmap elements. Th=
e latter are supported<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; since 4.1.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># Since: 4.0<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/qapi/crypto.json b=
/qapi/crypto.json<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index bb7930d332..2aebe6fa20 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/qapi/crypto.json<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/qapi/crypto.j=
son<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -336,7 &#43;336,7 @@<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;written =
into added active keyslots<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># @old-secret:&nbsp;&nbsp;&nbsp=
; Optional (for deactivation only)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If give=
n will deactive all keyslots that<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;#&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If =
given will deactivate all keyslots that<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match pa=
ssword located in QCryptoSecret with this ID<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># @iter-time:&nbsp;&nbsp;&nbsp;=
&nbsp; Optional (for activation only)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -354,7 &#43;354,7 @@<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; keyslot =
to deactivate<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># @secret:&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Optional. The ID of a QCryptoSecret object providing =
the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; passwor=
d to use to retrive current master key.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;#&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pas=
sword to use to retrieve current master key.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Defaults=
 to the same secret that was used to open the image<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.26.2.windows.1<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_640CDEE67BE2784FAE298BB2517210E48AC41Fdggemi522mbschina_--

