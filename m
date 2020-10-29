Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C1EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06212076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06212076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY3I8-0007zZ-OL
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 04:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kY3GV-00075P-3b; Thu, 29 Oct 2020 04:26:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kY3GS-0006Wm-8a; Thu, 29 Oct 2020 04:26:34 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CMJSN04xPzXgXh;
 Thu, 29 Oct 2020 16:26:28 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0487.000;
 Thu, 29 Oct 2020 16:26:18 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: RE: [PATCH 9/9] hw/timer/renesas_tmr: silence the compiler warnings
Thread-Topic: [PATCH 9/9] hw/timer/renesas_tmr: silence the compiler warnings
Thread-Index: AQHWrOF+ADO4HwGsJE2CG0fSb8vH1KmsQkOAgABVBgCAAFa8AIABUQUQ
Date: Thu, 29 Oct 2020 08:26:18 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA0FB63@dggemm531-mbx.china.huawei.com>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-10-kuhn.chenqun@huawei.com>
 <9992abee-6af6-5fae-15f6-3039fca84e80@amsat.org>
 <61ec3c46-f01e-c4ea-de28-a55507192ff3@redhat.com>
 <CAFEAcA-Pm2n19mVV0i4=551aVYW4wcOLE5BE14YmrpqowQr_nw@mail.gmail.com>
In-Reply-To: <CAFEAcA-Pm2n19mVV0i4=551aVYW4wcOLE5BE14YmrpqowQr_nw@mail.gmail.com>
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, ganqixin <ganqixin@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBNYXlkZWxsIFttYWls
dG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAy
OSwgMjAyMCA0OjE1IEFNDQo+IFRvOiBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT4NCj4g
Q2M6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxmNGJ1Z0BhbXNhdC5vcmc+OyBDaGVucXVuIChr
dWhuKQ0KPiA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+OyBRRU1VIERldmVsb3BlcnMgPHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZz47DQo+IFFFTVUgVHJpdmlhbCA8cWVtdS10cml2aWFsQG5vbmdudS5v
cmc+OyBZb3NoaW5vcmkgU2F0bw0KPiA8eXNhdG9AdXNlcnMuc291cmNlZm9yZ2UuanA+OyBNYWdu
dXMgRGFtbSA8bWFnbnVzLmRhbW1AZ21haWwuY29tPjsNCj4gWmhhbmdoYWlsaWFuZyA8emhhbmcu
emhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsgZ2FucWl4aW4NCj4gPGdhbnFpeGluQGh1YXdlaS5j
b20+OyBFdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCA5LzldIGh3L3RpbWVyL3JlbmVzYXNfdG1yOiBzaWxlbmNlIHRoZSBjb21waWxlciB3
YXJuaW5ncw0KPiANCj4gT24gV2VkLCAyOCBPY3QgMjAyMCBhdCAxNTowNywgVGhvbWFzIEh1dGgg
PHRodXRoQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gMjgvMTAvMjAyMCAxMC41OSwg
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+ID4gPiBPbiAxMC8yOC8yMCA1OjE4IEFN
LCBDaGVuIFF1biB3cm90ZToNCj4gPiA+PiBXaGVuIHVzaW5nIC1XaW1wbGljaXQtZmFsbHRocm91
Z2ggaW4gb3VyIENGTEFHUywgdGhlIGNvbXBpbGVyIHNob3dlZA0KPiB3YXJuaW5nOg0KPiA+ID4+
IC4uL2h3L3RpbWVyL3JlbmVzYXNfdG1yLmM6IEluIGZ1bmN0aW9uIOKAmHRtcl9yZWFk4oCZOg0K
PiA+ID4+IC4uL2h3L3RpbWVyL3JlbmVzYXNfdG1yLmM6MjIxOjE5OiB3YXJuaW5nOiB0aGlzIHN0
YXRlbWVudCBtYXkgZmFsbA0KPiB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4g
PiA+PiAgIDIyMSB8ICAgICAgICAgfSBlbHNlIGlmIChjaCA9PSAwKSB7aQ0KPiA+ID4+ICAgICAg
IHwgICAgICAgICAgICAgICAgICAgXg0KPiA+ID4+IC4uL2h3L3RpbWVyL3JlbmVzYXNfdG1yLmM6
MjI0OjU6IG5vdGU6IGhlcmUNCj4gPiA+PiAgIDIyNCB8ICAgICBjYXNlIEFfVENPUkI6DQo+ID4g
Pj4gICAgICAgfCAgICAgXn5+fg0KPiA+ID4+DQo+ID4gPj4gQWRkIHRoZSBjb3JyZXNwb25kaW5n
ICJmYWxsIHRocm91Z2giIGNvbW1lbnQgdG8gZml4IGl0Lg0KPiA+ID4+DQo+ID4gPj4gUmVwb3J0
ZWQtYnk6IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPiA+ID4+IFNpZ25l
ZC1vZmYtYnk6IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4gPiA+PiAtLS0N
Cj4gPiA+PiBDYzogWW9zaGlub3JpIFNhdG8gPHlzYXRvQHVzZXJzLnNvdXJjZWZvcmdlLmpwPg0K
PiA+ID4+IENjOiBNYWdudXMgRGFtbSA8bWFnbnVzLmRhbW1AZ21haWwuY29tPg0KPiA+ID4+IC0t
LQ0KPiA+ID4+ICBody90aW1lci9yZW5lc2FzX3Rtci5jIHwgMSArDQo+ID4gPj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4+DQo+ID4gPj4gZGlmZiAtLWdpdCBhL2h3L3Rp
bWVyL3JlbmVzYXNfdG1yLmMgYi9ody90aW1lci9yZW5lc2FzX3Rtci5jIGluZGV4DQo+ID4gPj4g
NDQ2ZjJlYWNkZC4uZTAzYTgxNTViMiAxMDA2NDQNCj4gPiA+PiAtLS0gYS9ody90aW1lci9yZW5l
c2FzX3Rtci5jDQo+ID4gPj4gKysrIGIvaHcvdGltZXIvcmVuZXNhc190bXIuYw0KPiA+ID4+IEBA
IC0yMjEsNiArMjIxLDcgQEAgc3RhdGljIHVpbnQ2NF90IHRtcl9yZWFkKHZvaWQgKm9wYXF1ZSwg
aHdhZGRyDQo+IGFkZHIsIHVuc2lnbmVkIHNpemUpDQo+ID4gPj4gICAgICAgICAgfSBlbHNlIGlm
IChjaCA9PSAwKSB7DQo+ID4gPj4gICAgICAgICAgICAgIHJldHVybiBjb25jYXRfcmVnKHRtci0+
dGNvcmEpOw0KPiA+ID4+ICAgICAgICAgIH0NCj4gPiA+PiArICAgICAgICAvKiBmYWxsIHRocm91
Z2ggKi8NCj4gPiA+PiAgICAgIGNhc2UgQV9UQ09SQjoNCj4gPiA+PiAgICAgICAgICBpZiAoc2l6
ZSA9PSAxKSB7DQo+ID4gPj4gICAgICAgICAgICAgIHJldHVybiB0bXItPnRjb3JiW2NoXTsNCj4g
PiA+Pg0KPiA+ID4NCj4gPiA+IFlvdSBmaXhlZCBBX1RDT1JBIGJ1dCBub3QgQV9UQ09SQi4uLg0K
PiA+DQo+ID4gQV9UQ09SQiBjYW5ub3QgZmFsbCB0aHJvdWdoLCBzaW5jZSBpdCBhbHdheXMgZG9l
cyBhICJyZXR1cm4iIGluIGJvdGgNCj4gPiBicmFuY2hlcyBvZiB0aGUgaWYtc3RhdGVtZW50Lg0K
PiA+DQo+ID4gSG93ZXZlciwgaXQgYWxzbyBsb29rcyByZWFsbHkgb2RkIHRoYXQgQV9UQ09SQSBm
YWxscyB0aHJvdWdoIHRvDQo+ID4gQV9UQ09SQiBoZXJlIGFuZCByZXR1cm4gdGhhdCByZWdpc3Rl
ciB2YWx1ZSBpbnN0ZWFkLiBJcyB0aGlzIHJlYWxseQ0KPiA+IGludGVuZGVkPyBZb3NoaW5vcmks
IGNvdWxkIHlvdSBwbGVhc2UgZG91YmxlLWNoZWNrIHdoZXRoZXIgdGhpcyBpcyBhIGJ1ZyBoZXJl
LA0KPiBvciBpbnRlbmRlZD8NCj4gDQo+IFNlZSB0aGUgZGlzY3Vzc2lvbiBpbiB0aGlzIHRocmVh
ZDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9DQUZFQWNBOGMyZHl3cj1a
eHoxRXhBVi00OEp3RlU1dmJCRA0KPiBEZkE9X0tFOThYYW1uWGlBQG1haWwuZ21haWwuY29tLw0K
PiBmcm9tIHdoZW4gQ292ZXJpdHkgc3BvdHRpbmcgdGhlIGZhbGwtdGhyb3VnaC4NCj4gDQo+IEkg
dGhpbmsgdGhpcyBjbGVhbnVwIHBhdGNoIGZyb20gWW9zaGlub3JpIGRlYWxzIHdpdGggdGhlIGZh
bGwtdGhyb3VnaCBzdHVmZiBieQ0KPiBjbGVhbmluZyB1cCB0aGF0IGFyZWEgb2YgdGhlIHRpbWVy
IGRldmljZToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIwMDcxMTE1
NDI0Mi40MTIyMi0xLXlzYXRvQHVzZXJzLnNvDQo+IHVyY2Vmb3JnZS5qcC8NCj4gSXQganVzdCBu
ZWVkcyBzb21lYm9keSB0byBjb2RlLXJldmlldyBpdCA6LSkNCg0KVGhpcyBjbGVhbnVwIHBhdGNo
IGhhcyBiZWVuIG1vZGlmaWVkIG1vcmUgdGhvcm91Z2hseSwgc28gbGV0J3Mgd2FpdCBmb3IgaXQg
bWVyZ2UgOi0pDQoNClRoYW5rcywNCkNoZW4gUXVuDQo=

