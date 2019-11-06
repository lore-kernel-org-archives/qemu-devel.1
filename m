Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2690EC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6601217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6601217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJAt-0005YL-WF
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSJ9n-0004gq-VK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSJ9l-000150-Qf
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:07:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:56249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSJ9l-0000wR-JB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:07:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 03:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="353447111"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga004.jf.intel.com with ESMTP; 06 Nov 2019 03:07:16 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 03:07:16 -0800
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 03:07:14 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.41]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 19:07:12 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v2 08/22] intel_iommu: provide get_iommu_context() callback
Thread-Topic: [RFC v2 08/22] intel_iommu: provide get_iommu_context() callback
Thread-Index: AQHVimstnV/JKooOkkKRXFjjp88wQKd17buAgAggrFA=
Date: Wed, 6 Nov 2019 11:07:11 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EF168@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-9-git-send-email-yi.l.liu@intel.com>
 <20191101145503.GB8888@xz-x1.metropole.lan>
In-Reply-To: <20191101145503.GB8888@xz-x1.metropole.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDY0MGVlZDktOWQ1Ni00ZWJiLWIyZDgtMGZmZjU0ZDBhZDA3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaVdVT0xHQXZ3ZXZRak9oZUdOTE44d3ljS0ptVzBNUVJEb2crbHpaakRnV21ON1NUOUhlUm5jNjhqUjlITFRpcSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: "tianyu.lan@intel.com" <tianyu.lan@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBGcmlk
YXksIE5vdmVtYmVyIDEsIDIwMTkgMTA6NTUgUE0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyB2MiAwOC8yMl0gaW50ZWxfaW9tbXU6IHBy
b3ZpZGUgZ2V0X2lvbW11X2NvbnRleHQoKSBjYWxsYmFjaw0KPiANCj4gT24gVGh1LCBPY3QgMjQs
IDIwMTkgYXQgMDg6MzQ6MjlBTSAtMDQwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gVGhpcyBwYXRj
aCBhZGRzIGdldF9pb21tdV9jb250ZXh0KCkgY2FsbGJhY2sgdG8gcmV0dXJuIGFuIGlvbW11X2Nv
bnRleHQNCj4gPiBJbnRlbCBWVC1kIHBsYXRmb3JtLg0KPiA+DQo+ID4gQ2M6IEtldmluIFRpYW4g
PGtldmluLnRpYW5AaW50ZWwuY29tPg0KPiA+IENjOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5A
bGludXguaW50ZWwuY29tPg0KPiA+IENjOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+
ID4gQ2M6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IExpdSBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L2kzODYv
aW50ZWxfaW9tbXUuYyAgICAgICAgIHwgNTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0NCj4gLS0NCj4gPiAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggfCAx
NCArKysrKysrKysrLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKyksIDcg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gaW5kZXggNjdhNzgzNi4uZTlmODY5MiAxMDA2
NDQNCj4gPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gPiArKysgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4gPiBAQCAtMzI4OCwyMiArMzI4OCwzMyBAQCBzdGF0aWMgY29uc3QgTWVt
b3J5UmVnaW9uT3BzIHZ0ZF9tZW1faXJfb3BzID0gew0KPiA+ICAgICAgfSwNCj4gPiAgfTsNCj4g
Pg0KPiA+IC1WVERBZGRyZXNzU3BhY2UgKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUg
KnMsIFBDSUJ1cyAqYnVzLCBpbnQgZGV2Zm4pDQo+ID4gK3N0YXRpYyBWVERCdXMgKnZ0ZF9maW5k
X2FkZF9idXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMgKmJ1cykNCj4gPiAgew0KPiA+ICAg
ICAgdWludHB0cl90IGtleSA9ICh1aW50cHRyX3QpYnVzOw0KPiA+IC0gICAgVlREQnVzICp2dGRf
YnVzID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT52dGRfYXNfYnlfYnVzcHRyLCAma2V5KTsNCj4g
PiAtICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9hczsNCj4gPiAtICAgIGNoYXIgbmFtZVsx
MjhdOw0KPiA+ICsgICAgVlREQnVzICp2dGRfYnVzOw0KPiA+DQo+ID4gKyAgICB2dGRfaW9tbXVf
bG9jayhzKTsNCj4gDQo+IFdoeSBleHBsaWNpdGx5IHRha2UgdGhlIElPTU1VIGxvY2sgaGVyZT8g
IEkgbWVhbiwgaXQncyBmaW5lIHRvIHRha2UNCj4gaXQsIGJ1dCBpZiBzbyB3aHkgbm90IHRha2Ug
aXQgdG8gY292ZXIgdGhlIHdob2xlIHZ0ZF9maW5kX2FkZF9hcygpPw0KDQpKdXN0IHdhbnRlZCB0
byBtYWtlIHRoZSBwcm90ZWN0ZWQgc25pcHBldCBzbWFsbGVyLiBCdXQgSSdtIGZpbmUgdG8gbW92
ZSBpdA0KdG8gdnRkX2ZpbmRfYWRkX2FzKCkgaWYgdGhlcmUgaXMgbm8gbXVjaCB2YWx1ZSBmb3Ig
cHV0dGluZyBpdCBoZXJlLg0KDQo+IEZvciBub3cgaXQnbGwgYmUgZmluZSBpbiBlaXRoZXIgd2F5
IGJlY2F1c2UgSSBiZWxpZXZlIGlvbW11X2xvY2sgaXMNCj4gbm90IHJlYWxseSBmdW5jdGlvbmlu
ZyB3aGVuIHdlJ3JlIHN0aWxsIHdpdGggQlFMIGhlcmUsIGhvd2V2ZXIgaWYgeW91DQo+IGFkZCB0
aGF0IGV4cGxpY2l0bHkgdGhlbiBJIGRvbid0IHNlZSB3aHkgaXQncyBub3QgY292ZXJpbmcgdGhh
dC4NCg0KR290IGl0LiBJdCBmdW5jdGlvbnMgaWYgeW91IG1pc3NlZCB0byBwdXQgYSBtaXJyb3Jl
ZCB1bmxvY2sgYWZ0ZXIgYSBsb2NrLiAoam9rZSkNCg0KPiANCj4gPiArICAgIHZ0ZF9idXMgPSBn
X2hhc2hfdGFibGVfbG9va3VwKHMtPnZ0ZF9hc19ieV9idXNwdHIsICZrZXkpOw0KPiA+ICAgICAg
aWYgKCF2dGRfYnVzKSB7DQo+ID4gICAgICAgICAgdWludHB0cl90ICpuZXdfa2V5ID0gZ19tYWxs
b2Moc2l6ZW9mKCpuZXdfa2V5KSk7DQo+ID4gICAgICAgICAgKm5ld19rZXkgPSAodWludHB0cl90
KWJ1czsNCj4gPiAgICAgICAgICAvKiBObyBjb3JyZXNwb25kaW5nIGZyZWUoKSAqLw0KPiA+IC0g
ICAgICAgIHZ0ZF9idXMgPSBnX21hbGxvYzAoc2l6ZW9mKFZUREJ1cykgKyBzaXplb2YoVlREQWRk
cmVzc1NwYWNlICopICogXA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJX0RF
VkZOX01BWCk7DQo+ID4gKyAgICAgICAgdnRkX2J1cyA9IGdfbWFsbG9jMChzaXplb2YoVlREQnVz
KSArIFBDSV9ERVZGTl9NQVggKiBcDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgKHNpemVvZihW
VERBZGRyZXNzU3BhY2UgKikgKyBzaXplb2YoVlRESU9NTVVDb250ZXh0ICopKSk7DQo+IA0KPiBT
aG91bGQgdGhpcyBiZSBhcyBzaW1wbGUgYXMgZ19tYWxsb2MwKHNpemVvZihWVERCdXMpIHNpbmNl
IFsxXT8NCg0KeWVzLCBpdCdzIG9sZCB3cml0aW5nLiBXaWxsIG1vZGlmeSBpdC4NCg0KPiBPdGhl
cndpc2UgdGhlIHBhdGNoIGxvb2tzIHNhbmUgdG8gbWUuDQo+IA0KPiA+ICAgICAgICAgIHZ0ZF9i
dXMtPmJ1cyA9IGJ1czsNCj4gPiAgICAgICAgICBnX2hhc2hfdGFibGVfaW5zZXJ0KHMtPnZ0ZF9h
c19ieV9idXNwdHIsIG5ld19rZXksIHZ0ZF9idXMpOw0KPiA+ICAgICAgfQ0KPiA+ICsgICAgdnRk
X2lvbW11X3VubG9jayhzKTsNCj4gPiArICAgIHJldHVybiB2dGRfYnVzOw0KPiA+ICt9DQo+IA0K
PiBbLi4uXQ0KPiANCj4gPiAgc3RydWN0IFZUREJ1cyB7DQo+ID4gICAgICBQQ0lCdXMqIGJ1czsJ
CS8qIEEgcmVmZXJlbmNlIHRvIHRoZSBidXMgdG8gcHJvdmlkZSB0cmFuc2xhdGlvbiBmb3INCj4g
Ki8NCj4gPiAtICAgIFZUREFkZHJlc3NTcGFjZSAqZGV2X2FzWzBdOwkvKiBBIHRhYmxlIG9mIFZU
REFkZHJlc3NTcGFjZSBvYmplY3RzDQo+IGluZGV4ZWQgYnkgZGV2Zm4gKi8NCj4gPiArICAgIC8q
IEEgdGFibGUgb2YgVlREQWRkcmVzc1NwYWNlIG9iamVjdHMgaW5kZXhlZCBieSBkZXZmbiAqLw0K
PiA+ICsgICAgVlREQWRkcmVzc1NwYWNlICpkZXZfYXNbUENJX0RFVkZOX01BWF07DQo+ID4gKyAg
ICAvKiBBIHRhYmxlIG9mIFZURElPTU1VQ29udGV4dCBvYmplY3RzIGluZGV4ZWQgYnkgZGV2Zm4g
Ki8NCj4gPiArICAgIFZURElPTU1VQ29udGV4dCAqZGV2X2ljW1BDSV9ERVZGTl9NQVhdOw0KPiAN
Cj4gWzFdDQoNCmV4YWN0bHkuDQoNCj4gDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RydWN0IFZURElP
VExCRW50cnkgew0KPiA+IEBAIC0yODIsNSArMjkzLDYgQEAgc3RydWN0IEludGVsSU9NTVVTdGF0
ZSB7DQo+ID4gICAqIGNyZWF0ZSBhIG5ldyBvbmUgaWYgbm9uZSBleGlzdHMNCj4gPiAgICovDQo+
ID4gIFZUREFkZHJlc3NTcGFjZSAqdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9NTVVTdGF0ZSAqcywg
UENJQnVzICpidXMsIGludCBkZXZmbik7DQo+ID4gK1ZURElPTU1VQ29udGV4dCAqdnRkX2ZpbmRf
YWRkX2ljKEludGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsIGludA0KPiBkZXZmbik7DQo+
ID4NCj4gPiAgI2VuZGlmDQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQoNClRoYW5rcywNCllpIExp
dQ0K

