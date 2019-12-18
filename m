Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08277C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4ED0218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ED0218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihP3s-0003SH-0L
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 21:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1ihP3F-0002v0-Cv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1ihP3E-0004bW-4D
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:27:01 -0500
Received: from smtp.h3c.com ([60.191.123.50]:60822 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1ihP3D-0004Gg-Ib; Tue, 17 Dec 2019 21:27:00 -0500
Received: from DAG2EX09-IDC.srv.huawei-3com.com ([10.8.0.72])
 by h3cspam02-ex.h3c.com with ESMTPS id xBI2QTrF012617
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2019 10:26:29 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX09-IDC.srv.huawei-3com.com (10.8.0.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 10:26:28 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Wed, 18 Dec 2019 10:26:28 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH] qcow2: Move error check of local_err near its assignment
Thread-Topic: [PATCH] qcow2: Move error check of local_err near its assignment
Thread-Index: AdW1Sk9pyaSaCMAlRUyLwKs8KWho0g==
Date: Wed, 18 Dec 2019 02:26:20 +0000
Message-ID: <c9d3fc7246ec4c1f9a6cde9ed3c3ae57@h3c.com>
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
X-MAIL: h3cspam02-ex.h3c.com xBI2QTrF012617
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpTaWduZWQtb2ZmLWJ5OiBHdW95aSBUdSA8dHUuZ3VveWlAaDNjLmNvbT4NCi0tLQ0KIGJsb2Nr
L3Fjb3cyLmMgfCAxMCArKysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLmMgYi9ibG9jay9x
Y293Mi5jDQppbmRleCA3YzE4NzIxLi5jZTNkYjI5IDEwMDY0NA0KLS0tIGEvYmxvY2svcWNvdzIu
Yw0KKysrIGIvYmxvY2svcWNvdzIuYw0KQEAgLTE3MDUsMTQgKzE3MDUsMTQgQEAgc3RhdGljIGlu
dCBjb3JvdXRpbmVfZm4gcWNvdzJfZG9fb3BlbihCbG9ja0RyaXZlclN0YXRlICpicywgUURpY3Qg
Km9wdGlvbnMsDQogICAgIGlmICghKGJkcnZfZ2V0X2ZsYWdzKGJzKSAmIEJEUlZfT19JTkFDVElW
RSkpIHsNCiAgICAgICAgIC8qIEl0J3MgY2FzZSAxLCAyIG9yIDMuMi4gT3IgMy4xIHdoaWNoIGlz
IEJVRyBpbiBtYW5hZ2VtZW50IGxheWVyLiAqLw0KICAgICAgICAgYm9vbCBoZWFkZXJfdXBkYXRl
ZCA9IHFjb3cyX2xvYWRfZGlydHlfYml0bWFwcyhicywgJmxvY2FsX2Vycik7DQorICAgICAgICBp
ZiAobG9jYWxfZXJyICE9IE5VTEwpIHsNCisgICAgICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJy
cCwgbG9jYWxfZXJyKTsNCisgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KKyAgICAgICAgICAg
IGdvdG8gZmFpbDsNCisgICAgICAgIH0NCiANCiAgICAgICAgIHVwZGF0ZV9oZWFkZXIgPSB1cGRh
dGVfaGVhZGVyICYmICFoZWFkZXJfdXBkYXRlZDsNCiAgICAgfQ0KLSAgICBpZiAobG9jYWxfZXJy
ICE9IE5VTEwpIHsNCi0gICAgICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0K
LSAgICAgICAgcmV0ID0gLUVJTlZBTDsNCi0gICAgICAgIGdvdG8gZmFpbDsNCi0gICAgfQ0KIA0K
ICAgICBpZiAodXBkYXRlX2hlYWRlcikgew0KICAgICAgICAgcmV0ID0gcWNvdzJfdXBkYXRlX2hl
YWRlcihicyk7DQotLSANCjIuNy40DQo=

