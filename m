Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65857C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 03:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D49208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 03:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D49208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVQt9-0007A7-8z
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 23:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kVQsI-0006WU-2S
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 23:02:46 -0400
Received: from zxshcas1.zhaoxin.com ([203.148.12.81]:44287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kVQsE-0006mS-Ea
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 23:02:45 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 22 Oct
 2020 11:02:33 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 22 Oct
 2020 11:02:32 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Thu, 22 Oct 2020 11:02:32 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvMV0gU2tpcCBmbGF0dmlld19zaW1wbGlmeSgpIGZv?=
 =?gb2312?Q?r_cpu_vendor_zhaoxin?=
Thread-Topic: [PATCH 1/1] Skip flatview_simplify() for cpu vendor zhaoxin
Thread-Index: AQHWo6+lIFwCGFufXkSJFIAohPLGXamZlV6AgAUx0wCAAPEVAIAA32uAgACU/oCAALuMAIAAEROAgADx78s=
Date: Thu, 22 Oct 2020 03:02:32 +0000
Message-ID: <0e275d4de640431cb07de7fafb4d9ef1@zhaoxin.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
 <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
 <20201019130206.1d3baffc@w520.home>
 <4d2b96cb-8f7f-2598-39e6-4cf0f61d567b@redhat.com>
 <20201020164437.5e3cb4ce@w520.home>
 <783b5ef0-277c-363d-f342-7c0351f9ac16@redhat.com>
 <20201021124908.53c7a98b@w520.home>,
 <eaab570f-741e-7397-09c2-8e47f0a6d32c@redhat.com>
In-Reply-To: <eaab570f-741e-7397-09c2-8e47f0a6d32c@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.40]
Content-Type: multipart/alternative;
 boundary="_000_0e275d4de640431cb07de7fafb4d9ef1zhaoxincom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=203.148.12.81;
 envelope-from=FelixCui-oc@zhaoxin.com; helo=ZXSHCAS1.zhaoxin.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 23:02:34
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

--_000_0e275d4de640431cb07de7fafb4d9ef1zhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgICwNCg0KPkkgYXNzdW1lIGl0J3MgdGhlIEJJT1MncyBkcml2ZXIgYW5kIGl0J3MgY2hvb3Np
bmcgYSByYW5nZSBpbiBsb3cgbWVtb3J5LA0KPmJ1dCBzdGlsbCBJJ20gbm90IHN1cmUgd2h5IGl0
cyBETUEgaXMgcmFjaW5nIGFnYWluc3QgdGhlIFBBTSB1cGRhdGUNCj4od2hpY2ggaXMgZG9uZSB2
ZXJ5IGVhcmx5KS4gIEZlbGl4LCBkbyB5b3Uga25vdyB0aGUgYW5zd2VyPw0KDQoNClRoaXMgYnVn
IGlzIHRyaWdnZXJlZCBieSBtYWtlX2Jpb3NfcmVhZG9ubHkoKSBpbiBzZWFiaW9zLiBNYWtlX2Jp
b3NfcmVhZG9ubHkoKSB3aWxsIHdyaXRlIHBhbSByZWdpc3Rlci4NCg0KQW5kIGVoY2lfc2V0dXAo
KSBpcyBleGVjdXRlZCBiZWZvcmUgbWFrZV9iaW9zX3JlYWRvbmx5KCkuIEFmdGVyIGluaXRpYWxp
emluZyBFSENJIGluIHNlYWJpb3MsIGl0IHdpbGwNCg0KY29udGludW91c2x5IHNlbmQgZG1hIGN5
Y2xlcy4gU28gd2hlbiB3cml0ZSBwYW0gcmVnaXN0ZXIsIHRoaXMgYnVnIGFwcGVhcmVkLg0KDQoN
CkluIGFkZGl0aW9uLCBiZWZvcmUgd3JpdGUgcGFtIHJlZ2lzdGVycywgZmxhdHZpZXdfc2ltcGxp
ZnkoKSBoYXMgbWVyZ2VkIGEgdmVyeSBsYXJnZSByYW5nZS5Gb3IgZXhhbXBsZSwNCg0KdGhpcyBs
YXJnZSByYW5nZSBpcyAweGMwMDAwLTB4YmZmZmZmZmYuIFNvIGV2ZW4gaWYgRUhDSSBpcyBjb25m
aWd1cmVkIHRvIG5vdCBhbGxvY2F0ZSBidWZmZXJzIGluIGxvdyBtZW1vcnksDQoNCnRoaXMgYnVn
IHdpbGwgc3RpbGwgb2NjdXIuVGhhbmtzLg0KDQoNCkJlc3QgcmVnYXJkcw0KDQpGZWxpeGN1aS1v
Yw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBQYW9sbyBCb256
aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0Kt6LLzcqxvOQ6IDIwMjDE6jEw1MIyMsjVIDM6NTA6
MTUNCsrVvP7IyzogQWxleCBXaWxsaWFtc29uDQqzrcvNOiBGZWxpeEN1aS1vYzsgUmljaGFyZCBI
ZW5kZXJzb247IEVkdWFyZG8gSGFia29zdDsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBSb2NrQ3Vp
LW9jOyBUb255IFcgV2FuZy1vYzsgQ29iZUNoZW4tb2MNCtb3zOI6IFJlOiBbUEFUQ0ggMS8xXSBT
a2lwIGZsYXR2aWV3X3NpbXBsaWZ5KCkgZm9yIGNwdSB2ZW5kb3Igemhhb3hpbg0KDQpPbiAyMS8x
MC8yMCAyMDo0OSwgQWxleCBXaWxsaWFtc29uIHdyb3RlOg0KPiBJIGNhbiB1bmRlcnN0YW5kIHRo
ZSBnZW5lcmFsIGJlbmVmaXQgb2YgZmxhdHZpZXdfc2ltcGxpZnkoKSwgYnV0IEkNCj4gd29uZGVy
IGlmIHRoZSBiZXN0IHNob3J0IHRlcm0gc29sdXRpb24gaXMgdG8gc2tpcCBvcGVyYXRpbmcgb24g
dGhlIHg4Ng0KPiBQQU0gcmFuZ2UsIHdoaWNoIEkgdW5kZXJzdGFuZCB0byBiZSBhIHNtYWxsIG51
bWJlciBvZiBtZW1vcnkgY2h1bmtzDQo+IGJlbG93IDFNQi4NCg0KSSdkIHJhdGhlciByZW1vdmUg
ZmxhdHZpZXdfc2ltcGxpZnkgYWx0b2dldGhlciwgaXQgcHJvYmFibHkgdHJpZ2dlcnMNCnJlbGF0
aXZlbHkgcmFyZWx5LiAgUG9zc2libHkgZG8gbm90IGxldCBpdCBvcGVyYXRlIG9uIFJBTS9ST00g
cmVnaW9ucywNCm9ubHkgb24gSS9PIHJlZ2lvbnMuDQoNCj4gSSBtaWdodCBhbHNvIHdvbmRlciB3
aHkgdGhlIEVIQ0kgY29udHJvbGxlciBvbiB0aGlzDQo+IHBsYXRmb3JtIGlzIGNob29zaW5nIHRo
YXQgcmFuZ2UgZm9yIERNQS4NCg0KSSBhc3N1bWUgaXQncyB0aGUgQklPUydzIGRyaXZlciBhbmQg
aXQncyBjaG9vc2luZyBhIHJhbmdlIGluIGxvdyBtZW1vcnksDQpidXQgc3RpbGwgSSdtIG5vdCBz
dXJlIHdoeSBpdHMgRE1BIGlzIHJhY2luZyBhZ2FpbnN0IHRoZSBQQU0gdXBkYXRlDQood2hpY2gg
aXMgZG9uZSB2ZXJ5IGVhcmx5KS4gIEZlbGl4LCBkbyB5b3Uga25vdyB0aGUgYW5zd2VyPw0KDQpQ
YW9sbw0KDQo=

--_000_0e275d4de640431cb07de7fafb4d9ef1zhaoxincom_
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
<p>hi&nbsp; ,</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;I assume it's t=
he BIOS's driver and it's choosing a range in low memory,</span><br style=
=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-seri=
f,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;but still I'm not =
sure why its DMA is racing against the PAM update</span><br style=3D"color:=
rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft Y=
aHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Em=
ojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;(which is done ver=
y early).&nbsp; Felix, do you know the answer?</span><br>
</p>
<p><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">This bug is trigger=
ed by make_bios_readonly() in seabios. Make_bios_readonly() will write pam =
register.</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"></span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">And&nbsp;ehci_setup=
() is executed before make_bios_readonly().&nbsp;After initializing EHCI in=
 seabios, it will</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">continuously send d=
ma cycles.&nbsp;So when write pam register, this bug appeared.</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"></p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<br>
</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"></span></p>
</span>
<p></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">In addition, before write pam registers=
, flatview_simplify() has merged a very large range.For example,</span></fo=
nt></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">this large range is 0xc0000-0xbfffffff.=
&nbsp;So even if EHCI is configured to not allocate buffers in low memory,<=
/span></font></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">this bug will still occur.Thanks.</span=
></font></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px"><br>
</span></font></p>
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
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA10=D4=C222=C8=D5 3:50:15<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Alex Williamson<br>
<b>=B3=AD=CB=CD:</b> FelixCui-oc; Richard Henderson; Eduardo Habkost; qemu-=
devel@nongnu.org; RockCui-oc; Tony W Wang-oc; CobeChen-oc<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH 1/1] Skip flatview_simplify() for cpu vendo=
r zhaoxin</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 21/10/20 20:49, Alex Williamson wrote:<br>
&gt; I can understand the general benefit of flatview_simplify(), but I<br>
&gt; wonder if the best short term solution is to skip operating on the x86=
<br>
&gt; PAM range, which I understand to be a small number of memory chunks<br=
>
&gt; below 1MB.<br>
<br>
I'd rather remove flatview_simplify altogether, it probably triggers<br>
relatively rarely.&nbsp; Possibly do not let it operate on RAM/ROM regions,=
<br>
only on I/O regions.<br>
<br>
&gt; I might also wonder why the EHCI controller on this<br>
&gt; platform is choosing that range for DMA.<br>
<br>
I assume it's the BIOS's driver and it's choosing a range in low memory,<br=
>
but still I'm not sure why its DMA is racing against the PAM update<br>
(which is done very early).&nbsp; Felix, do you know the answer?<br>
<br>
Paolo<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_0e275d4de640431cb07de7fafb4d9ef1zhaoxincom_--

