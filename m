Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF02C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 20:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FD92339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 20:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FD92339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0tUI-0000jr-LY
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 16:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael.d.kinney@intel.com>) id 1i0tT9-0000Gz-RF
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 16:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael.d.kinney@intel.com>) id 1i0tT7-0002KK-7U
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 16:14:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:44691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michael.d.kinney@intel.com>)
 id 1i0tT6-0002Fq-VZ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 16:14:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 13:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; d="scan'208";a="181502233"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by orsmga003.jf.intel.com with ESMTP; 22 Aug 2019 13:13:56 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 13:13:55 -0700
Received: from orsmsx113.amr.corp.intel.com ([169.254.9.198]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.159]) with mapi id 14.03.0439.000;
 Thu, 22 Aug 2019 13:13:55 -0700
From: "Kinney, Michael D" <michael.d.kinney@intel.com>
To: "devel@edk2.groups.io" <devel@edk2.groups.io>, "lersek@redhat.com"
 <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, "Yao, Jiewen"
 <jiewen.yao@intel.com>, "Kinney, Michael D" <michael.d.kinney@intel.com>
Thread-Topic: [edk2-rfc] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
Thread-Index: AQHVUfF5vU6QBeHgZE+cN7DIWDHHwKb6jzUA//+ZRQCAAaHSAIAAFq8AgAEuZqD//8zIAIAAiChAgABQUYCAACK6gIAAmpdAgAJgcwCAALs9d4AEPCbwgACNBoD//467cAAPWXAAAAlUNOAAESqCAAAZhzSAAA4EM9A=
Date: Thu, 22 Aug 2019 20:13:54 +0000
Message-ID: <E92EE9817A31E24EB0585FDF735412F5B9DA20B2@ORSMSX113.amr.corp.intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
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
 <E92EE9817A31E24EB0585FDF735412F5B9D9D74A@ORSMSX113.amr.corp.intel.com>
 <adf3f3b8-1dc9-79e1-7411-4d9131657a1f@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9E82C@ORSMSX113.amr.corp.intel.com>
 <772d64f7-e153-e9e6-dd69-9f34de5bb577@redhat.com>
 <3ca65433-8aed-57d4-7f18-a2a2718a6ffe@redhat.com>
In-Reply-To: <3ca65433-8aed-57d4-7f18-a2a2718a6ffe@redhat.com>
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
X-Received-From: 134.134.136.20
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
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TGFzemxvLA0KDQpJIGJlbGlldmUgYWxsIHRoZSBjb2RlIGZvciB0aGUgQVAgc3RhcnR1cCB2ZWN0
b3INCmlzIGFscmVhZHkgaW4gZWRrMi4NCg0KSXQgaXMgYSBjb21iaW5hdGlvbiBvZiB0aGUgcmVz
ZXQgdmVjdG9yIGNvZGUgaW4NClVlZmlDcHVQa2cvUmVzZXRWZWNvci9WdGYwIGFuZCBhbiBJQTMy
L1g2NCBzcGVjaWZpYw0KZmVhdHVyZSBpbiB0aGUgR2VuRnYgdG9vbC4gIEl0IHNldHMgdXAgYSA0
S0IgYWxpZ25lZA0KbG9jYXRpb24gbmVhciA0R0Igd2hpY2ggY2FuIGJlIHVzZWQgdG8gc3RhcnQg
YW4gQVANCnVzaW5nIElOSVQtU0lQSS1TSVBJLg0KDQpESSBpcyBzZXQgdG8gJ0FQJyBpZiB0aGUg
cHJvY2Vzc29yIGlzIG5vdCB0aGUgQlNQLg0KVGhpcyBjYW4gYmUgdXNlZCB0byBjaG9vc2UgdG8g
cHV0IHRoZSBBUHMgaW50byBhDQp3YWl0IGxvb3AgZXhlY3V0aW5nIGZyb20gdGhlIHByb3RlY3Rl
ZCBGTEFTSCByZWdpb24uDQoNClRoZSBTTU0gTW9uYXJjaCBvbiBhIGhvdCBhZGQgZXZlbnQgY2Fu
IHVzZSB0aGUgTG9jYWwNCkFQSUMgdG8gc2VuZCBhbiBJTklULVNJUEktU0lQSSB0byB3YWtlIHRo
ZSBBUCBhdCB0aGUgNEtCIA0Kc3RhcnR1cCB2ZWN0b3IgaW4gRkxBU0guICBMYXRlciB0aGUgU01N
IE1vbmFyY2gNCmNhbiBzZW50IHVzZSB0aGUgTG9jYWwgQVBJQyB0byBzZW5kIGFuIFNNSSB0byBw
dWxsIHRoZSANCmhvdCBhZGRlZCBDUFUgaW50byBTTU0uICBJdCBpcyBub3QgY2xlYXIgaWYgd2Ug
aGF2ZSB0bw0KZG8gYm90aCBTSVBJIGZvbGxvd2VkIGJ5IHRoZSBTTUkgb3IgaWYgd2UgY2FuIGp1
c3QgZG8NCnRoZSBTTUkuDQoNCkJlc3QgcmVnYXJkcywNCg0KTWlrZQ0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGRldmVsQGVkazIuZ3JvdXBzLmlvDQo+IFttYWlsdG86
ZGV2ZWxAZWRrMi5ncm91cHMuaW9dIE9uIEJlaGFsZiBPZiBMYXN6bG8gRXJzZWsNCj4gU2VudDog
VGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAxOSAxMToyOSBBTQ0KPiBUbzogUGFvbG8gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT47IEtpbm5leSwNCj4gTWljaGFlbCBEIDxtaWNoYWVsLmQua2lu
bmV5QGludGVsLmNvbT47DQo+IHJmY0BlZGsyLmdyb3Vwcy5pbzsgWWFvLCBKaWV3ZW4gPGppZXdl
bi55YW9AaW50ZWwuY29tPg0KPiBDYzogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25A
cmVkaGF0LmNvbT47DQo+IGRldmVsQGVkazIuZ3JvdXBzLmlvOyBxZW11IGRldmVsIGxpc3QgPHFl
bXUtDQo+IGRldmVsQG5vbmdudS5vcmc+OyBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQu
Y29tPjsNCj4gQ2hlbiwgWWluZ3dlbiA8eWluZ3dlbi5jaGVuQGludGVsLmNvbT47IE5ha2FqaW1h
LCBKdW4NCj4gPGp1bi5uYWthamltYUBpbnRlbC5jb20+OyBCb3JpcyBPc3Ryb3Zza3kNCj4gPGJv
cmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPjsgSm9hbyBNYXJjYWwgTGVtb3MgTWFydGlucw0KPiA8
am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT47IFBoaWxsaXAgR29lcmwNCj4gPHBoaWxsaXAuZ29l
cmxAb3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtlZGsyLXJmY10gW2VkazItZGV2ZWxdIENQ
VSBob3RwbHVnIHVzaW5nDQo+IFNNTSB3aXRoIFFFTVUrT1ZNRg0KPiANCj4gT24gMDgvMjIvMTkg
MDg6MTgsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+ID4gT24gMjEvMDgvMTkgMjI6MTcsIEtpbm5l
eSwgTWljaGFlbCBEIHdyb3RlOg0KPiA+PiBQYW9sbywNCj4gPj4NCj4gPj4gSXQgbWFrZXMgc2Vu
c2UgdG8gbWF0Y2ggcmVhbCBIVy4NCj4gPg0KPiA+IE5vdGUgdGhhdCBpdCdkIGFsc28gYmUgZmlu
ZSB0byBtYXRjaCBzb21lIGtpbmQgb2YNCj4gb2ZmaWNpYWwgSW50ZWwNCj4gPiBzcGVjaWZpY2F0
aW9uIGV2ZW4gaWYgbm8gcHJvY2Vzc29yIChjdXJyZW50bHk/KQ0KPiBzdXBwb3J0cyBpdC4NCj4g
DQo+IEkgYWdyZWUsIGJlY2F1c2UuLi4NCj4gDQo+ID4+IFRoYXQgcHV0cyB1cyBiYWNrIHRvIHRo
ZSByZXNldCB2ZWN0b3IgYW5kIGhhbmRsaW5nDQo+IHRoZSBpbml0aWFsIFNNSSBhdA0KPiA+PiAz
MDAwOjgwMDAuICBUaGF0IGlzIGFsbCB3b3JrYWJsZSBmcm9tIGEgRlcNCj4gaW1wbGVtZW50YXRp
b24NCj4gPj4gcGVyc3BlY3RpdmUuDQo+IA0KPiB0aGF0IHdvdWxkIHN1Z2dlc3QgdGhhdCBtYXRj
aGluZyByZXNldCB2ZWN0b3IgY29kZQ0KPiBhbHJlYWR5IGV4aXN0cywgYW5kIGl0IHdvdWxkICJv
bmx5IiBuZWVkIHRvIGJlDQo+IHVwc3RyZWFtZWQgdG8gZWRrMi4gOikNCj4gDQo+ID4+IEl0IGxv
b2sgbGlrZSB0aGUgb25seSBpc3N1ZSBsZWZ0IGlzIERNQS4NCj4gPj4NCj4gPj4gRE1BIHByb3Rl
Y3Rpb24gb2YgbWVtb3J5IHJhbmdlcyBpcyBhIGNoaXBzZXQNCj4gZmVhdHVyZS4gRm9yIHRoZSBj
dXJyZW50DQo+ID4+IFFFTVUgaW1wbGVtZW50YXRpb24sIHdoYXQgcmFuZ2VzIG9mIG1lbW9yeSBh
cmUNCj4gZ3VhcmFudGVlZCB0byBiZQ0KPiA+PiBwcm90ZWN0ZWQgZnJvbSBETUE/ICBJcyBpdCBv
bmx5IEEvQiBzZWcgYW5kIFRTRUc/DQo+ID4NCj4gPiBZZXMuDQo+IA0KPiAoDQo+IA0KPiBUaGlz
IHRocmVhZCAoZXNwLiBKaWV3ZW4ncyBhbmQgTWlrZSdzIG1lc3NhZ2VzKSBhcmUgdGhlDQo+IGZp
cnN0IHRpbWUgdGhhdCBJJ3ZlIGhlYXJkIGFib3V0IHRoZSAqZXhpc3RlbmNlKiBvZg0KPiBzdWNo
IFJBTSByYW5nZXMgLyB0aGUgY2hpcHNldCBmZWF0dXJlLiA6KQ0KPiANCj4gT3V0IG9mIGludGVy
ZXN0IChpbmRlcGVuZGVudGx5IG9mIHZpcnR1YWxpemF0aW9uKSwgaG93DQo+IGlzIGEgZ2VuZXJh
bCBwdXJwb3NlIE9TIGluZm9ybWVkIGJ5IHRoZSBmaXJtd2FyZSwNCj4gIm5ldmVyIHRyeSB0byBz
ZXQgdXAgRE1BIHRvIHRoaXMgUkFNIGFyZWEiPyBJcyB0aGlzDQo+IGNvbW11bmljYXRlZCB0aHJv
dWdoIEFDUEkgX0NSUyBwZXJoYXBzPw0KPiANCj4gLi4uIEFoLCBhbG1vc3Q6IEFDUEkgNi4yIHNw
ZWNpZmllcyBfRE1BLCBpbiAiNi4yLjQgX0RNQQ0KPiAoRGlyZWN0IE1lbW9yeSBBY2Nlc3MpIi4g
SXQgd3JpdGVzLA0KPiANCj4gICAgIEZvciBleGFtcGxlLCBpZiBhIHBsYXRmb3JtIGltcGxlbWVu
dHMgYSBQQ0kgYnVzDQo+IHRoYXQgY2Fubm90IGFjY2Vzcw0KPiAgICAgYWxsIG9mIHBoeXNpY2Fs
IG1lbW9yeSwgaXQgaGFzIGEgX0RNQSBvYmplY3QgdW5kZXINCj4gdGhhdCBQQ0kgYnVzIHRoYXQN
Cj4gICAgIGRlc2NyaWJlcyB0aGUgcmFuZ2VzIG9mIHBoeXNpY2FsIG1lbW9yeSB0aGF0IGNhbiBi
ZQ0KPiBhY2Nlc3NlZCBieQ0KPiAgICAgZGV2aWNlcyBvbiB0aGF0IGJ1cy4NCj4gDQo+IFNvcnJ5
IGFib3V0IHRoZSBkaWdyZXNzaW9uLCBhbmQgYWxzbyBhYm91dCBiZWluZyBsYXRlDQo+IHRvIHRo
aXMgdGhyZWFkLCBjb250aW51YWxseSAtLSBJJ20gcHJpbWFyaWx5IGZvbGxvd2luZw0KPiBhbmQg
bGVhcm5pbmcuDQo+IA0KPiApDQo+IA0KPiBUaGFua3MhDQo+IExhc3psbw0KPiANCj4gLT0tPS09
LT0tPS09LT0tPS09LT0tPS0NCj4gR3JvdXBzLmlvIExpbmtzOiBZb3UgcmVjZWl2ZSBhbGwgbWVz
c2FnZXMgc2VudCB0byB0aGlzDQo+IGdyb3VwLg0KPiANCj4gVmlldy9SZXBseSBPbmxpbmUgKCM0
NjIyOCk6DQo+IGh0dHBzOi8vZWRrMi5ncm91cHMuaW8vZy9kZXZlbC9tZXNzYWdlLzQ2MjI4DQo+
IE11dGUgVGhpcyBUb3BpYzogaHR0cHM6Ly9ncm91cHMuaW8vbXQvMzI5Nzk2ODEvMTY0MzQ5Ng0K
PiBHcm91cCBPd25lcjogZGV2ZWwrb3duZXJAZWRrMi5ncm91cHMuaW8NCj4gVW5zdWJzY3JpYmU6
IGh0dHBzOi8vZWRrMi5ncm91cHMuaW8vZy9kZXZlbC91bnN1Yg0KPiBbbWljaGFlbC5kLmtpbm5l
eUBpbnRlbC5jb21dDQo+IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQoNCg==

