Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24653C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8708206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8708206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDYi-0004yr-1W
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZDXx-00043M-8D
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:05:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2089 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZDXv-0005UH-T8
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:05:08 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 1C28C341606CB50D7B44;
 Thu, 14 May 2020 21:05:01 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 14 May 2020 21:05:01 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 14 May 2020 21:05:00 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Thu, 14 May 2020 21:05:00 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDUvNl0gbWlncmF0aW9uL3FlbXUtZmlsZS5jOiBEb24n?=
 =?gb2312?Q?t_ratelimit_a_shutdown_fd?=
Thread-Topic: [PATCH 5/6] migration/qemu-file.c: Don't ratelimit a shutdown fd
Thread-Index: AQHWJ4TfIeof1kb0t0KOJInWn/6h5ainj6bg
Date: Thu, 14 May 2020 13:05:00 +0000
Message-ID: <1dc261c8dce6421b80071c0eb3528afd@huawei.com>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <f3ea4250e6982598ffffc73924a6917dbc823c87.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <f3ea4250e6982598ffffc73924a6917dbc823c87.1589193382.git.lukasstraub2@web.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 08:45:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBUaGlzIGNhdXNlcyB0aGUgbWlncmF0aW9uIHRocmVhZCB0byBoYW5nIGlmIHdlIGZhaWxvdmVy
IGR1cmluZyBjaGVja3BvaW50LiBBDQo+IHNodXRkb3duIGZkIHdvbid0IGNhdXNlIG5ldHdvcmsg
dHJhZmZpYyBhbnl3YXkuDQo+IA0KDQpJJ20gbm90IHF1aXRlIHN1cmUgaWYgdGhpcyBtb2RpZmlj
YXRpb24gY2FuIHRha2Ugc2lkZSBlZmZlY3Qgb24gbm9ybWFsIG1pZ3JhdGlvbiBwcm9jZXNzIG9y
IG5vdCwNClRoZXJlIGFyZSBzZXZlcmFsIHBsYWNlcyBjYWxsaW5nIGl0Lg0KDQpNYXliZSBKdWFu
IGFuZCBEYXZlIGNhbiBoZWxwIDspDQoNCj4gU2lnbmVkLW9mZi1ieTogTHVrYXMgU3RyYXViIDxs
dWthc3N0cmF1YjJAd2ViLmRlPg0KPiAtLS0NCj4gIG1pZ3JhdGlvbi9xZW11LWZpbGUuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9xZW11LWZpbGUuYyBiL21pZ3JhdGlvbi9xZW11LWZp
bGUuYyBpbmRleA0KPiAxYzNhMzU4YTE0Li4wNzQ4YjU4MTBmIDEwMDY0NA0KPiAtLS0gYS9taWdy
YXRpb24vcWVtdS1maWxlLmMNCj4gKysrIGIvbWlncmF0aW9uL3FlbXUtZmlsZS5jDQo+IEBAIC02
NjAsNyArNjYwLDcgQEAgaW50NjRfdCBxZW11X2Z0ZWxsKFFFTVVGaWxlICpmKSAgaW50DQo+IHFl
bXVfZmlsZV9yYXRlX2xpbWl0KFFFTVVGaWxlICpmKSAgew0KPiAgICAgIGlmIChmLT5zaHV0ZG93
bikgew0KPiAtICAgICAgICByZXR1cm4gMTsNCj4gKyAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAg
fQ0KPiAgICAgIGlmIChxZW11X2ZpbGVfZ2V0X2Vycm9yKGYpKSB7DQo+ICAgICAgICAgIHJldHVy
biAxOw0KPiAtLQ0KPiAyLjIwLjENCg0K

