Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEE5C3A589
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1FD233FD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1FD233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i11ir-0000Pq-Cm
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiewen.yao@intel.com>) id 1i11go-0007L6-LP
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiewen.yao@intel.com>) id 1i11gi-0005hL-Dm
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:00:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:28035)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiewen.yao@intel.com>)
 id 1i11gf-0005at-DK
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:00:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 22:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; d="scan'208";a="173363546"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga008.jf.intel.com with ESMTP; 22 Aug 2019 22:00:21 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 22:00:21 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 22:00:21 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.19]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.204]) with mapi id 14.03.0439.000;
 Fri, 23 Aug 2019 13:00:18 +0800
From: "Yao, Jiewen" <jiewen.yao@intel.com>
To: "Kinney, Michael D" <michael.d.kinney@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "rfc@edk2.groups.io"
 <rfc@edk2.groups.io>
Thread-Topic: [edk2-rfc] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
Thread-Index: AQHVUfF5lMVYZhTq/0GuokGqDPas2Kb6jzUA//+ZRQCAAaHSAIAAFq8AgAEuZqD//8zIAIAAiChAgABQUYCAACK6gIAAmpdAgAJgcwCAALs9d4ADuC+AgAAViICAAaFPgIAADE2AgAAXS4CAACSxAIAABA6AgAAK9oCAAB76gIAAwP3Q
Date: Fri, 23 Aug 2019 05:00:17 +0000
Message-ID: <74D8A39837DF1E4DA445A8C0B3885C503F76FDAF@shsmsx102.ccr.corp.intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
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
 <E92EE9817A31E24EB0585FDF735412F5B9DA218F@ORSMSX113.amr.corp.intel.com>
 <3661c0c5-3da4-1453-a66a-3e4d4022e876@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA2346@ORSMSX113.amr.corp.intel.com>
In-Reply-To: <E92EE9817A31E24EB0585FDF735412F5B9DA2346@ORSMSX113.amr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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

VGhhbmsgeW91IE1pa2UhDQoNClRoYXQgaXMgZ29vZCByZWZlcmVuY2Ugb24gdGhlIHJlYWwgaGFy
ZHdhcmUgYmVoYXZpb3IuIChHbGFkIGl0IGlzIHB1YmxpYy4pDQoNCkZvciB0aHJlYXQgbW9kZWws
IHRoZSB1bmlxdWUgcGFydCBpbiB2aXJ0dWFsIGVudmlyb25tZW50IGlzIHRlbXAgUkFNLg0KVGhl
IHRlbXAgUkFNIGluIHJlYWwgcGxhdGZvcm0gaXMgcGVyIENQVSBjYWNoZSwgd2hpbGUgdGhlIHRl
bXAgUkFNIGluIHZpcnR1YWwgcGxhdGZvcm0gaXMgZ2xvYmFsIG1lbW9yeS4NClRoYXQgYnJpbmdz
IG9uZSBtb3JlIHBvdGVudGlhbCBhdHRhY2sgc3VyZmFjZSBpbiB2aXJ0dWFsIGVudmlyb25tZW50
LCBpZiBob3QtYWRkZWQgQ1BVIG5lZWQgcnVuIGNvZGUgd2l0aCBzdGFjayBvciBoZWFwIGJlZm9y
ZSBTTUkgcmViYXNlLg0KDQpPdGhlciB0aHJlYXRzLCBzdWNoIGFzIFNNUkFNIG9yIERNQSwgYXJl
IHNhbWUuDQoNClRoYW5rIHlvdQ0KWWFvIEppZXdlbg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS2lubmV5LCBNaWNoYWVsIEQNCj4gU2VudDogRnJpZGF5LCBBdWd1
c3QgMjMsIDIwMTkgOTowMyBBTQ0KPiBUbzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT47IExhc3psbyBFcnNlaw0KPiA8bGVyc2VrQHJlZGhhdC5jb20+OyByZmNAZWRrMi5ncm91
cHMuaW87IFlhbywgSmlld2VuDQo+IDxqaWV3ZW4ueWFvQGludGVsLmNvbT47IEtpbm5leSwgTWlj
aGFlbCBEIDxtaWNoYWVsLmQua2lubmV5QGludGVsLmNvbT4NCj4gQ2M6IEFsZXggV2lsbGlhbXNv
biA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+OyBkZXZlbEBlZGsyLmdyb3Vwcy5pbzsNCj4g
cWVtdSBkZXZlbCBsaXN0IDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBJZ29yIE1hbW1lZG92DQo+
IDxpbWFtbWVkb0ByZWRoYXQuY29tPjsgQ2hlbiwgWWluZ3dlbiA8eWluZ3dlbi5jaGVuQGludGVs
LmNvbT47DQo+IE5ha2FqaW1hLCBKdW4gPGp1bi5uYWthamltYUBpbnRlbC5jb20+OyBCb3JpcyBP
c3Ryb3Zza3kNCj4gPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPjsgSm9hbyBNYXJjYWwgTGVt
b3MgTWFydGlucw0KPiA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT47IFBoaWxsaXAgR29lcmwg
PHBoaWxsaXAuZ29lcmxAb3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUkU6IFtlZGsyLXJmY10gW2Vk
azItZGV2ZWxdIENQVSBob3RwbHVnIHVzaW5nIFNNTSB3aXRoDQo+IFFFTVUrT1ZNRg0KPiANCj4g
UGFvbG8sDQo+IA0KPiBJIGZpbmQgdGhlIGZvbGxvd2luZyBsaW5rcyByZWxhdGVkIHRvIHRoZSBk
aXNjdXNzaW9ucyBoZXJlDQo+IGFsb25nIHdpdGggb25lIGV4YW1wbGUgZmVhdHVyZSBjYWxsZWQg
R0VOUFJPVFJBTkdFLg0KPiANCj4gaHR0cHM6Ly9jc3JjLm5pc3QuZ292L0NTUkMvbWVkaWEvUHJl
c2VudGF0aW9ucy9UaGUtV2hvbGUtaXMtR3JlYXRlci9pbWENCj4gZ2VzLW1lZGlhL2RheTFfdHJ1
c3RlZC1jb21wdXRpbmdfMjAwLTI1MC5wZGYNCj4gaHR0cHM6Ly9jYW5zZWN3ZXN0LmNvbS9zbGlk
ZXMvMjAxNy9DU1cyMDE3X0N1YXVodGVtb2MtUmVuZV9DUFVfSG8NCj4gdC1BZGRfZmxvdy5wZGYN
Cj4gaHR0cHM6Ly93d3cubW91c2VyLmNvbS9kcy8yLzYxMi81NTIwLTU1MDAtY2hpcHNldC1pb2gt
ZGF0YXNoZWV0LTExMzENCj4gMjkyLnBkZg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiANCj4gTWlr
ZQ0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBhb2xvIEJv
bnppbmkgW21haWx0bzpwYm9uemluaUByZWRoYXQuY29tXQ0KPiA+IFNlbnQ6IFRodXJzZGF5LCBB
dWd1c3QgMjIsIDIwMTkgNDoxMiBQTQ0KPiA+IFRvOiBLaW5uZXksIE1pY2hhZWwgRCA8bWljaGFl
bC5kLmtpbm5leUBpbnRlbC5jb20+Ow0KPiA+IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5j
b20+OyByZmNAZWRrMi5ncm91cHMuaW87DQo+ID4gWWFvLCBKaWV3ZW4gPGppZXdlbi55YW9AaW50
ZWwuY29tPg0KPiA+IENjOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQu
Y29tPjsNCj4gPiBkZXZlbEBlZGsyLmdyb3Vwcy5pbzsgcWVtdSBkZXZlbCBsaXN0IDxxZW11LQ0K
PiA+IGRldmVsQG5vbmdudS5vcmc+OyBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29t
PjsNCj4gPiBDaGVuLCBZaW5nd2VuIDx5aW5nd2VuLmNoZW5AaW50ZWwuY29tPjsgTmFrYWppbWEs
IEp1bg0KPiA+IDxqdW4ubmFrYWppbWFAaW50ZWwuY29tPjsgQm9yaXMgT3N0cm92c2t5DQo+ID4g
PGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPjsgSm9hbyBNYXJjYWwgTGVtb3MgTWFydGlucw0K
PiA+IDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPjsgUGhpbGxpcCBHb2VybA0KPiA+IDxwaGls
bGlwLmdvZXJsQG9yYWNsZS5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtlZGsyLXJmY10gW2VkazIt
ZGV2ZWxdIENQVSBob3RwbHVnIHVzaW5nDQo+ID4gU01NIHdpdGggUUVNVStPVk1GDQo+ID4NCj4g
PiBPbiAyMy8wOC8xOSAwMDozMiwgS2lubmV5LCBNaWNoYWVsIEQgd3JvdGU6DQo+ID4gPiBQYW9s
bywNCj4gPiA+DQo+ID4gPiBJdCBpcyBteSB1bmRlcnN0YW5kaW5nIHRoYXQgcmVhbCBIVyBob3Qg
cGx1ZyB1c2VzIHRoZQ0KPiA+IFNETSBkZWZpbmVkDQo+ID4gPiBtZXRob2RzLiAgTWVhbmluZyB0
aGUgaW5pdGlhbCBTTUkgaXMgdG8gMzAwMDo4MDAwIGFuZA0KPiA+IHRoZXkgcmViYXNlIHRvDQo+
ID4gPiBUU0VHIGluIHRoZSBmaXJzdCBTTUkuICBUaGV5IG11c3QgaGF2ZSBjaGlwc2V0IHNwZWNp
ZmljDQo+ID4gbWV0aG9kcyB0bw0KPiA+ID4gcHJvdGVjdCAzMDAwOjgwMDAgZnJvbSBETUEuDQo+
ID4NCj4gPiBJdCB3b3VsZCBiZSBncmVhdCBpZiB5b3UgY291bGQgY2hlY2suDQo+ID4NCj4gPiA+
IENhbiB3ZSBhZGQgYSBjaGlwc2V0IGZlYXR1cmUgdG8gcHJldmVudCBETUEgdG8gNjRLQg0KPiA+
IHJhbmdlIGZyb20NCj4gPiA+IDB4MzAwMDAtMHgzRkZGRiBhbmQgdGhlIFVFRkkgTWVtb3J5IE1h
cCBhbmQgQUNQSQ0KPiA+IGNvbnRlbnQgY2FuIGJlDQo+ID4gPiB1cGRhdGVkIHNvIHRoZSBHdWVz
dCBPUyBrbm93cyB0byBub3QgdXNlIHRoYXQgcmFuZ2UgZm9yDQo+ID4gRE1BPw0KPiA+DQo+ID4g
SWYgcmVhbCBoYXJkd2FyZSBkb2VzIGl0IGF0IHRoZSBjaGlwc2V0IGxldmVsLCB3ZSB3aWxsDQo+
ID4gcHJvYmFibHkgdXNlIElnb3IncyBzdWdnZXN0aW9uIG9mIGFsaWFzaW5nIEEtc2VnIHRvDQo+
ID4gMzAwMDowMDAwLiAgQmVmb3JlIHN0YXJ0aW5nIHRoZSBuZXcgQ1BVLCB0aGUgU01JIGhhbmRs
ZXINCj4gPiBjYW4gcHJlcGFyZSB0aGUgU01CQVNFIHJlbG9jYXRpb24gdHJhbXBvbGluZSBhdA0K
PiA+IEEwMDA6ODAwMCBhbmQgdGhlIGhvdC1wbHVnZ2VkIENQVSB3aWxsIGZpbmQgaXQgYXQNCj4g
PiAzMDAwOjgwMDAgd2hlbiBpdCByZWNlaXZlcyB0aGUgaW5pdGlhbCBTTUkuICBCZWNhdXNlIHRo
aXMNCj4gPiBpcyBiYWNrZWQgYnkgUkFNIGF0IDB4QTAwMDAtMHhBRkZGRiwgRE1BIGNhbm5vdCBh
Y2Nlc3MgaXQNCj4gPiBhbmQgd291bGQgc3RpbGwgZ28gdGhyb3VnaCB0byBSQU0gYXQgMHgzMDAw
MC4NCj4gPg0KPiA+IFBhb2xvDQo=

