Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC6FC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BC021655
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BC021655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBqkO-0006kZ-4t
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBqjf-0005eK-Bv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBqjd-00066a-S5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:04:39 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:54368 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jBqjd-00063p-HJ; Tue, 10 Mar 2020 22:04:37 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id B0C4E3FEF1247CDBBA9C;
 Wed, 11 Mar 2020 10:04:31 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Mar 2020 10:04:31 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.115]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0439.000;
 Wed, 11 Mar 2020 10:04:24 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>, Kevin Wolf <kwolf@redhat.com>
Subject: RE: [PATCH v3 02/12] block/iscsi:Remove redundant statement in
 iscsi_open()
Thread-Topic: [PATCH v3 02/12] block/iscsi:Remove redundant statement in
 iscsi_open()
Thread-Index: AQHV8JOViwMsZBXmC0qleQnSjROZKqhBaHEAgAAKAQCAAT02sA==
Date: Wed, 11 Mar 2020 02:04:23 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B683E5E@dggemm511-mbx.china.huawei.com>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
 <20200302130715.29440-4-kuhn.chenqun@huawei.com>
 <20200310142614.GF6926@linux.fritz.box>
 <a1ed92ff-4842-c437-4e22-a94c46760cc0@vivier.eu>
In-Reply-To: <a1ed92ff-4842-c437-4e22-a94c46760cc0@vivier.eu>
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
X-Received-From: 45.249.212.255
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF1cmVudCBWaXZpZXIgW21haWx0
bzpsYXVyZW50QHZpdmllci5ldV0NCj5TZW50OiBUdWVzZGF5LCBNYXJjaCAxMCwgMjAyMCAxMTow
MiBQTQ0KPlRvOiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgQ2hlbnF1biAoa3VobikN
Cj48a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+Q2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9y
ZzsgWmhhbmdoYWlsaWFuZw0KPjx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBxZW11
LXRyaXZpYWxAbm9uZ251Lm9yZzsgUGV0ZXIgTGlldmVuDQo+PHBsQGthbXAuZGU+OyBxZW11LWRl
dmVsQG5vbmdudS5vcmc7IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+Ow0KPlJvbm5pZSBT
YWhsYmVyZyA8cm9ubmllc2FobGJlcmdAZ21haWwuY29tPjsgRXVsZXIgUm9ib3QNCj48ZXVsZXIu
cm9ib3RAaHVhd2VpLmNvbT47IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAwMi8xMl0gYmxvY2svaXNjc2k6UmVtb3ZlIHJlZHVuZGFu
dCBzdGF0ZW1lbnQgaW4NCj5pc2NzaV9vcGVuKCkNCj4NCj5MZSAxMC8wMy8yMDIwIMOgIDE1OjI2
LCBLZXZpbiBXb2xmIGEgw6ljcml0wqA6DQo+PiBBbSAwMi4wMy4yMDIwIHVtIDE0OjA3IGhhdCBD
aGVuIFF1biBnZXNjaHJpZWJlbjoNCj4+PiBDbGFuZyBzdGF0aWMgY29kZSBhbmFseXplciBzaG93
IHdhcm5pbmc6DQo+Pj4gICBibG9jay9pc2NzaS5jOjE5MjA6OTogd2FybmluZzogVmFsdWUgc3Rv
cmVkIHRvICdmbGFncycgaXMgbmV2ZXIgcmVhZA0KPj4+ICAgICAgICAgZmxhZ3MgJj0gfkJEUlZf
T19SRFdSOw0KPj4+ICAgICAgICAgXiAgICAgICAgfn5+fn5+fn5+fn5+DQo+Pj4NCj4+PiBSZXBv
cnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogQ2hlbiBRdW4gPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0KPj4+IC0tLQ0KPj4+
IENjOiBSb25uaWUgU2FobGJlcmcgPHJvbm5pZXNhaGxiZXJnQGdtYWlsLmNvbT4NCj4+PiBDYzog
UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4+PiBDYzogUGV0ZXIgTGlldmVu
IDxwbEBrYW1wLmRlPg0KPj4+IENjOiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPj4+
IENjOiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPj4+DQo+Pj4gdjEtPnYyOg0KPj4+
ICBLZWVwIHRoZSAnZmxhZ3MnIHRoZW4gdXNlIGl0KEJhc2Ugb24gS2V2aW4ncyBjb21tZW50cyku
DQo+Pg0KPj4gSSB0aGluayB0aGlzIHBhdGNoIHdhbnRzIGEgZGlmZmVyZW50IHN1YmplY3QgbGlu
ZSBub3cuDQo+DQpZZXMsICBpdCBuZWVkcyBhIG1vcmUgYXBwcm9wcmlhdGUgc3ViamVjdC4NCg0K
Pkl0IG5lZWRzIGFsc28gYSBiZXR0ZXIgZXhwbGFuYXRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdl
IGFuZCBzaG91bGQgbm90IGdvDQo+dGhyb3VnaCB0cml2aWFsIGFzIHRoZSBjaGFuZ2UgaXMgbm90
IG9idmlvdXMuDQo+DQpPSyAsIEkgd2lsbCB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIGJhc2Ug
b24gZXhpc3RpbmcgY29tbWVudHMuDQoNClRoYW5rcy4NCg0KPlRoYW5rcywNCj5MYXVyZW50DQo+
DQo+Pg0KPj4+IGRpZmYgLS1naXQgYS9ibG9jay9pc2NzaS5jIGIvYmxvY2svaXNjc2kuYyBpbmRl
eA0KPj4+IDY4MmFiZDhlMDkuLjUwYmFlNTE3MDAgMTAwNjQ0DQo+Pj4gLS0tIGEvYmxvY2svaXNj
c2kuYw0KPj4+ICsrKyBiL2Jsb2NrL2lzY3NpLmMNCj4+PiBAQCAtMjAwMiw3ICsyMDAyLDcgQEAg
c3RhdGljIGludCBpc2NzaV9vcGVuKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBRRGljdA0KPipvcHRp
b25zLCBpbnQgZmxhZ3MsDQo+Pj4gICAgICAgICAgaXNjc2lsdW4tPmNsdXN0ZXJfc2l6ZSA9IGlz
Y3NpbHVuLT5ibC5vcHRfdW5tYXBfZ3JhbiAqDQo+Pj4gICAgICAgICAgICAgIGlzY3NpbHVuLT5i
bG9ja19zaXplOw0KPj4+ICAgICAgICAgIGlmIChpc2NzaWx1bi0+bGJwcnopIHsNCj4+PiAtICAg
ICAgICAgICAgcmV0ID0gaXNjc2lfYWxsb2NtYXBfaW5pdChpc2NzaWx1biwgYnMtPm9wZW5fZmxh
Z3MpOw0KPj4+ICsgICAgICAgICAgICByZXQgPSBpc2NzaV9hbGxvY21hcF9pbml0KGlzY3NpbHVu
LCBmbGFncyk7DQo+Pj4gICAgICAgICAgfQ0KPj4+ICAgICAgfQ0KPj4NCj4+IFRoZSBjb2RlIGxv
b2tzIGdvb2QuDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5j
b20+DQo+Pg0KPj4NCg0K

