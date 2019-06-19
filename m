Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC4C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A798F2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A798F2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdVpg-0000XM-VP
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 04:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42378)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hdVnk-0007um-Q1
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hdVni-0007jb-V6
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:18:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45415 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hdVna-00075Y-9d; Wed, 19 Jun 2019 04:18:30 -0400
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 7611219928A051FA66D4;
 Wed, 19 Jun 2019 09:18:07 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.112]) by
 lhreml708-cah.china.huawei.com ([10.201.108.49]) with mapi id 14.03.0415.000; 
 Wed, 19 Jun 2019 09:18:01 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Thread-Topic: [PATCH v5 0/8] ARM virt: ACPI memory hotplug support
Thread-Index: AQHVELrXjlt3iCVXlkWsFxU/nLHFv6ahdyaAgAABhYCAAA0HgIABR4Eg
Date: Wed, 19 Jun 2019 08:18:00 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F2AA96B@lhreml524-mbs.china.huawei.com>
References: <20190522162252.28568-1-shameerali.kolothum.thodi@huawei.com>
 <653a6b3c-ac1a-f197-1240-a28f59890fa8@redhat.com>
 <CAFEAcA9g=9u1Cj+1gqWqXWfg1phmZPw4=y7Ks_EzbYOEBW-WOA@mail.gmail.com>
 <2c08ff88-7e94-6f24-33f1-173957cee2ba@redhat.com>
In-Reply-To: <2c08ff88-7e94-6f24-33f1-173957cee2ba@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.176.76.210
Subject: Re: [Qemu-devel] [PATCH v5 0/8] ARM virt: ACPI memory hotplug
 support
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBdWdlciBF
cmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tXQ0KPiBTZW50OiAxOCBKdW5lIDIwMTkg
MTQ6NDUNCj4gVG86IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4g
Q2M6IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlA
aHVhd2VpLmNvbT47DQo+IFFFTVUgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsg
cWVtdS1hcm0NCj4gPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBJZ29yIE1hbW1lZG92IDxpbWFtbWVk
b0ByZWRoYXQuY29tPjsNCj4gU2hhbm5vbiBaaGFvIDxzaGFubm9uLnpoYW9zbEBnbWFpbC5jb20+
OyBTYW11ZWwgT3J0aXoNCj4gPHNhbWVvQGxpbnV4LmludGVsLmNvbT47IHNlYmFzdGllbi5ib2V1
ZkBpbnRlbC5jb207IHh1d2VpIChPKQ0KPiA8eHV3ZWk1QGh1YXdlaS5jb20+OyBMYXN6bG8gRXJz
ZWsgPGxlcnNla0ByZWRoYXQuY29tPjsgQXJkIEJpZXNoZXV2ZWwNCj4gPGFyZC5iaWVzaGV1dmVs
QGxpbmFyby5vcmc+OyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NSAwLzhdIEFSTSB2aXJ0OiBBQ1BJIG1lbW9yeSBob3RwbHVnIHN1cHBvcnQN
Cj4gDQo+IEhpIFBldGVyLA0KPiBPbiA2LzE4LzE5IDI6NTcgUE0sIFBldGVyIE1heWRlbGwgd3Jv
dGU6DQo+ID4gSSdtIG5vdCBzdXJlIHdlIHNob3VsZCBjYXJyeSBhY3Jvc3MgVGVzdGVkLWJ5IHRh
Z3MgbGlrZSB0aGF0OiBhbnkNCj4gPiByZXNwaW4gbWlnaHQgYWNjaWRlbnRhbGx5IGludHJvZHVj
ZSBidWdzIHRoYXQgbWFrZSBpdCBzdG9wIHdvcmtpbmcuLi4NCj4gDQo+IE9LLiBObyBwcm9ibGVt
LiBJIHdpbGwgdGVzdCB0aGUgbmV4dCB2ZXJzaW9uIHRoZW4uDQoNClRoYW5rcyBmb3IgdGVzdGlu
ZyBhbmQgdmVyaWZ5aW5nLiBJIHdpbGwgcmVzcGluIHRoaXMgc29vbi4NCg0KQ2hlZXJzLA0KU2hh
bWVlcg0KIA0K

