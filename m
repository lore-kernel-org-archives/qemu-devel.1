Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C07C4BA35
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A73E208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A73E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j78K7-0003gM-DS
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 20:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j78JU-0003CM-Ph
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j78JT-0000Yx-GD
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:50:08 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2506 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j78JT-0000Ti-5t; Wed, 26 Feb 2020 20:50:07 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 2A28962E71BFD1CE1EF5;
 Thu, 27 Feb 2020 09:50:01 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0439.000;
 Thu, 27 Feb 2020 09:49:51 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: RE: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
 iscsi_open()
Thread-Topic: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
 iscsi_open()
Thread-Index: AQHV7IFlkw7HklI9YUytmY61YTlYXagstmsAgAGL6HA=
Date: Thu, 27 Feb 2020 01:49:50 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6638BE@dggemm531-mbx.china.huawei.com>
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-3-kuhn.chenqun@huawei.com>
 <20200226095444.GB6096@linux.fritz.box>
In-Reply-To: <20200226095444.GB6096@linux.fritz.box>
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
X-Received-From: 45.249.212.188
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS2V2aW4gV29sZiBbbWFpbHRvOmt3
b2xmQHJlZGhhdC5jb21dDQo+U2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNiwgMjAyMCA1OjU1
IFBNDQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj5DYzog
cWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZzsNCj5wZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc7IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVh
d2VpLmNvbT47DQo+RXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+OyBSb25uaWUg
U2FobGJlcmcNCj48cm9ubmllc2FobGJlcmdAZ21haWwuY29tPjsgUGFvbG8gQm9uemluaSA8cGJv
bnppbmlAcmVkaGF0LmNvbT47IFBldGVyDQo+TGlldmVuIDxwbEBrYW1wLmRlPjsgTWF4IFJlaXR6
IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzEzXSBibG9j
ay9pc2NzaTpSZW1vdmUgcmVkdW5kYW50IHN0YXRlbWVudCBpbg0KPmlzY3NpX29wZW4oKQ0KPg0K
PkFtIDI2LjAyLjIwMjAgdW0gMDk6NDYgaGF0IGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tIGdlc2No
cmllYmVuOg0KPj4gRnJvbTogQ2hlbiBRdW4gPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0KPj4N
Cj4+IENsYW5nIHN0YXRpYyBjb2RlIGFuYWx5emVyIHNob3cgd2FybmluZzoNCj4+ICAgYmxvY2sv
aXNjc2kuYzoxOTIwOjk6IHdhcm5pbmc6IFZhbHVlIHN0b3JlZCB0byAnZmxhZ3MnIGlzIG5ldmVy
IHJlYWQNCj4+ICAgICAgICAgZmxhZ3MgJj0gfkJEUlZfT19SRFdSOw0KPj4gICAgICAgICBeICAg
ICAgICB+fn5+fn5+fn5+fn4NCj4+DQo+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVy
LnJvYm90QGh1YXdlaS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVu
cXVuQGh1YXdlaS5jb20+DQo+DQo+SG1tLCBJJ20gbm90IHNvIHN1cmUgYWJvdXQgdGhpcyBvbmUg
YmVjYXVzZSBpZiB3ZSByZW1vdmUgdGhlIGxpbmUsIGZsYWdzIHdpbGwNCj5iZSBpbmNvbnNpc3Rl
bnQgd2l0aCBicy0+b3Blbl9mbGFncy4gSXQgZmVlbHMgbGlrZSBzZXR0aW5nIGEgdHJhcCBmb3Ig
YW55b25lDQo+d2hvIHdhbnRzIHRvIGFkZCBjb2RlIHVzaW5nIGZsYWdzIGluIHRoZSBmdXR1cmUu
DQpIaSBLZXZpbiwgIA0KSSBmaW5kIGl0IGV4aXN0cyBzaW5jZSA4ZjNiZjUwZDM0MDM3MjY2LiAg
IDogICkgIA0KSXQncyBub3QgYSBiaWcgZGVhbCwgIGp1c3QgdXBzZXQgY2xhbmcgc3RhdGljIGNv
ZGUgYW5hbHl6ZXIuIA0KQXMgeW91IHNhaWQsIGl0IGNvdWxkIGJlIGEgdHJhcCBmb3IgdGhlIGZ1
dHVyZS4gDQoNCkl0IOKAmXMgb2theSwgd2hldGhlciBpdCBleGlzdHMgb3Igbm90Lg0KDQpUaGFu
a3MuDQo+DQo+S2V2aW4NCj4NCj4+IENjOiBSb25uaWUgU2FobGJlcmcgPHJvbm5pZXNhaGxiZXJn
QGdtYWlsLmNvbT4NCj4+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0K
Pj4gQ2M6IFBldGVyIExpZXZlbiA8cGxAa2FtcC5kZT4NCj4+IENjOiBLZXZpbiBXb2xmIDxrd29s
ZkByZWRoYXQuY29tPg0KPj4gQ2M6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+PiAt
LS0NCj4+ICBibG9jay9pc2NzaS5jIHwgMSAtDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRp
b24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svaXNjc2kuYyBiL2Jsb2NrL2lzY3NpLmMg
aW5kZXgNCj4+IDY4MmFiZDhlMDkuLmVkODg0NzllZGUgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9p
c2NzaS5jDQo+PiArKysgYi9ibG9jay9pc2NzaS5jDQo+PiBAQCAtMTkxNyw3ICsxOTE3LDYgQEAg
c3RhdGljIGludCBpc2NzaV9vcGVuKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBRRGljdA0KPipvcHRp
b25zLCBpbnQgZmxhZ3MsDQo+PiAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4gICAgICAgICAg
ICAgIGdvdG8gb3V0Ow0KPj4gICAgICAgICAgfQ0KPj4gLSAgICAgICAgZmxhZ3MgJj0gfkJEUlZf
T19SRFdSOw0KPj4gICAgICB9DQo+Pg0KPj4gICAgICBpc2NzaV9yZWFkY2FwYWNpdHlfc3luYyhp
c2NzaWx1biwgJmxvY2FsX2Vycik7DQo+PiAtLQ0KPj4gMi4yMy4wDQo+Pg0KPj4NCg0K

