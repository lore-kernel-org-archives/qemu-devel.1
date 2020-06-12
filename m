Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340E6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07768206DC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07768206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjg6f-0003MM-Ce
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 05:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianjay.zhou@huawei.com>)
 id 1jjg5u-0002M0-NS
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 05:35:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2523 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianjay.zhou@huawei.com>)
 id 1jjg5r-0005in-S9
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 05:35:26 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id B0A40246740D0EEFA83F;
 Fri, 12 Jun 2020 17:35:19 +0800 (CST)
Received: from DGGEMM508-MBX.china.huawei.com ([169.254.2.47]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0487.000;
 Fri, 12 Jun 2020 17:35:11 +0800
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH] kvm: support to get/set dirty log initial-all-set
 capability
Thread-Topic: [PATCH] kvm: support to get/set dirty log initial-all-set
 capability
Thread-Index: AQHV8dBzPdW/4AkL+0GBczXBKqWav6hNu5OAgIcppiD//+h0AIAAh4nQ
Date: Fri, 12 Jun 2020 09:35:11 +0000
Message-ID: <B2D15215269B544CADD246097EACE7474BD283A5@dggemm508-mbx.china.huawei.com>
References: <20200304025554.2159-1-jianjay.zhou@huawei.com>
 <18e7b781-8a52-d78a-a653-898445a5ee53@redhat.com>
 <B2D15215269B544CADD246097EACE7474BD26B9F@dggemm508-mbx.china.huawei.com>
 <5346f621-6792-21fe-5030-fcf104345813@redhat.com>
In-Reply-To: <5346f621-6792-21fe-5030-fcf104345813@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=jianjay.zhou@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 05:35:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Liujinsong \(Paul\)" <liu.jinsong@huawei.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>,
 "mst@redhat.com" <mst@redhat.com>, "Wangxin \(Alexander,
 Cloud Infrastructure Service Product Dept.\)" <wangxinxin.wang@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAxMiwgMjAy
MCA1OjI4IFBNDQo+IFRvOiBaaG91amlhbiAoamF5KSA8amlhbmpheS56aG91QGh1YXdlaS5jb20+
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGt2bUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IG1z
dEByZWRoYXQuY29tOyBjb2h1Y2tAcmVkaGF0LmNvbTsgcGV0ZXJ4QHJlZGhhdC5jb207IFdhbmd4
aW4NCj4gKEFsZXhhbmRlciwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9kdWN0IERl
cHQuKQ0KPiA8d2FuZ3hpbnhpbi53YW5nQGh1YXdlaS5jb20+OyBIdWFuZ3dlaWRvbmcgKEMpDQo+
IDx3ZWlkb25nLmh1YW5nQGh1YXdlaS5jb20+OyBMaXVqaW5zb25nIChQYXVsKSA8bGl1LmppbnNv
bmdAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0ga3ZtOiBzdXBwb3J0IHRvIGdl
dC9zZXQgZGlydHkgbG9nIGluaXRpYWwtYWxsLXNldCBjYXBhYmlsaXR5DQo+IA0KPiBPbiAxMi8w
Ni8yMCAwNTowMSwgWmhvdWppYW4gKGpheSkgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBQYW9sbyBCb256aW5pIFttYWlsdG86cGJv
bnppbmlAcmVkaGF0LmNvbV0NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxOCwgMjAyMCA2
OjQ4IFBNDQo+ID4+IFRvOiBaaG91amlhbiAoamF5KSA8amlhbmpheS56aG91QGh1YXdlaS5jb20+
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ID4+IGt2bUB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4g
Q2M6IG1zdEByZWRoYXQuY29tOyBjb2h1Y2tAcmVkaGF0LmNvbTsgcGV0ZXJ4QHJlZGhhdC5jb207
IHdhbmd4aW4gKFUpDQo+ID4+IDx3YW5neGlueGluLndhbmdAaHVhd2VpLmNvbT47IEh1YW5nd2Vp
ZG9uZyAoQykNCj4gPj4gPHdlaWRvbmcuaHVhbmdAaHVhd2VpLmNvbT47IExpdWppbnNvbmcgKFBh
dWwpDQo+ID4+IDxsaXUuamluc29uZ0BodWF3ZWkuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BB
VENIXSBrdm06IHN1cHBvcnQgdG8gZ2V0L3NldCBkaXJ0eSBsb2cNCj4gPj4gaW5pdGlhbC1hbGwt
c2V0IGNhcGFiaWxpdHkNCj4gPj4NCj4gPj4gT24gMDQvMDMvMjAgMDM6NTUsIEpheSBaaG91IHdy
b3RlOg0KPiA+Pj4gU2luY2UgdGhlIG5ldyBjYXBhYmlsaXR5IEtWTV9ESVJUWV9MT0dfSU5JVElB
TExZX1NFVCBvZg0KPiA+Pj4gS1ZNX0NBUF9NQU5VQUxfRElSVFlfTE9HX1BST1RFQ1QyIGhhcyBi
ZWVuIGludHJvZHVjZWQgaW4gdGhlDQo+IGtlcm5lbCwNCj4gPj4+IHR3ZWFrIHRoZSB1c2Vyc3Bh
Y2Ugc2lkZSB0byBkZXRlY3QgYW5kIGVuYWJsZSB0aGlzIGNhcGFiaWxpdHkuDQo+ID4+Pg0KPiA+
Pj4gU2lnbmVkLW9mZi1ieTogSmF5IFpob3UgPGppYW5qYXkuemhvdUBodWF3ZWkuY29tPg0KPiA+
Pj4gLS0tDQo+ID4+PiAgYWNjZWwva3ZtL2t2bS1hbGwuYyAgICAgICB8IDIxICsrKysrKysrKysr
KysrLS0tLS0tLQ0KPiA+Pj4gIGxpbnV4LWhlYWRlcnMvbGludXgva3ZtLmggfCAgMyArKysNCj4g
Pj4+ICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+
ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2FjY2VsL2t2bS9rdm0tYWxsLmMgYi9hY2NlbC9rdm0v
a3ZtLWFsbC5jIGluZGV4DQo+ID4+PiA0MzlhNGVmZTUyLi40NWFiMjViZTYzIDEwMDY0NA0KPiA+
Pj4gLS0tIGEvYWNjZWwva3ZtL2t2bS1hbGwuYw0KPiA+Pj4gKysrIGIvYWNjZWwva3ZtL2t2bS1h
bGwuYw0KPiA+Pj4gQEAgLTEwMCw3ICsxMDAsNyBAQCBzdHJ1Y3QgS1ZNU3RhdGUNCj4gPj4+ICAg
ICAgYm9vbCBrZXJuZWxfaXJxY2hpcF9yZXF1aXJlZDsNCj4gPj4+ICAgICAgT25PZmZBdXRvIGtl
cm5lbF9pcnFjaGlwX3NwbGl0Ow0KPiA+Pj4gICAgICBib29sIHN5bmNfbW11Ow0KPiA+Pj4gLSAg
ICBib29sIG1hbnVhbF9kaXJ0eV9sb2dfcHJvdGVjdDsNCj4gPj4+ICsgICAgdWludDY0X3QgbWFu
dWFsX2RpcnR5X2xvZ19wcm90ZWN0Ow0KPiA+Pj4gICAgICAvKiBUaGUgbWFuIHBhZ2UgKGFuZCBw
b3NpeCkgc2F5IGlvY3RsIG51bWJlcnMgYXJlIHNpZ25lZCBpbnQsIGJ1dA0KPiA+Pj4gICAgICAg
KiB0aGV5J3JlIG5vdC4gIExpbnV4LCBnbGliYyBhbmQgKkJTRCBhbGwgdHJlYXQgaW9jdGwgbnVt
YmVycyBhcw0KPiA+Pj4gICAgICAgKiB1bnNpZ25lZCwgYW5kIHRyZWF0aW5nIHRoZW0gYXMgc2ln
bmVkIGhlcmUgY2FuIGJyZWFrIHRoaW5ncw0KPiA+Pj4gKi8gQEAgLTE4ODIsNiArMTg4Miw3IEBA
IHN0YXRpYyBpbnQga3ZtX2luaXQoTWFjaGluZVN0YXRlICptcykNCj4gPj4+ICAgICAgaW50IHJl
dDsNCj4gPj4+ICAgICAgaW50IHR5cGUgPSAwOw0KPiA+Pj4gICAgICBjb25zdCBjaGFyICprdm1f
dHlwZTsNCj4gPj4+ICsgICAgdWludDY0X3QgZGlydHlfbG9nX21hbnVhbF9jYXBzOw0KPiA+Pj4N
Cj4gPj4+ICAgICAgcyA9IEtWTV9TVEFURShtcy0+YWNjZWxlcmF0b3IpOw0KPiA+Pj4NCj4gPj4+
IEBAIC0yMDA3LDE0ICsyMDA4LDIwIEBAIHN0YXRpYyBpbnQga3ZtX2luaXQoTWFjaGluZVN0YXRl
ICptcykNCj4gPj4+ICAgICAgcy0+Y29hbGVzY2VkX3BpbyA9IHMtPmNvYWxlc2NlZF9tbWlvICYm
DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICBrdm1fY2hlY2tfZXh0ZW5zaW9uKHMsDQo+
ID4+IEtWTV9DQVBfQ09BTEVTQ0VEX1BJTyk7DQo+ID4+Pg0KPiA+Pj4gLSAgICBzLT5tYW51YWxf
ZGlydHlfbG9nX3Byb3RlY3QgPQ0KPiA+Pj4gKyAgICBkaXJ0eV9sb2dfbWFudWFsX2NhcHMgPQ0K
PiA+Pj4gICAgICAgICAga3ZtX2NoZWNrX2V4dGVuc2lvbihzLA0KPiA+PiBLVk1fQ0FQX01BTlVB
TF9ESVJUWV9MT0dfUFJPVEVDVDIpOw0KPiA+Pj4gLSAgICBpZiAocy0+bWFudWFsX2RpcnR5X2xv
Z19wcm90ZWN0KSB7DQo+ID4+PiAtICAgICAgICByZXQgPSBrdm1fdm1fZW5hYmxlX2NhcChzLA0K
PiA+PiBLVk1fQ0FQX01BTlVBTF9ESVJUWV9MT0dfUFJPVEVDVDIsIDAsIDEpOw0KPiA+Pj4gKyAg
ICBkaXJ0eV9sb2dfbWFudWFsX2NhcHMgJj0NCj4gPj4gKEtWTV9ESVJUWV9MT0dfTUFOVUFMX1BS
T1RFQ1RfRU5BQkxFIHwNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBLVk1f
RElSVFlfTE9HX0lOSVRJQUxMWV9TRVQpOw0KPiA+Pj4gKyAgICBzLT5tYW51YWxfZGlydHlfbG9n
X3Byb3RlY3QgPSBkaXJ0eV9sb2dfbWFudWFsX2NhcHM7DQo+ID4+PiArICAgIGlmIChkaXJ0eV9s
b2dfbWFudWFsX2NhcHMpIHsNCj4gPj4+ICsgICAgICAgIHJldCA9IGt2bV92bV9lbmFibGVfY2Fw
KHMsDQo+ID4+IEtWTV9DQVBfTUFOVUFMX0RJUlRZX0xPR19QUk9URUNUMiwgMCwNCj4gPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRpcnR5X2xvZ19tYW51YWxfY2Fwcyk7
DQo+ID4+PiAgICAgICAgICBpZiAocmV0KSB7DQo+ID4+PiAtICAgICAgICAgICAgd2Fybl9yZXBv
cnQoIlRyeWluZyB0byBlbmFibGUNCj4gPj4gS1ZNX0NBUF9NQU5VQUxfRElSVFlfTE9HX1BST1RF
Q1QyICINCj4gPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAiYnV0IGZhaWxlZC4gIEZhbGxp
bmcgYmFjayB0byB0aGUgbGVnYWN5IG1vZGUuDQo+ICIpOw0KPiA+Pj4gLSAgICAgICAgICAgIHMt
Pm1hbnVhbF9kaXJ0eV9sb2dfcHJvdGVjdCA9IGZhbHNlOw0KPiA+Pj4gKyAgICAgICAgICAgIHdh
cm5fcmVwb3J0KCJUcnlpbmcgdG8gZW5hYmxlIGNhcGFiaWxpdHkgJSJQUkl1NjQiIG9mICINCj4g
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAiS1ZNX0NBUF9NQU5VQUxfRElSVFlfTE9HX1BS
T1RFQ1QyDQo+ID4+IGJ1dCBmYWlsZWQuICINCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAiRmFsbGluZyBiYWNrIHRvIHRoZSBsZWdhY3kgbW9kZS4gIiwNCj4gPj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICBkaXJ0eV9sb2dfbWFudWFsX2NhcHMpOw0KPiA+Pj4gKyAgICAgICAgICAg
IHMtPm1hbnVhbF9kaXJ0eV9sb2dfcHJvdGVjdCA9IDA7DQo+ID4+PiAgICAgICAgICB9DQo+ID4+
PiAgICAgIH0NCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvbGludXgtaGVhZGVycy9saW51eC9r
dm0uaCBiL2xpbnV4LWhlYWRlcnMvbGludXgva3ZtLmgNCj4gPj4+IGluZGV4IDI2NTA5OTEwMGUu
LjNjYjcxYzJiMTkgMTAwNjQ0DQo+ID4+PiAtLS0gYS9saW51eC1oZWFkZXJzL2xpbnV4L2t2bS5o
DQo+ID4+PiArKysgYi9saW51eC1oZWFkZXJzL2xpbnV4L2t2bS5oDQo+ID4+PiBAQCAtMTYyOCw0
ICsxNjI4LDcgQEAgc3RydWN0IGt2bV9oeXBlcnZfZXZlbnRmZCB7DQo+ID4+PiAgI2RlZmluZSBL
Vk1fSFlQRVJWX0NPTk5fSURfTUFTSwkJMHgwMGZmZmZmZg0KPiA+Pj4gICNkZWZpbmUgS1ZNX0hZ
UEVSVl9FVkVOVEZEX0RFQVNTSUdOCSgxIDw8IDApDQo+ID4+Pg0KPiA+Pj4gKyNkZWZpbmUgS1ZN
X0RJUlRZX0xPR19NQU5VQUxfUFJPVEVDVF9FTkFCTEUgICAgKDEgPDwgMCkNCj4gPj4+ICsjZGVm
aW5lIEtWTV9ESVJUWV9MT0dfSU5JVElBTExZX1NFVCAgICAgICAgICAgICgxIDw8IDEpDQo+ID4+
PiArDQo+ID4+PiAgI2VuZGlmIC8qIF9fTElOVVhfS1ZNX0ggKi8NCj4gPj4+DQo+ID4+DQo+ID4+
IFF1ZXVlZCwgdGhhbmtzLg0KPiA+Pg0KPiA+DQo+ID4gSGkgUGFvbG8sDQo+ID4NCj4gPiBJdCBz
ZWVtcyB0aGF0IHRoaXMgcGF0Y2ggaXNuJ3QgaW5jbHVkZWQgaW4geW91ciBsYXN0IHB1bGwgcmVx
dWVzdC4uLg0KPiA+IElmIHRoZXJlJ3Mgc29tZXRoaW5nIGVsc2UgdG8gYmUgZG9uZSwgcGxlYXNl
IGxldCBtZSBrbm93Lg0KPiANCj4gU29ycnksIEkgdGhvdWdodCBtaXN0YWtlbmx5IHRoYXQgaXQg
d2FzIGEgNS44IGZlYXR1cmUgKHNvIGl0IHdvdWxkIGhhdmUgdG8gd2FpdCBmb3INCj4gdGhlIDUu
OC1yYzEgcmVsZWFzZSBhbmQgaGVhZGVyIHVwZGF0ZSkuICBJdCdzIHN0aWxsIHF1ZXVlZCB0aG91
Z2guDQoNCk9rYXksIG5ldmVyIG1pbmQsIDopDQoNClJlZ2FyZHMsDQpKYXkgWmhvdQ0K

