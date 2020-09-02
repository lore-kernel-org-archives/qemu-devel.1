Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173D2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 05:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EB420709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 05:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="DCyUCRuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EB420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDKvk-0006L7-VB
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 01:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruippan@tencent.com>)
 id 1kDJ4y-0004NJ-FT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 23:04:56 -0400
Received: from mail6.tencent.com ([220.249.245.26]:58002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruippan@tencent.com>)
 id 1kDJ4n-0004lR-JI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 23:04:49 -0400
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
 by mail6.tencent.com (Postfix) with ESMTP id D42E4CC3CC;
 Wed,  2 Sep 2020 11:05:43 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1599015943;
 bh=prgWJHQiDmmzGESHWoloTU8GlwJvf5H+oCzw3K9vBsM=;
 h=From:To:CC:Subject:Date;
 b=DCyUCRuhHJHzmNEwwJJwKhcOhNMqGFzYwEcjfwboQHxldmNVchAKEs9ZR87iddj9/
 1UBvZeENbV4QART1YULA0Ml+1/760CxeVxFpv7MuFDCjSqshdB0LE8WKXUaEHx7Vlv
 RDDJFwN4r7QAODDCrs957dyp6sQQ4X6mowGEx+c4=
Received: from EX-SZ001.tencent.com (10.28.6.13) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 2 Sep 2020
 11:04:24 +0800
Received: from EX-SZ007.tencent.com (10.28.6.31) by EX-SZ001.tencent.com
 (10.28.6.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 2 Sep 2020
 11:04:24 +0800
Received: from EX-SZ007.tencent.com ([fe80::c18:7c89:3e4e:3c42]) by
 EX-SZ007.tencent.com ([fe80::c18:7c89:3e4e:3c42%8]) with mapi id
 15.01.1847.007; Wed, 2 Sep 2020 11:04:24 +0800
From: =?gb2312?B?cnVpcHBhbijFy+6jKQ==?= <ruippan@tencent.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>
Subject: ui: fix potential compile error.
Thread-Topic: ui: fix potential compile error.
Thread-Index: AdaA1cIX+J3VvXsaQtu3KAdRudKiUg==
Date: Wed, 2 Sep 2020 03:04:24 +0000
Message-ID: <370e6ed66acf43e68f1ef2bffc3026f7@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.34]
Content-Type: multipart/mixed;
 boundary="_004_370e6ed66acf43e68f1ef2bffc3026f7tencentcom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=220.249.245.26; envelope-from=ruippan@tencent.com;
 helo=mail6.tencent.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 23:04:25
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: 36
X-Spam_score: 3.6
X-Spam_bar: +++
X-Spam_report: (3.6 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 02 Sep 2020 01:02:30 -0400
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_004_370e6ed66acf43e68f1ef2bffc3026f7tencentcom_
Content-Type: multipart/alternative;
	boundary="_000_370e6ed66acf43e68f1ef2bffc3026f7tencentcom_"

--_000_370e6ed66acf43e68f1ef2bffc3026f7tencentcom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

V2UgY29tcGlsZWQgdGhlIHVwc3RyZWFtIHFlbXUgYW5kIHJlc3VsdCBpbiB0aGlzIEdFTiBjb2Rl
IGVycm9yOg0KDQqhrqGvoa8NCkdFTiAgICAgdWkvaW5wdXQta2V5bWFwLWF0c2V0MS10by1xY29k
ZS5jDQp1c2FnZToga2V5bWFwLWdlbiBbLWhdDQogICAgICAgICAgICAgICAgICB7Y29kZS1tYXAs
Y29kZS10YWJsZSxuYW1lLW1hcCxuYW1lLXRhYmxlLGNvZGUtZG9jcyxuYW1lLWRvY3N9DQogICAg
ICAgICAgICAgICAgICAuLi4NCmtleW1hcC1nZW46IGVycm9yOiBpbnZhbGlkIGNob2ljZTogJ2ds
aWIyJyAoY2hvb3NlIGZyb20gJ2NvZGUtbWFwJywgJ2NvZGUtdGFibGUnLCAnbmFtZS1tYXAnLCAn
bmFtZS10YWJsZScsICdjb2RlLWRvY3MnLCAnbmFtZS1kb2NzJykNCqGuoa+hrw0KDQpNeSBlbnZp
cm9ubWVudDoNCg0KMS4gICAgIENlbnRPUzcgd2l0aCBQeXRob24gMi43LjUNCg0KMi4gICAgIHVw
c3RyZWFtJ3Mga2V5Y29kZW1hcGRiDQoNCjMuICAgICBhcmdwYXJzZSAxLjENCg0KUm9vdCBjYXVz
ZSBpcyBteSBhcmdwYXJzZSBhbmQgcHl0aG9uIHZlcnNpb24uIEJ1dCBjaGFuZ2UgdGhlIGludm9r
aW5nIG9yZGVyIGNhbiBhZGFwdCBib3RoIG5ldyBhbmQgb2xkIGFyZ3BhcnNlLg0KDQpUaGFua3Mu
DQo=

--_000_370e6ed66acf43e68f1ef2bffc3026f7tencentcom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:=B5=C8=CF=DF;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1828785327;
	mso-list-type:hybrid;
	mso-list-template-ids:-1258811980 1836499040 67698713 67698715 67698703 67=
698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
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
<p class=3D"MsoNormal"><span lang=3D"EN-US">We compiled the upstream qemu a=
nd result in this GEN code error:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:red">=A1=AE=A1=
=AF=A1=AF<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:red">GEN&nbsp;&n=
bsp;&nbsp;&nbsp; ui/input-keymap-atset1-to-qcode.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:red">usage: keym=
ap-gen [-h]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:red">&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; {code-map,code-table,name-map,name-table,code-docs,name-do=
cs}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:red">&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:red">keymap-gen:=
 error: invalid choice: 'glib2' (choose from 'code-map', 'code-table', 'nam=
e-map', 'name-table', 'code-docs', 'name-docs')<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:red">=A1=AE=A1=
=AF=A1=AF<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">My environment:<o:p></o:p></spa=
n></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo1">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">CentOS7 with Python 2.7=
.5<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo1">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">2=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">upstream's keycodemapdb=
<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo1">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">3=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">argparse 1.1<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Root cause is my argparse and p=
ython version. But change the invoking order can adapt both new and old arg=
parse.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks.<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_370e6ed66acf43e68f1ef2bffc3026f7tencentcom_--

--_004_370e6ed66acf43e68f1ef2bffc3026f7tencentcom_
Content-Type: application/octet-stream;
	name="0001-ui-fix-potential-compile-error.patch"
Content-Description: 0001-ui-fix-potential-compile-error.patch
Content-Disposition: attachment;
	filename="0001-ui-fix-potential-compile-error.patch"; size=1350;
	creation-date="Wed, 02 Sep 2020 02:54:37 GMT";
	modification-date="Wed, 02 Sep 2020 02:51:22 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3ZjI2MmIxNjBkNTc1NTliYWNlMWY4NzdmNzRiMWM0ZTVhODcyYjQxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBydWlwcGFuIDxydWlwcGFuQHRlbmNlbnQuY29tPgpEYXRlOiBX
ZWQsIDIgU2VwIDIwMjAgMTA6NDA6MjkgKzA4MDAKU3ViamVjdDogW1BBVENIXSB1aTogZml4IHBv
dGVudGlhbCBjb21waWxlIGVycm9yLgoKRml4IGNvZGUgR0VOIGVycm9yIHdpdGggaW5mbyAia2V5
bWFwLWdlbjogZXJyb3I6IGludmFsaWQgY2hvaWNlOiAnZ2xpYjInIi4KQ29tcGlsZSBlbnZpcm9u
bWVudDoKMS4gQ2VudE9TNyB3aXRoIFB5dGhvbiAyLjcuNQoyLiB1cHN0cmVhbSdzIGtleWNvZGVt
YXBkYgozLiBhcmdwYXJzZSAxLjEKCkNoYW5nZSBhcmcgb3JkZXIgdG8gYWRhcHQgb2xkIHZlcnNp
b24gb2YgYXJncGFyc2UuCgpTaWduZWQtb2ZmLWJ5OiBydWlwcGFuIDxydWlwcGFuQHRlbmNlbnQu
Y29tPgotLS0KIHVpL21lc29uLmJ1aWxkIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdWkvbWVzb24uYnVpbGQg
Yi91aS9tZXNvbi5idWlsZAppbmRleCA5NjJlNzc2NTY5Li40N2UxMzk5MDNiIDEwMDY0NAotLS0g
YS91aS9tZXNvbi5idWlsZAorKysgYi91aS9tZXNvbi5idWlsZApAQCAtMTA1LDkgKzEwNSw5IEBA
IGlmIGhhdmVfc3lzdGVtIG9yIHhrYmNvbW1vbi5mb3VuZCgpCiAgICAgICAgICAgICAgICAgICBj
YXB0dXJlOiB0cnVlLAogICAgICAgICAgICAgICAgICAgaW5wdXQ6IGZpbGVzKCdrZXljb2RlbWFw
ZGIvZGF0YS9rZXltYXBzLmNzdicpLAogICAgICAgICAgICAgICAgICAgY29tbWFuZDogW3B5dGhv
bi5mdWxsX3BhdGgoKSwgZmlsZXMoJ2tleWNvZGVtYXBkYi90b29scy9rZXltYXAtZ2VuJyksCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJy0tbGFuZycsICdnbGliMicsCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJy0tdmFybmFtZScsICdxZW11X2lucHV0X21hcF9AMEBfdG9fQDFA
Jy5mb3JtYXQoZVswXSwgZVsxXSksCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgJ2NvZGUt
bWFwJywgJ0BJTlBVVDBAJywgZVswXSwgZVsxXV0pCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAnY29kZS1tYXAnLCAnQElOUFVUMEAnLCBlWzBdLCBlWzFdLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJy0tbGFuZycsICdnbGliMicsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAn
LS12YXJuYW1lJywgJ3FlbXVfaW5wdXRfbWFwX0AwQF90b19AMUAnLmZvcm1hdChlWzBdLCBlWzFd
KV0pCiAgIGVuZGZvcmVhY2gKIGVuZGlmCiAKLS0gCjIuMTkuMQoK

--_004_370e6ed66acf43e68f1ef2bffc3026f7tencentcom_--

