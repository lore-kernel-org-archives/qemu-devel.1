Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48623C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 02:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEB52075E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 02:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEB52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXxt6-0008CB-A1
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 22:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kXxrv-0007M8-SZ; Wed, 28 Oct 2020 22:40:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kXxrs-0000sU-RS; Wed, 28 Oct 2020 22:40:51 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CM8nN1r45z4yV0;
 Thu, 29 Oct 2020 10:40:40 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 29 Oct 2020 10:40:37 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0487.000;
 Thu, 29 Oct 2020 10:40:30 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, 
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: RE: [PATCH 1/9] target/i386: silence the compiler warnings in
 gen_shiftd_rm_T1
Thread-Topic: [PATCH 1/9] target/i386: silence the compiler warnings in
 gen_shiftd_rm_T1
Thread-Index: AQHWrOF4zqsY6IHEck2606dhDvSD0amsc+oAgAAq6ACAABaLgIABIlOA
Date: Thu, 29 Oct 2020 02:40:29 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA0E335@dggemm531-mbx.china.huawei.com>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-2-kuhn.chenqun@huawei.com>
 <30ca9af0-dfc2-e236-5575-068cec679508@redhat.com>
 <d1d59436-1a8a-7aa3-7983-4344e16ab881@linaro.org>
 <9aac453d-2826-1b5e-db12-386b18f38eba@redhat.com>
In-Reply-To: <9aac453d-2826-1b5e-db12-386b18f38eba@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga03-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 22:40:39
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, ganqixin <ganqixin@huawei.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgSHV0aCBbbWFpbHRv
OnRodXRoQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDI5LCAyMDIwIDEy
OjUyIEFNDQo+IFRvOiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJv
Lm9yZz47IENoZW5xdW4gKGt1aG4pDQo+IDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT47IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcWVtdS10cml2aWFsQG5vbmdudS5vcmcNCj4gQ2M6IEVkdWFy
ZG8gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT47IFpoYW5naGFpbGlhbmcNCj4gPHpoYW5n
LnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IGdhbnFpeGluIDxnYW5xaXhpbkBodWF3ZWkuY29t
PjsgRXVsZXINCj4gUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+OyBQYW9sbyBCb256aW5p
IDxwYm9uemluaUByZWRoYXQuY29tPjsNCj4gUmljaGFyZCBIZW5kZXJzb24gPHJ0aEB0d2lkZGxl
Lm5ldD4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzldIHRhcmdldC9pMzg2OiBzaWxlbmNlIHRo
ZSBjb21waWxlciB3YXJuaW5ncyBpbg0KPiBnZW5fc2hpZnRkX3JtX1QxDQo+IA0KPiBPbiAyOC8x
MC8yMDIwIDE2LjMxLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4gPiBPbiAxMC8yOC8yMCA1
OjU3IEFNLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4gPj4gT24gMjgvMTAvMjAyMCAwNS4xOCwgQ2hl
biBRdW4gd3JvdGU6DQo+ID4+PiBUaGUgY3VycmVudCAiI2lmZGVmIFRBUkdFVF9YODZfNjQiIHN0
YXRlbWVudCBhZmZlY3RzIHRoZSBjb21waWxlcidzDQo+ID4+PiBkZXRlcm1pbmF0aW9uIG9mIGZh
bGwgdGhyb3VnaC4NCj4gPj4+DQo+ID4+PiBXaGVuIHVzaW5nIC1XaW1wbGljaXQtZmFsbHRocm91
Z2ggaW4gb3VyIENGTEFHUywgdGhlIGNvbXBpbGVyIHNob3dlZA0KPiB3YXJuaW5nOg0KPiA+Pj4g
dGFyZ2V0L2kzODYvdHJhbnNsYXRlLmM6IEluIGZ1bmN0aW9uIOKAmGdlbl9zaGlmdGRfcm1fVDHi
gJk6DQo+ID4+PiB0YXJnZXQvaTM4Ni90cmFuc2xhdGUuYzoxNzczOjEyOiB3YXJuaW5nOiB0aGlz
IHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoDQo+IFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0N
Cj4gPj4+ICAgICAgICAgIGlmIChpc19yaWdodCkgew0KPiA+Pj4gICAgICAgICAgICAgXg0KPiA+
Pj4gdGFyZ2V0L2kzODYvdHJhbnNsYXRlLmM6MTc4Mjo1OiBub3RlOiBoZXJlDQo+ID4+PiAgICAg
IGNhc2UgTU9fMzI6DQo+ID4+PiAgICAgIF5+fn4NCj4gPj4+DQo+ID4+PiBSZXBvcnRlZC1ieTog
RXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5
OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+ID4+PiAtLS0NCj4gPj4+IENj
OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiA+Pj4gQ2M6IFJpY2hhcmQg
SGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPiA+Pj4gQ2M6IEVkdWFy
ZG8gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIHRhcmdl
dC9pMzg2L3RyYW5zbGF0ZS5jIHwgNCArKy0tDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2kzODYvdHJhbnNsYXRlLmMgYi90YXJnZXQvaTM4Ni90cmFuc2xhdGUuYyBpbmRleA0KPiA+
Pj4gY2FlYTZmNWZiMS4uNGMzNTM0MjdkNyAxMDA2NDQNCj4gPj4+IC0tLSBhL3RhcmdldC9pMzg2
L3RyYW5zbGF0ZS5jDQo+ID4+PiArKysgYi90YXJnZXQvaTM4Ni90cmFuc2xhdGUuYw0KPiA+Pj4g
QEAgLTE3NzcsOSArMTc3Nyw5IEBAIHN0YXRpYyB2b2lkIGdlbl9zaGlmdGRfcm1fVDEoRGlzYXND
b250ZXh0ICpzLA0KPiBNZW1PcCBvdCwgaW50IG9wMSwNCj4gPj4+ICAgICAgICAgIH0gZWxzZSB7
DQo+ID4+PiAgICAgICAgICAgICAgdGNnX2dlbl9kZXBvc2l0X3RsKHMtPlQxLCBzLT5UMCwgcy0+
VDEsIDE2LCAxNik7DQo+ID4+PiAgICAgICAgICB9DQo+ID4+PiAtICAgICAgICAvKiBGQUxMVEhS
VSAqLw0KPiA+Pj4gLSNpZmRlZiBUQVJHRVRfWDg2XzY0DQo+ID4+PiArICAgICAgICAvKiBmYWxs
IHRocm91Z2ggKi8NCj4gPj4+ICAgICAgY2FzZSBNT18zMjoNCj4gPj4+ICsjaWZkZWYgVEFSR0VU
X1g4Nl82NA0KPiA+Pj4gICAgICAgICAgLyogQ29uY2F0ZW5hdGUgdGhlIHR3byAzMi1iaXQgdmFs
dWVzIGFuZCB1c2UgYSA2NC1iaXQgc2hpZnQuDQo+ICovDQo+ID4+PiAgICAgICAgICB0Y2dfZ2Vu
X3N1YmlfdGwocy0+dG1wMCwgY291bnQsIDEpOw0KPiA+Pj4gICAgICAgICAgaWYgKGlzX3JpZ2h0
KSB7DQo+ID4+DQo+ID4+IFRoZSB3aG9sZSBjb2RlIGhlcmUgbG9va3MgYSBsaXR0bGUgYml0IGZp
c2h5IHRvIG1lIC4uLiBpbiBjYXNlDQo+ID4+IFRBUkdFVF9YODZfNjQgaXMgZGVmaW5lZCwgdGhl
IE1PXzE2IGNvZGUgZmFsbHMgdGhyb3VnaCB0byBNT18zMiAuLi4NCj4gPj4gYnV0IGluIGNhc2Ug
aXQgaXMgbm90IGRlZmluZWQsIGl0IGZhbGxzIHRocm91Z2ggdG8gdGhlIGRlZmF1bHQgY2FzZQ0K
PiA+PiB0aGF0IGNvbWVzIGFmdGVyIHRoZSAjaWZkZWYgYmxvY2s/IElzIHRoaXMgcmVhbGx5IHRo
ZSByaWdodCB0aGluZw0KPiA+PiBoZXJlPyBJZiBzbywgSSB0aGluayB0aGVyZSBzaG91bGQgYmUg
c29tZSBhZGRpdGlvbmFsIGNvbW1lbnRzIGV4cGxhaW5pbmcNCj4gdGhpcyBiZWhhdmlvci4NCj4g
Pj4NCj4gPj4gUmljaGFyZCwgbWF5YmUgeW91IGNvdWxkIGhlbHAgdG8ganVkZ2Ugd2hhdCBpcyBy
aWdodCBoZXJlLi4uPw0KPiA+DQo+ID4gSXQgY291bGQgZGVmaW5pdGVseSBiZSByZXdyaXR0ZW4s
IGJ1dCBpdCdzIG5vdCB3cm9uZyBhcyBpcy4NCj4gDQo+IE9rLCB0aGFua3MgZm9yIHRoZSBjbGFy
aWZpY2F0aW9uISBJbiB0aGF0IGNhc2U6DQo+IA0KPiBSZXZpZXdlZC1ieTogVGhvbWFzIEh1dGgg
PHRodXRoQHJlZGhhdC5jb20+DQoNClRoYW5rcyBmb3IgdGhlIGRpc2N1c3Npb24hDQpJIG1pZ2h0
IGFkZCBhIGxpdHRsZSBjb21tZW50IHRvIGRlc2NyaWJlIHRoaXMgYmVoYXZpb3IgYmFzZSBvbiB0
aGlzIHBhdGNoLg0KSnVzdCBsaWtlOiAvKiBJZiBUQVJHRVRfWDg2XzY0IGRlZmluZWQgdGhlbiBm
YWxsIHRocm91Z2ggaW50byBNT18zMiwgb3RoZXJ3aXNlIGZhbGwgdGhyb3VnaCBkZWZhdWx0LiAq
Lw0KDQpJZiB0aGVyZSBpcyBubyBvdGhlciBzdWdnZXN0aW9uLCBJJ2xsIGtlZXAgUmljaGFyZCdz
IGFuZCBUaG9tYXMgJ3MgIlJldmlld2VkLWJ5IiB0YWcuDQoNClRoYW5rcywNCkNoZW4gUXVuDQoN
Cg0K

