Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8FEC3A589
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 02:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A90206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 02:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A90206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hySHA-0004nl-4B
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 22:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiewen.yao@intel.com>) id 1hySGW-0004MB-4j
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 22:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiewen.yao@intel.com>) id 1hySGT-00068m-HL
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 22:46:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:58577)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiewen.yao@intel.com>)
 id 1hySGT-000661-8U
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 22:46:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Aug 2019 19:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; d="scan'208";a="206109246"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2019 19:46:49 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 15 Aug 2019 19:46:48 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 15 Aug 2019 19:46:48 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.19]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.65]) with mapi id 14.03.0439.000;
 Fri, 16 Aug 2019 10:46:46 +0800
From: "Yao, Jiewen" <jiewen.yao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>
Thread-Topic: [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
Thread-Index: AQHVUfF5lMVYZhTq/0GuokGqDPas2Kb6jzUA//+ZRQCAAaHSAIAAFq8AgAEuZqA=
Date: Fri, 16 Aug 2019 02:46:45 +0000
Message-ID: <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
In-Reply-To: <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
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
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
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
 qemu devel list <qemu-devel@nongnu.org>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Q29tbWVudCBiZWxvdzoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFBhb2xvIEJvbnppbmkgW21haWx0bzpwYm9uemluaUByZWRoYXQuY29tXQ0KPiBTZW50OiBGcmlk
YXksIEF1Z3VzdCAxNiwgMjAxOSAxMjoyMSBBTQ0KPiBUbzogTGFzemxvIEVyc2VrIDxsZXJzZWtA
cmVkaGF0LmNvbT47IGRldmVsQGVkazIuZ3JvdXBzLmlvOyBZYW8sIEppZXdlbg0KPiA8amlld2Vu
Lnlhb0BpbnRlbC5jb20+DQo+IENjOiBlZGsyLXJmYy1ncm91cHMtaW8gPHJmY0BlZGsyLmdyb3Vw
cy5pbz47IHFlbXUgZGV2ZWwgbGlzdA0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgSWdvciBN
YW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT47DQo+IENoZW4sIFlpbmd3ZW4gPHlpbmd3ZW4u
Y2hlbkBpbnRlbC5jb20+OyBOYWthamltYSwgSnVuDQo+IDxqdW4ubmFrYWppbWFAaW50ZWwuY29t
PjsgQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47DQo+IEpvYW8g
TWFyY2FsIExlbW9zIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+OyBQaGlsbGlw
IEdvZXJsDQo+IDxwaGlsbGlwLmdvZXJsQG9yYWNsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbZWRr
Mi1kZXZlbF0gQ1BVIGhvdHBsdWcgdXNpbmcgU01NIHdpdGggUUVNVStPVk1GDQo+IA0KPiBPbiAx
NS8wOC8xOSAxNzowMCwgTGFzemxvIEVyc2VrIHdyb3RlOg0KPiA+IE9uIDA4LzE0LzE5IDE2OjA0
LCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPiA+PiBPbiAxNC8wOC8xOSAxNToyMCwgWWFvLCBKaWV3
ZW4gd3JvdGU6DQo+ID4+Pj4gLSBEb2VzIHRoaXMgcGFydCByZXF1aXJlIGEgbmV3IGJyYW5jaCBz
b21ld2hlcmUgaW4gdGhlIE9WTUYgU0VDDQo+IGNvZGU/DQo+ID4+Pj4gICBIb3cgZG8gd2UgZGV0
ZXJtaW5lIHdoZXRoZXIgdGhlIENQVSBleGVjdXRpbmcgU0VDIGlzIEJTUCBvcg0KPiA+Pj4+ICAg
aG90LXBsdWdnZWQgQVA/DQo+ID4+PiBbSmlld2VuXSBJIHRoaW5rIHRoaXMgaXMgYmxvY2tlZCBm
cm9tIGhhcmR3YXJlIHBlcnNwZWN0aXZlLCBzaW5jZSB0aGUgZmlyc3QNCj4gaW5zdHJ1Y3Rpb24u
DQo+ID4+PiBUaGVyZSBhcmUgc29tZSBoYXJkd2FyZSBzcGVjaWZpYyByZWdpc3RlcnMgY2FuIGJl
IHVzZWQgdG8gZGV0ZXJtaW5lIGlmDQo+IHRoZSBDUFUgaXMgbmV3IGFkZGVkLg0KPiA+Pj4gSSBk
b27igJl0IHRoaW5rIHRoaXMgbXVzdCBiZSBzYW1lIGFzIHRoZSByZWFsIGhhcmR3YXJlLg0KPiA+
Pj4gWW91IGFyZSBmcmVlIHRvIGludmVudCBzb21lIHJlZ2lzdGVycyBpbiBkZXZpY2UgbW9kZWwg
dG8gYmUgdXNlZCBpbg0KPiBPVk1GIGhvdCBwbHVnIGRyaXZlci4NCj4gPj4NCj4gPj4gWWVzLCB0
aGlzIHdvdWxkIGJlIGEgbmV3IG9wZXJhdGlvbiBtb2RlIGZvciBRRU1VLCB0aGF0IG9ubHkgYXBw
bGllcyB0bw0KPiA+PiBob3QtcGx1Z2dlZCBDUFVzLiAgSW4gdGhpcyBtb2RlIHRoZSBBUCBkb2Vz
bid0IHJlcGx5IHRvIElOSVQgb3IgU01JLCBpbg0KPiA+PiBmYWN0IGl0IGRvZXNuJ3QgcmVwbHkg
dG8gYW55dGhpbmcgYXQgYWxsLg0KPiA+Pg0KPiA+Pj4+IC0gSG93IGRvIHdlIHRlbGwgdGhlIGhv
dC1wbHVnZ2VkIEFQIHdoZXJlIHRvIHN0YXJ0IGV4ZWN1dGlvbj8gKEkuZS4NCj4gdGhhdA0KPiA+
Pj4+ICAgaXQgc2hvdWxkIGV4ZWN1dGUgY29kZSBhdCBhIHBhcnRpY3VsYXIgcGZsYXNoIGxvY2F0
aW9uLikNCj4gPj4+IFtKaWV3ZW5dIFNhbWUgcmVhbCBtb2RlIHJlc2V0IHZlY3RvciBhdCBGRkZG
OkZGRjAuDQo+ID4+DQo+ID4+IFlvdSBkbyBub3QgbmVlZCBhIHJlc2V0IHZlY3RvciBvciBJTklU
L1NJUEkvU0lQSSBzZXF1ZW5jZSBhdCBhbGwgaW4NCj4gPj4gUUVNVS4gIFRoZSBBUCBkb2VzIG5v
dCBzdGFydCBleGVjdXRpb24gYXQgYWxsIHdoZW4gaXQgaXMgdW5wbHVnZ2VkLCBzbw0KPiA+PiBu
byBjYWNoZS1hcy1SQU0gZXRjLg0KPiA+Pg0KPiA+PiBXZSBvbmx5IG5lZWQgdG8gbW9kaWZ5IFFF
TVUgc28gdGhhdCBob3QtcGx1Z2dlZCBBUElzIGRvIG5vdCByZXBseSB0bw0KPiA+PiBJTklUL1NJ
UEkvU01JLg0KPiA+Pg0KPiA+Pj4gSSBkb27igJl0IHRoaW5rIHRoZXJlIGlzIHByb2JsZW0gZm9y
IHJlYWwgaGFyZHdhcmUsIHdobyBhbHdheXMgaGFzIENBUi4NCj4gPj4+IENhbiBRRU1VIHByb3Zp
ZGUgc29tZSBDUFUgc3BlY2lmaWMgc3BhY2UsIHN1Y2ggYXMgTU1JTyByZWdpb24/DQo+ID4+DQo+
ID4+IFdoeSBpcyBhIENQVS1zcGVjaWZpYyByZWdpb24gbmVlZGVkIGlmIGV2ZXJ5IG90aGVyIHBy
b2Nlc3NvciBpcyBpbiBTTU0NCj4gPj4gYW5kIHRodXMgdHJ1c3RlZC4NCj4gPg0KPiA+IEkgd2Fz
IGdvaW5nIHRocm91Z2ggdGhlIHN0ZXBzIEppZXdlbiBhbmQgWWluZ3dlbiByZWNvbW1lbmRlZC4N
Cj4gPg0KPiA+IEluIHN0ZXAgKDAyKSwgdGhlIG5ldyBDUFUgaXMgZXhwZWN0ZWQgdG8gc2V0IHVw
IFJBTSBhY2Nlc3MuIEluIHN0ZXANCj4gPiAoMDMpLCB0aGUgbmV3IENQVSwgZXhlY3V0aW5nIGNv
ZGUgZnJvbSBmbGFzaCwgaXMgZXhwZWN0ZWQgdG8gInNlbmQgYm9hcmQNCj4gPiBtZXNzYWdlIHRv
IHRlbGwgaG9zdCBDUFUgKEdQSU8tPlNDSSkgLS0gSSBhbSB3YWl0aW5nIGZvciBob3QtYWRkDQo+
ID4gbWVzc2FnZS4iIEZvciB0aGF0IGFjdGlvbiwgdGhlIG5ldyBDUFUgbWF5IG5lZWQgYSBzdGFj
ayAobWluaW1hbGx5IGlmIHdlDQo+ID4gd2FudCB0byB1c2UgQyBmdW5jdGlvbiBjYWxscykuDQo+
ID4NCj4gPiBVbnRpbCBzdGVwICgwMyksIHRoZXJlIGhhZCBiZWVuIG5vIHdvcmQgYWJvdXQgYW55
IG90aGVyICg9IHByZS1wbHVnZ2VkKQ0KPiA+IENQVXMgKG1vcmUgcHJlY2lzZWx5LCBKaWV3ZW4g
ZXZlbiBjb25maXJtZWQgIk5vIGltcGFjdCB0byBvdGhlcg0KPiA+IHByb2Nlc3NvcnMiKSwgc28g
SSBkaWRuJ3QgYXNzdW1lIHRoYXQgb3RoZXIgQ1BVcyBoYWQgZW50ZXJlZCBTTU0uDQo+ID4NCj4g
PiBQYW9sbywgSSd2ZSBhdHRlbXB0ZWQgdG8gcmVhZCBKaWV3ZW4ncyByZXNwb25zZSwgYW5kIHlv
dXJzLCBhcyBjYXJlZnVsbHkNCj4gPiBhcyBJIGNhbi4gSSdtIHN0aWxsIHZlcnkgY29uZnVzZWQu
IElmIHlvdSBoYXZlIGEgYmV0dGVyIHVuZGVyc3RhbmRpbmcsDQo+ID4gY291bGQgeW91IHBsZWFz
ZSB3cml0ZSB1cCB0aGUgMTUtc3RlcCBwcm9jZXNzIGZyb20gdGhlIHRocmVhZCBzdGFydGVyDQo+
ID4gYWdhaW4sIHdpdGggYWxsIFFFTVUgY3VzdG9taXphdGlvbnMgYXBwbGllZD8gU3VjaCBhcywg
dW5uZWNlc3Nhcnkgc3RlcHMNCj4gPiByZW1vdmVkLCBhbmQgcGxhdGZvcm0gc3BlY2lmaWNzIGZp
bGxlZCBpbi4NCj4gDQo+IFN1cmUuDQo+IA0KPiAoMDFhKSBRRU1VOiBjcmVhdGUgbmV3IENQVS4g
IFRoZSBDUFUgYWxyZWFkeSBleGlzdHMsIGJ1dCBpdCBkb2VzIG5vdA0KPiAgICAgIHN0YXJ0IHJ1
bm5pbmcgY29kZSB1bnRpbCB1bnBhcmtlZCBieSB0aGUgQ1BVIGhvdHBsdWcgY29udHJvbGxlci4N
Cj4gDQo+ICgwMWIpIFFFTVU6IHRyaWdnZXIgU0NJDQo+IA0KPiAoMDItMDMpIG5vIGVxdWl2YWxl
bnQNCj4gDQo+ICgwNCkgSG9zdCBDUFU6IChPUykgZXhlY3V0ZSBHUEUgaGFuZGxlciBmcm9tIERT
RFQNCj4gDQo+ICgwNSkgSG9zdCBDUFU6IChPUykgUG9ydCAweEIyIHdyaXRlLCBhbGwgQ1BVcyBl
bnRlciBTTU0gKE5PVEU6IE5ldyBDUFUNCj4gICAgICB3aWxsIG5vdCBlbnRlciBDUFUgYmVjYXVz
ZSBTTUkgaXMgZGlzYWJsZWQpDQo+IA0KPiAoMDYpIEhvc3QgQ1BVOiAoU01NKSBTYXZlIDM4MDAw
LCBVcGRhdGUgMzgwMDAgLS0gZmlsbCBzaW1wbGUgU01NDQo+ICAgICAgcmViYXNlIGNvZGUuDQo+
IA0KPiAoMDdhKSBIb3N0IENQVTogKFNNTSkgV3JpdGUgdG8gQ1BVIGhvdHBsdWcgY29udHJvbGxl
ciB0byBlbmFibGUNCj4gICAgICBuZXcgQ1BVDQo+IA0KPiAoMDdiKSBIb3N0IENQVTogKFNNTSkg
U2VuZCBJTklUL1NJUEkvU0lQSSB0byBuZXcgQ1BVLg0KW0ppZXdlbl0gTk9URTogSU5JVC9TSVBJ
L1NJUEkgY2FuIGJlIHNlbnQgYnkgYSBtYWxpY2lvdXMgQ1BVLiBUaGVyZSBpcyBubw0KcmVzdHJp
Y3Rpb24gdGhhdCBJTklUL1NJUEkvU0lQSSBjYW4gb25seSBiZSBzZW50IGluIFNNTS4NCg0KDQoN
Cj4gKDA4YSkgTmV3IENQVTogKExvdyBSQU0pIEVudGVyIHByb3RlY3RlZCBtb2RlLg0KW0ppZXdl
bl0gTk9URTogVGhlIG5ldyBDUFUgc3RpbGwgY2Fubm90IHVzZSBhbnkgcGh5c2ljYWwgbWVtb3J5
LCBiZWNhdXNlDQp0aGUgSU5JVC9TSVBJL1NJUEkgbWF5IGJlIHNlbnQgYnkgbWFsaWNpb3VzIENQ
VSBpbiBub24tU01NIGVudmlyb25tZW50Lg0KDQoNCg0KPiAoMDhiKSBOZXcgQ1BVOiAoRmxhc2gp
IFNpZ25hbHMgaG9zdCBDUFUgdG8gcHJvY2VlZCBhbmQgZW50ZXIgY2xpO2hsdCBsb29wLg0KPiAN
Cj4gKDA5KSBIb3N0IENQVTogKFNNTSkgU2VuZCBTTUkgdG8gdGhlIG5ldyBDUFUgb25seS4NCj4g
DQo+ICgxMCkgTmV3IENQVTogKFNNTSkgUnVuIFNNTSBjb2RlIGF0IDM4MDAwLCBhbmQgcmViYXNl
IFNNQkFTRSB0bw0KPiAgICAgIFRTRUcuDQo+IA0KPiAoMTEpIEhvc3QgQ1BVOiAoU01NKSBSZXN0
b3JlIDM4MDAwLg0KPiANCj4gKDEyKSBIb3N0IENQVTogKFNNTSkgVXBkYXRlIGxvY2F0ZWQgZGF0
YSBzdHJ1Y3R1cmUgdG8gYWRkIHRoZSBuZXcgQ1BVDQo+ICAgICAgaW5mb3JtYXRpb24uIChUaGlz
IHN0ZXAgd2lsbCBpbnZvbHZlIENQVV9TRVJWSUNFIHByb3RvY29sKQ0KPiANCj4gKDEzKSBOZXcg
Q1BVOiAoRmxhc2gpIGRvIHdoYXRldmVyIG90aGVyIGluaXRpYWxpemF0aW9uIGlzIG5lZWRlZA0K
PiANCj4gKDE0KSBOZXcgQ1BVOiAoRmxhc2gpIERlYWRsb29wLCBhbmQgd2FpdCBmb3IgSU5JVC1T
SVBJLVNJUEkuDQo+IA0KPiAoMTUpIEhvc3QgQ1BVOiAoT1MpIFNlbmQgSU5JVC1TSVBJLVNJUEkg
dG8gcHVsbCBuZXcgQ1BVIGluLi4NCj4gDQo+IA0KPiBJbiBvdGhlciB3b3JkcywgdGhlIGNhY2hl
LWFzLVJBTSBwaGFzZSBvZiAwMi0wMyBpcyByZXBsYWNlZCBieSB0aGUNCj4gSU5JVC1TSVBJLVNJ
UEkgc2VxdWVuY2Ugb2YgMDdiLTA4YS0wOGIuDQpbSmlld2VuXSBJIGFtIE9LIHdpdGggdGhpcyBw
cm9wb3NhbC4NCkkgdGhpbmsgdGhlIHJ1bGUgaXMgc2FtZSAtIHRoZSBuZXcgQ1BVIENBTk5PVCB0
b3VjaCBhbnkgc3lzdGVtIG1lbW9yeSwNCm5vIG1hdHRlciBpdCBpcyBmcm9tIHJlc2V0LXZlY3Rv
ciBvciBmcm9tIElOSVQvU0lQSS9TSVBJLg0KT3IgSSB3b3VsZCBzYXk6IGlmIHRoZSBuZXcgQ1BV
IHdhbnQgdG8gdG91Y2ggc29tZSBtZW1vcnkgYmVmb3JlIGZpcnN0IFNNSSwgdGhlIG1lbW9yeSBz
aG91bGQgYmUNCkNQVSBzcGVjaWZpYyBvciBvbiB0aGUgZmxhc2guDQoNCg0KDQo+ID4+IFRoZSBR
RU1VIERTRFQgY291bGQgYmUgbW9kaWZpZWQgKHdoZW4gc2VjdXJlIGJvb3QgaXMgaW4gZWZmZWN0
KSB0byBPVVQNCj4gPj4gdG8gMHhCMiB3aGVuIGhvdHBsdWcgaGFwcGVucy4gIEl0IGNvdWxkIHdy
aXRlIGEgd2VsbC1rbm93biB2YWx1ZSB0bw0KPiA+PiAweEIyLCB0byBiZSByZWFkIGJ5IGFuIFNN
SSBoYW5kbGVyIGluIGVkazIuDQo+ID4NCj4gPiBJIGRpc2xpa2UgaW52b2x2aW5nIFFFTVUncyBn
ZW5lcmF0ZWQgRFNEVCBpbiBhbnl0aGluZyBTTU0gKGV2ZW4NCj4gPiBpbmplY3RpbmcgdGhlIFNN
SSksIGJlY2F1c2UgdGhlIEFNTCBpbnRlcnByZXRlciBydW5zIGluIHRoZSBPUy4NCj4gPg0KPiA+
IElmIGEgbWFsaWNpb3VzIE9TIGtlcm5lbCBpcyBhIGJpdCB0b28gZW5saWdodGVuZWQgYWJvdXQg
dGhlIERTRFQsIGl0DQo+ID4gY291bGQgd2lsbGZ1bGx5IGRpdmVyZ2UgZnJvbSB0aGUgcHJvY2Vz
cyB0aGF0IHdlIGRlc2lnbi4gSWYgUUVNVQ0KPiA+IGJyb2FkY2FzdCB0aGUgU01JIGludGVybmFs
bHksIHRoZSBndWVzdCBPUyBjb3VsZCBub3QgaW50ZXJmZXJlIHdpdGggdGhhdC4NCj4gPg0KPiA+
IElmIHRoZSBwdXJwb3NlIG9mIHRoZSBTTUkgaXMgc3BlY2lmaWNhbGx5IHRvIGZvcmNlIGFsbCBD
UFVzIGludG8gU01NDQo+ID4gKGFuZCB0aGVyZWJ5IGZvcmNlIHRoZW0gaW50byB0cnVzdGVkIHN0
YXRlKSwgdGhlbiB0aGUgT1Mgd291bGQgYmUNCj4gPiBleHBsaWNpdGx5IGNvdW50ZXItaW50ZXJl
c3RlZCBpbiBjYXJyeWluZyBvdXQgdGhlIEFNTCBvcGVyYXRpb25zIGZyb20NCj4gPiBRRU1VJ3Mg
RFNEVC4NCj4gDQo+IEJ1dCBzaW5jZSB0aGUgaG90cGx1ZyBjb250cm9sbGVyIHdvdWxkIG9ubHkg
YmUgYWNjZXNzaWJsZSBmcm9tIFNNTSwNCj4gdGhlcmUgd291bGQgYmUgbm8gb3RoZXIgd2F5IHRv
IGludm9rZSBpdCB0aGFuIHRvIGZvbGxvdyB0aGUgRFNEVCdzDQo+IGluc3RydWN0aW9uIGFuZCB3
cml0ZSB0byAweEIyLiAgRldJVywgcmVhbCBoYXJkd2FyZSBhbHNvIGhhcyBwbGVudHkgb2YNCj4g
MHhCMiB3cml0ZXMgaW4gdGhlIERTRFQgb3IgaW4gQVBFSSB0YWJsZXMgKGUuZy4gZm9yIHBlcnNp
c3RlbnQgc3RvcmUNCj4gYWNjZXNzKS4NCj4gDQo+IFBhb2xvDQo=

