Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A00C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A12C24686
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A12C24686
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irgSA-0001ii-7c
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 06:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1irgQq-0000UJ-KZ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1irgQm-0003vL-Si
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:01:52 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2060 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1irgQm-0003td-KD
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:01:48 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 4067C413C40147BF37C9;
 Wed, 15 Jan 2020 11:01:45 +0000 (GMT)
Received: from lhreml704-chm.china.huawei.com (10.201.108.53) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 Jan 2020 11:01:44 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml704-chm.china.huawei.com (10.201.108.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 15 Jan 2020 11:01:44 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Wed, 15 Jan 2020 11:01:44 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH] tests: acpi: update path in rebuild-expected-aml
Thread-Topic: [PATCH] tests: acpi: update path in rebuild-expected-aml
Thread-Index: AQHVyvr8WPaZMGiHfUyYVzy+t9unyafqZGGAgAEmIFA=
Date: Wed, 15 Jan 2020 11:01:44 +0000
Message-ID: <68b1e32176c145e293dfee93419072e6@huawei.com>
References: <20200114165138.15716-1-shameerali.kolothum.thodi@huawei.com>
 <cc70ac3c-199a-5bb4-fe34-51c1f6a26461@redhat.com>
In-Reply-To: <cc70ac3c-199a-5bb4-fe34-51c1f6a26461@redhat.com>
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
Cc: Linuxarm <linuxarm@huawei.com>, "xuwei \(O\)" <xuwei5@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIEh1dGggW21h
aWx0bzp0aHV0aEByZWRoYXQuY29tXQ0KPiBTZW50OiAxNCBKYW51YXJ5IDIwMjAgMTc6MDgNCj4g
VG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlA
aHVhd2VpLmNvbT47DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgaW1hbW1lZG9AcmVkaGF0LmNv
bTsgbXN0QHJlZGhhdC5jb20NCj4gQ2M6IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBM
aW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdGVz
dHM6IGFjcGk6IHVwZGF0ZSBwYXRoIGluIHJlYnVpbGQtZXhwZWN0ZWQtYW1sDQo+IA0KPiBPbiAx
NC8wMS8yMDIwIDE3LjUxLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IFNpbmNlIGNvbW1p
dCAxZThhMWZhZTc0NjQoInRlc3Q6IE1vdmUgcXRlc3RzIHRvIGEgc2VwYXJhdGUNCj4gPiBkaXJl
Y3RvcnkiKSBxdGVzdHMgYXJlIG5vdyBwbGFjZWQgaW4gYSBzZXBhcmF0ZSBmb2xkZXIgYW5kDQo+
ID4gdGhpcyBicmVha3MgdGhlIHNjcmlwdCB1c2VkIHRvIHJlYnVpbGQgdGhlIGV4cGVjdGVkIEFD
UEkNCj4gPiB0YWJsZXMgZm9yIGJpb3MtdGFibGVzLXRlc3QuIFVwZGF0ZSB0aGUgc2NyaXB0IHdp
dGggY29ycmVjdA0KPiA+IHBhdGguDQo+ID4NCj4gPiBGaXhlczogMWU4YTFmYWU3NDY0KCJ0ZXN0
OiBNb3ZlIHF0ZXN0cyB0byBhIHNlcGFyYXRlIGRpcmVjdG9yeSIpDQo+ID4gU2lnbmVkLW9mZi1i
eTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29t
Pg0KPiA+IC0tLQ0KPiA+ICB0ZXN0cy9kYXRhL2FjcGkvcmVidWlsZC1leHBlY3RlZC1hbWwuc2gg
fCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL2RhdGEvYWNwaS9yZWJ1aWxkLWV4
cGVjdGVkLWFtbC5zaA0KPiBiL3Rlc3RzL2RhdGEvYWNwaS9yZWJ1aWxkLWV4cGVjdGVkLWFtbC5z
aA0KPiA+IGluZGV4IGY4OWQ0NjI0YmMuLmQ0NGU1MTE1MzMgMTAwNzU1DQo+ID4gLS0tIGEvdGVz
dHMvZGF0YS9hY3BpL3JlYnVpbGQtZXhwZWN0ZWQtYW1sLnNoDQo+ID4gKysrIGIvdGVzdHMvZGF0
YS9hY3BpL3JlYnVpbGQtZXhwZWN0ZWQtYW1sLnNoDQo+ID4gQEAgLTE0LDcgKzE0LDcgQEANCj4g
Pg0KPiA+ICBxZW11X2JpbnM9Ing4Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82NA0KPiBh
YXJjaDY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0tYWFyY2g2NCINCj4gPg0KPiA+IC1pZiBbICEgLWUg
InRlc3RzL2Jpb3MtdGFibGVzLXRlc3QiIF07IHRoZW4NCj4gPiAraWYgWyAhIC1lICJ0ZXN0cy9x
dGVzdC9iaW9zLXRhYmxlcy10ZXN0IiBdOyB0aGVuDQo+ID4gICAgICBlY2hvICJUZXN0OiBiaW9z
LXRhYmxlcy10ZXN0IGlzIHJlcXVpcmVkISBSdW4gbWFrZSBjaGVjayBiZWZvcmUgdGhpcw0KPiBz
Y3JpcHQuIg0KPiA+ICAgICAgZWNobyAiUnVuIHRoaXMgc2NyaXB0IGZyb20gdGhlIGJ1aWxkIGRp
cmVjdG9yeS4iDQo+ID4gICAgICBleGl0IDE7DQo+ID4gQEAgLTI2LDExICsyNiwxMSBAQCBmb3Ig
cWVtdSBpbiAkcWVtdV9iaW5zOyBkbw0KPiA+ICAgICAgICAgIGVjaG8gIkFsc28sIHJ1biB0aGlz
IHNjcmlwdCBmcm9tIHRoZSBidWlsZCBkaXJlY3RvcnkuIg0KPiA+ICAgICAgICAgIGV4aXQgMTsN
Cj4gPiAgICAgIGZpDQo+ID4gLSAgICBURVNUX0FDUElfUkVCVUlMRF9BTUw9eSBRVEVTVF9RRU1V
X0JJTkFSWT0kcWVtdQ0KPiB0ZXN0cy9iaW9zLXRhYmxlcy10ZXN0DQo+ID4gKyAgICBURVNUX0FD
UElfUkVCVUlMRF9BTUw9eSBRVEVTVF9RRU1VX0JJTkFSWT0kcWVtdQ0KPiB0ZXN0cy9xdGVzdC9i
aW9zLXRhYmxlcy10ZXN0DQo+ID4gIGRvbmUNCj4gPg0KPiA+ICBldmFsIGBncmVwIFNSQ19QQVRI
PSBjb25maWctaG9zdC5tYWtgDQo+ID4NCj4gPiAtZWNobyAnLyogTGlzdCBvZiBjb21tYS1zZXBh
cmF0ZWQgY2hhbmdlZCBBTUwgZmlsZXMgdG8gaWdub3JlICovJyA+DQo+ICR7U1JDX1BBVEh9L3Rl
c3RzL2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmgNCj4gPiArZWNobyAnLyogTGlzdCBv
ZiBjb21tYS1zZXBhcmF0ZWQgY2hhbmdlZCBBTUwgZmlsZXMgdG8gaWdub3JlICovJyA+DQo+ICR7
U1JDX1BBVEh9L3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmgNCj4g
Pg0KPiA+ICBlY2hvICJUaGUgZmlsZXMgd2VyZSByZWJ1aWx0IGFuZCBjYW4gYmUgYWRkZWQgdG8g
Z2l0LiINCj4gDQo+IE9oLCBzb3JyeSBmb3IgbWlzc2luZyB0aGF0IGluIG15IHBhdGNoIHNlcmll
cyAuLi4gaXMgdGhlcmUgbWF5YmUgYSB3YXkNCj4gdGhhdCB3ZSBjb3VsZCB0ZXN0IHRoaXMgc2Ny
aXB0IGluIG9uZSBvZiBvdXIgQ0kgcGlwZWxpbmVzIHNvIHRoYXQgaXQgaXMNCj4gbm90IHNvIGVh
c3kgdG8gbWlzcz8NCg0KUmlnaHQuIFRoYXQgd2lsbCBiZSBhIHVzZWZ1bCBvbmUuDQoNCkkgYW0g
YWxzbyBzZWVpbmcgYW5vdGhlciBlcnJvciB3aGVuIEkgcnVuICJtYWtlIGNoZWNrLXF0ZXN0IiBv
biB4ODZfNjQuDQpUaGlzIGRvZXNu4oCZdCBzZWVtcyB0byBiZSByZWxhdGVkIHRvIHRoZSByZWNl
bnQgY2hhbmdlcy4gSSBoYXZlIGdvbmUgYmFjaw0KdG8gNC4xLjAgYW5kIGl0IGlzIHN0aWxsIHRo
ZXJlLg0KDQogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0ZXN0cy9ib290LW9yZGVyLXRl
c3QNCiAgVEVTVCAgICBjaGVjay1xdGVzdC14ODZfNjQ6IHRlc3RzL2Jpb3MtdGFibGVzLXRlc3QN
CkNvdWxkIG5vdCBhY2Nlc3MgS1ZNIGtlcm5lbCBtb2R1bGU6IE5vIHN1Y2ggZmlsZSBvciBkaXJl
Y3RvcnkNCnFlbXUtc3lzdGVtLXg4Nl82NDogZmFpbGVkIHRvIGluaXRpYWxpemUgS1ZNOiBObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5DQpxZW11LXN5c3RlbS14ODZfNjQ6IEJhY2sgdG8gdGNnIGFj
Y2VsZXJhdG9yDQpDb3VsZCBub3QgYWNjZXNzIEtWTSBrZXJuZWwgbW9kdWxlOiBObyBzdWNoIGZp
bGUgb3IgZGlyZWN0b3J5DQpxZW11LXN5c3RlbS14ODZfNjQ6IGZhaWxlZCB0byBpbml0aWFsaXpl
IEtWTTogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KcWVtdS1zeXN0ZW0teDg2XzY0OiBCYWNr
IHRvIHRjZyBhY2NlbGVyYXRvcg0KQ291bGQgbm90IGFjY2VzcyBLVk0ga2VybmVsIG1vZHVsZTog
Tm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KcWVtdS1zeXN0ZW0teDg2XzY0OiBmYWlsZWQgdG8g
aW5pdGlhbGl6ZSBLVk06IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCnFlbXUtc3lzdGVtLXg4
Nl82NDogQmFjayB0byB0Y2cgYWNjZWxlcmF0b3INCmFjcGktdGVzdDogV2FybmluZyEgRkFDUCBi
aW5hcnkgZmlsZSBtaXNtYXRjaC4gQWN0dWFsIFthbWw6L3RtcC9hbWwtMlE5RUUwXSwgRXhwZWN0
ZWQgW2FtbDp0ZXN0cy9kYXRhL2FjcGkvcGMvRkFDUC5icmlkZ2VdLg0KYWNwaS10ZXN0OiBXYXJu
aW5nISBGQUNQIG1pc21hdGNoLiBBY3R1YWwgW2FzbDovdG1wL2FzbC1DUTlFRTAuZHNsLCBhbWw6
L3RtcC9hbWwtMlE5RUUwXSwgRXhwZWN0ZWQgW2FzbDovdG1wL2FzbC1OMThFRTAuZHNsLCBhbWw6
dGVzdHMvZGF0YS9hY3BpL3BjL0ZBQ1AuYnJpZGdlXS4NCioqDQpFUlJPUjp0ZXN0cy9iaW9zLXRh
Ymxlcy10ZXN0LmM6NDQ3OnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbiBmYWlsZWQ6IChhbGxfdGFi
bGVzX21hdGNoKQ0KRVJST1IgLSBCYWlsIG91dCEgRVJST1I6dGVzdHMvYmlvcy10YWJsZXMtdGVz
dC5jOjQ0Nzp0ZXN0X2FjcGlfYXNsOiBhc3NlcnRpb24gZmFpbGVkOiAoYWxsX3RhYmxlc19tYXRj
aCkNCkFib3J0ZWQgKGNvcmUgZHVtcGVkKQ0KL2hvbWUvc2hhbWVlci9xZW11L3Rlc3RzL01ha2Vm
aWxlLmluY2x1ZGU6ODk5OiByZWNpcGUgZm9yIHRhcmdldCAnY2hlY2stcXRlc3QteDg2XzY0JyBm
YWlsZWQNCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxDQoNCkZBQ1Agc2Vl
bXMgdG8gaGF2ZSBjaGFuZ2VkIGFuZCBpdCBsb29rcyBsaWtlIG5lZWQgdG8gcnVuIHRoZSBzY3Jp
cHQgdG8gZ2VuZXJhdGUNCmEgbmV3IG9uZS4NCg0Kfi9xZW11JCBkaWZmIC11IC90bXAvYXNsLUNR
OUVFMC5kc2wgL3RtcC9hc2wtTjE4RUUwLmRzbA0KLS0tIC90bXAvYXNsLUNROUVFMC5kc2wgMjAy
MC0wMS0xNSAxMDo1MjowMy4wMTg0NDg2MjcgKzAwMDANCisrKyAvdG1wL2FzbC1OMThFRTAuZHNs
IDIwMjAtMDEtMTUgMTA6NTI6MDMuMDIyNDQ4NjI3ICswMDAwDQpAQCAtMyw3ICszLDcgQEANCiAg
KiBBTUwvQVNMKyBEaXNhc3NlbWJsZXIgdmVyc2lvbiAyMDE4MDEwNSAoNjQtYml0IHZlcnNpb24p
DQogICogQ29weXJpZ2h0IChjKSAyMDAwIC0gMjAxOCBJbnRlbCBDb3Jwb3JhdGlvbg0KICAqDQot
ICogRGlzYXNzZW1ibHkgb2YgL3RtcC9hbWwtMlE5RUUwLCBXZWQgSmFuIDE1IDEwOjUyOjAzIDIw
MjANCisgKiBEaXNhc3NlbWJseSBvZiB0ZXN0cy9kYXRhL2FjcGkvcGMvRkFDUC5icmlkZ2UsIFdl
ZCBKYW4gMTUgMTA6NTI6MDMgDQorIDIwMjANCiAgKg0KICAqIEFDUEkgRGF0YSBUYWJsZSBbRkFD
UF0NCiAgKg0KQEAgLTEzLDcgKzEzLDcgQEANCiBbMDAwaCAwMDAwICAgNF0gICAgICAgICAgICAg
ICAgICAgIFNpZ25hdHVyZSA6ICJGQUNQIiAgICBbRml4ZWQgQUNQSQ0KRGVzY3JpcHRpb24gVGFi
bGUgKEZBRFQpXQ0KIFswMDRoIDAwMDQgICA0XSAgICAgICAgICAgICAgICAgVGFibGUgTGVuZ3Ro
IDogMDAwMDAwNzQNCiBbMDA4aCAwMDA4ICAgMV0gICAgICAgICAgICAgICAgICAgICBSZXZpc2lv
biA6IDAxDQotWzAwOWggMDAwOSAgIDFdICAgICAgICAgICAgICAgICAgICAgQ2hlY2tzdW0gOiBB
MQ0KK1swMDloIDAwMDkgICAxXSAgICAgICAgICAgICAgICAgICAgIENoZWNrc3VtIDogRDMNCiBb
MDBBaCAwMDEwICAgNl0gICAgICAgICAgICAgICAgICAgICAgIE9lbSBJRCA6ICJCT0NIUyAiDQog
WzAxMGggMDAxNiAgIDhdICAgICAgICAgICAgICAgICBPZW0gVGFibGUgSUQgOiAiQlhQQ0ZBQ1Ai
DQogWzAxOGggMDAyNCAgIDRdICAgICAgICAgICAgICAgICBPZW0gUmV2aXNpb24gOiAwMDAwMDAw
MQ0KQEAgLTU0LDcgKzU0LDcgQEANCiBbMDY5aCAwMTA1ICAgMV0gICAgICAgICAgICAgRHV0eSBD
eWNsZSBXaWR0aCA6IDAwDQogWzA2QWggMDEwNiAgIDFdICAgICAgICAgIFJUQyBEYXkgQWxhcm0g
SW5kZXggOiAwMA0KIFswNkJoIDAxMDcgICAxXSAgICAgICAgUlRDIE1vbnRoIEFsYXJtIEluZGV4
IDogMDANCi1bMDZDaCAwMTA4ICAgMV0gICAgICAgICAgICBSVEMgQ2VudHVyeSBJbmRleCA6IDMy
DQorWzA2Q2ggMDEwOCAgIDFdICAgICAgICAgICAgUlRDIENlbnR1cnkgSW5kZXggOiAwMA0KIFsw
NkRoIDAxMDkgICAyXSAgIEJvb3QgRmxhZ3MgKGRlY29kZWQgYmVsb3cpIDogMDAwMA0KICAgICAg
ICAgICAgICAgIExlZ2FjeSBEZXZpY2VzIFN1cHBvcnRlZCAoVjIpIDogMA0KICAgICAgICAgICAg
IDgwNDIgUHJlc2VudCBvbiBwb3J0cyA2MC82NCAoVjIpIDogMCBAQCAtODksMTEgKzg5LDExIEBA
DQoNCg0KTm90IHN1cmUgdGhpcyBpcyBhbiBhbHJlYWR5IHJlcG9ydGVkIG9uZSBvciBJIGFtIG1p
c3Npbmcgc29tZXRoaW5nLg0KUGxlYXNlIGxldCBtZSBrbm93Lg0KDQpUaGFua3MsDQpTaGFtZWVy
DQoNCj4gQW55d2F5LCBmb3IgdGhpcyBwYXRjaDoNCj4gDQo+IFJldmlld2VkLWJ5OiBUaG9tYXMg
SHV0aCA8dGh1dGhAcmVkaGF0LmNvbT4NCg0K

