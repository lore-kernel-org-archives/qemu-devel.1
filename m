Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795E3C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 06:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30ED320790
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 06:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ED320790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVU9e-0004KN-Qj
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 02:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kVU8R-0003OR-Ts
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 02:31:39 -0400
Received: from zxshcas1.zhaoxin.com ([203.148.12.81]:11460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kVU8P-0006bI-2D
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 02:31:39 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 22 Oct
 2020 14:31:27 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 22 Oct
 2020 14:31:27 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Thu, 22 Oct 2020 14:31:27 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIIDEvMV0gU2tpcCBmbGF0dmlld19zaW1wbGlm?=
 =?gb2312?Q?y()_for_cpu_vendor_zhaoxin?=
Thread-Topic: =?gb2312?B?tPC4tDogW1BBVENIIDEvMV0gU2tpcCBmbGF0dmlld19zaW1wbGlmeSgpIGZv?=
 =?gb2312?Q?r_cpu_vendor_zhaoxin?=
Thread-Index: AQHWo6+lIFwCGFufXkSJFIAohPLGXamZlV6AgAUx0wCAAPEVAIAA32uAgACU/oCAALuMAIAAEROAgADx78v//46xgIAAs1Fm
Date: Thu, 22 Oct 2020 06:31:26 +0000
Message-ID: <2b934315e08b4725b60c62602189d59a@zhaoxin.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
 <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
 <20201019130206.1d3baffc@w520.home>
 <4d2b96cb-8f7f-2598-39e6-4cf0f61d567b@redhat.com>
 <20201020164437.5e3cb4ce@w520.home>
 <783b5ef0-277c-363d-f342-7c0351f9ac16@redhat.com>
 <20201021124908.53c7a98b@w520.home>
 <eaab570f-741e-7397-09c2-8e47f0a6d32c@redhat.com>
 <0e275d4de640431cb07de7fafb4d9ef1@zhaoxin.com>,
 <606cf65a-a614-5c9b-705f-3a8f3707fb10@redhat.com>
In-Reply-To: <606cf65a-a614-5c9b-705f-3a8f3707fb10@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.40]
Content-Type: multipart/alternative;
 boundary="_000_2b934315e08b4725b60c62602189d59azhaoxincom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=203.148.12.81;
 envelope-from=FelixCui-oc@zhaoxin.com; helo=ZXSHCAS1.zhaoxin.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 02:31:28
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 HTML_FONT_FACE_BAD=0.001, HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_2b934315e08b4725b60c62602189d59azhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgcGFvbG8sDQoNCg0KPlNvIHJlbW92aW5nIGZsYXR2aWV3X3NpbXBsaWZ5KCkgd29ya3MgYmVj
YXVzZSB0aGUgaGlnaGVyIGFyZWEgKDB4MTAwMDANCg0KPmFuZCBhYm92ZSkgcmVtYWlucyB0aGUg
c2FtZS4gIEkgZ3Vlc3MgdGhlIHNpbXBsZXN0IHRoaW5nIHRvIGRvIGlzIHRvDQo+YXBwbHkgZmxh
dHZpZXdfc2ltcGxpZnkoKSBvbmx5IHRvIEkvTyBhcmVhcywgdGhvdWdoIHdlIGNhbiBhbHNvIGNv
bnNpZGVyDQo+cmVtb3ZpbmcgaXQgY29tcGxldGVseS4gIEknbSBub3Qgc3VyZSBpbiB3aGljaCBj
YXNlIGl0IHdvdWxkIHByb3ZpZGUgYQ0KPm5vdGljZWFibGUgaW1wcm92ZW1lbnQuDQoNCg0KSSBh
Z3JlZSB3aXRoIHlvdSB2ZXJ5IG11Y2guIEJvdGggb2YgdGhlc2UgY2FzZXMgY2FuIHNvbHZlIHRo
aXMgYnVnLg0KDQpUaGFua3MuDQoNCg0KQmVzdCByZWdhcmRzDQoNCkZlbGl4Y3VpLW9jDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IFBhb2xvIEJvbnppbmkgPHBi
b256aW5pQHJlZGhhdC5jb20+DQq3osvNyrG85DogMjAyMMTqMTDUwjIyyNUgMTE6MzA6MzcNCsrV
vP7IyzogRmVsaXhDdWktb2M7IEFsZXggV2lsbGlhbXNvbg0Ks63LzTogUmljaGFyZCBIZW5kZXJz
b247IEVkdWFyZG8gSGFia29zdDsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBSb2NrQ3VpLW9jOyBU
b255IFcgV2FuZy1vYzsgQ29iZUNoZW4tb2MNCtb3zOI6IFJlOiC08Li0OiBbUEFUQ0ggMS8xXSBT
a2lwIGZsYXR2aWV3X3NpbXBsaWZ5KCkgZm9yIGNwdSB2ZW5kb3Igemhhb3hpbg0KDQpPbiAyMi8x
MC8yMCAwNTowMiwgRmVsaXhDdWktb2Mgd3JvdGU6DQo+IEluIGFkZGl0aW9uLCBiZWZvcmUgd3Jp
dGUgcGFtIHJlZ2lzdGVycywgZmxhdHZpZXdfc2ltcGxpZnkoKSBoYXMgbWVyZ2VkDQo+IGEgdmVy
eSBsYXJnZSByYW5nZS5Gb3IgZXhhbXBsZSwNCj4NCj4gdGhpcyBsYXJnZSByYW5nZSBpcyAweGMw
MDAwLTB4YmZmZmZmZmYuIFNvIGV2ZW4gaWYgRUhDSSBpcyBjb25maWd1cmVkIHRvDQo+IG5vdCBh
bGxvY2F0ZSBidWZmZXJzIGluIGxvdyBtZW1vcnksDQo+DQo+IHRoaXMgYnVnIHdpbGwgc3RpbGwg
b2NjdXIuVGhhbmtzLg0KDQpTbyByZW1vdmluZyBmbGF0dmlld19zaW1wbGlmeSgpIHdvcmtzIGJl
Y2F1c2UgdGhlIGhpZ2hlciBhcmVhICgweDEwMDAwDQphbmQgYWJvdmUpIHJlbWFpbnMgdGhlIHNh
bWUuICBJIGd1ZXNzIHRoZSBzaW1wbGVzdCB0aGluZyB0byBkbyBpcyB0bw0KYXBwbHkgZmxhdHZp
ZXdfc2ltcGxpZnkoKSBvbmx5IHRvIEkvTyBhcmVhcywgdGhvdWdoIHdlIGNhbiBhbHNvIGNvbnNp
ZGVyDQpyZW1vdmluZyBpdCBjb21wbGV0ZWx5LiAgSSdtIG5vdCBzdXJlIGluIHdoaWNoIGNhc2Ug
aXQgd291bGQgcHJvdmlkZSBhDQpub3RpY2VhYmxlIGltcHJvdmVtZW50Lg0KDQpQYW9sbw0KDQo=

--_000_2b934315e08b4725b60c62602189d59azhaoxincom_
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
<p>hi paolo,</p>
<p><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;So removing fla=
tview_simplify() works because the higher area (0x10000</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"></span><span style=
=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-seri=
f,serif,EmojiFont; font-size:13.3333px">&gt;and
 above) remains the same.&nbsp; I guess the simplest thing to do is to</spa=
n><br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;apply flatview_sim=
plify() only to I/O areas, though we can also consider</span><br style=3D"c=
olor:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Micros=
oft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,ser=
if,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;removing it comple=
tely.&nbsp; I'm not sure in which case it would provide a</span><br style=
=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-seri=
f,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;noticeable improve=
ment.</span><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">I agree with you ve=
ry much. Both of these cases can solve this bug.</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Thanks.</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">Best regards</span></font></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">Felixcui-oc</span></font></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Paolo=
 Bonzini &lt;pbonzini@redhat.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA10=D4=C222=C8=D5 11:30:37<br>
<b>=CA=D5=BC=FE=C8=CB:</b> FelixCui-oc; Alex Williamson<br>
<b>=B3=AD=CB=CD:</b> Richard Henderson; Eduardo Habkost; qemu-devel@nongnu.=
org; RockCui-oc; Tony W Wang-oc; CobeChen-oc<br>
<b>=D6=F7=CC=E2:</b> Re: =B4=F0=B8=B4: [PATCH 1/1] Skip flatview_simplify()=
 for cpu vendor zhaoxin</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 22/10/20 05:02, FelixCui-oc wrote:<br>
&gt; In addition, before write pam registers, flatview_simplify() has merge=
d<br>
&gt; a very large range.For example,<br>
&gt; <br>
&gt; this large range is 0xc0000-0xbfffffff.&nbsp;So even if EHCI is config=
ured to<br>
&gt; not allocate buffers in low memory,<br>
&gt; <br>
&gt; this bug will still occur.Thanks.<br>
<br>
So removing flatview_simplify() works because the higher area (0x10000<br>
and above) remains the same.&nbsp; I guess the simplest thing to do is to<b=
r>
apply flatview_simplify() only to I/O areas, though we can also consider<br=
>
removing it completely.&nbsp; I'm not sure in which case it would provide a=
<br>
noticeable improvement.<br>
<br>
Paolo<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_2b934315e08b4725b60c62602189d59azhaoxincom_--

