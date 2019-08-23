Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC42C3A5A1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 01:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495982173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 01:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495982173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0y1Z-0005BH-FA
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 21:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael.d.kinney@intel.com>) id 1i0xyZ-0003kY-Jy
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael.d.kinney@intel.com>) id 1i0xyY-0006zC-7H
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:02:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:36616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michael.d.kinney@intel.com>)
 id 1i0xyX-0006yw-WF
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:02:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 18:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; d="scan'208";a="181565941"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
 by orsmga003.jf.intel.com with ESMTP; 22 Aug 2019 18:02:44 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 18:02:44 -0700
Received: from orsmsx113.amr.corp.intel.com ([169.254.9.198]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.208]) with mapi id 14.03.0439.000;
 Thu, 22 Aug 2019 18:02:44 -0700
From: "Kinney, Michael D" <michael.d.kinney@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, "Yao, Jiewen"
 <jiewen.yao@intel.com>, "Kinney, Michael D" <michael.d.kinney@intel.com>
Thread-Topic: [edk2-rfc] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
Thread-Index: AQHVUfF5vU6QBeHgZE+cN7DIWDHHwKb6jzUA//+ZRQCAAaHSAIAAFq8AgAEuZqD//8zIAIAAiChAgABQUYCAACK6gIAAmpdAgAJgcwCAALs9d4AEPCbwgACNBoCAAaFPgIAADE2A//+WXtAAFLPEAAAOlQSA//+aXICAAGdgAA==
Date: Fri, 23 Aug 2019 01:02:43 +0000
Message-ID: <E92EE9817A31E24EB0585FDF735412F5B9DA2346@ORSMSX113.amr.corp.intel.com>
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
In-Reply-To: <3661c0c5-3da4-1453-a66a-3e4d4022e876@redhat.com>
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
X-Received-From: 134.134.136.126
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

UGFvbG8sDQoNCkkgZmluZCB0aGUgZm9sbG93aW5nIGxpbmtzIHJlbGF0ZWQgdG8gdGhlIGRpc2N1
c3Npb25zIGhlcmUNCmFsb25nIHdpdGggb25lIGV4YW1wbGUgZmVhdHVyZSBjYWxsZWQgR0VOUFJP
VFJBTkdFLg0KDQpodHRwczovL2NzcmMubmlzdC5nb3YvQ1NSQy9tZWRpYS9QcmVzZW50YXRpb25z
L1RoZS1XaG9sZS1pcy1HcmVhdGVyL2ltYWdlcy1tZWRpYS9kYXkxX3RydXN0ZWQtY29tcHV0aW5n
XzIwMC0yNTAucGRmDQpodHRwczovL2NhbnNlY3dlc3QuY29tL3NsaWRlcy8yMDE3L0NTVzIwMTdf
Q3VhdWh0ZW1vYy1SZW5lX0NQVV9Ib3QtQWRkX2Zsb3cucGRmDQpodHRwczovL3d3dy5tb3VzZXIu
Y29tL2RzLzIvNjEyLzU1MjAtNTUwMC1jaGlwc2V0LWlvaC1kYXRhc2hlZXQtMTEzMTI5Mi5wZGYN
Cg0KQmVzdCByZWdhcmRzLA0KDQpNaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogUGFvbG8gQm9uemluaSBbbWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNl
bnQ6IFRodXJzZGF5LCBBdWd1c3QgMjIsIDIwMTkgNDoxMiBQTQ0KPiBUbzogS2lubmV5LCBNaWNo
YWVsIEQgPG1pY2hhZWwuZC5raW5uZXlAaW50ZWwuY29tPjsNCj4gTGFzemxvIEVyc2VrIDxsZXJz
ZWtAcmVkaGF0LmNvbT47IHJmY0BlZGsyLmdyb3Vwcy5pbzsNCj4gWWFvLCBKaWV3ZW4gPGppZXdl
bi55YW9AaW50ZWwuY29tPg0KPiBDYzogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25A
cmVkaGF0LmNvbT47DQo+IGRldmVsQGVkazIuZ3JvdXBzLmlvOyBxZW11IGRldmVsIGxpc3QgPHFl
bXUtDQo+IGRldmVsQG5vbmdudS5vcmc+OyBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQu
Y29tPjsNCj4gQ2hlbiwgWWluZ3dlbiA8eWluZ3dlbi5jaGVuQGludGVsLmNvbT47IE5ha2FqaW1h
LCBKdW4NCj4gPGp1bi5uYWthamltYUBpbnRlbC5jb20+OyBCb3JpcyBPc3Ryb3Zza3kNCj4gPGJv
cmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPjsgSm9hbyBNYXJjYWwgTGVtb3MgTWFydGlucw0KPiA8
am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT47IFBoaWxsaXAgR29lcmwNCj4gPHBoaWxsaXAuZ29l
cmxAb3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtlZGsyLXJmY10gW2VkazItZGV2ZWxdIENQ
VSBob3RwbHVnIHVzaW5nDQo+IFNNTSB3aXRoIFFFTVUrT1ZNRg0KPiANCj4gT24gMjMvMDgvMTkg
MDA6MzIsIEtpbm5leSwgTWljaGFlbCBEIHdyb3RlOg0KPiA+IFBhb2xvLA0KPiA+DQo+ID4gSXQg
aXMgbXkgdW5kZXJzdGFuZGluZyB0aGF0IHJlYWwgSFcgaG90IHBsdWcgdXNlcyB0aGUNCj4gU0RN
IGRlZmluZWQNCj4gPiBtZXRob2RzLiAgTWVhbmluZyB0aGUgaW5pdGlhbCBTTUkgaXMgdG8gMzAw
MDo4MDAwIGFuZA0KPiB0aGV5IHJlYmFzZSB0bw0KPiA+IFRTRUcgaW4gdGhlIGZpcnN0IFNNSS4g
IFRoZXkgbXVzdCBoYXZlIGNoaXBzZXQgc3BlY2lmaWMNCj4gbWV0aG9kcyB0bw0KPiA+IHByb3Rl
Y3QgMzAwMDo4MDAwIGZyb20gRE1BLg0KPiANCj4gSXQgd291bGQgYmUgZ3JlYXQgaWYgeW91IGNv
dWxkIGNoZWNrLg0KPiANCj4gPiBDYW4gd2UgYWRkIGEgY2hpcHNldCBmZWF0dXJlIHRvIHByZXZl
bnQgRE1BIHRvIDY0S0INCj4gcmFuZ2UgZnJvbQ0KPiA+IDB4MzAwMDAtMHgzRkZGRiBhbmQgdGhl
IFVFRkkgTWVtb3J5IE1hcCBhbmQgQUNQSQ0KPiBjb250ZW50IGNhbiBiZQ0KPiA+IHVwZGF0ZWQg
c28gdGhlIEd1ZXN0IE9TIGtub3dzIHRvIG5vdCB1c2UgdGhhdCByYW5nZSBmb3INCj4gRE1BPw0K
PiANCj4gSWYgcmVhbCBoYXJkd2FyZSBkb2VzIGl0IGF0IHRoZSBjaGlwc2V0IGxldmVsLCB3ZSB3
aWxsDQo+IHByb2JhYmx5IHVzZSBJZ29yJ3Mgc3VnZ2VzdGlvbiBvZiBhbGlhc2luZyBBLXNlZyB0
bw0KPiAzMDAwOjAwMDAuICBCZWZvcmUgc3RhcnRpbmcgdGhlIG5ldyBDUFUsIHRoZSBTTUkgaGFu
ZGxlcg0KPiBjYW4gcHJlcGFyZSB0aGUgU01CQVNFIHJlbG9jYXRpb24gdHJhbXBvbGluZSBhdA0K
PiBBMDAwOjgwMDAgYW5kIHRoZSBob3QtcGx1Z2dlZCBDUFUgd2lsbCBmaW5kIGl0IGF0DQo+IDMw
MDA6ODAwMCB3aGVuIGl0IHJlY2VpdmVzIHRoZSBpbml0aWFsIFNNSS4gIEJlY2F1c2UgdGhpcw0K
PiBpcyBiYWNrZWQgYnkgUkFNIGF0IDB4QTAwMDAtMHhBRkZGRiwgRE1BIGNhbm5vdCBhY2Nlc3Mg
aXQNCj4gYW5kIHdvdWxkIHN0aWxsIGdvIHRocm91Z2ggdG8gUkFNIGF0IDB4MzAwMDAuDQo+IA0K
PiBQYW9sbw0K

