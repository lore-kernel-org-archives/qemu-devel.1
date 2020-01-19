Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4824DC33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 09:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168D4206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 09:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168D4206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it6VR-0002k6-5o
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 04:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1it6Od-0007lE-GE
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1it6Oc-0004Ru-1U
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:57:27 -0500
Received: from smtp.h3c.com ([60.191.123.50]:37093 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1it6Ob-0004Jh-Go; Sun, 19 Jan 2020 03:57:25 -0500
Received: from DAG2EX08-IDC.srv.huawei-3com.com ([10.8.0.71])
 by h3cspam02-ex.h3c.com with ESMTPS id 00J8v3Sp066556
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 19 Jan 2020 16:57:03 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 19 Jan 2020 16:57:06 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Sun, 19 Jan 2020 16:57:06 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: RE: util/async: File descriptor leak in aio_context_unref()?
Thread-Topic: util/async: File descriptor leak in aio_context_unref()?
Thread-Index: AdXOnyeauMnbk/akShmIS8k2o6hjwQABw7Mw
Date: Sun, 19 Jan 2020 08:57:06 +0000
Message-ID: <b612a2b0508e477d97a15b3e05994558@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.112]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 00J8v3Sp066556
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.50
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
Cc: Wangyongqing <w_yongqing@h3c.com>, Wangyong <wang.yongD@h3c.com>,
 Changlimin <changlimin@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Chengchiwen <chengchiwen@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T0ssIEkgZ290IGl0LCBpdCB3aWxsIGJlIHJlbGVhc2VkIGluIGFpb19jdHhfZmluYWxpemUoKS4N
ClBsZWFzZSBpZ25vcmUgdGhpcyBtYWlsLg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogdHVndW95aSAoQ2xvdWQpDQo+IFNlbnQ6IFN1bmRheSwgSmFudWFyeSAxOSwg
MjAyMCA0OjE1IFBNDQo+IFRvOiAnU3RlZmFuIEhham5vY3ppJyA8c3RlZmFuaGFAcmVkaGF0LmNv
bT47ICdGYW0gWmhlbmcnDQo+IDxmYW1AZXVwaG9uLm5ldD47ICdxZW11LWJsb2NrQG5vbmdudS5v
cmcnIDxxZW11LWJsb2NrQG5vbmdudS5vcmc+DQo+IENjOiAncWVtdS1kZXZlbEBub25nbnUub3Jn
JyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgY2hhbmdsaW1pbiAoQ2xvdWQpDQo+IDxjaGFuZ2xp
bWluQGgzYy5jb20+OyBjaGVuZ2NoaXdlbiAoQ2xvdWQpIDxjaGVuZ2NoaXdlbkBoM2MuY29tPjsN
Cj4gd2FuZ3lvbmdxaW5nIChDbG91ZCkgPHdfeW9uZ3FpbmdAaDNjLmNvbT47IHdhbmd5b25nIChD
bG91ZCkNCj4gPHdhbmcueW9uZ0RAaDNjLmNvbT4NCj4gU3ViamVjdDogdXRpbC9hc3luYzogRmls
ZSBkZXNjcmlwdG9yIGxlYWsgaW4gYWlvX2NvbnRleHRfdW5yZWYoKT8NCj4gDQo+IEluIGFpb19j
b250ZXh0X25ldygpLCB0aGUgQG5vdGlmaWVyIHZhcmlhYmxlIHdpbGwgYmUgaW5pdGlhbGl6ZWQs
IGJ1dCBpdA0KPiBkb24ndCBnZXQgY2xlYW5lZCB1cCBpbiBhaW9fY29udGV4dF91bnJlZigpIHdo
ZW4gcmVmZXJlbmNlIGNvdW50IHJlYWNoZXMNCj4gdG8gMCwgaXQgd2lsbCBjYXVzZSBmaWxlIGRl
c2NyaXB0b3IgbGVhay4NCj4gLS0NCj4gQmVzdCByZWdhcmRzLA0KPiBHdW95aQ0KDQo=

