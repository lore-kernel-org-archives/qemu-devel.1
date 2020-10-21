Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E31C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D74A221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D74A221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVE5V-0003FR-9A
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 09:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kVE4d-0002TV-Hj
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:22:39 -0400
Received: from zxshcas1.zhaoxin.com ([203.148.12.81]:16417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kVE4Y-0003YL-Qd
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:22:38 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 21:16:14 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 21:16:13 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Wed, 21 Oct 2020 21:16:13 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvMV0gU2tpcCBmbGF0dmlld19zaW1wbGlmeSgpIGZv?=
 =?gb2312?Q?r_cpu_vendor_zhaoxin?=
Thread-Topic: [PATCH 1/1] Skip flatview_simplify() for cpu vendor zhaoxin
Thread-Index: AQHWo6+lIFwCGFufXkSJFIAohPLGXamZlV6AgAUx0wCAAPEVAIAA32uAgACU/oCAAN+P8Q==
Date: Wed, 21 Oct 2020 13:16:13 +0000
Message-ID: <6b7179fb801c4ef1919153ebee85c256@zhaoxin.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
 <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
 <20201019130206.1d3baffc@w520.home>
 <4d2b96cb-8f7f-2598-39e6-4cf0f61d567b@redhat.com>
 <20201020164437.5e3cb4ce@w520.home>,
 <783b5ef0-277c-363d-f342-7c0351f9ac16@redhat.com>
In-Reply-To: <783b5ef0-277c-363d-f342-7c0351f9ac16@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.40]
Content-Type: multipart/alternative;
 boundary="_000_6b7179fb801c4ef1919153ebee85c256zhaoxincom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=203.148.12.81;
 envelope-from=FelixCui-oc@zhaoxin.com; helo=ZXSHCAS1.zhaoxin.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 09:16:15
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001,
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
Cc: CobeChen-oc <CobeChen-oc@zhaoxin.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, RockCui-oc <RockCui-oc@zhaoxin.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_6b7179fb801c4ef1919153ebee85c256zhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgUGFvbG8sDQoNCj5GZWxpeCwgZGlkIHlvdSBpZGVudGlmeSB0aGUgcmVnaW9ucyB3aG9zZSBz
aW1wbGlmaWNhdGlvbiBjYXVzZXMgdGhlIGJ1Zz8NCj5JcyB0aGlzIFJBTSAoZm9yIGV4YW1wbGUg
ZHVlIHRvIHRoZSBQQU0gcmVnaXN0ZXJzKSBvciBzb21ldGhpbmcgZWxzZT8NCg0KDQp5ZXMsIHRo
aXMgYnVnIGlzIGNhdXNlZCBieSB3cml0ZSBQQU0gcmVnaXN0ZXIuVGhlIGFjdHVhbCBzaXR1YXRp
b24gaXMgdGhhdCB0aGUNCg0KcHJvcGVydGllcyBvZiBzb21lIHJhbmdlcyBhcmUgY2hhbmdlZCBm
cm9tIFJXIHRvIHJlYWRvbmx5LlRoaXMgc2l0dWF0aW9uDQoNCndpbGwgY2F1c2UgdGhlIG9sZCBy
YW5nZXMgdG8gYmUgdW5tYXBwZWQuDQoNCg0KQmVzdCByZWdhcmRzDQoNCkZlbGl4Y3VpLW9jDQoN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogUGFvbG8gQm9uemlu
aSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCreiy83KsbzkOiAyMDIwxOoxMNTCMjHI1SAxNTozNzo1
Mw0KytW8/sjLOiBBbGV4IFdpbGxpYW1zb24NCrOty806IEZlbGl4Q3VpLW9jOyBSaWNoYXJkIEhl
bmRlcnNvbjsgRWR1YXJkbyBIYWJrb3N0OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFJvY2tDdWkt
b2M7IFRvbnkgVyBXYW5nLW9jOyBDb2JlQ2hlbi1vYw0K1vfM4jogUmU6IFtQQVRDSCAxLzFdIFNr
aXAgZmxhdHZpZXdfc2ltcGxpZnkoKSBmb3IgY3B1IHZlbmRvciB6aGFveGluDQoNCk9uIDIxLzEw
LzIwIDAwOjQ0LCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6DQo+IERvIHdlIG5lY2Vzc2FyaWx5IG5l
ZWQgYSBtZW1vcnkgbWFwIGlvY3RsIGZvciB0aGlzIG9yIGNvdWxkIGl0IGJlIHRoZQ0KPiBRRU1V
IGNvZGUgdGhhdCBjb21wYXJlcyB0aGUgb2xkIGFuZCBuZXcgbWFwcyB0byB0cmlnZ2VyIG1hcCBh
bmQgdW5tYXANCj4gaW9jdGxzPyAgRm9yIGV4YW1wbGUgKGFpdWkpIG91ciByYWNlIGlzIHRoYXQg
aWYgd2UgaGF2ZSBjb250aWd1b3VzDQo+IG1lbW9yeSByZWdpb25zIEEgYW5kIEIgYW5kIGZsYXR2
aWV3X3NpbXBsaWZ5KCkgdHJpZXMgdG8gZXhwYW5kIEEgYW5kDQo+IGRlbGV0ZSBCIHdlJ2xsIHNl
ZSBhIHNlcmllcyBvZiBsaXN0ZW5lciBub3RpZmljYXRpb25zIGRlbGV0aW5nIEEgYW5kIEINCj4g
YW5kIGFkZGluZyBBJy4gIEJ1dCB0aGUgdmZpbyBRRU1VIGNvZGUgY291bGQgcGFyc2UgdGhlIG1l
bW9yeSBtYXAgdG8NCj4gZGV0ZXJtaW5lIHRoYXQgb2xkIEEgKyBCIGlzIGZ1bmN0aW9uYWxseSBl
cXVpdmFsZW50IHRvIEEnIGFuZCBkbw0KPiBub3RoaW5nLg0KDQpJIHRoaW5rIHRoZSBpc3N1ZSBp
cyBhIGJpdCBkaWZmZXJlbnQsIGFuZCBpbiBmYWN0IHRoZXJlIGFyZSB0d28gc2lkZXMgb2YNCnRo
ZSBzYW1lIGlzc3VlLiAgU2F5IHlvdSBoYXZlIEEgKGxhcmdlKSBhbmQgaXQgaXMgcmVwbGFjZWQg
YnkgQScNCihzbWFsbGVyKSArIEIsIHRoZW46DQoNCiogdGhlIGZpcnN0IHBhcnQgb2YgQSBkaXNh
cHBlYXJzIGZvciBhIG1vbWVudCBiZWZvcmUgQScgYXBwZWFycy4gIFRoaXMNCmlzIHNvbWV0aGlu
ZyB0aGF0IFFFTVUgY2FuIHdvcmsgYXJvdW5kLCBieSBub3QgZG9pbmcgYW55dGhpbmcNCg0KKiB0
aGUgc2Vjb25kIHBhcnQgb2YgQSBkaXNhcHBlYXJzIGZvciBhIG1vbWVudCBiZWZvcmUgQiBhcHBl
YXJzLiAgVGhpcw0KaXMgdGhlIHJvb3QgQVBJIGlzc3VlIGFuZCBub3Qgc29tZXRoaW5nIHRoYXQg
UUVNVSBjYW4gd29yayBhcm91bmQ7IGFuZA0KaW4gZmFjdCBpdCBpcyBub3QgZXZlbiBmaXhlZCBi
eSByZW1vdmluZyBmbGF0dmlld19zaW1wbGlmeS4NCg0KRmVsaXgsIGRpZCB5b3UgaWRlbnRpZnkg
dGhlIHJlZ2lvbnMgd2hvc2Ugc2ltcGxpZmljYXRpb24gY2F1c2VzIHRoZSBidWc/DQogSXMgdGhp
cyBSQU0gKGZvciBleGFtcGxlIGR1ZSB0byB0aGUgUEFNIHJlZ2lzdGVycykgb3Igc29tZXRoaW5n
IGVsc2U/DQoNClBhb2xvDQoNCg==

--_000_6b7179fb801c4ef1919153ebee85c256zhaoxincom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>hi Paolo,</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;Felix, did you =
identify the regions whose simplification causes the bug?</span><br style=
=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-seri=
f,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;Is this RAM (for e=
xample due to the PAM registers) or something else?</span><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">yes, this bug is ca=
used by write PAM register.The actual situation is that the</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">properties of some =
ranges are changed from RW to readonly.This situation&nbsp;</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">will cause the old =
ranges to be unmapped.</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Best regards</span>=
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Felixcui-oc</span><=
/p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Paolo=
 Bonzini &lt;pbonzini@redhat.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA10=D4=C221=C8=D5 15:37:53<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Alex Williamson<br>
<b>=B3=AD=CB=CD:</b> FelixCui-oc; Richard Henderson; Eduardo Habkost; qemu-=
devel@nongnu.org; RockCui-oc; Tony W Wang-oc; CobeChen-oc<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH 1/1] Skip flatview_simplify() for cpu vendo=
r zhaoxin</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 21/10/20 00:44, Alex Williamson wrote:<br>
&gt; Do we necessarily need a memory map ioctl for this or could it be the<=
br>
&gt; QEMU code that compares the old and new maps to trigger map and unmap<=
br>
&gt; ioctls?&nbsp; For example (aiui) our race is that if we have contiguou=
s<br>
&gt; memory regions A and B and flatview_simplify() tries to expand A and<b=
r>
&gt; delete B we'll see a series of listener notifications deleting A and B=
<br>
&gt; and adding A'.&nbsp; But the vfio QEMU code could parse the memory map=
 to<br>
&gt; determine that old A &#43; B is functionally equivalent to A' and do<b=
r>
&gt; nothing.<br>
<br>
I think the issue is a bit different, and in fact there are two sides of<br=
>
the same issue.&nbsp; Say you have A (large) and it is replaced by A'<br>
(smaller) &#43; B, then:<br>
<br>
* the first part of A disappears for a moment before A' appears.&nbsp; This=
<br>
is something that QEMU can work around, by not doing anything<br>
<br>
* the second part of A disappears for a moment before B appears.&nbsp; This=
<br>
is the root API issue and not something that QEMU can work around; and<br>
in fact it is not even fixed by removing flatview_simplify.<br>
<br>
Felix, did you identify the regions whose simplification causes the bug?<br=
>
&nbsp;Is this RAM (for example due to the PAM registers) or something else?=
<br>
<br>
Paolo<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_6b7179fb801c4ef1919153ebee85c256zhaoxincom_--

