Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9BBC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7B02077C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7B02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2c7-0002xr-Iw
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 05:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1is2b0-0001hr-5H
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1is2ay-0004Xv-N4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:41:50 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2062 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1is2ay-0004PF-EV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:41:48 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 87BC6DE79002A2BBBF46;
 Thu, 16 Jan 2020 10:41:43 +0000 (GMT)
Received: from lhreml706-chm.china.huawei.com (10.201.108.55) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 16 Jan 2020 10:41:43 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml706-chm.china.huawei.com (10.201.108.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 16 Jan 2020 10:41:42 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Thu, 16 Jan 2020 10:41:42 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH] tests: acpi: update path in rebuild-expected-aml
Thread-Topic: [PATCH] tests: acpi: update path in rebuild-expected-aml
Thread-Index: AQHVyvr8WPaZMGiHfUyYVzy+t9unyafqZGGAgAEmIFCAADOiAIABXlGQ
Date: Thu, 16 Jan 2020 10:41:42 +0000
Message-ID: <47aed3cfe4984e59942d053bd815362c@huawei.com>
References: <20200114165138.15716-1-shameerali.kolothum.thodi@huawei.com>
 <cc70ac3c-199a-5bb4-fe34-51c1f6a26461@redhat.com>
 <68b1e32176c145e293dfee93419072e6@huawei.com>
 <20200115064454-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200115064454-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.176.76.210
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xuwei
 \(O\)" <xuwei5@huawei.com>, Linuxarm <linuxarm@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIFttYWlsdG86bXN0QHJlZGhhdC5jb21dDQo+IFNlbnQ6IDE1IEphbnVhcnkgMjAyMCAxMzo0
Ng0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhhdC5jb20+OyBx
ZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGltYW1tZWRvQHJlZGhhdC5jb207IHh1d2VpIChPKSA8
eHV3ZWk1QGh1YXdlaS5jb20+OyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gdGVzdHM6IGFjcGk6IHVwZGF0ZSBwYXRoIGluIHJlYnVpbGQt
ZXhwZWN0ZWQtYW1sDQo+IA0KPiBPbiBXZWQsIEphbiAxNSwgMjAyMCBhdCAxMTowMTo0NEFNICsw
MDAwLCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBUaG9tYXMgSHV0aCBbbWFp
bHRvOnRodXRoQHJlZGhhdC5jb21dDQo+ID4gPiBTZW50OiAxNCBKYW51YXJ5IDIwMjAgMTc6MDgN
Cj4gPiA+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+ID4gPiA8c2hhbWVlcmFsaS5r
b2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsNCj4gPiA+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsg
aW1hbW1lZG9AcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb20NCj4gPiA+IENjOiB4dXdlaSAoTykg
PHh1d2VpNUBodWF3ZWkuY29tPjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIXSB0ZXN0czogYWNwaTogdXBkYXRlIHBhdGggaW4NCj4gPiA+
IHJlYnVpbGQtZXhwZWN0ZWQtYW1sDQo+ID4gPg0KPiA+ID4gT24gMTQvMDEvMjAyMCAxNy41MSwg
U2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiA+ID4gU2luY2UgY29tbWl0IDFlOGExZmFlNzQ2
NCgidGVzdDogTW92ZSBxdGVzdHMgdG8gYSBzZXBhcmF0ZQ0KPiA+ID4gPiBkaXJlY3RvcnkiKSBx
dGVzdHMgYXJlIG5vdyBwbGFjZWQgaW4gYSBzZXBhcmF0ZSBmb2xkZXIgYW5kIHRoaXMNCj4gPiA+
ID4gYnJlYWtzIHRoZSBzY3JpcHQgdXNlZCB0byByZWJ1aWxkIHRoZSBleHBlY3RlZCBBQ1BJIHRh
YmxlcyBmb3INCj4gPiA+ID4gYmlvcy10YWJsZXMtdGVzdC4gVXBkYXRlIHRoZSBzY3JpcHQgd2l0
aCBjb3JyZWN0IHBhdGguDQo+ID4gPiA+DQo+ID4gPiA+IEZpeGVzOiAxZThhMWZhZTc0NjQoInRl
c3Q6IE1vdmUgcXRlc3RzIHRvIGEgc2VwYXJhdGUgZGlyZWN0b3J5IikNCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0KPiA+ID4gPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIHRlc3RzL2RhdGEvYWNwaS9y
ZWJ1aWxkLWV4cGVjdGVkLWFtbC5zaCB8IDYgKysrLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvdGVzdHMvZGF0YS9hY3BpL3JlYnVpbGQtZXhwZWN0ZWQtYW1sLnNoDQo+ID4gPiBi
L3Rlc3RzL2RhdGEvYWNwaS9yZWJ1aWxkLWV4cGVjdGVkLWFtbC5zaA0KPiA+ID4gPiBpbmRleCBm
ODlkNDYyNGJjLi5kNDRlNTExNTMzIDEwMDc1NQ0KPiA+ID4gPiAtLS0gYS90ZXN0cy9kYXRhL2Fj
cGkvcmVidWlsZC1leHBlY3RlZC1hbWwuc2gNCj4gPiA+ID4gKysrIGIvdGVzdHMvZGF0YS9hY3Bp
L3JlYnVpbGQtZXhwZWN0ZWQtYW1sLnNoDQo+ID4gPiA+IEBAIC0xNCw3ICsxNCw3IEBADQo+ID4g
PiA+DQo+ID4gPiA+ICBxZW11X2JpbnM9Ing4Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82
NA0KPiA+ID4gYWFyY2g2NC1zb2Z0bW11L3FlbXUtc3lzdGVtLWFhcmNoNjQiDQo+ID4gPiA+DQo+
ID4gPiA+IC1pZiBbICEgLWUgInRlc3RzL2Jpb3MtdGFibGVzLXRlc3QiIF07IHRoZW4NCj4gPiA+
ID4gK2lmIFsgISAtZSAidGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdCIgXTsgdGhlbg0KPiA+
ID4gPiAgICAgIGVjaG8gIlRlc3Q6IGJpb3MtdGFibGVzLXRlc3QgaXMgcmVxdWlyZWQhIFJ1biBt
YWtlIGNoZWNrDQo+ID4gPiA+IGJlZm9yZSB0aGlzDQo+ID4gPiBzY3JpcHQuIg0KPiA+ID4gPiAg
ICAgIGVjaG8gIlJ1biB0aGlzIHNjcmlwdCBmcm9tIHRoZSBidWlsZCBkaXJlY3RvcnkuIg0KPiA+
ID4gPiAgICAgIGV4aXQgMTsNCj4gPiA+ID4gQEAgLTI2LDExICsyNiwxMSBAQCBmb3IgcWVtdSBp
biAkcWVtdV9iaW5zOyBkbw0KPiA+ID4gPiAgICAgICAgICBlY2hvICJBbHNvLCBydW4gdGhpcyBz
Y3JpcHQgZnJvbSB0aGUgYnVpbGQgZGlyZWN0b3J5LiINCj4gPiA+ID4gICAgICAgICAgZXhpdCAx
Ow0KPiA+ID4gPiAgICAgIGZpDQo+ID4gPiA+IC0gICAgVEVTVF9BQ1BJX1JFQlVJTERfQU1MPXkg
UVRFU1RfUUVNVV9CSU5BUlk9JHFlbXUNCj4gPiA+IHRlc3RzL2Jpb3MtdGFibGVzLXRlc3QNCj4g
PiA+ID4gKyAgICBURVNUX0FDUElfUkVCVUlMRF9BTUw9eSBRVEVTVF9RRU1VX0JJTkFSWT0kcWVt
dQ0KPiA+ID4gdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdA0KPiA+ID4gPiAgZG9uZQ0KPiA+
ID4gPg0KPiA+ID4gPiAgZXZhbCBgZ3JlcCBTUkNfUEFUSD0gY29uZmlnLWhvc3QubWFrYA0KPiA+
ID4gPg0KPiA+ID4gPiAtZWNobyAnLyogTGlzdCBvZiBjb21tYS1zZXBhcmF0ZWQgY2hhbmdlZCBB
TUwgZmlsZXMgdG8gaWdub3JlICovJw0KPiA+ID4gPiA+DQo+ID4gPiAke1NSQ19QQVRIfS90ZXN0
cy9iaW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQtZGlmZi5oDQo+ID4gPiA+ICtlY2hvICcvKiBMaXN0
IG9mIGNvbW1hLXNlcGFyYXRlZCBjaGFuZ2VkIEFNTCBmaWxlcyB0byBpZ25vcmUgKi8nDQo+ID4g
PiA+ICs+DQo+ID4gPiAke1NSQ19QQVRIfS90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFs
bG93ZWQtZGlmZi5oDQo+ID4gPiA+DQo+ID4gPiA+ICBlY2hvICJUaGUgZmlsZXMgd2VyZSByZWJ1
aWx0IGFuZCBjYW4gYmUgYWRkZWQgdG8gZ2l0LiINCj4gPiA+DQo+ID4gPiBPaCwgc29ycnkgZm9y
IG1pc3NpbmcgdGhhdCBpbiBteSBwYXRjaCBzZXJpZXMgLi4uIGlzIHRoZXJlIG1heWJlIGENCj4g
PiA+IHdheSB0aGF0IHdlIGNvdWxkIHRlc3QgdGhpcyBzY3JpcHQgaW4gb25lIG9mIG91ciBDSSBw
aXBlbGluZXMgc28NCj4gPiA+IHRoYXQgaXQgaXMgbm90IHNvIGVhc3kgdG8gbWlzcz8NCj4gPg0K
PiA+IFJpZ2h0LiBUaGF0IHdpbGwgYmUgYSB1c2VmdWwgb25lLg0KPiA+DQo+ID4gSSBhbSBhbHNv
IHNlZWluZyBhbm90aGVyIGVycm9yIHdoZW4gSSBydW4gIm1ha2UgY2hlY2stcXRlc3QiIG9uIHg4
Nl82NC4NCj4gPiBUaGlzIGRvZXNu4oCZdCBzZWVtcyB0byBiZSByZWxhdGVkIHRvIHRoZSByZWNl
bnQgY2hhbmdlcy4gSSBoYXZlIGdvbmUNCj4gPiBiYWNrIHRvIDQuMS4wIGFuZCBpdCBpcyBzdGls
bCB0aGVyZS4NCj4gPg0KPiA+ICAgVEVTVCAgICBjaGVjay1xdGVzdC14ODZfNjQ6IHRlc3RzL2Jv
b3Qtb3JkZXItdGVzdA0KPiA+ICAgVEVTVCAgICBjaGVjay1xdGVzdC14ODZfNjQ6IHRlc3RzL2Jp
b3MtdGFibGVzLXRlc3QNCj4gPiBDb3VsZCBub3QgYWNjZXNzIEtWTSBrZXJuZWwgbW9kdWxlOiBO
byBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ID4gcWVtdS1zeXN0ZW0teDg2XzY0OiBmYWlsZWQg
dG8gaW5pdGlhbGl6ZSBLVk06IE5vIHN1Y2ggZmlsZSBvcg0KPiA+IGRpcmVjdG9yeQ0KPiA+IHFl
bXUtc3lzdGVtLXg4Nl82NDogQmFjayB0byB0Y2cgYWNjZWxlcmF0b3IgQ291bGQgbm90IGFjY2Vz
cyBLVk0NCj4gPiBrZXJuZWwgbW9kdWxlOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ID4g
cWVtdS1zeXN0ZW0teDg2XzY0OiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSBLVk06IE5vIHN1Y2ggZmls
ZSBvcg0KPiA+IGRpcmVjdG9yeQ0KPiA+IHFlbXUtc3lzdGVtLXg4Nl82NDogQmFjayB0byB0Y2cg
YWNjZWxlcmF0b3IgQ291bGQgbm90IGFjY2VzcyBLVk0NCj4gPiBrZXJuZWwgbW9kdWxlOiBObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ID4gcWVtdS1zeXN0ZW0teDg2XzY0OiBmYWlsZWQgdG8g
aW5pdGlhbGl6ZSBLVk06IE5vIHN1Y2ggZmlsZSBvcg0KPiA+IGRpcmVjdG9yeQ0KPiA+IHFlbXUt
c3lzdGVtLXg4Nl82NDogQmFjayB0byB0Y2cgYWNjZWxlcmF0b3INCj4gPiBhY3BpLXRlc3Q6IFdh
cm5pbmchIEZBQ1AgYmluYXJ5IGZpbGUgbWlzbWF0Y2guIEFjdHVhbCBbYW1sOi90bXAvYW1sLTJR
OUVFMF0sDQo+IEV4cGVjdGVkIFthbWw6dGVzdHMvZGF0YS9hY3BpL3BjL0ZBQ1AuYnJpZGdlXS4N
Cj4gPiBhY3BpLXRlc3Q6IFdhcm5pbmchIEZBQ1AgbWlzbWF0Y2guIEFjdHVhbCBbYXNsOi90bXAv
YXNsLUNROUVFMC5kc2wsDQo+IGFtbDovdG1wL2FtbC0yUTlFRTBdLCBFeHBlY3RlZCBbYXNsOi90
bXAvYXNsLU4xOEVFMC5kc2wsDQo+IGFtbDp0ZXN0cy9kYXRhL2FjcGkvcGMvRkFDUC5icmlkZ2Vd
Lg0KPiA+ICoqDQo+ID4gRVJST1I6dGVzdHMvYmlvcy10YWJsZXMtdGVzdC5jOjQ0Nzp0ZXN0X2Fj
cGlfYXNsOiBhc3NlcnRpb24gZmFpbGVkOg0KPiA+IChhbGxfdGFibGVzX21hdGNoKSBFUlJPUiAt
IEJhaWwgb3V0IQ0KPiA+IEVSUk9SOnRlc3RzL2Jpb3MtdGFibGVzLXRlc3QuYzo0NDc6dGVzdF9h
Y3BpX2FzbDogYXNzZXJ0aW9uIGZhaWxlZDoNCj4gPiAoYWxsX3RhYmxlc19tYXRjaCkgQWJvcnRl
ZCAoY29yZSBkdW1wZWQpDQo+ID4gL2hvbWUvc2hhbWVlci9xZW11L3Rlc3RzL01ha2VmaWxlLmlu
Y2x1ZGU6ODk5OiByZWNpcGUgZm9yIHRhcmdldA0KPiA+ICdjaGVjay1xdGVzdC14ODZfNjQnIGZh
aWxlZA0KPiA+IG1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxDQo+IA0KPiBX
ZWxsIG1ha2UgY2hlY2sgc2VlbXMgdG8gcGFzcyBmb3IgbWUgLi4uIFdoYXQncyBkaWZmZXJlbnQg
Zm9yIHlvdT8NCg0KSSB0cmllZCBhIGZyZXNoIGdpdCBjbG9uZSBvZiBxZW11IGFuZCB0aGF0IHNl
ZW1zIHRvIHdvcmsgZmluZS4gU28gSSBndWVzcw0KaXQgbWlnaHQgYmUgc29tZXRoaW5nIHRvIGRv
IHdpdGggbXkgZWFybGllciBzZXR1cC4gSWdub3JlIGFuZCBzb3JyeQ0KZm9yIHRoZSBub2lzZS4N
Cg0KVGhhbmtzLA0KU2hhbWVlcg0K

