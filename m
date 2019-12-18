Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6F9C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0530A2072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0530A2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihXvp-00018w-5C
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 06:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1ihXtq-0007nq-TQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1ihXtp-0006EP-E2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:53:54 -0500
Received: from smtp.h3c.com ([60.191.123.56]:50602 helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1ihXto-0005bg-AM; Wed, 18 Dec 2019 06:53:53 -0500
Received: from DAG2EX05-BASE.srv.huawei-3com.com ([10.8.0.68])
 by h3cspam01-ex.h3c.com with ESMTPS id xBIBrVrZ003811
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2019 19:53:31 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 19:53:35 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Wed, 18 Dec 2019 19:53:35 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH v2] qcow2: Move error check of local_err near its assignment
Thread-Topic: [PATCH v2] qcow2: Move error check of local_err near its
 assignment
Thread-Index: AdW1mTSoOOuBNsNvTxeUrz3yzMUMzg==
Date: Wed, 18 Dec 2019 11:53:35 +0000
Message-ID: <d7301bf410e04b50a494a82679335158@h3c.com>
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
X-MAIL: h3cspam01-ex.h3c.com xBIBrVrZ003811
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.56
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
Cc: "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGxvY2FsX2VyciBjaGVjayBvdXRzaWRlIG9mIHRoZSBpZiBibG9jayB3YXMgbmVjZXNzYXJ5
DQp3aGVuIGl0IHdhcyBpbnRyb2R1Y2VkIGluIGNvbW1pdCBkMTI1OGRkMGM4NyBiZWNhdXNlIGl0
IG5lZWRlZCB0byBiZQ0KZXhlY3V0ZWQgZXZlbiBpZiBxY293Ml9sb2FkX2F1dG9sb2FkaW5nX2Rp
cnR5X2JpdG1hcHMoKSByZXR1cm5lZCBmYWxzZS4NCg0KQWZ0ZXIgc29tZSBtb2RpZmljYXRpb25z
IHRoYXQgYWxsIHJlcXVpcmVkIHRoZSBlcnJvciBjaGVjayB0byByZW1haW4NCndoZXJlIGl0IGlz
LCBjb21taXQgOWM5OGYxNDVkZmIgZmluYWxseSBtb3ZlZCB0aGUNCnFjb3cyX2xvYWRfZGlydHlf
Yml0bWFwcygpIGNhbGwgaW50byB0aGUgaWYgYmxvY2ssIHNvIG5vdyB0aGUgZXJyb3INCmNoZWNr
IHNob3VsZCBiZSB0aGVyZSwgdG9vLg0KDQpTaWduZWQtb2ZmLWJ5OiBHdW95aSBUdSA8dHUuZ3Vv
eWlAaDNjLmNvbT4NClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQotLS0NCiBibG9jay9xY293Mi5jIHwgMTAgKysrKyst
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9ibG9jay9xY293Mi5jIGIvYmxvY2svcWNvdzIuYw0KaW5kZXggN2MxODcy
MS4uY2UzZGIyOSAxMDA2NDQNCi0tLSBhL2Jsb2NrL3Fjb3cyLmMNCisrKyBiL2Jsb2NrL3Fjb3cy
LmMNCkBAIC0xNzA1LDE0ICsxNzA1LDE0IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIHFjb3cy
X2RvX29wZW4oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIFFEaWN0ICpvcHRpb25zLA0KICAgICBpZiAo
IShiZHJ2X2dldF9mbGFncyhicykgJiBCRFJWX09fSU5BQ1RJVkUpKSB7DQogICAgICAgICAvKiBJ
dCdzIGNhc2UgMSwgMiBvciAzLjIuIE9yIDMuMSB3aGljaCBpcyBCVUcgaW4gbWFuYWdlbWVudCBs
YXllci4gKi8NCiAgICAgICAgIGJvb2wgaGVhZGVyX3VwZGF0ZWQgPSBxY293Ml9sb2FkX2RpcnR5
X2JpdG1hcHMoYnMsICZsb2NhbF9lcnIpOw0KKyAgICAgICAgaWYgKGxvY2FsX2VyciAhPSBOVUxM
KSB7DQorICAgICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQorICAg
ICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCisgICAgICAgICAgICBnb3RvIGZhaWw7DQorICAgICAg
ICB9DQogDQogICAgICAgICB1cGRhdGVfaGVhZGVyID0gdXBkYXRlX2hlYWRlciAmJiAhaGVhZGVy
X3VwZGF0ZWQ7DQogICAgIH0NCi0gICAgaWYgKGxvY2FsX2VyciAhPSBOVUxMKSB7DQotICAgICAg
ICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxfZXJyKTsNCi0gICAgICAgIHJldCA9IC1FSU5W
QUw7DQotICAgICAgICBnb3RvIGZhaWw7DQotICAgIH0NCiANCiAgICAgaWYgKHVwZGF0ZV9oZWFk
ZXIpIHsNCiAgICAgICAgIHJldCA9IHFjb3cyX3VwZGF0ZV9oZWFkZXIoYnMpOw0KLS0gDQoyLjcu
NA0KDQo=

