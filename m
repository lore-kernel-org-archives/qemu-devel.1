Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C04C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E54218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E54218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY22Y-0000yh-C1
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 03:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kY21Z-0000EX-Kr; Thu, 29 Oct 2020 03:07:05 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kY21R-0002hj-QB; Thu, 29 Oct 2020 03:07:05 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CMGhT4qLWz13N1S;
 Thu, 29 Oct 2020 15:06:49 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0487.000;
 Thu, 29 Oct 2020 15:06:44 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>
Subject: RE: [PATCH 7/9] ppc: silence the compiler warnings
Thread-Topic: [PATCH 7/9] ppc: silence the compiler warnings
Thread-Index: AQHWrOF+tr0Fl7gIT0SaZWaF976IB6mr5dcAgACraoCAAJXHgIABAeEw
Date: Thu, 29 Oct 2020 07:06:44 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA0F9E3@dggemm531-mbx.china.huawei.com>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-8-kuhn.chenqun@huawei.com>
 <20201028042900.GC5604@yekko.fritz.box>
 <ddcb887d-42ec-2021-1785-a6fb0d13d6b9@redhat.com>
 <20201028233835.GG5604@yekko.fritz.box>
In-Reply-To: <20201028233835.GG5604@yekko.fritz.box>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga08-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 03:06:51
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, ganqixin <ganqixin@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBHaWJzb24gW21haWx0
bzpkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXVdDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVy
IDI5LCAyMDIwIDc6MzkgQU0NCj4gVG86IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0K
PiBDYzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPjsgcWVtdS10cml2
aWFsQG5vbmdudS5vcmc7DQo+IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPjsg
cWVtdS1kZXZlbEBub25nbnUub3JnOyBnYW5xaXhpbg0KPiA8Z2FucWl4aW5AaHVhd2VpLmNvbT47
IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47DQo+IHFlbXUt
cHBjQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCA3LzldIHBwYzogc2lsZW5jZSB0
aGUgY29tcGlsZXIgd2FybmluZ3MNCj4gDQo+IE9uIFdlZCwgT2N0IDI4LCAyMDIwIGF0IDAzOjQy
OjMxUE0gKzAxMDAsIFRob21hcyBIdXRoIHdyb3RlOg0KPiA+IE9uIDI4LzEwLzIwMjAgMDUuMjks
IERhdmlkIEdpYnNvbiB3cm90ZToNCj4gPiA+IE9uIFdlZCwgT2N0IDI4LCAyMDIwIGF0IDEyOjE4
OjE3UE0gKzA4MDAsIENoZW4gUXVuIHdyb3RlOg0KPiA+ID4+IFdoZW4gdXNpbmcgLVdpbXBsaWNp
dC1mYWxsdGhyb3VnaCBpbiBvdXIgQ0ZMQUdTLCB0aGUgY29tcGlsZXIgc2hvd2VkDQo+IHdhcm5p
bmc6DQo+ID4gPj4gaHcvcHBjL3BwYy5jOiBJbiBmdW5jdGlvbiDigJhwcGM2eHhfc2V0X2lyceKA
mToNCj4gPiA+PiBody9wcGMvcHBjLmM6MTE4OjE2OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBt
YXkgZmFsbCB0aHJvdWdoDQo+IFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gPiA+PiAgIDEx
OCB8ICAgICAgICAgICAgIGlmIChsZXZlbCkgew0KPiA+ID4+ICAgICAgIHwgICAgICAgICAgICAg
ICAgXg0KPiA+ID4+IGh3L3BwYy9wcGMuYzoxMjM6OTogbm90ZTogaGVyZQ0KPiA+ID4+ICAgMTIz
IHwgICAgICAgICBjYXNlIFBQQzZ4eF9JTlBVVF9JTlQ6DQo+ID4gPj4gICAgICAgfCAgICAgICAg
IF5+fn4NCj4gPiA+Pg0KPiA+ID4+IEFkZCB0aGUgY29ycmVzcG9uZGluZyAiZmFsbCB0aHJvdWdo
IiBjb21tZW50IHRvIGZpeCBpdC4NCj4gPiA+Pg0KPiA+ID4+IFJlcG9ydGVkLWJ5OiBFdWxlciBS
b2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBDaGVu
IFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+ID4gPg0KPiA+ID4gQWNrZWQtYnk6IERh
dmlkIEdpYnNvbiA8ZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1Pg0KPiA+ID4NCj4gPiA+PiAt
LS0NCj4gPiA+PiBDYzogRGF2aWQgR2lic29uIDxkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU+
DQo+ID4gPj4gLS0tDQo+ID4gPj4gIGh3L3BwYy9wcGMuYyB8IDEgKw0KPiA+ID4+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiA+Pg0KPiA+ID4+IGRpZmYgLS1naXQgYS9ody9w
cGMvcHBjLmMgYi9ody9wcGMvcHBjLmMgaW5kZXgNCj4gPiA+PiA0YTExZmIxNjQwLi5mOWViOGYy
MWI0IDEwMDY0NA0KPiA+ID4+IC0tLSBhL2h3L3BwYy9wcGMuYw0KPiA+ID4+ICsrKyBiL2h3L3Bw
Yy9wcGMuYw0KPiA+ID4+IEBAIC0xMjAsNiArMTIwLDcgQEAgc3RhdGljIHZvaWQgcHBjNnh4X3Nl
dF9pcnEodm9pZCAqb3BhcXVlLCBpbnQgcGluLA0KPiBpbnQgbGV2ZWwpDQo+ID4gPj4gICAgICAg
ICAgICAgIH0gZWxzZSB7DQo+ID4gPj4gICAgICAgICAgICAgICAgICBjcHVfcHBjX3RiX3N0b3Ao
ZW52KTsNCj4gPiA+PiAgICAgICAgICAgICAgfQ0KPiA+ID4+ICsgICAgICAgICAgICAvKiBmYWxs
IHRocm91Z2ggKi8NCj4gPiA+PiAgICAgICAgICBjYXNlIFBQQzZ4eF9JTlBVVF9JTlQ6DQo+ID4g
Pj4gICAgICAgICAgICAgIC8qIExldmVsIHNlbnNpdGl2ZSAtIGFjdGl2ZSBoaWdoICovDQo+ID4g
Pj4gICAgICAgICAgICAgIExPR19JUlEoIiVzOiBzZXQgdGhlIGV4dGVybmFsIElSUSBzdGF0ZSB0
byAlZFxuIiwNCj4gPiA+DQo+ID4NCj4gPiBJcyB0aGF0IGZhbGwgdGhyb3VnaCBhY3R1YWxseSBy
ZWFsbHkgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGhlcmU/IEknZA0KPiA+IHJhdGhlciBleHBlY3Qg
dG8gc2VlIGEgUFBDX0lOVEVSUlVQVF9ERUNSIGluc3RlYWQgb2YgYQ0KPiA+IFBQQ19JTlRFUlJV
UFRfRVhUIGluIGNhc2Ugc29tZW9uZSBtZXNzZXMgd2l0aCB0aGUgVEJFTiBwaW4/IFNvIEkNCj4g
PiBhc3N1bWUgdGhpcyBpcyBsaWtlbHkgcmF0aGVyIGJ1ZyBhbmQgd2Ugc2hvdWxkIGEgImJyZWFr
IiBzdGF0ZW1lbnQgaGVyZQ0KPiBpbnN0ZWFkPw0KPiANCj4gT2guLiBnb29kIGNhdGNoLCBJIHRo
aW5rIEkgbWlzcmVhZCB0aGlzLiAgSSB0aG91Z2h0IHRoZSBjaGFuZ2Ugd2FzIGNvcnJlY3QsDQo+
IGJlY2F1c2UgREVDUnMgbG9vayBzb21ld2hhdCBsaWtlIGV4dGVybmFsIGludGVycnVwdHMuICBC
dXQgdGhpcyBpcyBUQkVOLCBub3QNCj4gYSBERUNSIGludGVycnVwdCBwZXIgc2UuICBTbywgeWVz
LCBJIHRoaW5rIHRoaXMgd2FzIGEgYnVnIGFuZCBpdCBzaG91bGQgYmUgYQ0KPiBicmVhayBpbnN0
ZWFkLg0KPiANClRoaXMgYnVnIGxvb2tzIGxpa2UgaXQncyBiZWVuIGhpZGRlbiBmb3IgeWVhcnMu
IFRoYW5rcyBmb3IgeW91ciBwb2ludC4NCkFjY29yZGluZyB0byB5b3VyIG9waW5pb24sIEkgd2ls
bCBtb2RpZnkgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KQ2hlbiBRdW4NCj4g
LS0NCj4gRGF2aWQgR2lic29uCQkJfCBJJ2xsIGhhdmUgbXkgbXVzaWMgYmFyb3F1ZSwgYW5kIG15
IGNvZGUNCj4gZGF2aWQgQVQgZ2lic29uLmRyb3BiZWFyLmlkLmF1CXwgbWluaW1hbGlzdCwgdGhh
bmsgeW91LiAgTk9UIF90aGVfDQo+IF9vdGhlcl8NCj4gCQkJCXwgX3dheV8gX2Fyb3VuZF8hDQo+
IGh0dHA6Ly93d3cub3psYWJzLm9yZy9+ZGdpYnNvbg0K

