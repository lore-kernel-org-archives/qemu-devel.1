Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBADCECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A606A206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NGAyXhT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A606A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yfQ-00039S-9u
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1i7yJC-0000SR-57
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1i7yJ9-0004Ls-NU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:49:01 -0400
Received: from smtpbg512.qq.com ([203.205.250.48]:52405 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1i7yJ8-0004JK-99
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1568191727;
 bh=QIkVbEMO3OIs+pCdElbxUdRjzX7vfLpFssvFBDtzUN8=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=NGAyXhT8TTOxYYD4HUFsMA7rrabD9e6GDaDqoFUovDiHM96lsHjnZRlcd95KYKJ+y
 /7XPQGtozhx461xFXLfWzctC7VEBTTh8Y81mx4hb4zC35yQ6eb3wkcUMkinG9goCsj
 EcpZxJuKiUMXuC2XXGhKVGXNTABY5LLJpHulA/Ec=
X-QQ-SSF: 00010000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.200.70.7
In-Reply-To: <CAL1e-=jb5qrtikifPoqUdc0_rgqXPfnUMMhafmXXw62x+ANu1Q@mail.gmail.com>
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
 <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
 <tencent_23ACCA1A48AFB09124C52E70@qq.com> <87blvy99y9.fsf@linaro.org>
 <tencent_541F04AB1A100DF25C334D8C@qq.com> <87zhjh7pf0.fsf@linaro.org>
 <tencent_479D109A5BEC536D64AE43BF@qq.com>
 <CAL1e-=gpYhsrhb1B8UPNhd-uTo-B60jtdxEZSFTauS_+HYee9w@mail.gmail.com>
 <CAL1e-=jb5qrtikifPoqUdc0_rgqXPfnUMMhafmXXw62x+ANu1Q@mail.gmail.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1568191725t969126
From: "=?utf-8?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?utf-8?B?QWxla3NhbmRhciBNYXJrb3ZpYw==?=" <aleksandar.m.mail@gmail.com>
Mime-Version: 1.0
Date: Wed, 11 Sep 2019 16:48:45 +0800
X-Priority: 3
Message-ID: <tencent_15D534A32CA952F47FF73B6F@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 3025390440
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Wed, 11 Sep 2019 16:48:46 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.205.250.48
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?utf-8?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UmV2ZXJ0aW5nIHRoZSBjb21taXQgc29sdmVkIG15IHByb2JsZW0sIGFsdGhvdWdoIEkgZG9u
J3Qga25vdyB3aHkgaXQgbmVlZGVkIHRvIGJlIGZpeGVkIHRvIDY0LWJpdCBiYWNrIHRoZW4u
IEZpbmFsbHkgSSBjYW4gbm93ICBzaW5nbGUgc3RlcCBhIGNyb3NzLWNvbXBpbGVkIE1JUFMg
cHJvZ3JhbSBvbiBhIFFFTVUgTGludXggdXNlciBiaW5hcnkgYW5kIG9ic2VydmUgdGhlIHJl
Z2lzdGVyIGFuZCBtZW1vcnkgY29udGVudHMuDQoNCg0KDQotLS0tLS0tLS0tLS0tLS0tLS0g
T3JpZ2luYWwgLS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tOiAgIkFsZWtzYW5kYXIgTWFya292
aWMiOzxhbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5jb20+Ow0KU2VuZCB0aW1lOiBXZWRuZXNk
YXksIFNlcCAxMSwgMjAxOSAxOjUwIEFNDQpUbzogIkxpYm8gWmhvdSI8emhsYjI5QGZveG1h
aWwuY29tPjsgDQpDYzogIkFsZXggQmVubsOpZSI8YWxleC5iZW5uZWVAbGluYXJvLm9yZz47
ICJxZW11LWRldmVsIjxxZW11LWRldmVsQG5vbmdudS5vcmc+OyANClN1YmplY3Q6ICBSZTog
W1FlbXUtZGV2ZWxdIFFFTVUgYXMgSVNTIChJbnN0cnVjdGlvbiBTZXQgU2ltdWxhdG9yKQ0K
DQoNCg0KMTAuMDkuMjAxOS4gMTkuMjYsIGFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbSA/
0LUg0L3QsNC/0LjRgdCw0L4v0LvQsDoNCj4NCj4NCj4gMTAuMDkuMjAxOS4gMTEuNTcsICJM
aWJvIFpob3UiIDx6aGxiMjlAZm94bWFpbC5jb20+ID/QtSDQvdCw0L/QuNGB0LDQvi/Qu9Cw
Og0KPiA+DQo+ID4gSGkgQWxleCwNCj4gPg0KPiA+IGdkYiBzYXlzIHJlbW90ZSAnZycgcGFj
a2V0IHJlcGx5IGlzIHRvbyBsb25nLCBhbmQgdGhlbiBwcmludHMgb3V0IGENCmxvbmcgc3Ry
aW5nIG9mIHplcm9zIGFuZCBzb21lIG90aGVyIGRpZ2l0cyBzcGFyc2VseS4NCj4gPg0KPiA+
IEkgaGF2ZSB0cmllZCBhIGxvdCBvZiBjb21iaW5hdGlvbnMgb2YgZmxhZ3MgYnV0IEkganVz
dCBjYW4ndCBnZXQgaXQNCnJ1bm5pbmcgcHJvcGVybHkuIERvIHlvdSBrbm93IHdoYXQgaXMg
Y2F1c2luZyB0aGlzIGVycm9yPw0KPiA+DQo+DQo+IFRoaXMgaXMgYSBrbm93biBidWcsIGFj
dHVhbGx5IGluIGdkYiwgYnV0IHRoZXJlIGlzIGEgd29ya2Fyb3VuZCBpcyB0bw0Kcm9sbGJh
Y2sgYSBjb21taXQgbWFkZSAgYXJvdW5kIGEgeWVhciBhZ28gaW4gUUVNVSwgYWJvdXQgNjQt
Yml0IEZQVSBNaXBzDQpyZWdpc3RlcnMuDQoNCk1vcmUgcHJldmlzZWx5LCByZXZlcnRpbmcN
Cmh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvY29tbWl0LzhlMGIzNzNmOGFhNGI5ZmVl
YzdiNDQwMjk0NTU1ODdlMmUzZDJiMGYNCndvdWxkIG1vc3QgbGlrZWx5IHJybW92ZSB5b3Vy
IHByb2JsZW0uDQoNCkFsZWtzYW5kYXINCg0KPiBPciB5b3UgY2FuIGZpeCB0aGUgYnVmZmVy
IHNpemUgaW4gZ2RiLg0KPg0KPiBBbGVrc2FuZGFyDQo+DQo+ID4gQ2hlZXJzLA0KPiA+IExp
Ym8NCj4gPg0KPiA+DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiA+IEZyb206ICAiQWxleCBCZW5uw6llIjs8YWxleC5iZW5uZWVAbGlu
YXJvLm9yZz47DQo+ID4gU2VuZCB0aW1lOiBGcmlkYXksIFNlcCA2LCAyMDE5IDU6MTkgUE0N
Cj4gPiBUbzogIkxpYm8gWmhvdSI8emhsYjI5QGZveG1haWwuY29tPjsNCj4gPiBDYzogInFl
bXUtZGV2ZWwiPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47ICJBbGVrc2FuZGFyIE1hcmtvdmlj
IjwNCmFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbT47DQo+ID4gU3ViamVjdDogIFJlOiBb
UWVtdS1kZXZlbF0gUUVNVSBhcyBJU1MgKEluc3RydWN0aW9uIFNldCBTaW11bGF0b3IpDQo+
ID4NCj4gPg0KPiA+IExpYm8gWmhvdSA8emhsYjI5QGZveG1haWwuY29tPiB3cml0ZXM6DQo+
ID4NCj4gPiA+IEhpIEFsZXgsDQo+ID4gPg0KPiA+ID4NCj4gPiA+IEkganVzdCBuZWVkIHRv
IGxvZyB0aGUgcmVnaXN0ZXJzIGFuZCBtZW1vcnkgYWZ0ZXIgdGhlIHByb2dyYW0gZmluaXNo
ZXMNCj4gPiA+IGl0cyBleGVjdXRpb24uIElzIGl0IHBvc3NpYmxlIHRvIGFkZCB0aGlzIGZ1
bmN0aW9uYWxpdHkgbXlzZWxmPw0KPiA+DQo+ID4gWW91J2xsIG5lZWQgdG8gc2V0IHNvbWUg
c29ydCBvZiBicmVha3BvaW50IG9uIHRoZSBsYXN0IGluc3RydWN0aW9uIHNvDQo+ID4gZ2Ri
IGNhbiBpbnNwZWN0IHRoaW5ncyBiZWZvcmUgdGhlIHByb2dyYW0gaXMgdW5sb2FkZWQuIEkg
dGhpbmsgaXQncw0KPiA+IHBvc3NpYmxlIHRvIHdpcmUgcG93ZXJvZmYgZXZlbnRzIHRvIHRo
ZSBnZGJzdHViIGJ1dCBJIGhhdmVuJ3QgbG9va2VkDQo+ID4gaW50byB0aGF0IG15c2VsZi4N
Cj4gPg0KPiA+ID4gQXMgZm9yIHRoZSBHREIgb3B0aW9uLCBjYW4geW91IHRlbGwgbWUgdGhl
IHNwZWNpZmljIHN0ZXBzIHRvIGRvIHRoYXQ/DQpJJ3ZlIHRyaWVkIGl0IG15c2VsZiBidXQg
SSBoYWQgbm8gbHVjayBnZXR0aW5nIGl0IHJ1bm5pbmcgZHVlIHRvIG1lIGJlaW5nDQpuZXcg
dG8gYWxsIHRoaXMuDQo+ID4gPg0KPiA+DQo+ID4gRm9yIGxpbnV4LXVzZXI6DQo+ID4NCj4g
PiAgICRRRU1VIC1nIDEyMzQgJFBSRw0KPiA+DQo+ID4gZm9yIHN5c3RlbSBlbXVsYXRpb24N
Cj4gPg0KPiA+ICAgJFFFTVUgLXMgLVMNCj4gPg0KPiA+IGFuZCB0aGVuIG9uIHRoZSBnZGIg
ZW5kOg0KPiA+DQo+ID4gICBnZGIgJEJJTiAtZXggInRhcmdldCByZW1vdGUgbG9jYWxob3N0
OjEyMzQiDQo+ID4NCj4gPiBhbmQgdGhlbiB5b3UgY2FuIG9wZXJhdGUgYXMgeW91IG5vcm1h
bGx5IGRvIHdpdGggYSBnZGIgc2Vzc2lvbi4gR0RCIGhhcw0KPiA+IHR3byBzY3JpcHRpbmcg
aW50ZXJmYWNlcy4gVGhlIGNvbW1hbmQgbW9kZSBpcyBiYXNpY2FsbHkgYSBsaXN0IG9mIGdk
Yg0KPiA+IGNvbW1hbmRzIGJ1dCBtaWdodCB3b3JrIGZvciB3aGF0IHlvdSB3YW50LiBJZiB5
b3Ugd2FudCB0byBiZSBhIGJpdCBtb3JlDQo+ID4gcHJvZ3JhbWF0aWMgeW91IGNhbiB1c2Ug
cHl0aG9uLiBTZWUgdGhlIGV4YW1wbGUgaW4NCj4gPiB0ZXN0cy9ndWVzdC1kZWJ1Zy90ZXN0
LWdkYnN0dWIucHkNCj4gPg0KPiA+ID4NCj4gPiA+IFRoYW5rcywNCj4gPiA+IExpYm8NCj4g
PiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLSBPcmlnaW5hbCAt
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+IEZyb206ICAiQWxleCBCZW5uw6llIjs8YWxleC5i
ZW5uZWVAbGluYXJvLm9yZz47DQo+ID4gPiBTZW5kIHRpbWU6IFRodXJzZGF5LCBTZXAgNSwg
MjAxOSA4OjU4IFBNDQo+ID4gPiBUbzogInFlbXUtZGV2ZWwiPHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZz47DQo+ID4gPiBDYzogIkFsZWtzYW5kYXIgTWFya292aWMiPGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbT47DQo+ID4gPiBTdWJqZWN0OiAgUmU6IFtRZW11LWRldmVsXSBRRU1V
IGFzIElTUyAoSW5zdHJ1Y3Rpb24gU2V0IFNpbXVsYXRvcikNCj4gPiA+DQo+ID4gPg0KPiA+
ID4NCj4gPiA+DQo+ID4gPiBMaWJvIFpob3UgPHpobGIyOUBmb3htYWlsLmNvbT4gd3JpdGVz
Og0KPiA+ID4NCj4gPiA+PiBEbyB5b3Uga25vdyB3aGVyZSBpbiB0aGUgc291cmNlIGZpbGUg
SSBzaG91bGQgbG9vayBpbnRvIHRvIGFkZCBteQ0KY3VzdG9tIGxvZ2dpbmcgZnVuY3Rpb25h
bGl0eT8NCj4gPiA+Pg0KPiA+ID4+DQo+ID4gPj4gT3IsIHdvdWxkIHlvdSBzdWdnZXN0IHVz
aW5nIGdkYiB0byBsb29rIGF0IG15IHRhcmdldCByZWdpc3RlciBhbmQNCm1lbW9yeSBjb250
ZW50cz8gVGhlIGFuc3dlciBpbiB0aGlzIGxpbmsgYmVsb3cgbG9va3MgcmVhbGx5IHByb21p
c2luZy4gSSdtDQpnb25uYSBnaXZlIGl0IGEgdHJ5IGZpcnN0Lg0KPiA+ID4+DQo+ID4gPj4N
Cmh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vcXVlc3Rpb25zLzM5NTAzOTk3L2hvdy10by1y
dW4tYS1zaW5nbGUtbGluZS1vZi1hc3NlbWJseS10aGVuLXNlZS1yMS1hbmQtY29uZGl0aW9u
LWZsYWdzDQo+ID4gPg0KPiA+ID4gVGhlIGdkYnN0dWIgc2hvdWxkIGFsbG93IHlvdSBkbyBm
dWxsIGludHJvc3BlY3Rpb24gYW5kIGFkZGluZw0KPiA+ID4gYWRkaXRpb25hbCByZWdpc3Rl
cnMgaXMgZmFpcmx5IGVhc3ksIHNlZSBGT09fZ2RiX1tzZXR8Z2V0XV9yZWcgaGVscGVycw0K
PiA+ID4gaW4gdGhlIGFwcHJvcHJpYXRlIHRhcmdldC9GT08gZGlyZWN0b3JpZXMuDQo+ID4g
Pg0KPiA+ID4+IEhvd2V2ZXIsIGlmIEkgYW0gYWJsZSB0byBjdXN0b21pemUgbG9nLCBpdCB3
aWxsIGJlIHN1cGVyIGNvbnZlbmllbnQuDQo+ID4gPg0KPiA+ID4gU28geW91IHdhbnQgc29t
ZXRoaW5nIGFib3ZlIHdoYXQgLWQgY3B1IHdpbGwgc2hvdyB5b3U/DQo+ID4gPg0KPiA+ID4+
DQo+ID4gPj4NCj4gPiA+Pg0KPiA+ID4+IENoZWVycywNCj4gPiA+Pg0KPiA+ID4+IExpYm8N
Cj4gPiA+Pg0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+PiAtLS0tLS0tLS0tLS0tLS0tLS0gT3Jp
Z2luYWwgLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPj4gRnJvbTogICJBbGVrc2FuZGFyIE1h
cmtvdmljIjs8YWxla3NhbmRhci5tLm1haWxAZ21haWwuY29tPjsNCj4gPiA+PiBTZW5kIHRp
bWU6IFRodXJzZGF5LCBTZXAgNSwgMjAxOSA2OjU0IFBNDQo+ID4gPj4gVG86ICJMaWJvIFpo
b3UiPHpobGIyOUBmb3htYWlsLmNvbT47DQo+ID4gPj4gQ2M6ICJxZW11LWRldmVsIjxxZW11
LWRldmVsQG5vbmdudS5vcmc+Ow0KPiA+ID4+IFN1YmplY3Q6ICBSZTogW1FlbXUtZGV2ZWxd
IFFFTVUgYXMgSVNTIChJbnN0cnVjdGlvbiBTZXQgU2ltdWxhdG9yKQ0KPiA+ID4+DQo+ID4g
Pj4NCj4gPiA+Pg0KPiA+ID4+IDA0LjA5LjIwMTkuIDA1LjIzLCAiTGlibyBaaG91IiA8emhs
YjI5QGZveG1haWwuY29tPiA/0LUg0L3QsNC/0LjRgdCw0L4v0LvQsDoNCj4gPiA+Pj4NCj4g
PiA+Pj4gSGkgQWxla3NhbmRhciwNCj4gPiA+Pj4NCj4gPiA+Pj4gSSBoYXZlIHNwZW50IHNv
bWUgdGltZSBsb29raW5nIGF0IHlvdXIgTVhVIEFTRSBwYXRjaC4gSXQncyBzdXBlcg0KaGVs
cGZ1bC4NCj4gPiA+PiBJIG5lZWQgdG8gZG8gZXhhY3RseSB0aGUgc2FtZSB0aGluZyBhcyB5
b3UgZGlkLg0KPiA+ID4+Pg0KPiA+ID4+PiBOb3cgSSBqdXN0IG5lZWQgYSB3YXkgdG8gb2Jz
ZXJ2ZSB0aGUgbWVtb3J5IGFuZCByZWdpc3RlciBmaWxlDQpjb250ZW50cyB0bw0KPiA+ID4+
IGRlYnVnIG15IGluc3RydWN0aW9uIHNldCBzaW11bGF0b3IuIEkgcGxheWVkIHdpdGggdGhl
ICItZCIgc3dpdGNoIHRvDQpsb2cgYQ0KPiA+ID4+IGJ1bmNoIG9mIGluZm9ybWF0aW9uLCBi
dXQgaXQgc2VlbXMgdGhhdCBub25lIG9mIHRoZSBpdGVtcyBpcyBvZiBteQ0KPiA+ID4+IGlu
dGVyZXN0LiBUaGUgIi1kIGNwdV9yZXNldCIgb3B0aW9uIGRpc3BsYXlzIGFsbCB6ZXJvcyBp
biB0aGUgR1BSDQpsb2cuDQo+ID4gPj4+DQo+ID4gPj4NCj4gPiA+PiBJdCBsb29rcyB5b3Ug
bmVlZCBhIGN1c3RvbSBsb2dnaW5nIHRhaWxvcmVkIHRvIHlvdXIgbmVlZHMsIGJhc2VkIG9u
DQo+ID4gPj4gaW50ZXJjZXB0aW5nIHRoZSBpbnN0cnVjdGlvbnMgeW91IGFkZGVkLg0KPiA+
ID4+DQo+ID4gPj4gQWxla3NhbmRhcg0KPiA+ID4+DQo+ID4gPj4+IFBsZWFzZSB0YWtlIHlv
dXIgdGltZSwgYXMgSSBmdWxseSB1bmRlcnN0YW5kIHlvdSBuZWVkIHRvIHdvcmsgb24NClFl
bXUNCj4gPiA+PiB3aGlsZSBhbnN3ZXJpbmcgYWxsIG15IHF1ZXN0aW9ucy4gQWdhaW4sIHRo
YW5rIHlvdSB2ZXJ5IG11Y2ggZm9yDQp5b3VyIGhlbHAhDQo+ID4gPj4+DQo+ID4gPj4+IENo
ZWVycywNCj4gPiA+Pj4gTGlibw0KPiA+ID4+Pg0KPiA+DQo+ID4NCj4gPiAtLQ0KPiA+IEFs
ZXggQmVubsOpZQ==
