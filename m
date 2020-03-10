Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44FBC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BE42464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BE42464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdRW-0003zg-So
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBdQx-0003MM-BK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBdQu-0001wV-1U
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:52:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2508 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jBdQt-0001cN-Lk; Tue, 10 Mar 2020 07:52:23 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 5F123583ED6FED16B8BF;
 Tue, 10 Mar 2020 19:52:18 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.115]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0439.000;
 Tue, 10 Mar 2020 19:52:11 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v3 04/12] scsi/esp-pci: Remove redundant statement in
 esp_pci_io_write()
Thread-Topic: [PATCH v3 04/12] scsi/esp-pci: Remove redundant statement in
 esp_pci_io_write()
Thread-Index: AQHV8JOVS578ZhzbJE28CpTx6OhzAqg/s18AgAHkKuA=
Date: Tue, 10 Mar 2020 11:52:11 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B681D85@dggemm511-mbx.china.huawei.com>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
 <20200302130715.29440-6-kuhn.chenqun@huawei.com>
 <111d4416-2281-6f8d-9b1d-66e60a05e02a@vivier.eu>
In-Reply-To: <111d4416-2281-6f8d-9b1d-66e60a05e02a@vivier.eu>
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF1cmVudCBWaXZpZXIgW21haWx0
bzpsYXVyZW50QHZpdmllci5ldV0NCj5TZW50OiBNb25kYXksIE1hcmNoIDksIDIwMjAgODoyMiBQ
TQ0KPlRvOiBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+OyBxZW11LQ0K
PmRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUub3JnDQo+Q2M6IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+Ow0K
PlpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IFBhb2xvIEJv
bnppbmkNCj48cGJvbnppbmlAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA0
LzEyXSBzY3NpL2VzcC1wY2k6IFJlbW92ZSByZWR1bmRhbnQgc3RhdGVtZW50IGluDQo+ZXNwX3Bj
aV9pb193cml0ZSgpDQo+DQo+TGUgMDIvMDMvMjAyMCDDoCAxNDowNywgQ2hlbiBRdW4gYSDDqWNy
aXTCoDoNCj4+IENsYW5nIHN0YXRpYyBjb2RlIGFuYWx5emVyIHNob3cgd2FybmluZzoNCj4+ICAg
aHcvc2NzaS9lc3AtcGNpLmM6MTk4Ojk6IHdhcm5pbmc6IFZhbHVlIHN0b3JlZCB0byAnc2l6ZScg
aXMgbmV2ZXIgcmVhZA0KPj4gICAgICAgICBzaXplID0gNDsNCj4+ICAgICAgICAgXiAgICAgIH4N
Cj4+DQo+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+
PiAtLS0NCj4+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPiBDYzpGYW0g
WmhlbmcNCj48ZmFtQGV1cGhvbi5uZXQ+DQo+PiAtLS0NCj4+ICBody9zY3NpL2VzcC1wY2kuYyB8
IDEgLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2h3L3Njc2kvZXNwLXBjaS5jIGIvaHcvc2NzaS9lc3AtcGNpLmMgaW5kZXgNCj4+IGQ1YTFm
OWUwMTcuLjJlNmNjMDdkNGUgMTAwNjQ0DQo+PiAtLS0gYS9ody9zY3NpL2VzcC1wY2kuYw0KPj4g
KysrIGIvaHcvc2NzaS9lc3AtcGNpLmMNCj4+IEBAIC0xOTUsNyArMTk1LDYgQEAgc3RhdGljIHZv
aWQgZXNwX3BjaV9pb193cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkcg0KPmFkZHIsDQo+PiAgICAg
ICAgICB2YWwgPDw9IHNoaWZ0Ow0KPj4gICAgICAgICAgdmFsIHw9IGN1cnJlbnQgJiB+KG1hc2sg
PDwgc2hpZnQpOw0KPj4gICAgICAgICAgYWRkciAmPSB+MzsNCj4+IC0gICAgICAgIHNpemUgPSA0
Ow0KPj4gICAgICB9DQo+DQo+cGVyaGFwcyBhICJnX2Fzc2VydChzaXplID49IDQpIiBpbnN0ZWFk
IHdvdWxkIGJlIGNsZWFuZXIgdG8gbXV0ZSB0aGUgd2FybmluZz8NCj4NClllcywgYWRkICdnX2Fz
c2VydChzaXplID49IDQpJyBjYW4gbXV0ZSB0aGUgd2FybmluZy4NCg0KPg0KPkkgdGhpbmsgaXQn
cyBhIGdvb2QgcG9pbnQgdG8gdXBkYXRlIHRoZSBzaXplIGlmIGluIHRoZSBmdXR1cmUgdGhlIGNv
ZGUgYmVsb3cgaXMNCj5tb2RpZmllZCB0byB1c2Ugc2l6ZS4NCj4NCkhtbSwgbWF5YmUgaXQgaXMg
dHJ1ZS4NCg0KU28sIGxldCdzICBrZWVwICcgc2l6ZSA9IDQnICBhbmQgIGFkZCAnZ19hc3NlcnQo
c2l6ZSA+PSA0KScgYWZ0ZXIgaWYoKSBzdGF0ZW1lbnQgLCBzaGFsbCB3ZT8NCg0KVGhhbmtzLA0K
Q2hlbiBRdW4NCj4NCj5UaGFua3MsDQo+TGF1cmVudA0KPg0KDQo=

