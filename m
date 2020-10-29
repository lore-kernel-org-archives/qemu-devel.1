Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4F1C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7102075E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7102075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY1Cs-0006Nq-KR
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 02:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kY1Bj-0005RS-Dn; Thu, 29 Oct 2020 02:13:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kY1Bg-0001H9-I2; Thu, 29 Oct 2020 02:13:31 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CMFVg20RBzQlbw;
 Thu, 29 Oct 2020 14:13:15 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 DGGEMM402-HUB.china.huawei.com ([10.3.20.210]) with mapi id 14.03.0487.000;
 Thu, 29 Oct 2020 14:13:03 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth
 <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH 3/9] accel/tcg/user-exec: silence the compiler warnings
Thread-Topic: [PATCH 3/9] accel/tcg/user-exec: silence the compiler warnings
Thread-Index: AQHWrOF7eMg99l5n60mgSlthe5b9zKmsg00AgAAdcYCAAXjdAA==
Date: Thu, 29 Oct 2020 06:13:03 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA0F933@dggemm531-mbx.china.huawei.com>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-4-kuhn.chenqun@huawei.com>
 <e2a3548e-d36c-3338-f298-150cce3c3d47@redhat.com>
 <d84d1e42-5814-05fb-4bfa-878cdca0754b@linaro.org>
In-Reply-To: <d84d1e42-5814-05fb-4bfa-878cdca0754b@linaro.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga02-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 02:13:17
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, ganqixin <ganqixin@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIEhlbmRlcnNvbiBb
bWFpbHRvOnJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IFdlZG5lc2RheSwg
T2N0b2JlciAyOCwgMjAyMCAxMTozOCBQTQ0KPiBUbzogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhh
dC5jb20+OyBDaGVucXVuIChrdWhuKQ0KPiA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+OyBxZW11
LWRldmVsQG5vbmdudS5vcmc7DQo+IHFlbXUtdHJpdmlhbEBub25nbnUub3JnDQo+IENjOiBaaGFu
Z2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBSaWt1IFZvaXBpbw0K
PiA8cmlrdS52b2lwaW9AaWtpLmZpPjsgUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNv
bT47IGdhbnFpeGluDQo+IDxnYW5xaXhpbkBodWF3ZWkuY29tPjsgRXVsZXIgUm9ib3QgPGV1bGVy
LnJvYm90QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy85XSBhY2NlbC90Y2cv
dXNlci1leGVjOiBzaWxlbmNlIHRoZSBjb21waWxlciB3YXJuaW5ncw0KPiANCj4gT24gMTAvMjgv
MjAgNjo1MiBBTSwgVGhvbWFzIEh1dGggd3JvdGU6DQo+ID4gT24gMjgvMTAvMjAyMCAwNS4xOCwg
Q2hlbiBRdW4gd3JvdGU6DQo+ID4+IFdoZW4gdXNpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCBp
biBvdXIgQ0ZMQUdTLCB0aGUgY29tcGlsZXIgc2hvd2VkDQo+IHdhcm5pbmc6DQo+ID4+IC4uL2Fj
Y2VsL3RjZy91c2VyLWV4ZWMuYzogSW4gZnVuY3Rpb24g4oCYaGFuZGxlX2NwdV9zaWduYWzigJk6
DQo+ID4+IC4uL2FjY2VsL3RjZy91c2VyLWV4ZWMuYzoxNjk6MTM6IHdhcm5pbmc6IHRoaXMgc3Rh
dGVtZW50IG1heSBmYWxsIHRocm91Z2gNCj4gWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQ0KPiA+
PiAgIDE2OSB8ICAgICAgICAgICAgIGNwdV9leGl0X3RiX2Zyb21fc2lnaGFuZGxlcihjcHUsIG9s
ZF9zZXQpOw0KPiA+PiAgICAgICB8ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4+IC4uL2FjY2VsL3RjZy91c2VyLWV4ZWMuYzoxNzI6OTog
bm90ZTogaGVyZQ0KPiA+PiAgIDE3MiB8ICAgICAgICAgZGVmYXVsdDoNCj4gPj4NCj4gPj4gVGhp
cyBleGNlcHRpb24gYnJhbmNoIGZhbGwgdGhyb3VnaCB0aGUgJ2RlZmF1bHQnIGJyYW5jaCBhbmQg
cnVuIHRoZQ0KPiAnZ19hc3NlcnRfbm90X3JlYWNoZWQnIHN0YXRlbWVudC4NCj4gPj4gU28gd2Ug
Y291bGQgdXNlICJmYWxsIHRocm91Z2giIGluc3RlYWQgb2YgIk5PUkVUVVJOIiBoZXJlLg0KPiA+
Pg0KPiA+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+
DQo+ID4+IFNpZ25lZC1vZmYtYnk6IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4N
Cj4gPj4gLS0tDQo+ID4+IENjOiBSaWt1IFZvaXBpbyA8cmlrdS52b2lwaW9AaWtpLmZpPg0KPiA+
PiBDYzogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+
ID4+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiA+PiAtLS0NCj4g
Pj4gIGFjY2VsL3RjZy91c2VyLWV4ZWMuYyB8IDIgKy0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvYWNj
ZWwvdGNnL3VzZXItZXhlYy5jIGIvYWNjZWwvdGNnL3VzZXItZXhlYy5jIGluZGV4DQo+ID4+IDRl
YmUyNTQ2MWEuLjMzMDQ2OGU5OTAgMTAwNjQ0DQo+ID4+IC0tLSBhL2FjY2VsL3RjZy91c2VyLWV4
ZWMuYw0KPiA+PiArKysgYi9hY2NlbC90Y2cvdXNlci1leGVjLmMNCj4gPj4gQEAgLTE2Nyw3ICsx
NjcsNyBAQCBzdGF0aWMgaW5saW5lIGludCBoYW5kbGVfY3B1X3NpZ25hbCh1aW50cHRyX3QgcGMs
DQo+IHNpZ2luZm9fdCAqaW5mbywNCj4gPj4gICAgICAgICAgICAgICAqLw0KPiA+PiAgICAgICAg
ICAgICAgY2xlYXJfaGVscGVyX3JldGFkZHIoKTsNCj4gPj4gICAgICAgICAgICAgIGNwdV9leGl0
X3RiX2Zyb21fc2lnaGFuZGxlcihjcHUsIG9sZF9zZXQpOw0KPiA+PiAtICAgICAgICAgICAgLyog
Tk9SRVRVUk4gKi8NCj4gPj4gKyAgICAgICAgICAgIC8qIGZhbGwgdGhyb3VnaCAqLw0KPiA+DQo+
ID4gVGhlcmUgc2hvdWxkIG5vdCBiZSBhIGZhbGwgdGhyb3VnaCBoZXJlIHNpbmNlIHRoZSBwcmV2
aW91cyBmdW5jdGlvbg0KPiA+IHNob3VsZCBuZXZlciByZXR1cm4uIERvZXMgdGhlIHdhcm5pbmcg
Z28gYXdheSBpZiB5b3UgbWFyayB0aGUNCj4gPiBjcHVfZXhpdF90Yl9mcm9tX3NpZ2hhbmRsZXIo
KSBmdW5jdGlvbiB3aXRoIFFFTVVfTk9SRVRVUk4gPyBJZiBzbywgSQ0KPiA+IHRoaW5rIHRoYXQg
d291bGQgYmUgdGhlIGJldHRlciBmaXguDQo+IA0KPiBUaGUgY29tcGlsZXIgc2hvdWxkIGhhdmUg
ZmlndXJlZCB0aGF0IG91dCBpdHNlbGYsIGR1ZSB0byBjcHVfbG9vcF9leGl0X25vZXhjDQo+IGJl
aW5nIG1hcmtlZCBRRU1VX05PUkVUVVJOLiAgSG93ZXZlciwgaWYgYWRkaW5nIGEgc2Vjb25kDQo+
IFFFTVVfTk9SRVRVUk4gd29ya3MsIEknbSBmaW5lIHdpdGggdGhhdC4NCj4gDQogIEkgdHJpZWQg
dG8gYWRkIFFFTVVfTk9SRVRVUk4gdG8gdGhlIGNwdV9leGl0X3RiX2Zyb21fc2lnaGFuZGxlcigp
IGZ1bmN0aW9uLg0KQW5kIHRoZW4gdGhlIGNvbXBpbGVyIHdhcm5pbmcgd2FzIGNsZWFyZWQuIEl0
IHNlZW1zIHRvIGJlIGEgYmV0dGVyIGZpeC4NCg0KVGhhbmtzLA0KQ2hlbiBRdW4NCj4gQXMgYSB2
ZXJ5IGxhc3QgcmVzb3J0LCB3ZSBjYW4gY2hhbmdlIHRoZSBjb21tZW50IHRvDQo+IA0KPiAgICAg
Lyogbm8gcmV0dXJuLCBidXQgZmFsbCB0aHJvdWdoIHRvIGFzc2VydCBub3QgcmVhY2hlZCAqLw0K
PiANCj4gd2hpY2ggY29ycmVjdGx5IGRvY3VtZW50cyBib3RoIHRoZSBmdW5jdGlvbiBwcmVjZWRp
bmcgYW5kIGFsc28gY29udGFpbnMgdGhlDQo+IHJlZ2V4cCB0aGF0IHRoZSBjb21waWxlciBpcyB1
c2luZyBmb3IgdGhlIHdhcm5pbmcuDQo+IA0KDQo=

