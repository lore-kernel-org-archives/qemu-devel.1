Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26252C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 07:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219DF20738
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 07:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219DF20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMRX0-00026d-3u
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 03:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kMRVz-0001Ex-NK; Sun, 27 Sep 2020 03:54:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2936 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kMRVx-00030z-Ef; Sun, 27 Sep 2020 03:54:35 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id C64D7766811F0C375C72;
 Sun, 27 Sep 2020 15:54:13 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sun, 27 Sep 2020 15:54:13 +0800
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 27 Sep 2020 15:54:13 +0800
Received: from dggpemm000001.china.huawei.com ([7.185.36.245]) by
 dggpemm000001.china.huawei.com ([7.185.36.245]) with mapi id 15.01.1913.007;
 Sun, 27 Sep 2020 15:54:13 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: RE: [PATCH] target/riscv: raise exception to HS-mode at
 get_physical_address
Thread-Topic: [PATCH] target/riscv: raise exception to HS-mode at
 get_physical_address
Thread-Index: AQHWefKN/OgGU8CPl0ibaJ0/byQAGql5myUAgAK0+QA=
Date: Sun, 27 Sep 2020 07:54:13 +0000
Message-ID: <c1273b7d24f5488c845d81153e495b69@huawei.com>
References: <20200824084158.1769-1-jiangyifei@huawei.com>
 <CAKmqyKOAAzhBqosJCFq9ww0T44EUZV1zqG+T1UPYAuebYbR1KQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOAAzhBqosJCFq9ww0T44EUZV1zqG+T1UPYAuebYbR1KQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.31]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=jiangyifei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 03:54:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpc3RhaXIgRnJhbmNp
cyBbbWFpbHRvOmFsaXN0YWlyMjNAZ21haWwuY29tXQ0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVt
YmVyIDI2LCAyMDIwIDY6MjQgQU0NCj4gVG86IEppYW5neWlmZWkgPGppYW5neWlmZWlAaHVhd2Vp
LmNvbT4NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyBEZXZlbG9wZXJzIDxxZW11LWRldmVs
QG5vbmdudS5vcmc+OyBvcGVuDQo+IGxpc3Q6UklTQy1WIDxxZW11LXJpc2N2QG5vbmdudS5vcmc+
OyBaaGFuZ2hhaWxpYW5nDQo+IDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBTYWdh
ciBLYXJhbmRpa2FyDQo+IDxzYWdhcmtAZWVjcy5iZXJrZWxleS5lZHU+OyBCYXN0aWFuIEtvcHBl
bG1hbm4NCj4gPGtiYXN0aWFuQG1haWwudW5pLXBhZGVyYm9ybi5kZT47IFpoYW5neGlhb2Zlbmcg
KEYpDQo+IDx2aWN0b3Iuemhhbmd4aWFvZmVuZ0BodWF3ZWkuY29tPjsgQWxpc3RhaXIgRnJhbmNp
cw0KPiA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsgeWlueWlwZW5nIDx5aW55aXBlbmcxQGh1
YXdlaS5jb20+OyBQYWxtZXINCj4gRGFiYmVsdCA8cGFsbWVyQGRhYmJlbHQuY29tPjsgV3ViaW4g
KEgpIDx3dS53dWJpbkBodWF3ZWkuY29tPjsNCj4gZGVuZ2thaSAoQSkgPGRlbmdrYWkxQGh1YXdl
aS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRhcmdldC9yaXNjdjogcmFpc2UgZXhjZXB0
aW9uIHRvIEhTLW1vZGUgYXQNCj4gZ2V0X3BoeXNpY2FsX2FkZHJlc3MNCj4gDQo+IE9uIE1vbiwg
QXVnIDI0LCAyMDIwIGF0IDE6NDMgQU0gWWlmZWkgSmlhbmcgPGppYW5neWlmZWlAaHVhd2VpLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBWUy1zdGFnZSB0cmFuc2xhdGlvbiBhdCBnZXRfcGh5c2ljYWxf
YWRkcmVzcyBuZWVkcyB0byB0cmFuc2xhdGUgcHRlDQo+ID4gYWRkcmVzcyBieSBHLXN0YWdlIHRy
YW5zbGF0aW9uLiBCdXQgdGhlIEctc3RhZ2UgdHJhbnNsYXRpb24gZXJyb3IgY2FuDQo+ID4gbm90
IGJlIGRpc3Rpbmd1aXNoZWQgZnJvbSBWUy1zdGFnZSB0cmFuc2xhdGlvbiBlcnJvciBpbg0KPiA+
IHJpc2N2X2NwdV90bGJfZmlsbC4gT24gbWlncmF0aW9uLCBkZXN0aW5hdGlvbiBuZWVkcyB0byBy
ZWJ1aWxkIHB0ZSwNCj4gPiBhbmQgdGhpcyBHLXN0YWdlIHRyYW5zbGF0aW9uIGVycm9yIG11c3Qg
YmUgaGFuZGxlZCBieSBIUy1tb2RlLiBTbw0KPiA+IGludHJvZHVjZSBUUkFOU0xBVEVfU1RBR0Uy
X0ZBSUwgc28gdGhhdCByaXNjdl9jcHVfdGxiX2ZpbGwgY291bGQNCj4gPiBkaXN0aW5ndWlzaCBh
bmQgcmFpc2UgaXQgdG8gSFMtbW9kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlpZmVpIEpp
YW5nIDxqaWFuZ3lpZmVpQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWlwZW5nIFlp
biA8eWlueWlwZW5nMUBodWF3ZWkuY29tPg0KPiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2ghDQo+
IA0KPiBTb3JyeSBmb3IgdGhlIGRlbGF5IGhlcmUuDQo+IA0KPiA+IC0tLQ0KPiA+ICB0YXJnZXQv
cmlzY3YvY3B1LmggICAgICAgIHwgIDEgKw0KPiA+ICB0YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5j
IHwgMTIgKysrKysrKysrKy0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1
LmggYi90YXJnZXQvcmlzY3YvY3B1LmggaW5kZXgNCj4gPiBhODA0YTVkMGJhLi44YjNiMzY4ZDZh
IDEwMDY0NA0KPiA+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUuaA0KPiA+ICsrKyBiL3RhcmdldC9y
aXNjdi9jcHUuaA0KPiA+IEBAIC04NSw2ICs4NSw3IEBAIGVudW0gew0KPiA+ICAjZGVmaW5lIFRS
QU5TTEFURV9GQUlMIDENCj4gPiAgI2RlZmluZSBUUkFOU0xBVEVfU1VDQ0VTUyAwDQo+ID4gICNk
ZWZpbmUgTU1VX1VTRVJfSURYIDMNCj4gPiArI2RlZmluZSBUUkFOU0xBVEVfR19TVEFHRV9GQUlM
IDQNCj4gPg0KPiA+ICAjZGVmaW5lIE1BWF9SSVNDVl9QTVBTICgxNikNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jIGIvdGFyZ2V0L3Jpc2N2L2NwdV9oZWxw
ZXIuYw0KPiA+IGluZGV4IGZkMWQzNzNiNmYuLjE2MzViMDljNDEgMTAwNjQ0DQo+ID4gLS0tIGEv
dGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYw0KPiA+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHVfaGVs
cGVyLmMNCj4gPiBAQCAtNDQwLDcgKzQ0MCwxMCBAQCByZXN0YXJ0Og0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbW11X2lkeCwNCj4gZmFsc2Us
DQo+ID4gdHJ1ZSk7DQo+ID4NCj4gPiAgICAgICAgICAgICAgaWYgKHZiYXNlX3JldCAhPSBUUkFO
U0xBVEVfU1VDQ0VTUykgew0KPiA+IC0gICAgICAgICAgICAgICAgcmV0dXJuIHZiYXNlX3JldDsN
Cj4gPiArICAgICAgICAgICAgICAgIGVudi0+Z3Vlc3RfcGh5c19mYXVsdF9hZGRyID0gKGJhc2Ug
fA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGFk
ZHIgJg0KPiA+ICsNCj4gKFRBUkdFVF9QQUdFX1NJWkUgLQ0KPiA+ICsgMSkpKSA+PiAyOw0KPiAN
Cj4gQ2FuIHdlIHNldCBndWVzdF9waHlzX2ZhdWx0X2FkZHIgaW4gcmlzY3ZfY3B1X3RsYl9maWxs
KCkgaW5zdGVhZD8NCg0KSGkgQWxpc3RhaXIsDQoNCkl0J3Mgbm90IGVhc3kgdG8gZG8gdGhhdC4g
VGhlIGtleSBpcyB0aGF0IHRoZSB3cm9uZyBhZGRyZXNzKHRoZSBgYmFzZWAgdmFyaWFibGUpIGlz
IG5vdCB2aXNpYmxlIHRvIHJpc2N2X2NwdV90bGJfZmlsbCgpLg0KQmVjYXVzZSB0aGUgd3Jvbmcg
YWRkcmVzcyBtYXkgYmUgZnJvbSBhbnkgbGV2ZWwgb2YgUFRFIHdoaWNoIGNhbid0IGJlIGVhc2ls
eSBvYnRhaW5lZCBieSByaXNjdl9jcHVfdGxiX2ZpbGwoKS4NClRoZSBhbHRlcm5hdGl2ZSBpcyB0
byBhZGQgYW4gb3V0IHBhcmFtZXRlciBpbiBnZXRfcGh5c2ljYWxfYWRkcmVzcygpLiBCdXQgaXQg
aXMgbm90IGVpdGhlciBlbGVnYW50Lg0KV2hhdCBpcyB5b3VyIGFkdmljZT8NCg0KQmVzdCBSZWdh
cmRzLA0KWWlmZWkNCg0KPiANCj4gPiArICAgICAgICAgICAgICAgIHJldHVybiBUUkFOU0xBVEVf
R19TVEFHRV9GQUlMOw0KPiA+ICAgICAgICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgICAgICAg
cHRlX2FkZHIgPSB2YmFzZSArIGlkeCAqIHB0ZXNpemU7IEBAIC03MjgsMTIgKzczMSwxNyBAQA0K
PiA+IGJvb2wgcmlzY3ZfY3B1X3RsYl9maWxsKENQVVN0YXRlICpjcywgdmFkZHIgYWRkcmVzcywg
aW50IHNpemUsDQo+ID4gICAgICAgICAgcmV0ID0gZ2V0X3BoeXNpY2FsX2FkZHJlc3MoZW52LCAm
cGEsICZwcm90LCBhZGRyZXNzLA0KPiBhY2Nlc3NfdHlwZSwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBtbXVfaWR4LCB0cnVlLCB0cnVlKTsNCj4gPg0KPiA+ICsgICAg
ICAgIGlmIChyZXQgPT0gVFJBTlNMQVRFX0dfU1RBR0VfRkFJTCkgew0KPiA+ICsgICAgICAgICAg
ICBmaXJzdF9zdGFnZV9lcnJvciA9IGZhbHNlOw0KPiA+ICsgICAgICAgICAgICBhY2Nlc3NfdHlw
ZSA9IE1NVV9EQVRBX0xPQUQ7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgICBx
ZW11X2xvZ19tYXNrKENQVV9MT0dfTU1VLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIiVz
IDFzdC1zdGFnZSBhZGRyZXNzPSUiIFZBRERSX1BSSXggIg0KPiByZXQgJWQgcGh5c2ljYWwgIg0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgVEFSR0VUX0ZNVF9wbHggIiBwcm90ICVkXG4iLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGFkZHJlc3MsIHJldCwgcGEsIHBy
b3QpOw0KPiA+DQo+ID4gLSAgICAgICAgaWYgKHJldCAhPSBUUkFOU0xBVEVfRkFJTCkgew0KPiA+
ICsgICAgICAgIGlmIChyZXQgIT0gVFJBTlNMQVRFX0ZBSUwgJiYgcmV0ICE9IFRSQU5TTEFURV9H
X1NUQUdFX0ZBSUwpIHsNCj4gDQo+IE90aGVyd2lzZSB0aGlzIHBhdGNoIGxvb2tzIGNvcnJlY3Qu
DQo+IA0KPiBBbGlzdGFpcg0KPiANCj4gPiAgICAgICAgICAgICAgLyogU2Vjb25kIHN0YWdlIGxv
b2t1cCAqLw0KPiA+ICAgICAgICAgICAgICBpbV9hZGRyZXNzID0gcGE7DQo+ID4NCj4gPiAtLQ0K
PiA+IDIuMTkuMQ0KPiA+DQo+ID4NCj4gPg0K

