Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A63C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 02:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B4D22255
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 02:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B4D22255
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSsdr-0003rJ-Fi
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 22:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kSscP-0003NW-Tl; Wed, 14 Oct 2020 22:03:49 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2983 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kSscN-0001hh-HB; Wed, 14 Oct 2020 22:03:49 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 2C2ED579A1C55DF5AC15;
 Thu, 15 Oct 2020 10:03:40 +0800 (CST)
Received: from dggpemm000002.china.huawei.com (7.185.36.174) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 15 Oct 2020 10:03:39 +0800
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggpemm000002.china.huawei.com (7.185.36.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 15 Oct 2020 10:03:39 +0800
Received: from dggpemm000001.china.huawei.com ([7.185.36.245]) by
 dggpemm000001.china.huawei.com ([7.185.36.245]) with mapi id 15.01.1913.007;
 Thu, 15 Oct 2020 10:03:39 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Alistair Francis <alistair23@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: RE: [PATCH V2 1/5] target/riscv: Add basic vmstate description of CPU
Thread-Topic: [PATCH V2 1/5] target/riscv: Add basic vmstate description of CPU
Thread-Index: AQHWntxJ5AggHdvtL0uIIsQkOTs3q6mQTSIAgAab+aD//9UhAIAAOdOAgAD4FBA=
Date: Thu, 15 Oct 2020 02:03:39 +0000
Message-ID: <476a5e7d98994bbca642ea8aa4cd141a@huawei.com>
References: <20201010080623.768-1-jiangyifei@huawei.com>
 <20201010080623.768-2-jiangyifei@huawei.com>
 <0bc022ca-35f6-8579-51f1-65005e89a9a3@linaro.org>
 <cbbaee32aaca498294e599ba7768279a@huawei.com>
 <0d4fa7cd-b534-5635-302a-6ef0c4b8426a@linaro.org>
 <CAKmqyKPcK9jKCF4VrVsSuPMpTJXjkOdhmRc0jPqkFVyRLA1qUQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPcK9jKCF4VrVsSuPMpTJXjkOdhmRc0jPqkFVyRLA1qUQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.47]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=jiangyifei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 22:03:41
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>,
 "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>,
 yinyipeng <yinyipeng1@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "Wubin \(H\)" <wu.wubin@huawei.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsaXN0YWlyIEZyYW5jaXMg
W21haWx0bzphbGlzdGFpcjIzQGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
MTUsIDIwMjAgMzoxMiBBTQ0KPiBUbzogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmc+DQo+IENjOiBKaWFuZ3lpZmVpIDxqaWFuZ3lpZmVpQGh1YXdlaS5jb20+
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZzsgWmhhbmdo
YWlsaWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsNCj4gc2FnYXJrQGVlY3Mu
YmVya2VsZXkuZWR1OyBrYmFzdGlhbkBtYWlsLnVuaS1wYWRlcmJvcm4uZGU7IFpoYW5neGlhb2Zl
bmcNCj4gKEYpIDx2aWN0b3Iuemhhbmd4aWFvZmVuZ0BodWF3ZWkuY29tPjsgQWxpc3RhaXIuRnJh
bmNpc0B3ZGMuY29tOyB5aW55aXBlbmcNCj4gPHlpbnlpcGVuZzFAaHVhd2VpLmNvbT47IHBhbG1l
ckBkYWJiZWx0LmNvbTsgV3ViaW4gKEgpDQo+IDx3dS53dWJpbkBodWF3ZWkuY29tPjsgZGVuZ2th
aSAoQSkgPGRlbmdrYWkxQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMS81
XSB0YXJnZXQvcmlzY3Y6IEFkZCBiYXNpYyB2bXN0YXRlIGRlc2NyaXB0aW9uIG9mIENQVQ0KPiAN
Cj4gT24gV2VkLCBPY3QgMTQsIDIwMjAgYXQgODo0NSBBTSBSaWNoYXJkIEhlbmRlcnNvbg0KPiA8
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiAxMC8xNC8y
MCAzOjIxIEFNLCBKaWFuZ3lpZmVpIHdyb3RlOg0KPiA+ID4+IFdvdWxkIHRoaXMgYmUgYSBnb29k
IHRpbWUgdG8gZXhwYW5kIG1zdGF0dXMgdG8gdWludDY0X3QgaW5zdGVhZCBvZg0KPiA+ID4+IHRh
cmdldF91bG9uZyBzbyB0aGF0IGl0IGNhbiBiZSBzYXZlZCBhcyBvbmUgdW5pdCBhbmQgcmVkdWNl
IHNvbWUNCj4gPiA+PiBpZmRlZnMgaW4gdGhlIGNvZGUgYmFzZT8NCj4gPiA+Pg0KPiA+ID4+IFNp
bWlsYXJseSB3aXRoIHNvbWUgb2YgdGhlIG90aGVyIHN0YXR1cyByZWdpc3RlcnMgdGhhdCBhcmUg
dHdvDQo+ID4gPj4gaGFsdmVkIGZvciByaXNjdjMyLg0KPiA+ID4NCj4gPiA+IEkgYWdyZWUgd2l0
aCB5b3UgdGhhdCBpdCBzaG91bGQgYmUgcmVhcnJhbmdlZC4NCj4gPiA+IEJ1dCBJIGhvcGUgdGhp
cyBzZXJpZXMgd2lsbCBmb2N1cyBvbiBhY2hpZXZpbmcgbWlncmF0aW9uLg0KPiA+ID4gQ2FuIEkg
c2VuZCBhbm90aGVyIHBhdGNoIHRvIHJlYXJyYW5nZSBpdCBsYXRlcj8NCj4gPg0KPiA+IFdlbGws
IHRoYXQgY2hhbmdlcyB0aGUgYml0IGxheW91dCBmb3IgbWlncmF0aW9uLg0KPiA+IFdoaWxlIHdl
IGNvdWxkIGJ1bXAgdGhlIHZlcnNpb24gbnVtYmVyLCBpdCBzZWVtZWQgZWFzaWVyIHRvIGNoYW5n
ZSB0aGUNCj4gPiByZXByZXNlbnRhdGlvbiBmaXJzdC4NCj4gDQo+ICsxIGl0IHdvdWxkIGJlIGdy
ZWF0IHRvIGNvbnNvbGlkYXRlIHRoZXNlLg0KPiANCj4gQWxpc3RhaXINCj4gDQoNCk9LLiBJIHdp
bGwgY2hhbmdlIHRoaXMgaW4gdGhlIG5leHQgc2VyaWVzLg0KDQpZaWZlaQ0KDQo+ID4NCj4gPg0K
PiA+IHJ+DQo+ID4NCg==

