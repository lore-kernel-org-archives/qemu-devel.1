Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C67C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89DC20EDD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89DC20EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFqfU-0003u9-RD
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 23:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <RockCui-oc@zhaoxin.com>)
 id 1kFqeY-0002r5-N2
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 23:20:10 -0400
Received: from [203.148.12.81] (port=53169 helo=ZXSHCAS1.zhaoxin.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <RockCui-oc@zhaoxin.com>)
 id 1kFqeU-0007Og-Dt
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 23:20:10 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 11:13:42 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 11:13:41 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Wed, 9 Sep 2020 11:13:41 +0800
From: RockCui-oc <RockCui-oc@zhaoxin.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBpZGU6ZG8gbm90aGluZyBmb3IgaWRlbnRpZnkgY21k?=
 =?gb2312?Q?_if_no_any_device_attached?=
Thread-Topic: [PATCH] ide:do nothing for identify cmd if no any device attached
Thread-Index: AQHWdEfWn1VcMPOnkU+PO9h+3wgKR6lVN70AgAEW7ACACXBwng==
Date: Wed, 9 Sep 2020 03:13:41 +0000
Message-ID: <4ee746f7bb364ed491d2b00a9b810183@zhaoxin.com>
References: <20200817033803.14014-1-RockCui-oc@zhaoxin.com>
 <8dbcc856-879a-af83-1a76-a2a875da3699@redhat.com>,
 <0347935f-5235-3c61-07cc-fb4435ec45d1@redhat.com>
In-Reply-To: <0347935f-5235-3c61-07cc-fb4435ec45d1@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.52]
Content-Type: multipart/alternative;
 boundary="_000_4ee746f7bb364ed491d2b00a9b810183zhaoxincom_"
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 203.148.12.81 (failed)
Received-SPF: pass client-ip=203.148.12.81;
 envelope-from=RockCui-oc@zhaoxin.com; helo=ZXSHCAS1.zhaoxin.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 23:13:44
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: 45
X-Spam_score: 4.5
X-Spam_bar: ++++
X-Spam_report: (4.5 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Cobe Chen\(BJ-RD\)" <CobeChen@zhaoxin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_4ee746f7bb364ed491d2b00a9b810183zhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgSm9obiAmIE1heKOsDQoNCg0KICAxLiAgRm9sbG93IG15IExvZ6OsdGhlcmUgYXJlIDEwMDAw
IHJlYWQgMHgxeDcgb3BzLiBPbiBteSBJbnRlbCBJNSBwbGF0Zm9ybSwgaWYgZG93biB0aGUgZnJl
cXVlbmN5IHRvIDEuMkcsIHlvdSBjYW4gc2VlIGEgb2J2aW91c2x5IGxhZyBkdXJpbmcgV0lORE9X
UyBMT0dPIGFuaW1hdGlvbiBwbGF5aW5nLg0KICAyLiAgV2UgbXVzdCBzdXBwbHkgYSBDRC1ST00g
dG8gb3VyIFZESSB1c2Vycy4NCiAgMy4gIEluIGlkZV9pb3BvcnRfcmVhZCgpIDoNCg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpjYXNlIDc6DQogICAgICAgaWYg
KCghYnVzLT5pZnNbMF0uYmxrICYmICFidXMtPmlmc1sxXS5ibGspIHx8IChzICE9IGJ1cy0+aWZz
ICYmICFzLT5ibGspKSB7DQogICAgICAgICAgICByZXQgPSAwOw0KICAgICAgIH0gZWxzZSB7DQog
ICAgICAgICAgICByZXQgPSBzLT5zdGF0dXM7DQogICAgICAgfQ0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICAgICAgICAgICAgc28gSSBmb2xsb3cgdGhpcy4N
Cg0KUm9jaw0KDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7Iyzog
TWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCreiy83KsbzkOiAyMDIwxOo51MIzyNUgMTg6
NDANCsrVvP7IyzogSm9obiBTbm93OyBSb2NrQ3VpLW9jOyBxZW11LWRldmVsQG5vbmdudS5vcmcN
CrOty806IENvYmUgQ2hlbihCSi1SRCk7IFBldGVyIE1heWRlbGwNCtb3zOI6IFJlOiBbUEFUQ0hd
IGlkZTpkbyBub3RoaW5nIGZvciBpZGVudGlmeSBjbWQgaWYgbm8gYW55IGRldmljZSBhdHRhY2hl
ZA0KDQpPbiAwMi4wOS4yMCAyMDowMiwgSm9obiBTbm93IHdyb3RlOg0KPiAoQ0MgTWF4IGZvciBi
bG9jayBiYWNrZW5kIG1vZGVsIGNvbmZ1c2lvbiwgc2VlIGJlbG93KQ0KPg0KPiBPbiA4LzE2LzIw
IDExOjM4IFBNLCB6aGFveGluXFJvY2tDdWlvYyB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggaXMgZm9y
IGF2b2lkaW5nIHdpbjcgSURFIGRyaXZlciBwb2xsaW5nIDB4MWY3IHdoZW4NCj4+IG5vIGFueSBk
ZXZpY2UgYXR0YWNoZWQuIER1cmluZyBXaW43IFZNIGJvb3QgcHJvY2VkdXJlLCBpZiB1c2Ugdmly
dGlvIGZvcg0KPj4gZGlzayBhbmQgdGhlcmUgaXMgbm8gYW55IGRldmljZSBiZSBhdHRhY2hlZCBv
biBoZGEgJiBoZGIsIHRoZSB3aW43IElERQ0KPj4gZHJpdmVyDQo+PiB3b3VsZCBwb2xsIDB4MWY3
IGZvciBhIHdoaWxlLiBUaGlzIGFjdGlvbiBtYXkgYmUgc3RvcCB3aW5kb3dzIExPR08NCj4+IGF0
b21pYyBmb3INCj4+IGEgd2hpbGUgdG9vIG9uIGEgcG9vciBwZXJmb3JtYW5jZSBDUFUuDQo+Pg0K
Pg0KPiBBIGZldyBxdWVzdGlvbnM6DQo+DQo+ICgxKSBIb3cgc2xvdyBpcyB0aGUgcHJvYmluZz8N
Cj4NCj4gKDIpIElmIHRoZXJlIGFyZSBubyBkZXZpY2VzIGF0dGFjaGVkLCB3aHkgZG9uJ3QgeW91
IHJlbW92ZSB0aGUgSURFDQo+IGNvbnRyb2xsZXIgc28gdGhhdCBXaW5kb3dzIGRvZXNuJ3QgaGF2
ZSB0byBwcm9iZSBpdD8NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IHpoYW94aW5cUm9ja0N1aW9jIDxS
b2NrQ3VpLW9jQHpoYW94aW4uY29tPg0KPj4gLS0tDQo+PiAgIGh3L2lkZS9jb3JlLmMgfCA1ICsr
Ky0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2lkZS9jb3JlLmMgYi9ody9pZGUvY29yZS5jDQo+PiBp
bmRleCBkOTk3YTc4ZTQ3Li4yNmQ4NmY0YjQwIDEwMDY0NA0KPj4gLS0tIGEvaHcvaWRlL2NvcmUu
Yw0KPj4gKysrIGIvaHcvaWRlL2NvcmUuYw0KPj4gQEAgLTIwNzMsOCArMjA3Myw5IEBAIHZvaWQg
aWRlX2V4ZWNfY21kKElERUJ1cyAqYnVzLCB1aW50MzJfdCB2YWwpDQo+PiAgICAgICBzID0gaWRl
YnVzX2FjdGl2ZV9pZihidXMpOw0KPj4gICAgICAgdHJhY2VfaWRlX2V4ZWNfY21kKGJ1cywgcywg
dmFsKTsNCj4+ICAgLSAgICAvKiBpZ25vcmUgY29tbWFuZHMgdG8gbm9uIGV4aXN0ZW50IHNsYXZl
ICovDQo+PiAtICAgIGlmIChzICE9IGJ1cy0+aWZzICYmICFzLT5ibGspIHsNCg0KKFdhcyB0aGUg
Zmlyc3Qgb25lIGJhc2ljYWxseSBtZWFudCB0byBiZSChsHMgIT0gJmJ1cy0+aWZzWzBdobEsIGku
ZS4gdG8NCmNoZWNrIHRoYXQgdGhpcyBkb2VzbqGvdCBnbyB0byB0aGUgbWFeVyBwcmltYXJ5PyAg
Tm90IHRvbyBvYnZpb3VzLikNCg0KPj4gKyAgICAvKiBpZ25vcmUgY29tbWFuZHMgaWYgbm8gYW55
IGRldmljZSBleGlzdCBvciBub24gZXhpc3RlbnQgc2xhdmUgKi8NCj4+ICsgICAgaWYgKCghYnVz
LT5pZnNbMF0uYmxrICYmICFidXMtPmlmc1sxXS5ibGspIHx8DQo+PiArICAgICAgICAocyAhPSBi
dXMtPmlmcyAmJiAhcy0+YmxrKSkgew0KDQooTWF5YmUgdGhpcyBjb3VsZCBiZSBpbXByb3ZlZCBo
ZXJlKQ0KDQo+PiAgICAgICAgICAgcmV0dXJuOw0KPj4gICAgICAgfQ0KPj4NCj4NCj4gSSB0aGlu
ayBpdCdzIHRoZSBjYXNlIHRoYXQgRW1wdHkgQ0QtUk9NIGRyaXZlcyB3aWxsIGhhdmUgYW4gYW5v
bnltb3VzDQo+IGJsb2NrIGJhY2tlbmQgcmVwcmVzZW50aW5nIHRoZSBlbXB0eSBkcml2ZSwNCg0K
KEFzIGZhciBhcyBJIHJlbWVtYmVyLCkgeWVzLg0KDQooaWRlX2Rldl9pbml0Zm4oKSBlbnN1cmVz
IGFsbCBDRCBkcml2ZXMgaGF2ZSBvbmUsIGV2ZW4gaWYgaXShr3MgZW1wdHkuKQ0KDQo+IHNvIEkg
c3VwcG9zZSB0aGlzIGlzIG1heWJlDQo+IGZpbmU/DQo+DQo+IEkgc3VwcG9zZSB0aGUgaWRlYSBp
cyB0aGF0IHdpdGggbm8gZHJpdmVzIG9uIHRoZSBidXMgdGhhdCBpdCdzIGZpbmUgdG8NCj4gaWdu
b3JlIHRoZSByZWdpc3RlciB3cml0ZXMsIGFzIHRoZXJlIGFyZSBubyBkZXZpY2VzIHRvIHJlY29y
ZCB0aG9zZSB3cml0ZXMuDQo+DQo+IChCdXQgdGhlbiwgd2h5IGRpZCB3ZSBldmVyIG9ubHkgY2hl
Y2sgZGV2aWNlMT8gLi4uKQ0KPg0KPiBNYXliZSBiZWZvcmUgdGhlIGJsb2NrLWJhY2tlbmQgc3Bs
aXQgd2UgdXNlZCB0byBoYXZlIHRvIGNoZWNrIHRvIHNlZSBpZg0KPiB3ZSBoYWQgYXR0YWNoZWQg
bWVkaWEgb3Igbm90LCBidXQgSSB0aGluayBub3dhZGF5cyB3ZSBzaG91bGQgYWx3YXlzIGhhdmUN
Cj4gYSBibGsgcG9pbnRlciBpZiB3ZSBoYXZlIGEgZGV2aWNlIG1vZGVsIGludGVuZGVkIHRvIGJl
IG9wZXJhdGluZyBhdCB0aGlzDQo+IGFkZHJlc3MuDQoNClRoZSBjaGVjayBpbiBpZGVfZGV2X2lu
aXRmbigpIGxvb2tzIHRoYXQgd2F5IHRvIG1lLg0KDQo+IFNvIEkgZ3Vlc3MgaXQgY2FuIGJlIHNp
bXBsaWZpZWQgLi4uPw0KPg0KPiBpZiAoIXMtPmJsaykgew0KPiAgICAgcmV0dXJuOw0KPiB9DQoN
ClByb2JhYmx5LiAgQWx0aG91Z2ggdGhlcmWhr3MgYSBkaWZmZXJlbmNlLCBvZiBjb3Vyc2UsIG5h
bWVseSBpZiB5b3UgaGF2ZQ0Kb25seSBhIHNlY29uZGFyeSBkZXZpY2UgYW5kIHRyeSB0byBhY2Nl
c3MgdGhlIHByaW1hcnksIHRoaXMgc2ltcGxpZmllZA0KdmVyc2lvbiB3aWxsIGJlIGEgbm8tb3As
IHdoZXJlYXMgdGhlIG1vcmUgY29tcGxpY2F0ZWQgdmVyc2lvbiBpbiB0aGlzDQpwYXRjaCB3b3Vs
ZCBzdGlsbCBnbyBvbi4gIEkgZG9uoa90IGtub3cgaG93IHJlYWwgaGFyZHdhcmUgd291bGQgaGFu
ZGxlDQp0aGF0IGNhc2UuICBJcyBpdCBldmVuIHBvc3NpYmxlIHRvIGhhdmUganVzdCBhIHNlY29u
ZGFyeSB3aXRoIG5vIHByaW1hcnk/DQoNCk1heA0KDQo=

--_000_4ee746f7bb364ed491d2b00a9b810183zhaoxincom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p>Hi John &amp; Max=A3=AC</p>
<p><br>
</p>
<ol style=3D"margin-bottom: 0px; margin-top: 0px;">
<li>Follow my Log=A3=ACthere are 10000 read 0x1x7 ops. On my Intel I5 platf=
orm, if down the frequency to 1.2G, you can see a obviously lag during WIND=
OWS LOGO animation playing.</li><li>We must supply a CD-ROM to our VDI user=
s.</li><li>In ide_ioport_read() :</li></ol>
<div>----------------------------------------------------------------------=
-----------------------------<br>
</div>
<div>case 7:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((!bus-&gt;ifs[0].blk &amp;&amp; !b=
us-&gt;ifs[1].blk) || (s !=3D bus-&gt;ifs &amp;&amp; !s-&gt;blk)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
s-&gt;status;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div>----------------------------------------------------------------------=
------------------------------</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <sp=
an>so I follow this.</span></div>
<div><span><br>
</span></div>
<div><span>Rock&nbsp;</span><br>
<br>
</div>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr style=3D"display:inline-block; width:98%" tabindex=3D"-1">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Max R=
eitz &lt;mreitz@redhat.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA9=D4=C23=C8=D5 18:40<br>
<b>=CA=D5=BC=FE=C8=CB:</b> John Snow; RockCui-oc; qemu-devel@nongnu.org<br>
<b>=B3=AD=CB=CD:</b> Cobe Chen(BJ-RD); Peter Maydell<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH] ide:do nothing for identify cmd if no any =
device attached</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 02.09.20 20:02, John Snow wrote:<br>
&gt; (CC Max for block backend model confusion, see below)<br>
&gt; <br>
&gt; On 8/16/20 11:38 PM, zhaoxin\RockCuioc wrote:<br>
&gt;&gt; This patch is for avoiding win7 IDE driver polling 0x1f7 when<br>
&gt;&gt; no any device attached. During Win7 VM boot procedure, if use virt=
io for<br>
&gt;&gt; disk and there is no any device be attached on hda &amp; hdb, the =
win7 IDE<br>
&gt;&gt; driver<br>
&gt;&gt; would poll 0x1f7 for a while. This action may be stop windows LOGO=
<br>
&gt;&gt; atomic for<br>
&gt;&gt; a while too on a poor performance CPU.<br>
&gt;&gt;<br>
&gt; <br>
&gt; A few questions:<br>
&gt; <br>
&gt; (1) How slow is the probing?<br>
&gt; <br>
&gt; (2) If there are no devices attached, why don't you remove the IDE<br>
&gt; controller so that Windows doesn't have to probe it?<br>
&gt; <br>
&gt;&gt; Signed-off-by: zhaoxin\RockCuioc &lt;RockCui-oc@zhaoxin.com&gt;<br=
>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; hw/ide/core.c | 5 &#43;&#43;&#43;--<br>
&gt;&gt; &nbsp; 1 file changed, 3 insertions(&#43;), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/ide/core.c b/hw/ide/core.c<br>
&gt;&gt; index d997a78e47..26d86f4b40 100644<br>
&gt;&gt; --- a/hw/ide/core.c<br>
&gt;&gt; &#43;&#43;&#43; b/hw/ide/core.c<br>
&gt;&gt; @@ -2073,8 &#43;2073,9 @@ void ide_exec_cmd(IDEBus *bus, uint32_t =
val)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s =3D idebus_active_if(bus);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_ide_exec_cmd(bus, s, val);<br=
>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; /* ignore commands to non existent slav=
e */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (s !=3D bus-&gt;ifs &amp;&amp; !s-&gt;blk) =
{<br>
<br>
(Was the first one basically meant to be =A1=B0s !=3D &amp;bus-&gt;ifs[0]=
=A1=B1, i.e. to<br>
check that this doesn=A1=AFt go to the ma^W primary?&nbsp; Not too obvious.=
)<br>
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /* ignore commands if no any device exist =
or non existent slave */<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if ((!bus-&gt;ifs[0].blk &amp;&amp; !bus-&=
gt;ifs[1].blk) ||<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s !=3D bus-&gt;if=
s &amp;&amp; !s-&gt;blk)) {<br>
<br>
(Maybe this could be improved here)<br>
<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; <br>
&gt; <br>
&gt; I think it's the case that Empty CD-ROM drives will have an anonymous<=
br>
&gt; block backend representing the empty drive,<br>
<br>
(As far as I remember,) yes.<br>
<br>
(ide_dev_initfn() ensures all CD drives have one, even if it=A1=AFs empty.)=
<br>
<br>
&gt; so I suppose this is maybe<br>
&gt; fine?<br>
&gt; <br>
&gt; I suppose the idea is that with no drives on the bus that it's fine to=
<br>
&gt; ignore the register writes, as there are no devices to record those wr=
ites.<br>
&gt; <br>
&gt; (But then, why did we ever only check device1? ...)<br>
&gt; <br>
&gt; Maybe before the block-backend split we used to have to check to see i=
f<br>
&gt; we had attached media or not, but I think nowadays we should always ha=
ve<br>
&gt; a blk pointer if we have a device model intended to be operating at th=
is<br>
&gt; address.<br>
<br>
The check in ide_dev_initfn() looks that way to me.<br>
<br>
&gt; So I guess it can be simplified ...?<br>
&gt; <br>
&gt; if (!s-&gt;blk) {<br>
&gt; &nbsp;&nbsp;&nbsp; return;<br>
&gt; }<br>
<br>
Probably.&nbsp; Although there=A1=AFs a difference, of course, namely if yo=
u have<br>
only a secondary device and try to access the primary, this simplified<br>
version will be a no-op, whereas the more complicated version in this<br>
patch would still go on.&nbsp; I don=A1=AFt know how real hardware would ha=
ndle<br>
that case.&nbsp; Is it even possible to have just a secondary with no prima=
ry?<br>
<br>
Max<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_4ee746f7bb364ed491d2b00a9b810183zhaoxincom_--

