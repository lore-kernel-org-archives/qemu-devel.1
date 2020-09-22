Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,FROM_ILLEGAL_CHARS,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4465C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31AA23A1E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31AA23A1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcNn-00035r-Qd
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duanzhenzhong@jd.com>)
 id 1kKcC9-0001zI-5a
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:54:33 -0400
Received: from smtp4.jd.com ([59.151.64.78]:2049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <duanzhenzhong@jd.com>)
 id 1kKcC1-0003c9-5J
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:54:31 -0400
Received: from JDCloudMail10.360buyAD.local (172.31.68.43) by
 JDCloudMail16.360buyAD.local (172.31.68.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 22 Sep 2020 14:47:40 +0800
Received: from JDCloudMail10.360buyAD.local ([fe80::7489:42a2:4437:c234]) by
 JDCloudMail10.360buyAD.local ([fe80::7489:42a2:4437:c234%5]) with mapi id
 15.01.1847.007; Tue, 22 Sep 2020 14:47:40 +0800
To: "mst@redhat.com" <mst@redhat.com>, "tiwei.bie@intel.com"
 <tiwei.bie@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Question about guest notification offload
Thread-Topic: Question about guest notification offload
Thread-Index: AdaQqRkooEfHrtFKS3u4T/9zU7Lj4A==
Date: Tue, 22 Sep 2020 06:47:40 +0000
Message-ID: <a4141e1402b6434896fc5949d33e3b06@jd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.12.238]
Content-Type: multipart/alternative;
 boundary="_000_a4141e1402b6434896fc5949d33e3b06jdcom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=59.151.64.78; envelope-from=duanzhenzhong@jd.com;
 helo=smtp4.jd.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:47:41
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Sep 2020 03:01:46 -0400
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
Reply-to: 段振中 <duanzhenzhong@jd.com>
From: 段振中 via <qemu-devel@nongnu.org>

--_000_a4141e1402b6434896fc5949d33e3b06jdcom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgTWFpbnRhaW5lcnMsDQoNCkkgc2V0dXAgYSB2ZHBhIGRldmljZSBhbmQgd2FudCB0byB1c2Ug
dGhlIGhvc3QgYW5kIGd1ZXN0IG5vdGlmaWNhdGlvbnMgb2ZmbG9hZCBmb3IgYmV0dGVyIHBlcmZv
cm1hbmNlLg0KSG9zdCBub3RpZmljYXRpb24gb2ZmbG9hZCB3b3JrcyB3ZWxsIGJ1dCBzZWVtcyBn
dWVzdCBub3RpZmljYXRpb24gb2ZmbG9hZCBpc26hr3Qgc3VwcG9ydGVkIGluIHFlbXUuDQoNCkkg
c2VlIHRoZXJlIHdlcmUgZWZmb3J0IHRvIGFkZCB0aGUgc3VwcG9ydCBmb3IgYm90aCBpbiBiZWxv
dyBsaW5rIHR3byB5ZWFycyBhZ28uDQpodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hp
dmVzL3ZpcnRpby1kZXYvMjAxODAzL21zZzAwMzA4Lmh0bWwNCg0KSG9zdCBub3RpZmljYXRpb24g
b2ZmbG9hZCBnb3QgaXRzIHdheSBpbiBmaW5hbGx5IGJ1dCBndWVzdCBub3RpZmljYXRpb24gb2Zm
bG9hZCBub3QsIEmhr20gaW50ZXJlc3RlZCB0byBrbm93IHRoZSByZWFzb24NCmd1ZXN0IG5vdGlm
aWNhdGlvbiBvZmZsb2FkIG1pc3NlZC4gQXBwcmVjaWF0ZSB5b3VyIHJlcGx5LiBUaGFua3MgdmVy
eSBtdWNoLg0KDQpaaGVuemhvbmcNCg==

--_000_a4141e1402b6434896fc5949d33e3b06jdcom_
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
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Maintainers,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I setup a vdpa device and want =
to use the host and guest notifications offload for better performance.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Host notification offload works=
 well but seems guest notification offload isn=A1=AFt supported in qemu.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I see there were effort to add =
the support for both in below link two years ago.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"https://lists.oasis-=
open.org/archives/virtio-dev/201803/msg00308.html">https://lists.oasis-open=
.org/archives/virtio-dev/201803/msg00308.html</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US">H=
ost notification offload got its way in finally but guest notification offl=
oad not, I=A1=AFm interested to know the reason<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US">g=
uest notification offload missed. Appreciate your reply. Thanks very much.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US"><=
o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US">Z=
henzhong<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_a4141e1402b6434896fc5949d33e3b06jdcom_--

