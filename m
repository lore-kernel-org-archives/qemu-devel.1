Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9420DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A47421019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A47421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BeQ-00088J-Jk
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael.d.kinney@intel.com>) id 1i1BR7-0001ty-AL
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael.d.kinney@intel.com>) id 1i1BR5-0000ER-63
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:25:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:21175)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michael.d.kinney@intel.com>)
 id 1i1BR4-0000Ck-Sy
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:25:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 08:25:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,421,1559545200"; d="scan'208";a="173509698"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by orsmga008.jf.intel.com with ESMTP; 23 Aug 2019 08:25:02 -0700
Received: from orsmsx113.amr.corp.intel.com ([169.254.9.198]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.66]) with mapi id 14.03.0439.000;
 Fri, 23 Aug 2019 08:25:00 -0700
From: "Kinney, Michael D" <michael.d.kinney@intel.com>
To: "Yao, Jiewen" <jiewen.yao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Laszlo Ersek <lersek@redhat.com>, "rfc@edk2.groups.io" <rfc@edk2.groups.io>,
 "Kinney, Michael D" <michael.d.kinney@intel.com>
Thread-Topic: [edk2-rfc] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
Thread-Index: AQHVUfF5vU6QBeHgZE+cN7DIWDHHwKb6jzUA//+ZRQCAAaHSAIAAFq8AgAEuZqD//8zIAIAAiChAgABQUYCAACK6gIAAmpdAgAJgcwCAALs9d4AEPCbwgACNBoCAAaFPgIAADE2A//+WXtAAFLPEAAAOlQSA//+aXICAAGdgAP//+fqA///MaZA=
Date: Fri, 23 Aug 2019 15:25:00 +0000
Message-ID: <E92EE9817A31E24EB0585FDF735412F5B9DA25CC@ORSMSX113.amr.corp.intel.com>
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
 <74D8A39837DF1E4DA445A8C0B3885C503F76FDAF@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <74D8A39837DF1E4DA445A8C0B3885C503F76FDAF@shsmsx102.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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

SGkgSmlld2VuLA0KDQpJZiBhIGhvdCBhZGQgQ1BVIG5lZWRzIHRvIHJ1biBhbnkgY29kZSBiZWZv
cmUgdGhlDQpmaXJzdCBTTUksIEkgd291bGQgcmVjb21tZW5kIGlzIG9ubHkgZXhlY3V0ZXMgY29k
ZQ0KZnJvbSBhIHdyaXRlIHByb3RlY3RlZCBGTEFTSCByYW5nZSB3aXRob3V0IGEgc3RhY2sNCmFu
ZCB0aGVuIHdhaXQgZm9yIHRoZSBmaXJzdCBTTUkuDQoNCkZvciB0aGlzIE9WTUYgdXNlIGNhc2Us
IGlzIGFueSBDUFUgaW5pdCByZXF1aXJlZA0KYmVmb3JlIHRoZSBmaXJzdCBTTUk/DQoNCkZyb20g
UGFvbG8ncyBsaXN0IG9mIHN0ZXBzIGFyZSBzdGVwcyAoOGEpIGFuZCAoOGIpIA0KcmVhbGx5IHJl
cXVpcmVkPyAgQ2FuIHRoZSBTTUkgbW9uYXJjaCB1c2UgdGhlIExvY2FsDQpBUElDIHRvIHNlbmQg
YSBkaXJlY3RlZCBTTUkgdG8gdGhlIGhvdCBhZGRlZCBDUFU/DQpUaGUgU01JIG1vbmFyY2ggbmVl
ZHMgdG8ga25vdyB0aGUgQVBJQyBJRCBvZiB0aGUNCmhvdCBhZGRlZCBDUFUuICBEbyB3ZSBhbHNv
IG5lZWQgdG8gaGFuZGxlIHRoZSBjYXNlDQp3aGVyZSBtdWx0aXBsZSBDUFVzIGFyZSBhZGRlZCBh
dCBvbmNlPyAgSSB0aGluayB3ZQ0Kd291bGQgbmVlZCB0byBzZXJpYWxpemUgdGhlIHVzZSBvZiAz
MDAwOjgwMDAgZm9yIHRoZQ0KU01NIHJlYmFzZSBvcGVyYXRpb24gb24gZWFjaCBob3QgYWRkZWQg
Q1BVLg0KDQpJdCB3b3VsZCBiZSBzaW1wbGVyIGlmIHdlIGNhbiBndWFyYW50ZWUgdGhhdCBvbmx5
DQpvbmUgQ1BVIGNhbiBiZSBhZGRlZCBvciByZW1vdmVkIGF0IGEgdGltZSBhbmQgdGhlIA0KY29t
cGxldGUgZmxvdyBvZiBhZGRpbmcgYSBDUFUgdG8gU01NIGFuZCB0aGUgT1MNCm5lZWRzIHRvIGJl
IGNvbXBsZXRlZCBiZWZvcmUgYW5vdGhlciBhZGQvcmVtb3ZlDQpldmVudCBuZWVkcyB0byBiZSBw
cm9jZXNzZWQuDQoNCk1pa2UNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBZYW8sIEppZXdlbg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDIyLCAyMDE5IDEwOjAwIFBN
DQo+IFRvOiBLaW5uZXksIE1pY2hhZWwgRCA8bWljaGFlbC5kLmtpbm5leUBpbnRlbC5jb20+Ow0K
PiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgTGFzemxvIEVyc2VrDQo+IDxs
ZXJzZWtAcmVkaGF0LmNvbT47IHJmY0BlZGsyLmdyb3Vwcy5pbw0KPiBDYzogQWxleCBXaWxsaWFt
c29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT47DQo+IGRldmVsQGVkazIuZ3JvdXBzLmlv
OyBxZW11IGRldmVsIGxpc3QgPHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc+OyBJZ29yIE1hbW1l
ZG92IDxpbWFtbWVkb0ByZWRoYXQuY29tPjsNCj4gQ2hlbiwgWWluZ3dlbiA8eWluZ3dlbi5jaGVu
QGludGVsLmNvbT47IE5ha2FqaW1hLCBKdW4NCj4gPGp1bi5uYWthamltYUBpbnRlbC5jb20+OyBC
b3JpcyBPc3Ryb3Zza3kNCj4gPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPjsgSm9hbyBNYXJj
YWwgTGVtb3MgTWFydGlucw0KPiA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT47IFBoaWxsaXAg
R29lcmwNCj4gPHBoaWxsaXAuZ29lcmxAb3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUkU6IFtlZGsy
LXJmY10gW2VkazItZGV2ZWxdIENQVSBob3RwbHVnIHVzaW5nDQo+IFNNTSB3aXRoIFFFTVUrT1ZN
Rg0KPiANCj4gVGhhbmsgeW91IE1pa2UhDQo+IA0KPiBUaGF0IGlzIGdvb2QgcmVmZXJlbmNlIG9u
IHRoZSByZWFsIGhhcmR3YXJlIGJlaGF2aW9yLg0KPiAoR2xhZCBpdCBpcyBwdWJsaWMuKQ0KPiAN
Cj4gRm9yIHRocmVhdCBtb2RlbCwgdGhlIHVuaXF1ZSBwYXJ0IGluIHZpcnR1YWwgZW52aXJvbm1l
bnQNCj4gaXMgdGVtcCBSQU0uDQo+IFRoZSB0ZW1wIFJBTSBpbiByZWFsIHBsYXRmb3JtIGlzIHBl
ciBDUFUgY2FjaGUsIHdoaWxlDQo+IHRoZSB0ZW1wIFJBTSBpbiB2aXJ0dWFsIHBsYXRmb3JtIGlz
IGdsb2JhbCBtZW1vcnkuDQo+IFRoYXQgYnJpbmdzIG9uZSBtb3JlIHBvdGVudGlhbCBhdHRhY2sg
c3VyZmFjZSBpbiB2aXJ0dWFsDQo+IGVudmlyb25tZW50LCBpZiBob3QtYWRkZWQgQ1BVIG5lZWQg
cnVuIGNvZGUgd2l0aCBzdGFjaw0KPiBvciBoZWFwIGJlZm9yZSBTTUkgcmViYXNlLg0KPiANCj4g
T3RoZXIgdGhyZWF0cywgc3VjaCBhcyBTTVJBTSBvciBETUEsIGFyZSBzYW1lLg0KPiANCj4gVGhh
bmsgeW91DQo+IFlhbyBKaWV3ZW4NCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gRnJvbTogS2lubmV5LCBNaWNoYWVsIEQNCj4gPiBTZW50OiBGcmlkYXksIEF1Z3Vz
dCAyMywgMjAxOSA5OjAzIEFNDQo+ID4gVG86IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhh
dC5jb20+OyBMYXN6bG8gRXJzZWsNCj4gPiA8bGVyc2VrQHJlZGhhdC5jb20+OyByZmNAZWRrMi5n
cm91cHMuaW87IFlhbywgSmlld2VuDQo+ID4gPGppZXdlbi55YW9AaW50ZWwuY29tPjsgS2lubmV5
LCBNaWNoYWVsIEQNCj4gPG1pY2hhZWwuZC5raW5uZXlAaW50ZWwuY29tPg0KPiA+IENjOiBBbGV4
IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPjsNCj4gPiBkZXZlbEBlZGsy
Lmdyb3Vwcy5pbzsgcWVtdSBkZXZlbCBsaXN0IDxxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnPjsg
SWdvcg0KPiA+IE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29tPjsgQ2hlbiwgWWluZ3dlbg0K
PiA+IDx5aW5nd2VuLmNoZW5AaW50ZWwuY29tPjsgTmFrYWppbWEsIEp1bg0KPiA8anVuLm5ha2Fq
aW1hQGludGVsLmNvbT47DQo+ID4gQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5vc3Ryb3Zza3lAb3Jh
Y2xlLmNvbT47IEpvYW8NCj4gTWFyY2FsIExlbW9zDQo+ID4gTWFydGlucyA8am9hby5tLm1hcnRp
bnNAb3JhY2xlLmNvbT47IFBoaWxsaXAgR29lcmwNCj4gPiA8cGhpbGxpcC5nb2VybEBvcmFjbGUu
Y29tPg0KPiA+IFN1YmplY3Q6IFJFOiBbZWRrMi1yZmNdIFtlZGsyLWRldmVsXSBDUFUgaG90cGx1
ZyB1c2luZw0KPiBTTU0gd2l0aA0KPiA+IFFFTVUrT1ZNRg0KPiA+DQo+ID4gUGFvbG8sDQo+ID4N
Cj4gPiBJIGZpbmQgdGhlIGZvbGxvd2luZyBsaW5rcyByZWxhdGVkIHRvIHRoZSBkaXNjdXNzaW9u
cw0KPiBoZXJlIGFsb25nIHdpdGgNCj4gPiBvbmUgZXhhbXBsZSBmZWF0dXJlIGNhbGxlZCBHRU5Q
Uk9UUkFOR0UuDQo+ID4NCj4gPiBodHRwczovL2NzcmMubmlzdC5nb3YvQ1NSQy9tZWRpYS9QcmVz
ZW50YXRpb25zL1RoZS0NCj4gV2hvbGUtaXMtR3JlYXRlci9pbQ0KPiA+IGEgZ2VzLW1lZGlhL2Rh
eTFfdHJ1c3RlZC1jb21wdXRpbmdfMjAwLTI1MC5wZGYNCj4gPiBodHRwczovL2NhbnNlY3dlc3Qu
Y29tL3NsaWRlcy8yMDE3L0NTVzIwMTdfQ3VhdWh0ZW1vYy0NCj4gUmVuZV9DUFVfSG8NCj4gPiB0
LUFkZF9mbG93LnBkZg0KPiA+IGh0dHBzOi8vd3d3Lm1vdXNlci5jb20vZHMvMi82MTIvNTUyMC01
NTAwLWNoaXBzZXQtaW9oLQ0KPiBkYXRhc2hlZXQtMTEzMQ0KPiA+IDI5Mi5wZGYNCj4gPg0KPiA+
IEJlc3QgcmVnYXJkcywNCj4gPg0KPiA+IE1pa2UNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFBhb2xvIEJvbnppbmkgW21haWx0bzpwYm9uemluaUBy
ZWRoYXQuY29tXQ0KPiA+ID4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAxOSA0OjEyIFBN
DQo+ID4gPiBUbzogS2lubmV5LCBNaWNoYWVsIEQgPG1pY2hhZWwuZC5raW5uZXlAaW50ZWwuY29t
PjsNCj4gTGFzemxvIEVyc2VrDQo+ID4gPiA8bGVyc2VrQHJlZGhhdC5jb20+OyByZmNAZWRrMi5n
cm91cHMuaW87IFlhbywgSmlld2VuDQo+ID4gPiA8amlld2VuLnlhb0BpbnRlbC5jb20+DQo+ID4g
PiBDYzogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT47DQo+ID4g
PiBkZXZlbEBlZGsyLmdyb3Vwcy5pbzsgcWVtdSBkZXZlbCBsaXN0IDxxZW11LQ0KPiBkZXZlbEBu
b25nbnUub3JnPjsgSWdvcg0KPiA+ID4gTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+OyBD
aGVuLCBZaW5nd2VuDQo+ID4gPiA8eWluZ3dlbi5jaGVuQGludGVsLmNvbT47IE5ha2FqaW1hLCBK
dW4NCj4gPGp1bi5uYWthamltYUBpbnRlbC5jb20+Ow0KPiA+ID4gQm9yaXMgT3N0cm92c2t5IDxi
b3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IEpvYW8NCj4gTWFyY2FsIExlbW9zDQo+ID4gPiBN
YXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPjsgUGhpbGxpcCBHb2VybA0KPiA+ID4g
PHBoaWxsaXAuZ29lcmxAb3JhY2xlLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbZWRrMi1yZmNd
IFtlZGsyLWRldmVsXSBDUFUgaG90cGx1Zw0KPiB1c2luZyBTTU0gd2l0aA0KPiA+ID4gUUVNVStP
Vk1GDQo+ID4gPg0KPiA+ID4gT24gMjMvMDgvMTkgMDA6MzIsIEtpbm5leSwgTWljaGFlbCBEIHdy
b3RlOg0KPiA+ID4gPiBQYW9sbywNCj4gPiA+ID4NCj4gPiA+ID4gSXQgaXMgbXkgdW5kZXJzdGFu
ZGluZyB0aGF0IHJlYWwgSFcgaG90IHBsdWcgdXNlcw0KPiB0aGUNCj4gPiA+IFNETSBkZWZpbmVk
DQo+ID4gPiA+IG1ldGhvZHMuICBNZWFuaW5nIHRoZSBpbml0aWFsIFNNSSBpcyB0byAzMDAwOjgw
MDANCj4gYW5kDQo+ID4gPiB0aGV5IHJlYmFzZSB0bw0KPiA+ID4gPiBUU0VHIGluIHRoZSBmaXJz
dCBTTUkuICBUaGV5IG11c3QgaGF2ZSBjaGlwc2V0DQo+IHNwZWNpZmljDQo+ID4gPiBtZXRob2Rz
IHRvDQo+ID4gPiA+IHByb3RlY3QgMzAwMDo4MDAwIGZyb20gRE1BLg0KPiA+ID4NCj4gPiA+IEl0
IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBjb3VsZCBjaGVjay4NCj4gPiA+DQo+ID4gPiA+IENhbiB3
ZSBhZGQgYSBjaGlwc2V0IGZlYXR1cmUgdG8gcHJldmVudCBETUEgdG8NCj4gNjRLQg0KPiA+ID4g
cmFuZ2UgZnJvbQ0KPiA+ID4gPiAweDMwMDAwLTB4M0ZGRkYgYW5kIHRoZSBVRUZJIE1lbW9yeSBN
YXAgYW5kIEFDUEkNCj4gPiA+IGNvbnRlbnQgY2FuIGJlDQo+ID4gPiA+IHVwZGF0ZWQgc28gdGhl
IEd1ZXN0IE9TIGtub3dzIHRvIG5vdCB1c2UgdGhhdA0KPiByYW5nZSBmb3INCj4gPiA+IERNQT8N
Cj4gPiA+DQo+ID4gPiBJZiByZWFsIGhhcmR3YXJlIGRvZXMgaXQgYXQgdGhlIGNoaXBzZXQgbGV2
ZWwsIHdlDQo+IHdpbGwgcHJvYmFibHkgdXNlDQo+ID4gPiBJZ29yJ3Mgc3VnZ2VzdGlvbiBvZiBh
bGlhc2luZyBBLXNlZyB0byAzMDAwOjAwMDAuDQo+IEJlZm9yZSBzdGFydGluZw0KPiA+ID4gdGhl
IG5ldyBDUFUsIHRoZSBTTUkgaGFuZGxlciBjYW4gcHJlcGFyZSB0aGUgU01CQVNFDQo+IHJlbG9j
YXRpb24NCj4gPiA+IHRyYW1wb2xpbmUgYXQNCj4gPiA+IEEwMDA6ODAwMCBhbmQgdGhlIGhvdC1w
bHVnZ2VkIENQVSB3aWxsIGZpbmQgaXQgYXQNCj4gPiA+IDMwMDA6ODAwMCB3aGVuIGl0IHJlY2Vp
dmVzIHRoZSBpbml0aWFsIFNNSS4gIEJlY2F1c2UNCj4gdGhpcyBpcyBiYWNrZWQNCj4gPiA+IGJ5
IFJBTSBhdCAweEEwMDAwLTB4QUZGRkYsIERNQSBjYW5ub3QgYWNjZXNzIGl0IGFuZA0KPiB3b3Vs
ZCBzdGlsbCBnbw0KPiA+ID4gdGhyb3VnaCB0byBSQU0gYXQgMHgzMDAwMC4NCj4gPiA+DQo+ID4g
PiBQYW9sbw0K

