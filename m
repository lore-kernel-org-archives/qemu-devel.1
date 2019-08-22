Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C7BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E47921848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E47921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0vfV-00011A-Pp
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael.d.kinney@intel.com>) id 1i0vdO-0007O5-Om
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael.d.kinney@intel.com>) id 1i0vdM-0008RY-P1
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:32:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:10874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michael.d.kinney@intel.com>)
 id 1i0vdM-0008PQ-Ez
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:32:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 15:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,418,1559545200"; d="scan'208";a="378675669"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2019 15:32:39 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 15:32:39 -0700
Received: from orsmsx113.amr.corp.intel.com ([169.254.9.198]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.89]) with mapi id 14.03.0439.000;
 Thu, 22 Aug 2019 15:32:38 -0700
From: "Kinney, Michael D" <michael.d.kinney@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, "Yao, Jiewen"
 <jiewen.yao@intel.com>, "Kinney, Michael D" <michael.d.kinney@intel.com>
Thread-Topic: [edk2-rfc] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
Thread-Index: AQHVUfF5vU6QBeHgZE+cN7DIWDHHwKb6jzUA//+ZRQCAAaHSAIAAFq8AgAEuZqD//8zIAIAAiChAgABQUYCAACK6gIAAmpdAgAJgcwCAALs9d4AEPCbwgACNBoCAAaFPgIAADE2A//+WXtAAFLPEAAAOlQSA
Date: Thu, 22 Aug 2019 22:32:37 +0000
Message-ID: <E92EE9817A31E24EB0585FDF735412F5B9DA218F@ORSMSX113.amr.corp.intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
 <20190816161933.7d30a881@x1.home>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9C671@ORSMSX113.amr.corp.intel.com>
 <a76014e2-2f0a-afce-6d15-1c45c5c1e467@redhat.com>
 <b3907432-b149-3f96-6d93-f443f215e0f8@redhat.com>
 <2b4ba607-f0e3-efee-6712-6dcef129b310@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA209B@ORSMSX113.amr.corp.intel.com>
 <7f2d2f1e-2dd8-6914-c55e-61067e06b142@redhat.com>
In-Reply-To: <7f2d2f1e-2dd8-6914-c55e-61067e06b142@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [edk2-rfc] [edk2-devel] CPU hotplug using SMM with
 QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor
 Mammedov <imammedo@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGFvbG8sDQoNCkl0IGlzIG15IHVuZGVyc3RhbmRpbmcgdGhhdCByZWFsIEhXIGhvdCBwbHVnIHVz
ZXMgdGhlIFNETSBkZWZpbmVkDQptZXRob2RzLiAgTWVhbmluZyB0aGUgaW5pdGlhbCBTTUkgaXMg
dG8gMzAwMDo4MDAwIGFuZCB0aGV5IHJlYmFzZQ0KdG8gVFNFRyBpbiB0aGUgZmlyc3QgU01JLiAg
VGhleSBtdXN0IGhhdmUgY2hpcHNldCBzcGVjaWZpYyBtZXRob2RzDQp0byBwcm90ZWN0IDMwMDA6
ODAwMCBmcm9tIERNQS4NCg0KQ2FuIHdlIGFkZCBhIGNoaXBzZXQgZmVhdHVyZSB0byBwcmV2ZW50
IERNQSB0byA2NEtCIHJhbmdlIGZyb20NCjB4MzAwMDAtMHgzRkZGRiBhbmQgdGhlIFVFRkkgTWVt
b3J5IE1hcCBhbmQgQUNQSSBjb250ZW50IGNhbiBiZQ0KdXBkYXRlZCBzbyB0aGUgR3Vlc3QgT1Mg
a25vd3MgdG8gbm90IHVzZSB0aGF0IHJhbmdlIGZvciBETUE/DQoNClRoYW5rcywNCg0KTWlrZQ0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgW21h
aWx0bzpwYm9uemluaUByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDIyLCAy
MDE5IDM6MTggUE0NCj4gVG86IEtpbm5leSwgTWljaGFlbCBEIDxtaWNoYWVsLmQua2lubmV5QGlu
dGVsLmNvbT47DQo+IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+OyByZmNAZWRrMi5n
cm91cHMuaW87DQo+IFlhbywgSmlld2VuIDxqaWV3ZW4ueWFvQGludGVsLmNvbT4NCj4gQ2M6IEFs
ZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+Ow0KPiBkZXZlbEBlZGsy
Lmdyb3Vwcy5pbzsgcWVtdSBkZXZlbCBsaXN0IDxxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnPjsg
SWdvciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT47DQo+IENoZW4sIFlpbmd3ZW4gPHlp
bmd3ZW4uY2hlbkBpbnRlbC5jb20+OyBOYWthamltYSwgSnVuDQo+IDxqdW4ubmFrYWppbWFAaW50
ZWwuY29tPjsgQm9yaXMgT3N0cm92c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47
IEpvYW8gTWFyY2FsIExlbW9zIE1hcnRpbnMNCj4gPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+
OyBQaGlsbGlwIEdvZXJsDQo+IDxwaGlsbGlwLmdvZXJsQG9yYWNsZS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbZWRrMi1yZmNdIFtlZGsyLWRldmVsXSBDUFUgaG90cGx1ZyB1c2luZw0KPiBTTU0gd2l0
aCBRRU1VK09WTUYNCj4gDQo+IE9uIDIyLzA4LzE5IDIyOjA2LCBLaW5uZXksIE1pY2hhZWwgRCB3
cm90ZToNCj4gPiBUaGUgU01CQVNFIHJlZ2lzdGVyIGlzIGludGVybmFsIGFuZCBjYW5ub3QgYmUg
ZGlyZWN0bHkNCj4gYWNjZXNzZWQgYnkgYW55DQo+ID4gQ1BVLiAgVGhlcmUgaXMgYW4gU01CQVNF
IGZpZWxkIHRoYXQgaXMgbWVtYmVyIG9mIHRoZQ0KPiBTTU0gU2F2ZSBTdGF0ZQ0KPiA+IGFyZWEg
YW5kIGNhbiBvbmx5IGJlIG1vZGlmaWVkIGZyb20gU01NIGFuZCByZXF1aXJlcyB0aGUNCj4gZXhl
Y3V0aW9uIG9mDQo+ID4gYW4gUlNNIGluc3RydWN0aW9uIGZyb20gU01NIGZvciB0aGUgU01CQVNF
IHJlZ2lzdGVyIHRvDQo+IGJlIHVwZGF0ZWQgZnJvbQ0KPiA+IHRoZSBjdXJyZW50IFNNQkFTRSBm
aWVsZCB2YWx1ZS4gIFRoZSBuZXcgU01CQVNFDQo+IHJlZ2lzdGVyIHZhbHVlIGlzIG9ubHkNCj4g
PiB1c2VkIG9uIHRoZSBuZXh0IFNNSS4NCj4gDQo+IEFjdHVhbGx5IHRoZXJlIGlzIGFsc28gYW4g
U01CQVNFIE1TUiwgZXZlbiB0aG91Z2ggaW4NCj4gY3VycmVudCBzaWxpY29uIGl0J3MgcmVhZC1v
bmx5IGFuZCBpdHMgdXNlIGlzDQo+IHRoZW9yZXRpY2FsbHkgbGltaXRlZCB0byBTTU0tdHJhbnNm
ZXIgbW9uaXRvcnMuICBJZiB0aGF0DQo+IE1TUiBjb3VsZCBiZSBtYWRlIGFjY2Vzc2libGUgc29t
ZWhvdyBvdXRzaWRlIFNNTSwgdGhhdA0KPiB3b3VsZCBiZSBncmVhdC4NCj4gDQo+ID4gT25jZSBh
bGwgdGhlIENQVXMgaGF2ZSBiZWVuIGluaXRpYWxpemVkIGZvciBTTU0sIHRoZQ0KPiBDUFVzIHRo
YXQgYXJlIG5vdA0KPiA+IG5lZWRlZCBjYW4gYmUgaG90IHJlbW92ZWQuICBBcyBub3RlZCBhYm92
ZSwgdGhlIFNNQkFTRQ0KPiB2YWx1ZSBkb2VzIG5vdA0KPiA+IGNoYW5nZSBvbiBhbiBJTklULiAg
U28gYXMgbG9uZyBhcyB0aGUgaG90IGFkZCBvcGVyYXRpb24NCj4gZG9lcyBub3QgZG8gYQ0KPiA+
IFJFU0VULCB0aGUgU01CQVNFIHZhbHVlIG11c3QgYmUgcHJlc2VydmVkLg0KPiANCj4gSUlSQywg
aG90LXJlbW92ZSArIGhvdC1hZGQgd2lsbCB1bnBsdWdzL3BsdWdzIGENCj4gY29tcGxldGVseSBk
aWZmZXJlbnQgQ1BVLg0KPiANCj4gPiBBbm90aGVyIGlkZWEgaXMgdG8gZW11bGF0ZSB0aGlzIGJl
aGF2aW9yLiAgSWYgdGhlIGhvdA0KPiBwbHVnIGNvbnRyb2xsZXINCj4gPiBwcm92aWRlIHJlZ2lz
dGVycyAob25seSBhY2Nlc3NpYmxlIGZyb20gU01NKSB0byBhc3NpZ24NCj4gdGhlIFNNQkFTRQ0K
PiA+IGFkZHJlc3MgZm9yIGV2ZXJ5IENQVS4gIFdoZW4gYSBDUFUgaXMgaG90IGFkZGVkLCBRRU1V
DQo+IGNhbiBzZXQgdGhlDQo+ID4gaW50ZXJuYWwgU01CQVNFIHJlZ2lzdGVyIHZhbHVlIGZyb20g
dGhlIGhvdCBwbHVnDQo+IGNvbnRyb2xsZXIgcmVnaXN0ZXINCj4gPiB2YWx1ZS4gIElmIHRoZSBT
TU0gTW9uYXJjaCBzZW5kcyBhbiBJTklUIG9yIGFuIFNNSSBmcm9tDQo+IHRoZSBMb2NhbCBBUElD
DQo+ID4gdG8gdGhlIGhvdCBhZGRlZCBDUFUsIHRoZW4gdGhlIFNNQkFTRSByZWdpc3RlciBzaG91
bGQNCj4gbm90IGJlIG1vZGlmaWVkDQo+ID4gYW5kIHRoZSBDUFUgc3RhcnRzIGV4ZWN1dGlvbiB3
aXRoaW4gVFNFRyB0aGUgZmlyc3QgdGltZQ0KPiBpdCByZWNlaXZlcyBhbiBTTUkuDQo+IA0KPiBZ
ZXMsIHRoaXMgd291bGQgd29yay4gIEJ1dCBhZ2Fpbi0tLWlmIHRoZSBpc3N1ZSBpcyByZWFsDQo+
IG9uIGN1cnJlbnQgaGFyZHdhcmUgdG9vLCBJJ2QgcmF0aGVyIGhhdmUgYSBtYXRjaGluZw0KPiBz
b2x1dGlvbiBmb3IgdmlydHVhbCBwbGF0Zm9ybXMuDQo+IA0KPiBJZiB0aGUgY3VycmVudCBoYXJk
d2FyZSBmb3IgZXhhbXBsZSByZW1lbWJlcnMgSU5JVC0NCj4gcHJlc2VydmVkIGFjcm9zcyBob3Qt
cmVtb3ZlL2hvdC1hZGQsIHdlIGNvdWxkIGVtdWxhdGUNCj4gdGhhdC4NCj4gDQo+IEkgZ3Vlc3Mg
dGhlIGZ1bmRhbWVudGFsIHF1ZXN0aW9uIGlzOiBob3cgZG8gYmFyZSBtZXRhbA0KPiBwbGF0Zm9y
bXMgYXZvaWQgdGhpcyBpc3N1ZSwgb3IgcGxhbiB0byBhdm9pZCB0aGlzIGlzc3VlPw0KPiBPbmNl
IHdlIGtub3cgdGhhdCwgd2UgY2FuIHVzZSB0aGF0IGluZm9ybWF0aW9uIHRvIGZpbmQgYQ0KPiB3
YXkgdG8gaW1wbGVtZW50IGl0IGluIEtWTS4gIE9ubHkgaWYgaXQgaXMgaW1wb3NzaWJsZQ0KPiB3
ZSdsbCBoYXZlIGEgZGlmZmVyZW50IHN0cmF0ZWd5IHRoYXQgaXMgc3BlY2lmaWMgdG8gb3VyDQo+
IHBsYXRmb3JtLg0KPiANCj4gUGFvbG8NCj4gDQo+ID4gSmlld2VuIGFuZCBJIGNhbiBjb2xsZWN0
IHNwZWNpZmljIHF1ZXN0aW9ucyBvbiB0aGlzDQo+IHRvcGljIGFuZCBjb250aW51ZQ0KPiA+IHRo
ZSBkaXNjdXNzaW9uIGhlcmUuICBGb3IgZXhhbXBsZSwgSSBkbyBub3QgdGhpbmsgdGhlcmUNCj4g
aXMgYW55IG1ldGhvZA0KPiA+IG90aGVyIHRoYW4gd2hhdCBJIHJlZmVyZW5jZWQgYWJvdmUgdG8g
cHJvZ3JhbSB0aGUNCj4gU01CQVNFIHJlZ2lzdGVyLCBidXQNCj4gPiBJIGNhbiBhc2sgaWYgdGhl
cmUgYXJlIGFueSBvdGhlciBtZXRob2RzLg0KDQo=

