Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B2DC49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 13:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1272208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 13:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1272208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dornerworks.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBfNR-00066S-1g
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 09:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Stewart.Hildebrand@dornerworks.com>)
 id 1iBfMf-0005ZR-T5
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 09:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Stewart.Hildebrand@dornerworks.com>)
 id 1iBfMe-0001li-RI
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 09:23:53 -0400
Received: from mail.dornerworks.com ([12.207.209.150]:35801
 helo=webmail.dornerworks.com) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Stewart.Hildebrand@dornerworks.com>)
 id 1iBfMe-0001kO-MN; Sat, 21 Sep 2019 09:23:52 -0400
From: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "Peter
 Maydell" <peter.maydell@linaro.org>, Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>,
 =?utf-8?B?Wm9sdMOhbiBCYWxkYXN6dGk=?= <bztemail@gmail.com>
Subject: RE: [Qemu-arm] [RFC PATCH 00/14] hw/arm: Add the Raspberry Pi 4B
Thread-Topic: [Qemu-arm] [RFC PATCH 00/14] hw/arm: Add the Raspberry Pi 4B
Thread-Index: AQHVY0TkMHB97Y0/60qxJoIoRMQ4KKc2NZsg
Date: Sat, 21 Sep 2019 13:25:36 +0000
Message-ID: <e27f5b1a3e92494086340831c3c8513c@dornerworks.com>
References: <20190904171315.8354-1-f4bug@amsat.org>
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.58.139.46]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 12.207.209.150
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
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNCwgMjAxOSAxOjEzIFBNLCBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSB3cm90ZToNCj5Fc3RlYmFuIHdyb3RlIG1lIG92ZXIgdGhlIHdlZWtlbmQgYXNraW5n
IGFib3V0IHJhc3BpNCBwcm9ncmVzcy4NCj5JIGNsZWFuZWQgdXAgbXkgcGF0Y2hlcy9ub3RlcyB0
byBwYXNzIGhpbS4gT3RoZXIgaGVscCBpcyBhbHNvIHdlbGNvbWVkIDopDQo+SSBnb3Qgc2NhcmVk
IHRyeWluZyB0byB1bmRlcnN0YW5kIGhvdyB0byB1c2UgdGhlIEdJQywgYW5kIHdpcmUgdGhlIHZh
cmlvdXMNCj5JUlFzLg0KPg0KPk1vc3QgaW1wb3J0YW50IG5vdGVzIGFib3V0IHRlc3RpbmcgYXJl
IGluIHBhdGNoICMxMjoNCj4iQWRkIHRoZSBCQ00yODM4IHdoaWNoIHVzZXMgYSBHSUN2MiINCj4N
Cj5Ob3QgbXVjaCB3b3JrcyB5ZXQsIGl0IG9ubHkgcnVucyBhIGJpdCB1bnRpbCBjb25maWd1cmlu
ZyB0aGUgR0lDLg0KPg0KPmJyYW5jaCBwdXNoZWQgYXQgaHR0cHM6Ly9naXRsYWIuY29tL3BoaWxt
ZC9xZW11L2NvbW1pdHMvcmFzcGk0X3dpcA0KPg0KPlJlZ2FyZHMsDQo+DQo+UGhpbC4NCg0KSXQg
c2VlbXMgdXBzdHJlYW0gbGludXggbWF5IGJlIGFkb3B0aW5nIHRoZSBCQ00yNzExIG5hbWluZyBj
b252ZW50aW9uIFsxXSwgdGhvdWdoIGl0IGRvZXNuJ3QgbG9vayBsaWtlIHRoZSBzZXJpZXMgWzFd
IGhhcyBiZWVuIGNvbW1pdHRlZCB5ZXQuIFRoZSBTb0MgbmFtZSBpbiBkb2N1bWVudGF0aW9uIGlz
IEJDTTI3MTEgWzJdLiBJIGhhdmUgbm8gb3BpbmlvbiBvbiB3aGljaCBuYW1pbmcgY29udmVudGlv
biB0aGUgUUVNVSBjb21tdW5pdHkgYWRvcHRzLCBJIHNpbXBseSB3YW50ZWQgdG8gcGFzcyBhbG9u
ZyB0aGlzIG9ic2VydmF0aW9uLg0KDQotU3Rldw0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9jb3Zlci8xMTA5MjYxMy8NClsyXSBodHRwczovL3d3dy5yYXNwYmVycnlwaS5vcmcv
ZG9jdW1lbnRhdGlvbi9oYXJkd2FyZS9yYXNwYmVycnlwaS9iY20yNzExL1JFQURNRS5tZA0K

