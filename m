Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54E2C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB5E22267
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB5E22267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXeGt-0000Zc-TC
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 01:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kXeFl-0008PT-1n; Wed, 28 Oct 2020 01:44:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kXeFh-0004uE-Si; Wed, 28 Oct 2020 01:44:08 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CLcvN2HVHz4xQk;
 Wed, 28 Oct 2020 13:44:00 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 28 Oct 2020 13:43:56 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0487.000;
 Wed, 28 Oct 2020 13:43:47 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [PATCH] target/ppc/excp_helper: Add a missing break for
 POWERPC_EXCP_HISI
Thread-Topic: [PATCH] target/ppc/excp_helper: Add a missing break for
 POWERPC_EXCP_HISI
Thread-Index: AQHWrOEhDVQBenQ31E2N25gfU+hXv6mr5Y4AgACauqA=
Date: Wed, 28 Oct 2020 05:43:46 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA0AE06@dggemm531-mbx.china.huawei.com>
References: <20201028041620.2168707-1-kuhn.chenqun@huawei.com>
 <20201028042758.GB5604@yekko.fritz.box>
In-Reply-To: <20201028042758.GB5604@yekko.fritz.box>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:43:58
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 ganqixin <ganqixin@huawei.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBHaWJzb24gW21haWx0
bzpkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXVdDQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2Jl
ciAyOCwgMjAyMCAxMjoyOCBQTQ0KPiBUbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBo
dWF3ZWkuY29tPg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LXRyaXZpYWxAbm9u
Z251Lm9yZzsgY2xnQGthb2Qub3JnOw0KPiBaaGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxp
YW5nQGh1YXdlaS5jb20+OyBnYW5xaXhpbg0KPiA8Z2FucWl4aW5AaHVhd2VpLmNvbT47IEV1bGVy
IFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0
YXJnZXQvcHBjL2V4Y3BfaGVscGVyOiBBZGQgYSBtaXNzaW5nIGJyZWFrIGZvcg0KPiBQT1dFUlBD
X0VYQ1BfSElTSQ0KPiANCj4gT24gV2VkLCBPY3QgMjgsIDIwMjAgYXQgMTI6MTY6MjBQTSArMDgw
MCwgQ2hlbiBRdW4gd3JvdGU6DQo+ID4gV2hlbiB1c2luZyAtV2ltcGxpY2l0LWZhbGx0aHJvdWdo
IGluIG91ciBDRkxBR1MsIHRoZSBjb21waWxlciBzaG93ZWQNCj4gd2FybmluZzoNCj4gPiAuLi90
YXJnZXQvcHBjL2V4Y3BfaGVscGVyLmM6IEluIGZ1bmN0aW9uIOKAmHBvd2VycGNfZXhjcOKAmToN
Cj4gPiAuLi90YXJnZXQvcHBjL2V4Y3BfaGVscGVyLmM6NTI5OjEzOiB3YXJuaW5nOiB0aGlzIHN0
YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoDQo+IFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4g
PiAgIDUyOSB8ICAgICAgICAgbXNyIHw9IGVudi0+ZXJyb3JfY29kZTsNCj4gPiAgICAgICB8ICAg
ICAgICAgfn5+fl5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+IC4uL3RhcmdldC9wcGMvZXhjcF9oZWxw
ZXIuYzo1MzA6NTogbm90ZTogaGVyZQ0KPiA+ICAgNTMwIHwgICAgIGNhc2UgUE9XRVJQQ19FWENQ
X0hERUNSOiAgICAgLyogSHlwZXJ2aXNvcg0KPiBkZWNyZW1lbnRlciBleGNlcHRpb24gICAgICAg
ICAqLw0KPiA+ICAgICAgIHwgICAgIF5+fn4NCj4gPg0KPiA+IEEgYnJlYWsgc3RhdGVtZW50IG1h
eSBiZSByZXF1aXJlZCB0byBlbnRlciB0aGlzIGV4Y2VwdGlvbi4NCj4gPg0KPiA+IFJlcG9ydGVk
LWJ5OiBFdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+IA0KPiBUaGlzIGNoYW5n
ZSBpcyBpbmNvcnJlY3QuICBXZSBkZWZpbml0ZWx5IG5lZWQgdGhlIGZhbGx0aHJvdWdoIHRvIHNl
dCBzcnJbMDFdDQo+IHByb3Blcmx5LiAgU28gdGhlIGNvcnJlY3QgZml4IGlzIHRvIGFubm90YXRl
IHRoZSBmYWxsdGhyb3VnaCwgbm90IHJlbW92ZSBpdC4NCj4gDQpPSywgSSdsbCBtb2RpZnkgaXQg
bGF0ZXIuDQonDQpUaGFua3MsDQpDaGVuIFF1bg0KPiA+DQo+ID4gLS0tDQo+ID4gSSBndWVzcyB0
aGVyZSdzIGEgYnJlYWsgbWlzc2luZyBpbiAnUE9XRVJQQ19FWENQX0hJU0knIGJyYW5jaCwganVz
dA0KPiA+IGxpa2UgdGhlICdQT1dFUlBDX0VYQ1BfSVNJJyBicmFuY2guDQo+ID4gLS0tDQo+ID4g
IHRhcmdldC9wcGMvZXhjcF9oZWxwZXIuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvcHBjL2V4Y3BfaGVscGVy
LmMgYi90YXJnZXQvcHBjL2V4Y3BfaGVscGVyLmMgaW5kZXgNCj4gPiBhOTg4YmExNWY0Li41ZTY5
YWMxYjMzIDEwMDY0NA0KPiA+IC0tLSBhL3RhcmdldC9wcGMvZXhjcF9oZWxwZXIuYw0KPiA+ICsr
KyBiL3RhcmdldC9wcGMvZXhjcF9oZWxwZXIuYw0KPiA+IEBAIC01MjcsNiArNTI3LDcgQEAgc3Rh
dGljIGlubGluZSB2b2lkIHBvd2VycGNfZXhjcChQb3dlclBDQ1BVICpjcHUsDQo+IGludCBleGNw
X21vZGVsLCBpbnQgZXhjcCkNCj4gPiAgICAgICAgICBicmVhazsNCj4gPiAgICAgIGNhc2UgUE9X
RVJQQ19FWENQX0hJU0k6ICAgICAgLyogSHlwZXJ2aXNvciBpbnN0cnVjdGlvbiBzdG9yYWdlDQo+
IGV4Y2VwdGlvbiAqLw0KPiA+ICAgICAgICAgIG1zciB8PSBlbnYtPmVycm9yX2NvZGU7DQo+ID4g
KyAgICAgICAgYnJlYWs7DQo+ID4gICAgICBjYXNlIFBPV0VSUENfRVhDUF9IREVDUjogICAgIC8q
IEh5cGVydmlzb3IgZGVjcmVtZW50ZXINCj4gZXhjZXB0aW9uICAgICAgICAgKi8NCj4gPiAgICAg
IGNhc2UgUE9XRVJQQ19FWENQX0hEU0k6ICAgICAgLyogSHlwZXJ2aXNvciBkYXRhIHN0b3JhZ2UN
Cj4gZXhjZXB0aW9uICAgICAgICAqLw0KPiA+ICAgICAgY2FzZSBQT1dFUlBDX0VYQ1BfSERTRUc6
ICAgICAvKiBIeXBlcnZpc29yIGRhdGEgc2VnbWVudA0KPiBleGNlcHRpb24gICAgICAgICovDQo+
IA0KPiAtLQ0KPiBEYXZpZCBHaWJzb24JCQl8IEknbGwgaGF2ZSBteSBtdXNpYyBiYXJvcXVlLCBh
bmQgbXkgY29kZQ0KPiBkYXZpZCBBVCBnaWJzb24uZHJvcGJlYXIuaWQuYXUJfCBtaW5pbWFsaXN0
LCB0aGFuayB5b3UuICBOT1QgX3RoZV8NCj4gX290aGVyXw0KPiAJCQkJfCBfd2F5XyBfYXJvdW5k
XyENCj4gaHR0cDovL3d3dy5vemxhYnMub3JnL35kZ2lic29uDQo=

