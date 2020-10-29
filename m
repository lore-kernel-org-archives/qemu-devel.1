Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4529CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 02:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405B42076A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 02:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405B42076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXxzH-00022f-Uo
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 22:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kXxwy-0000j3-9Z; Wed, 28 Oct 2020 22:46:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kXxwv-00031h-Ls; Wed, 28 Oct 2020 22:46:03 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CM8vR5B2Vz4xtf;
 Thu, 29 Oct 2020 10:45:55 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 29 Oct 2020 10:45:53 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0487.000;
 Thu, 29 Oct 2020 10:45:44 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH 6/9] target/sparc/win_helper: silence the compiler warnings
Thread-Topic: [PATCH 6/9] target/sparc/win_helper: silence the compiler
 warnings
Thread-Index: AQHWrOF7z/lhJ4kApUmZKCgUssA+W6msP+qAgAGg03A=
Date: Thu, 29 Oct 2020 02:45:44 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA0E34B@dggemm531-mbx.china.huawei.com>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-7-kuhn.chenqun@huawei.com>
 <9fad34a2-56e1-9c67-bb8a-205640b92544@amsat.org>
In-Reply-To: <9fad34a2-56e1-9c67-bb8a-205640b92544@amsat.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 22:45:55
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
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, ganqixin <ganqixin@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSBbbWFpbHRvOnBoaWxpcHBlLm1hdGhpZXUuZGF1ZGVAZ21haWwuY29tXQ0KPiBPbiBCZWhh
bGYgT2YgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDI4LCAyMDIwIDU6NTEgUE0NCj4gVG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVh
d2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcWVtdS10cml2aWFsQG5vbmdudS5v
cmcNCj4gQ2M6IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47
IE1hcmsgQ2F2ZS1BeWxhbmQNCj4gPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPjsgZ2Fu
cWl4aW4gPGdhbnFpeGluQGh1YXdlaS5jb20+OyBFdWxlcg0KPiBSb2JvdCA8ZXVsZXIucm9ib3RA
aHVhd2VpLmNvbT47IEFydHlvbSBUYXJhc2Vua28NCj4gPGF0YXI0cWVtdUBnbWFpbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNi85XSB0YXJnZXQvc3BhcmMvd2luX2hlbHBlcjogc2lsZW5j
ZSB0aGUgY29tcGlsZXINCj4gd2FybmluZ3MNCj4gDQo+IE9uIDEwLzI4LzIwIDU6MTggQU0sIENo
ZW4gUXVuIHdyb3RlOg0KPiA+IFdoZW4gdXNpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCBpbiBv
dXIgQ0ZMQUdTLCB0aGUgY29tcGlsZXIgc2hvd2VkDQo+IHdhcm5pbmc6DQo+ID4gdGFyZ2V0L3Nw
YXJjL3dpbl9oZWxwZXIuYzogSW4gZnVuY3Rpb24g4oCYZ2V0X2dyZWdzZXTigJk6DQo+ID4gdGFy
Z2V0L3NwYXJjL3dpbl9oZWxwZXIuYzozMDQ6OTogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5
IGZhbGwgdGhyb3VnaA0KPiBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+ID4gICAzMDQgfCAg
ICAgICAgIHRyYWNlX3dpbl9oZWxwZXJfZ3JlZ3NldF9lcnJvcihwc3RhdGUpOw0KPiA+ICAgICAg
IHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+IHRh
cmdldC9zcGFyYy93aW5faGVscGVyLmM6MzA2OjU6IG5vdGU6IGhlcmUNCj4gPiAgIDMwNiB8ICAg
ICBjYXNlIDA6DQo+ID4gICAgICAgfCAgICAgXn5+fg0KPiA+DQo+ID4gQWRkIHRoZSBjb3JyZXNw
b25kaW5nICJmYWxsIHRocm91Z2giIGNvbW1lbnQgdG8gZml4IGl0Lg0KPiA+DQo+ID4gUmVwb3J0
ZWQtYnk6IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiBD
YzogTWFyayBDYXZlLUF5bGFuZCA8bWFyay5jYXZlLWF5bGFuZEBpbGFuZGUuY28udWs+DQo+ID4g
Q2M6IEFydHlvbSBUYXJhc2Vua28gPGF0YXI0cWVtdUBnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4g
IHRhcmdldC9zcGFyYy93aW5faGVscGVyLmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3NwYXJjL3dpbl9oZWxw
ZXIuYyBiL3RhcmdldC9zcGFyYy93aW5faGVscGVyLmMNCj4gPiBpbmRleCA4MjkwYTIxMTQyLi4z
MmVhY2MwNWU2IDEwMDY0NA0KPiA+IC0tLSBhL3RhcmdldC9zcGFyYy93aW5faGVscGVyLmMNCj4g
PiArKysgYi90YXJnZXQvc3BhcmMvd2luX2hlbHBlci5jDQo+ID4gQEAgLTMwMyw2ICszMDMsNyBA
QCBzdGF0aWMgaW5saW5lIHVpbnQ2NF90ICpnZXRfZ3JlZ3NldChDUFVTUEFSQ1N0YXRlDQo+ICpl
bnYsIHVpbnQzMl90IHBzdGF0ZSkNCj4gPiAgICAgIGRlZmF1bHQ6DQo+ID4gICAgICAgICAgdHJh
Y2Vfd2luX2hlbHBlcl9ncmVnc2V0X2Vycm9yKHBzdGF0ZSk7DQo+ID4gICAgICAgICAgLyogcGFz
cyB0aHJvdWdoIHRvIG5vcm1hbCBzZXQgb2YgZ2xvYmFsIHJlZ2lzdGVycyAqLw0KPiA+ICsgICAg
ICAgIC8qIGZhbGwgdGhyb3VnaCAqLw0KPiANCj4gQ2FuIHlvdSBrZWVwIHRoZSBjb21tZW50LCBk
b2luZyBzL3Bhc3MvZmFsbC8/DQo+IA0KVGhhdCBsb29rcyBnb29kLCB0b28uDQoNClRoYW5rcywN
CkNoZW4gUXVuDQo+ID4gICAgICBjYXNlIDA6DQo+ID4gICAgICAgICAgcmV0dXJuIGVudi0+Ymdy
ZWdzOw0KPiA+ICAgICAgY2FzZSBQU19BRzoNCj4gPg0KDQo=

