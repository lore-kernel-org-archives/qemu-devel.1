Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75024C55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9852071A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9852071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY34l-0000c4-Rw
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 04:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kY33Y-0008C3-Az; Thu, 29 Oct 2020 04:13:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kY33M-0001nL-PO; Thu, 29 Oct 2020 04:13:11 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CMJ8m4t15zXglY;
 Thu, 29 Oct 2020 16:12:56 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0487.000;
 Thu, 29 Oct 2020 16:12:46 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH 9/9] hw/timer/renesas_tmr: silence the compiler warnings
Thread-Topic: [PATCH 9/9] hw/timer/renesas_tmr: silence the compiler warnings
Thread-Index: AQHWrOF+ADO4HwGsJE2CG0fSb8vH1KmsQkOAgAC6j4A=
Date: Thu, 29 Oct 2020 08:12:45 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA0FAE5@dggemm531-mbx.china.huawei.com>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-10-kuhn.chenqun@huawei.com>
 <9992abee-6af6-5fae-15f6-3039fca84e80@amsat.org>
In-Reply-To: <9992abee-6af6-5fae-15f6-3039fca84e80@amsat.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga01-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 03:17:04
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
Cc: ganqixin <ganqixin@huawei.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSBbbWFpbHRvOnBoaWxpcHBlLm1hdGhpZXUuZGF1ZGVAZ21haWwuY29tXQ0KPiBPbiBCZWhh
bGYgT2YgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDI4LCAyMDIwIDY6MDAgUE0NCj4gVG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVh
d2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcWVtdS10cml2aWFsQG5vbmdudS5v
cmcNCj4gQ2M6IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47
IFlvc2hpbm9yaSBTYXRvDQo+IDx5c2F0b0B1c2Vycy5zb3VyY2Vmb3JnZS5qcD47IE1hZ251cyBE
YW1tIDxtYWdudXMuZGFtbUBnbWFpbC5jb20+Ow0KPiBnYW5xaXhpbiA8Z2FucWl4aW5AaHVhd2Vp
LmNvbT47IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDkvOV0gaHcvdGltZXIvcmVuZXNhc190bXI6IHNpbGVuY2UgdGhlIGNvbXBpbGVy
IHdhcm5pbmdzDQo+IA0KPiBPbiAxMC8yOC8yMCA1OjE4IEFNLCBDaGVuIFF1biB3cm90ZToNCj4g
PiBXaGVuIHVzaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2ggaW4gb3VyIENGTEFHUywgdGhlIGNv
bXBpbGVyIHNob3dlZA0KPiB3YXJuaW5nOg0KPiA+IC4uL2h3L3RpbWVyL3JlbmVzYXNfdG1yLmM6
IEluIGZ1bmN0aW9uIOKAmHRtcl9yZWFk4oCZOg0KPiA+IC4uL2h3L3RpbWVyL3JlbmVzYXNfdG1y
LmM6MjIxOjE5OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoDQo+IFst
V2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gPiAgIDIyMSB8ICAgICAgICAgfSBlbHNlIGlmIChj
aCA9PSAwKSB7aQ0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgXg0KPiA+IC4uL2h3L3Rp
bWVyL3JlbmVzYXNfdG1yLmM6MjI0OjU6IG5vdGU6IGhlcmUNCj4gPiAgIDIyNCB8ICAgICBjYXNl
IEFfVENPUkI6DQo+ID4gICAgICAgfCAgICAgXn5+fg0KPiA+DQo+ID4gQWRkIHRoZSBjb3JyZXNw
b25kaW5nICJmYWxsIHRocm91Z2giIGNvbW1lbnQgdG8gZml4IGl0Lg0KPiA+DQo+ID4gUmVwb3J0
ZWQtYnk6IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiBD
YzogWW9zaGlub3JpIFNhdG8gPHlzYXRvQHVzZXJzLnNvdXJjZWZvcmdlLmpwPg0KPiA+IENjOiBN
YWdudXMgRGFtbSA8bWFnbnVzLmRhbW1AZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBody90aW1l
ci9yZW5lc2FzX3Rtci5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3RpbWVyL3JlbmVzYXNfdG1yLmMgYi9ody90aW1l
ci9yZW5lc2FzX3Rtci5jIGluZGV4DQo+ID4gNDQ2ZjJlYWNkZC4uZTAzYTgxNTViMiAxMDA2NDQN
Cj4gPiAtLS0gYS9ody90aW1lci9yZW5lc2FzX3Rtci5jDQo+ID4gKysrIGIvaHcvdGltZXIvcmVu
ZXNhc190bXIuYw0KPiA+IEBAIC0yMjEsNiArMjIxLDcgQEAgc3RhdGljIHVpbnQ2NF90IHRtcl9y
ZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsDQo+IHVuc2lnbmVkIHNpemUpDQo+ID4gICAg
ICAgICAgfSBlbHNlIGlmIChjaCA9PSAwKSB7DQo+ID4gICAgICAgICAgICAgIHJldHVybiBjb25j
YXRfcmVnKHRtci0+dGNvcmEpOw0KPiA+ICAgICAgICAgIH0NCj4gPiArICAgICAgICAvKiBmYWxs
IHRocm91Z2ggKi8NCj4gPiAgICAgIGNhc2UgQV9UQ09SQjoNCj4gPiAgICAgICAgICBpZiAoc2l6
ZSA9PSAxKSB7DQo+ID4gICAgICAgICAgICAgIHJldHVybiB0bXItPnRjb3JiW2NoXTsNCj4gPg0K
PiANCj4gWW91IGZpeGVkIEFfVENPUkEgYnV0IG5vdCBBX1RDT1JCLi4uDQo+IA0KSGkgUGhpbGlw
cGUsDQogTXkgZmlyc3QgZmVlbGluZyBpcyB0aGUgc2FtZSBhcyB5b3Ugd2hlbiB0aGlzIHdhcm5p
bmcgZm91bmQuDQpCdXQsIHRoZSBudW1iZXIgb2YgYnJhbmNoZXMgZm9yIEFfVENPUkEgYW5kIEFf
VENPUkIgaXMgZGlmZmVyZW50Lg0KDQpJbiBBX1RDT1JBIGNhc2XvvJoifSBlbHNlIGlmIChjaCA9
PSAwKSB7Ig0KSW4gQV9UQ09SQiBjYXNl77yaIn0gZWxzZSB7Ig0KDQpPYnZpb3VzbHksIEFfVENP
QiBoYXZlIGFsbCByZXR1cm4gdmFsdWVzLiBCdXQgQV9UQ09BIGlzIG5vdCwgaXQgbmVlZCB0byBm
YWxsIHRocm91Z2ggb3IgYnJlYWsuDQoNCj4gSG93IHRoZSBFdWxlciBSb2JvdCB3b3Jrcz8gTGlr
ZSBDb3Zlcml0eT8NCg0KTm8sIHVubGlrZSBDb3Zlcml0eSwgQ292ZXJpdHkgaXMgZXNzZW50aWFs
bHkgYSBnb29kIGRpc2NvdmVyeSBidWcgdG9vbC4NCkJ1dCBFdWxlclJvYm90IGlzIGEgdmlydHVh
bGl6YXRpb24gc29mdHdhcmUgcXVhbGl0eSBhdXRvbWF0aW9uIHByb2plY3QgdGhhdCBpbnRlZ3Jh
dGVzIHNvbWUgdG9vbHMgYW5kIHRlc3Qgc3VpdGVzIHN1Y2ggYXMgZ2NjL2NsYW5nIG1ha2UgdGVz
dCwgcWVtdSB1dCwgcXRlc3QsIGNvY2NpbmVsbGUgc2NyaXB0cyBhbmQgYXZvY2Fkby12dC4NCg0K
VGhhbmtzLA0KQ2hlbiBRdW4gDQoNCg==

