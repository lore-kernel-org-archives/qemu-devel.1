Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D30C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 02:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D53320752
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 02:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D53320752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF7Mb-0003ZZ-94
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 22:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jF7Lw-000334-Q9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 22:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jF7Lv-00021t-Je
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 22:25:40 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2078 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jF7Lv-0001sV-84; Thu, 19 Mar 2020 22:25:39 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 71F7EE67EEDC492CD667;
 Fri, 20 Mar 2020 10:25:29 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.221]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0439.000;
 Fri, 20 Mar 2020 10:25:23 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v3] block/iscsi:use the flags in iscsi_open() prevent
 Clang warning
Thread-Topic: [PATCH v3] block/iscsi:use the flags in iscsi_open() prevent
 Clang warning
Thread-Index: AQHV91VRoTJjKENIM0yjt9fTbzvVVKhQzWiQ
Date: Fri, 20 Mar 2020 02:25:23 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6A4539@dggemm531-mbx.china.huawei.com>
References: <20200311032927.35092-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20200311032927.35092-1-kuhn.chenqun@huawei.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, Peter Lieven <pl@kamp.de>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

R2VudGxlIHBpbmcuDQoNCkFueSBvdGhlciBzdWdnZXN0aW9ucyBhYm91dCB0aGlzPw0KDQpUaGFu
a3MuDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW5xdW4gKGt1aG4p
DQo+U2VudDogV2VkbmVzZGF5LCBNYXJjaCAxMSwgMjAyMCAxMToyOSBBTQ0KPlRvOiBxZW11LWRl
dmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUub3JnDQo+Q2M6IFpoYW5naGFpbGlh
bmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IENoZW5xdW4gKGt1aG4pDQo+PGt1
aG4uY2hlbnF1bkBodWF3ZWkuY29tPjsgRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5j
b20+Ow0KPktldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+OyBSb25uaWUgU2FobGJlcmcNCj48
cm9ubmllc2FobGJlcmdAZ21haWwuY29tPjsgUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT47IFBldGVyDQo+TGlldmVuIDxwbEBrYW1wLmRlPjsgTWF4IFJlaXR6IDxtcmVpdHpAcmVk
aGF0LmNvbT47IExhdXJlbnQgVml2aWVyDQo+PGxhdXJlbnRAdml2aWVyLmV1Pg0KPlN1YmplY3Q6
IFtQQVRDSCB2M10gYmxvY2svaXNjc2k6dXNlIHRoZSBmbGFncyBpbiBpc2NzaV9vcGVuKCkgcHJl
dmVudCBDbGFuZw0KPndhcm5pbmcNCj4NCj5DbGFuZyBzdGF0aWMgY29kZSBhbmFseXplciBzaG93
IHdhcm5pbmc6DQo+ICBibG9jay9pc2NzaS5jOjE5MjA6OTogd2FybmluZzogVmFsdWUgc3RvcmVk
IHRvICdmbGFncycgaXMgbmV2ZXIgcmVhZA0KPiAgICAgICAgZmxhZ3MgJj0gfkJEUlZfT19SRFdS
Ow0KPiAgICAgICAgXiAgICAgICAgfn5+fn5+fn5+fn5+DQo+DQo+SW4gaXNjc2lfYWxsb2NtYXBf
aW5pdCgpIG9ubHkgY2hlY2tzIEJEUlZfT19OT0NBQ0hFLCB3aGljaCBpcyB0aGUgc2FtZSBpbg0K
PmJvdGggb2YgZmxhZ3MgYW5kIGJzLT5vcGVuX2ZsYWdzLg0KPldlIGNhbiB1c2UgdGhlIGZsYWdz
IGluc3RlYWQgYnMtPm9wZW5fZmxhZ3MgdG8gcHJldmVudCBDbGFuZyB3YXJuaW5nLg0KPg0KPlJl
cG9ydGVkLWJ5OiBFdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj5TaWduZWQt
b2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+UmV2aWV3ZWQtYnk6
IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+DQo+LS0tDQo+Q2M6IFJvbm5pZSBTYWhsYmVy
ZyA8cm9ubmllc2FobGJlcmdAZ21haWwuY29tPg0KPkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemlu
aUByZWRoYXQuY29tPg0KPkNjOiBQZXRlciBMaWV2ZW4gPHBsQGthbXAuZGU+DQo+Q2M6IEtldmlu
IFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+DQo+Q2M6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5j
b20+DQo+Q2M6IExhdXJlbnQgVml2aWVyIDxsYXVyZW50QHZpdmllci5ldT4NCj4NCj52MS0+djI6
DQo+IEtlZXAgdGhlICdmbGFncycgdGhlbiB1c2UgaXQoQmFzZSBvbiBLZXZpbidzIGNvbW1lbnRz
KS4NCj4NCj52Mi0+djM6DQo+IE1vZGlmeSBzdWJqZWN0IGFuZCBjb21taXQgbWVzc2FnZXMoQmFz
ZSBvbiBLZXZpbidzIGFuZCBMYXVyZW50J3MNCj5jb21tZW50cykuDQo+LS0tDQo+IGJsb2NrL2lz
Y3NpLmMgfCAyICstDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPg0KPmRpZmYgLS1naXQgYS9ibG9jay9pc2NzaS5jIGIvYmxvY2svaXNjc2kuYyBpbmRl
eCA2ODJhYmQ4ZTA5Li41MGJhZTUxNzAwIDEwMDY0NA0KPi0tLSBhL2Jsb2NrL2lzY3NpLmMNCj4r
KysgYi9ibG9jay9pc2NzaS5jDQo+QEAgLTIwMDIsNyArMjAwMiw3IEBAIHN0YXRpYyBpbnQgaXNj
c2lfb3BlbihCbG9ja0RyaXZlclN0YXRlICpicywgUURpY3QNCj4qb3B0aW9ucywgaW50IGZsYWdz
LA0KPiAgICAgICAgIGlzY3NpbHVuLT5jbHVzdGVyX3NpemUgPSBpc2NzaWx1bi0+Ymwub3B0X3Vu
bWFwX2dyYW4gKg0KPiAgICAgICAgICAgICBpc2NzaWx1bi0+YmxvY2tfc2l6ZTsNCj4gICAgICAg
ICBpZiAoaXNjc2lsdW4tPmxicHJ6KSB7DQo+LSAgICAgICAgICAgIHJldCA9IGlzY3NpX2FsbG9j
bWFwX2luaXQoaXNjc2lsdW4sIGJzLT5vcGVuX2ZsYWdzKTsNCj4rICAgICAgICAgICAgcmV0ID0g
aXNjc2lfYWxsb2NtYXBfaW5pdChpc2NzaWx1biwgZmxhZ3MpOw0KPiAgICAgICAgIH0NCj4gICAg
IH0NCj4NCj4tLQ0KPjIuMjMuMA0KPg0KDQo=

