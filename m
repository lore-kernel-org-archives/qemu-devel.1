Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC42DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 07:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D4A22203
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 07:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D4A22203
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUPCj-0006HB-KD
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 03:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kUPBf-0005RC-TX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:02:33 -0400
Received: from zxshcas1.zhaoxin.com ([203.148.12.81]:32020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kUPBZ-0006sP-Ml
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:02:30 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 19 Oct
 2020 14:55:53 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 19 Oct
 2020 14:55:52 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Mon, 19 Oct 2020 14:55:52 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvMV0gU2tpcCBmbGF0dmlld19zaW1wbGlmeSgpIGZv?=
 =?gb2312?Q?r_cpu_vendor_zhaoxin?=
Thread-Topic: [PATCH 1/1] Skip flatview_simplify() for cpu vendor zhaoxin
Thread-Index: AQHWo6+lIFwCGFufXkSJFIAohPLGXamZlV6AgATpvi8=
Date: Mon, 19 Oct 2020 06:55:52 +0000
Message-ID: <ad6ad56ab786426ba8c2d6ea4646a986@zhaoxin.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>,
 <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
In-Reply-To: <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.40]
Content-Type: multipart/alternative;
 boundary="_000_ad6ad56ab786426ba8c2d6ea4646a986zhaoxincom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=203.148.12.81;
 envelope-from=FelixCui-oc@zhaoxin.com; helo=ZXSHCAS1.zhaoxin.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:55:54
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
Cc: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 RockCui-oc <RockCui-oc@zhaoxin.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 CobeChen-oc <CobeChen-oc@zhaoxin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_ad6ad56ab786426ba8c2d6ea4646a986zhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgcGFvbG8sDQoNCg0KPjIpIHlvdSdyZSBhZGRpbmcgYSBjaGVjayBmb3IgdGhlIGhvc3QsIGJ1
dCB0aGUgYnVnIGFwcGxpZXMgdG8gYWxsIGhvc3RzLg0KPklmIHRoZXJlIGlzIGEgYnVnIG9uIHg4
NiBoYXJkd2FyZSBlbXVsYXRpb24sIGl0IHNob3VsZCBiZSBmaXhlZCBldmVuDQo+d2hlbiBlbXVs
YXRpbmcgeDg2IGZyb20gQVJNLiAgSXQgc2hvdWxkIGFsc28gYXBwbHkgdG8gYWxsIENQVSB2ZW5k
b3JzLg0KDQoNCldoYXQgaXMgdGhlIHByb2dyZXNzIG9mIGhhbmRsaW5nIHRoaXMgYnVnID8NCg0K
SWYgdGhlIHByb2Nlc3NpbmcgaXMgbW9yZSBjb21wbGljYXRlZCwgY2FuIHdlIHRlbXBvcmFyaWx5
IHJlbW92ZSBmbGF0dmlld19zaW1wbGlmeSgpPw0KDQoNCmhpIEFsZXgsDQoNCg0KPnRoZSBpc3N1
ZSBoZXJlIGlzIHRoYXQgdGhlIGRlbGV0ZSthZGQgcGFzc2VzIGFyZSByYWNpbmcgYWdhaW5zdCBh
bg0KPmFzc2lnbmVkIGRldmljZSdzIERNQQ0KDQoNClBsZWFzZSBoZWxwIGNvbW1lbnQgaG93IHRv
IHNvbHZlIHRoaXMgcHJvYmxlbS4NCg0KDQpCZXN0IHJlZ2FyZHMNCg0KRmVsaXhjdWktb2MNCg0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBQYW9sbyBCb256aW5p
IDxwYm9uemluaUByZWRoYXQuY29tPg0Kt6LLzcqxvOQ6IDIwMjDE6jEw1MIxNsjVIDE5OjQyOjI5
DQrK1bz+yMs6IEZlbGl4Q3VpLW9jOyBSaWNoYXJkIEhlbmRlcnNvbjsgRWR1YXJkbyBIYWJrb3N0
OyBBbGV4IFdpbGxpYW1zb24NCrOty806IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgUm9ja0N1aS1v
YzsgVG9ueSBXIFdhbmctb2M7IENvYmVDaGVuLW9jOyBBbGV4IFdpbGxpYW1zb24NCtb3zOI6IFJl
OiBbUEFUQ0ggMS8xXSBTa2lwIGZsYXR2aWV3X3NpbXBsaWZ5KCkgZm9yIGNwdSB2ZW5kb3Igemhh
b3hpbg0KDQpPbiAxNi8xMC8yMCAxMzoyOSwgRmVsaXhDdWlvYyB3cm90ZToNCj4gVGhlIGlzc3Vl
IGhlcmUgaXMgdGhhdCBhbiBhc3NpbmdlZCBFSENJIGRldmljZSBhY2Nlc3Nlcw0KPiBhbiBhZGph
Y2VudCBtYXBwaW5nIGJldHdlZW4gdGhlIGRlbGV0ZSBhbmQgYWRkIHBoYXNlcw0KPiBvZiB0aGUg
VkZJTyBNZW1vcnlMaXN0ZW5lci4NCj4gV2Ugd2FudCB0byBza2lwIGZsYXR2aWV3X3NpbXBsaWZ5
KCkgaXMgdG8gcHJldmVudCBFSENJDQo+IGRldmljZSBJT1ZBIG1hcHBpbmdzIGZyb20gYmVpbmcg
dW5tYXBwZWQuDQoNCkhpLA0KDQp0aGVyZSBpcyBpbmRlZWQgYSBidWcsIGJ1dCBJIGhhdmUgYWxy
ZWFkeSBleHBsYWluZWQgbGFzdCBtb250aA0KKGh0dHBzOi8vbWFpbC5nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMjAtMDkvbXNnMDEyNzkuaHRtbCkNCnRoYXQgdGhpcyBwYXRjaCBp
cyBjb25jZXB0dWFsbHkgd3Jvbmc6DQoNCjEpIHlvdSdyZSBhZGRpbmcgaG9zdF9nZXRfdmVuZG9y
IGNvbmRpdGlvbmVkIG9uIGNvbXBpbGluZyB0aGUgeDg2DQplbXVsYXRvciwgc28geW91IGFyZSBi
cmVha2luZyBjb21waWxhdGlvbiBvbiBub24teDg2IG1hY2hpbmVzLg0KDQoyKSB5b3UncmUgYWRk
aW5nIGEgY2hlY2sgZm9yIHRoZSBob3N0LCBidXQgdGhlIGJ1ZyBhcHBsaWVzIHRvIGFsbCBob3N0
cy4NCiBJZiB0aGVyZSBpcyBhIGJ1ZyBvbiB4ODYgaGFyZHdhcmUgZW11bGF0aW9uLCBpdCBzaG91
bGQgYmUgZml4ZWQgZXZlbg0Kd2hlbiBlbXVsYXRpbmcgeDg2IGZyb20gQVJNLiAgSXQgc2hvdWxk
IGFsc28gYXBwbHkgdG8gYWxsIENQVSB2ZW5kb3JzLg0KDQpBbGV4LCB0aGUgaXNzdWUgaGVyZSBp
cyB0aGF0IHRoZSBkZWxldGUrYWRkIHBhc3NlcyBhcmUgcmFjaW5nIGFnYWluc3QgYW4NCmFzc2ln
bmVkIGRldmljZSdzIERNQS4gRm9yIEtWTSB3ZSB3ZXJlIHRoaW5raW5nIG9mIGNoYW5naW5nIHRo
ZSB3aG9sZQ0KbWVtb3J5IG1hcCB3aXRoIGEgc2luZ2xlIGlvY3RsLCBidXQgdGhhdCdzIG11Y2gg
ZWFzaWVyIGJlY2F1c2UgS1ZNDQpidWlsZHMgaXRzIHBhZ2UgdGFibGVzIGxhemlseS4gSXQgd291
bGQgYmUgcG9zc2libGUgZm9yIHRoZSBJT01NVSB0b28NCmJ1dCBpdCB3b3VsZCByZXF1aXJlIGEg
cmVsYXRpdmVseSBjb21wbGljYXRlZCBjb21wYXJpc29uIG9mIHRoZSBvbGQgYW5kDQpuZXcgbWVt
b3J5IG1hcHMgaW4gdGhlIGtlcm5lbC4NCg0KUGFvbG8NCg0K

--_000_ad6ad56ab786426ba8c2d6ea4646a986zhaoxincom_
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
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;2) you're addin=
g a check for the host, but the bug applies to all hosts.</span><br style=
=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-seri=
f,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;If there is a bug =
on x86 hardware emulation, it should be fixed even</span><br style=3D"color=
:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft =
YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,E=
mojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;when emulating x86=
 from ARM.&nbsp; It should also apply to all CPU vendors.</span>&nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;</p>
<p><br>
</p>
<p>What is the progress of handling this bug ?&nbsp;</p>
<p>If the processing is more complicated, can we temporarily remove flatvie=
w_simplify()?</p>
<p><br>
</p>
<p>hi Alex,</p>
<p><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;the issue here =
is that the delete&#43;add passes are racing against an</span><br style=3D"=
color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Micro=
soft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,se=
rif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;assigned device's =
DMA</span><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p>Please help comment how to solve this problem.<span style=3D"color:rgb(3=
3,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&=
quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFo=
nt; font-size:13.3333px"></span></p>
<p><br>
</p>
<p>Best regards</p>
<p>Felixcui-oc&nbsp;</p>
<p><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Paolo=
 Bonzini &lt;pbonzini@redhat.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA10=D4=C216=C8=D5 19:42:29<br>
<b>=CA=D5=BC=FE=C8=CB:</b> FelixCui-oc; Richard Henderson; Eduardo Habkost;=
 Alex Williamson<br>
<b>=B3=AD=CB=CD:</b> qemu-devel@nongnu.org; RockCui-oc; Tony W Wang-oc; Cob=
eChen-oc; Alex Williamson<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH 1/1] Skip flatview_simplify() for cpu vendo=
r zhaoxin</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 16/10/20 13:29, FelixCuioc wrote:<br>
&gt; The issue here is that an assinged EHCI device accesses<br>
&gt; an adjacent mapping between the delete and add phases<br>
&gt; of the VFIO MemoryListener.<br>
&gt; We want to skip flatview_simplify() is to prevent EHCI<br>
&gt; device IOVA mappings from being unmapped.<br>
<br>
Hi,<br>
<br>
there is indeed a bug, but I have already explained last month<br>
(<a href=3D"https://mail.gnu.org/archive/html/qemu-devel/2020-09/msg01279.h=
tml">https://mail.gnu.org/archive/html/qemu-devel/2020-09/msg01279.html</a>=
)<br>
that this patch is conceptually wrong:<br>
<br>
1) you're adding host_get_vendor conditioned on compiling the x86<br>
emulator, so you are breaking compilation on non-x86 machines.<br>
<br>
2) you're adding a check for the host, but the bug applies to all hosts.<br=
>
&nbsp;If there is a bug on x86 hardware emulation, it should be fixed even<=
br>
when emulating x86 from ARM.&nbsp; It should also apply to all CPU vendors.=
<br>
<br>
Alex, the issue here is that the delete&#43;add passes are racing against a=
n<br>
assigned device's DMA. For KVM we were thinking of changing the whole<br>
memory map with a single ioctl, but that's much easier because KVM<br>
builds its page tables lazily. It would be possible for the IOMMU too<br>
but it would require a relatively complicated comparison of the old and<br>
new memory maps in the kernel.<br>
<br>
Paolo<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_ad6ad56ab786426ba8c2d6ea4646a986zhaoxincom_--

