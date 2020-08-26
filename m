Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB289C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7635206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7635206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAkXf-0000Vo-3N
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 21:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kAkX7-0008OR-4m; Tue, 25 Aug 2020 21:47:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2924 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kAkX5-00035H-0s; Tue, 25 Aug 2020 21:47:24 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 9EB401279F9843CC924F;
 Wed, 26 Aug 2020 09:47:12 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.141]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 09:47:02 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: RE: [PATCH v2 07/10] vfio/platform: Remove dead assignment in
 vfio_intp_interrupt()
Thread-Topic: [PATCH v2 07/10] vfio/platform: Remove dead assignment in
 vfio_intp_interrupt()
Thread-Index: AQHWetKKG1C120Vf5E2prTROrs4ndKlJF1UAgACHUtA=
Date: Wed, 26 Aug 2020 01:47:02 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B8E23ED@dggemm511-mbx.china.huawei.com>
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-8-kuhn.chenqun@huawei.com>
 <CAKXe6S+BBKztHmBG0TLRTJH6bDntyz4=mWpgccctaZgYWn_TdA@mail.gmail.com>
In-Reply-To: <CAKXe6S+BBKztHmBG0TLRTJH6bDntyz4=mWpgccctaZgYWn_TdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 21:47:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
 Pannengyuan <pannengyuan@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+ID4gQ2xhbmcgc3RhdGljIGNvZGUgYW5hbHl6ZXIgc2hvdyB3YXJuaW5nOg0KPiA+IGh3L3Zm
aW8vcGxhdGZvcm0uYzoyMzk6OTogd2FybmluZzogVmFsdWUgc3RvcmVkIHRvICdyZXQnIGlzIG5l
dmVyIHJlYWQNCj4gPiAgICAgICAgIHJldCA9IGV2ZW50X25vdGlmaWVyX3Rlc3RfYW5kX2NsZWFy
KGludHAtPmludGVycnVwdCk7DQo+ID4gICAgICAgICBeICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogRXVsZXIg
Um9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hlbiBR
dW4gPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBFcmljIEF1Z2Vy
IDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+ID4gLS0tDQo+ID4gQ2M6IEFsZXggV2lsbGlhbXNv
biA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+ID4gQ2M6IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj4gPiBDYzogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPg0KPiA+IC0tLQ0KPiA+ICBody92ZmlvL3BsYXRmb3JtLmMgfCAyICstDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2h3L3ZmaW8vcGxhdGZvcm0uYyBiL2h3L3ZmaW8vcGxhdGZvcm0uYyBpbmRleA0K
PiA+IGFjMmNlZmM5YjEuLjg2OWVkMmMzOWQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdmZpby9wbGF0
Zm9ybS5jDQo+ID4gKysrIGIvaHcvdmZpby9wbGF0Zm9ybS5jDQo+ID4gQEAgLTIzNiw3ICsyMzYs
NyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2ludHBfaW50ZXJydXB0KFZGSU9JTlRwICppbnRwKQ0KPiA+
ICAgICAgICAgIHRyYWNlX3ZmaW9faW50cF9pbnRlcnJ1cHRfc2V0X3BlbmRpbmcoaW50cC0+cGlu
KTsNCj4gPiAgICAgICAgICBRU0lNUExFUV9JTlNFUlRfVEFJTCgmdmRldi0+cGVuZGluZ19pbnRw
X3F1ZXVlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludHAsIHBxbmV4dCk7
DQo+ID4gLSAgICAgICAgcmV0ID0gZXZlbnRfbm90aWZpZXJfdGVzdF9hbmRfY2xlYXIoaW50cC0+
aW50ZXJydXB0KTsNCj4gDQo+IFNob3VsZG4ndCB3ZSBjaGVjayB0aGUgJ3JldCcgbGlrZSB0aGUg
b3RoZXIgcGxhY2UgaW4gdGhpcyBmdW5jdGlvbj8NCg0KSGksIExpIFFpYW5nLA0KDQpFcmlj44CB
QWxleOOAgVN0ZWZhbiBoYXMgYWxyZWFkeSBkaXNjdXNzZWQgdGhpcyBwb2ludCBpbiB0aGUgVjEg
dmVyc2lvbi4NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3MTE4OTcvDQoN
ClRoYW5rcy4NCg==

