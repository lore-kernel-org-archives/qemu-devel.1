Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AE3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA36320870
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA36320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGi4U-0003xn-Pl
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGi3a-0003Os-DR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGi3Z-0004C5-79
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:49:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2080 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jGi3Y-00049x-S0; Tue, 24 Mar 2020 07:49:17 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 13BEF8FCEEAEE8E4FBC8;
 Tue, 24 Mar 2020 19:49:10 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.202]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0487.000;
 Tue, 24 Mar 2020 19:49:02 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v4 2/3] display/blizzard: Remove redundant statement in
 blizzard_draw_line16_32()
Thread-Topic: [PATCH v4 2/3] display/blizzard: Remove redundant statement in
 blizzard_draw_line16_32()
Thread-Index: AQHWAbVx/A3Wg4UYH0Gv6GR7DLfPXKhW5cyAgAAAagCAAKfykA==
Date: Tue, 24 Mar 2020 11:49:00 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6BF710@dggemm511-mbx.china.huawei.com>
References: <20200324082235.27980-1-kuhn.chenqun@huawei.com>
 <20200324082235.27980-3-kuhn.chenqun@huawei.com>
 <aff5ca8a-af20-a3ba-4354-5c203a9eea81@vivier.eu>
 <a3798e7d-702b-3da8-bde2-f5b920d89feb@vivier.eu>
In-Reply-To: <a3798e7d-702b-3da8-bde2-f5b920d89feb@vivier.eu>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.205.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.189
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "philmd@redhat.com" <philmd@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF1cmVudCBWaXZpZXIgW21haWx0
bzpsYXVyZW50QHZpdmllci5ldV0NCj5TZW50OiBUdWVzZGF5LCBNYXJjaCAyNCwgMjAyMCA0OjQw
IFBNDQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT47IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZzsNCj5xZW11LXRyaXZpYWxAbm9uZ251Lm9yZw0KPkNjOiBaaGFuZ2hh
aWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBwaGlsbWRAcmVkaGF0LmNv
bTsNCj5FdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT47IEFuZHJ6ZWogWmFib3Jv
d3NraQ0KPjxiYWxyb2dnQGdtYWlsLmNvbT47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvM10gZGlzcGxheS9ibGl6emFy
ZDogUmVtb3ZlIHJlZHVuZGFudCBzdGF0ZW1lbnQgaW4NCj5ibGl6emFyZF9kcmF3X2xpbmUxNl8z
MigpDQo+DQo+TGUgMjQvMDMvMjAyMCDDoCAwOTozOCwgTGF1cmVudCBWaXZpZXIgYSDDqWNyaXTC
oDoNCj4+IExlIDI0LzAzLzIwMjAgw6AgMDk6MjIsIENoZW4gUXVuIGEgw6ljcml0wqA6DQo+Pj4g
Q2xhbmcgc3RhdGljIGNvZGUgYW5hbHl6ZXIgc2hvdyB3YXJuaW5nOg0KPj4+ICAgaHcvZGlzcGxh
eS9ibGl6emFyZC5jOjk0MDo5OiB3YXJuaW5nOiBWYWx1ZSBzdG9yZWQgdG8gJ2RhdGEnIGlzIG5l
dmVyIHJlYWQNCj4+PiAgICAgICAgIGRhdGEgPj49IDU7DQo+Pj4gICAgICAgICBeICAgICAgICB+
DQo+Pj4gUmVwb3J0ZWQtYnk6IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4+
PiAtLS0NCj4+PiBDYzogQW5kcnplaiBaYWJvcm93c2tpIDxiYWxyb2dnQGdtYWlsLmNvbT4NCj4+
PiBDYzogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPj4+IC0tLQ0K
Pj4+ICBody9kaXNwbGF5L2JsaXp6YXJkLmMgfCAxIC0NCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDEg
ZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody9kaXNwbGF5L2JsaXp6YXJkLmMg
Yi9ody9kaXNwbGF5L2JsaXp6YXJkLmMgaW5kZXgNCj4+PiAzNTllMzk5YzJhLi42MjUxN2JkZjc1
IDEwMDY0NA0KPj4+IC0tLSBhL2h3L2Rpc3BsYXkvYmxpenphcmQuYw0KPj4+ICsrKyBiL2h3L2Rp
c3BsYXkvYmxpenphcmQuYw0KPj4+IEBAIC05MzcsNyArOTM3LDYgQEAgc3RhdGljIHZvaWQgYmxp
enphcmRfZHJhd19saW5lMTZfMzIodWludDMyX3QgKmRlc3QsDQo+Pj4gICAgICAgICAgZyA9IChk
YXRhICYgMHgzZikgPDwgMjsNCj4+PiAgICAgICAgICBkYXRhID4+PSA2Ow0KPj4+ICAgICAgICAg
IHIgPSAoZGF0YSAmIDB4MWYpIDw8IDM7DQo+Pj4gLSAgICAgICAgZGF0YSA+Pj0gNTsNCj4+PiAg
ICAgICAgICAqZGVzdCsrID0gcmdiX3RvX3BpeGVsMzIociwgZywgYik7DQo+Pj4gICAgICB9DQo+
Pj4gIH0NCj4+Pg0KPj4NCj4+IFBlcmhhcHMgaXQgd291bGQgYmUgY2xlYXJlciB0byB1c2UgZXh0
cmFjdDMyKCkgdG8gY29tcHV0ZSByLCBnIGFuZCBiPw0KPg0KPmluIGZhY3QgZXh0cmFjdDE2KCkg
YXMgZGF0YSBpcyB1aW50MTZfdC4uLg0KDQpHb29kIFBvaW50LCBJIHdpbGwgdXBkYXRlIGl0IG5l
eHQgdmVyaXNvbi4NCg0KVGhhbmtzLg0K

