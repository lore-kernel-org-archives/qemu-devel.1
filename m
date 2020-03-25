Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3D2C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03742206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03742206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3db-0008Ea-3u
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jH3UY-00042z-5a
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jH3UW-00039V-Rj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:18398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jH3UW-00039C-IM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:32 -0400
IronPort-SDR: fmd9wU24DozZAi4CFcSqBlnKJWXtRiy8Flkgzxy5G2IqqG/BH2N1jEGeNF85mfKj9Js/uAbVFW
 EFjJ4AYMNi/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 03:42:30 -0700
IronPort-SDR: LWkUJka4Ry8MhjSbLvQqnSfpT6IDusdEYVp9AteGJhlwD8R6Ldy/atzLpoeOAX6D+kfErperJO
 jtPHiK+HwFtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; d="scan'208";a="282102346"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2020 03:42:30 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 03:42:30 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Mar 2020 03:42:30 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 03:42:30 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.137]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 18:42:26 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 17/22] intel_iommu: do not pass down pasid bind for
 PASID #0
Thread-Topic: [PATCH v1 17/22] intel_iommu: do not pass down pasid bind for
 PASID #0
Thread-Index: AQHWAEW2o830y533sUCksKmHK8WrT6hXiSsAgAGL4GA=
Date: Wed, 25 Mar 2020 10:42:25 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A201FC7@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-18-git-send-email-yi.l.liu@intel.com>
 <20200324181326.GB127076@xz-x1>
In-Reply-To: <20200324181326.GB127076@xz-x1>
Accept-Language: en-US
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
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8IHBldGVyeEByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXks
IE1hcmNoIDI1LCAyMDIwIDI6MTMgQU0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDE3LzIyXSBpbnRlbF9pb21tdTogZG8gbm90
IHBhc3MgZG93biBwYXNpZCBiaW5kIGZvciBQQVNJRA0KPiAjMA0KPiANCj4gT24gU3VuLCBNYXIg
MjIsIDIwMjAgYXQgMDU6MzY6MTRBTSAtMDcwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gUklEX1BB
U0lEIGZpZWxkIHdhcyBpbnRyb2R1Y2VkIGluIFZULWQgMy4wIHNwZWMsIGl0IGlzIHVzZWQgZm9y
IERNQQ0KPiA+IHJlcXVlc3RzIHcvbyBQQVNJRCBpbiBzY2FsYWJsZSBtb2RlIFZULWQuIEl0IGlz
IGFsc28ga25vd24gYXMgSU9WQS4NCj4gPiBBbmQgaW4gVlQtZCAzLjEgc3BlYywgdGhlcmUgaXMg
ZGVmaW5pdGlvbiBvbiBpdDoNCj4gPg0KPiA+ICJJbXBsZW1lbnRhdGlvbnMgbm90IHN1cHBvcnRp
bmcgUklEX1BBU0lEIGNhcGFiaWxpdHkgKEVDQVBfUkVHLlJQUyBpcw0KPiA+IDBiKSwgdXNlIGEg
UEFTSUQgdmFsdWUgb2YgMCB0byBwZXJmb3JtIGFkZHJlc3MgdHJhbnNsYXRpb24gZm9yDQo+ID4g
cmVxdWVzdHMgd2l0aG91dCBQQVNJRC4iDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgYSBjaGVj
ayBhZ2FpbnN0IHRoZSBQQVNJRHMgd2hpY2ggYXJlIGdvaW5nIHRvIGJlIGJvdW5kDQo+ID4gdG8g
ZGV2aWNlLiBGb3IgUEFTSUQgIzAsIGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gcGFzcyBkb3duIHBh
c2lkIGJpbmQNCj4gPiByZXF1ZXN0IGZvciBpdCBzaW5jZSBQQVNJRCAjMCBpcyB1c2VkIGFzIFJJ
RF9QQVNJRCBmb3IgRE1BIHJlcXVlc3RzDQo+ID4gd2l0aG91dCBwYXNpZC4gRnVydGhlciByZWFz
b24gaXMgY3VycmVudCBJbnRlbCB2SU9NTVUgc3VwcG9ydHMgZ0lPVkENCj4gPiBieSBzaGFkb3dp
bmcgZ3Vlc3QgMm5kIGxldmVsIHBhZ2UgdGFibGUuIEhvd2V2ZXIsIGluIGZ1dHVyZSwgaWYgZ3Vl
c3QNCj4gPiBJT01NVSBkcml2ZXIgdXNlcyAxc3QgbGV2ZWwgcGFnZSB0YWJsZSB0byBzdG9yZSBJ
T1ZBIG1hcHBpbmdzLCB0aGVuDQo+ID4gZ3Vlc3QgSU9WQSBzdXBwb3J0IHdpbGwgYWxzbyBiZSBk
b25lIHZpYSBuZXN0ZWQgdHJhbnNsYXRpb24uIFdoZW4NCj4gPiBnSU9WQSBpcyBvdmVyIEZMUFQs
IHRoZW4gdklPTU1VIHNob3VsZCBwYXNzIGRvd24gdGhlIHBhc2lkIGJpbmQNCj4gPiByZXF1ZXN0
IGZvciBQQVNJRCAjMCB0byBob3N0LCBob3N0IG5lZWRzIHRvIGJpbmQgdGhlIGd1ZXN0IElPVkEg
cGFnZQ0KPiA+IHRhYmxlIHRvIGEgcHJvcGVyIFBBU0lELiBlLmcgUEFTSUQgdmFsdWUgaW4gUklE
X1BBU0lEIGZpZWxkIGZvciBQRi9WRg0KPiA+IGlmIEVDQVBfUkVHLlJQUyBpcyBjbGVhciBvciBk
ZWZhdWx0IFBBU0lEIGZvciBBREkgKEFzc2lnbmFibGUgRGV2aWNlDQo+ID4gSW50ZXJmYWNlIGlu
IFNjYWxhYmxlIElPViBzb2x1dGlvbikuDQo+ID4NCj4gPiBJT1ZBIG92ZXIgRkxQVCBzdXBwb3J0
IG9uIEludGVsIFZULWQ6DQo+ID4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvOS8yMy8yOTcN
Cj4gPg0KPiA+IENjOiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPiBDYzog
SmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogUGV0ZXIg
WHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiA+IENjOiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4g
PiBDYzogUmljaGFyZCBIZW5kZXJzb24gPHJ0aEB0d2lkZGxlLm5ldD4NCj4gPiBDYzogRWR1YXJk
byBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpdSBZ
aSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L2kzODYvaW50ZWxfaW9t
bXUuYyB8IDEwICsrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMgaW5kZXgNCj4gPiAxZTBjY2RlLi5iMDA3NzE1IDEwMDY0NA0KPiA+IC0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPiA+IEBAIC0xODg2LDYgKzE4ODYsMTYgQEAgc3RhdGljIGludCB2dGRfYmluZF9ndWVzdF9w
YXNpZChJbnRlbElPTU1VU3RhdGUgKnMsDQo+IFZUREJ1cyAqdnRkX2J1cywNCj4gPiAgICAgIHN0
cnVjdCBpb21tdV9ncGFzaWRfYmluZF9kYXRhICpnX2JpbmRfZGF0YTsNCj4gPiAgICAgIGludCBy
ZXQgPSAtMTsNCj4gPg0KPiA+ICsgICAgaWYgKHBhc2lkIDwgVlREX01JTl9IUEFTSUQpIHsNCj4g
PiArICAgICAgICAvKg0KPiA+ICsgICAgICAgICAqIElmIHBhc2lkIDwgVlREX0hQQVNJRF9NSU4s
IHRoaXMgcGFzaWQgaXMgbm90IGFsbG9jYXRlZA0KPiANCj4gcy9WVERfSFBBU0lEX01JTi9WVERf
TUlOX0hQQVNJRC8uDQoNCkdvdCBpdC4NCg0KPiANCj4gPiArICAgICAgICAgKiBmcm9tIGhvc3Qu
IE5vIG5lZWQgdG8gcGFzcyBkb3duIHRoZSBjaGFuZ2VzIG9uIGl0IHRvIGhvc3QuDQo+ID4gKyAg
ICAgICAgICogVE9ETzogd2hlbiBJT1ZBIG92ZXIgRkxQVCBpcyByZWFkeSwgdGhpcyBzd2l0Y2gg
c2hvdWxkIGJlDQo+ID4gKyAgICAgICAgICogcmVmaW5lZC4NCj4gDQo+IFdoYXQgd2lsbCBoYXBw
ZW4gaWYgd2l0aG91dCB0aGlzIHBhdGNoPyAgSXMgaXQgYSBtdXN0Pw0KDQpCZWZvcmUgZ0lPVkEg
aXMgc3VwcG9ydGVkIGJ5IG5lc3RlZCB0cmFuc2xhdGlvbiwgaXQgaXMgYSBtdXN0LiBUaGlzIHJl
cXVpcmVzDQpJT1ZBIG92ZXIgMXN0IGxldmVsIHBhZ2UgdGFibGUgaXMgcmVhZHkgaW4gZ3Vlc3Qg
a2VybmVsLCBhbHNvIHJlcXVpcmVzIHRoZQ0KUUVNVS9WRklPIHN1cHBvcnRzIHRvIGJpbmQgdGhl
IGd1ZXN0IElPVkEgcGFnZSB0YWJsZSB0byBob3N0Lg0KQ3VycmVudGx5LCBndWVzdCBrZXJuZWwg
c2lkZSBpcyByZWFkeS4gSG93ZXZlciwgUUVNVSBhbmQgVkZJTyBzaWRlIGlzDQpub3QuDQoNClJl
Z2FyZHMsDQpZaSBMaXUNCg0K

