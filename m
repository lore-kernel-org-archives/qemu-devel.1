Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0386CC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 11:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1699206D3
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 11:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="m+Za0XVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1699206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJyKT-0002sd-VK
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 07:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bauerchen@tencent.com>) id 1jJyJt-0002SO-5n
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 07:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bauerchen@tencent.com>) id 1jJyJk-0005eT-W6
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 07:47:31 -0400
Received: from mail6.tencent.com ([220.249.245.26]:55261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bauerchen@tencent.com>)
 id 1jJyJk-0005cO-2g
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 07:47:28 -0400
Received: from EX-SZ021.tencent.com (unknown [10.28.6.73])
 by mail6.tencent.com (Postfix) with ESMTP id 36CF3CC271;
 Thu,  2 Apr 2020 19:47:56 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1585828076;
 bh=ODk1nZ4bCkOyrjG9lQDyR2E9wQvZp3xy0tCZBxevX28=;
 h=From:To:CC:Subject:Date;
 b=m+Za0XVnem/0/arNf8aCti34ilCLIvI0nd5mbizfjzjZgRQ7vKRaMvCB2OreLPC0C
 EKJYq8OMPYgGsVtzzCElA/vpMNe0mFQSeTdnCVzLRTvtVJmRF1ssl7jg37UTL3tx9u
 bew/stNCiQMxrV0bozGPf5xvs17eXnNQa7bPdK14=
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ021.tencent.com
 (10.28.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 2 Apr 2020
 19:47:17 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ005.tencent.com
 (10.28.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 2 Apr 2020
 19:47:17 +0800
Received: from EX-SZ005.tencent.com ([fe80::5d14:1c60:ce53:dbd6]) by
 EX-SZ005.tencent.com ([fe80::5d14:1c60:ce53:dbd6%4]) with mapi id
 15.01.1847.007; Thu, 2 Apr 2020 19:47:17 +0800
From: =?utf-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: is just a wrong function name of libusb_get_port_number? request for
 a review of the bug fix
Thread-Topic: is just a wrong function name of libusb_get_port_number? request
 for a review of the bug fix
Thread-Index: AQHWCOBmrsmcg0upoEK6uJ0LEU9ceA==
Date: Thu, 2 Apr 2020 11:47:17 +0000
Message-ID: <02a07a59c3964199b73b1145e4abe0e9@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.198]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.249.245.26
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
Cc: hdegoede <hdegoede@redhat.com>, kraxel <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbSA2YmZiMzA4Nzg2NjYwNmVkMzZhMjFlN2JkMDVmMDY3NGU2YTk3MTU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCYXVlcmNoZW4gPGJhdWVyY2hlbkB0ZW5jZW50LmNvbT4KRGF0
ZTogVGh1LCAyIEFwciAyMDIwIDE5OjE5OjAwICswODAwClN1YmplY3Q6IFtQQVRDSF0gRml4OmZp
eCB0aGUgd3JvbmcgZnVuY3Rpb24gbmFtZSBvZiBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVyCgpbZGVz
Y106CmxpYnVzYl9nZXRfcG9ydF9udW1iZXJzIGlzIGNhbGxlZCBpbiBmdW5jdGlvbgp1c2JfaG9z
dF9nZXRfcG9ydCwgYW5kIHFlbXUgY3Jhc2hlZCB3aXRoOgpzeW1ib2wgbG9va3VwIGVycm9yOiB1
bmRlZmluZWQgc3ltYm9sOiBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVycwpJIGNoZWNrIC9saWI2NC9s
aWJ1c2ItMS4wLnNvLjAgYW5kIG91dHB1dCBpcyBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVyLCBJCmNo
YW5nZSBpdCB0byBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVyLCBjcmFzaCBwcm9ibGVtIGlzIGdvbmU7
CnNvIGlzIGl0IGp1c3QgYSBmdW5jdGlvbiBuYW1lIGJ1Zz8KClNpZ25lZC1vZmYtYnk6IEJhdWVy
Y2hlbiA8YmF1ZXJjaGVuQHRlbmNlbnQuY29tPgotLS0KwqBody91c2IvaG9zdC1saWJ1c2IuYyB8
IDIgKy0KwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9ody91c2IvaG9zdC1saWJ1c2IuYyBiL2h3L3VzYi9ob3N0LWxpYnVzYi5jCmlu
ZGV4IDJhYzdhOTMuLjcxM2RiOGQgMTAwNjQ0Ci0tLSBhL2h3L3VzYi9ob3N0LWxpYnVzYi5jCisr
KyBiL2h3L3VzYi9ob3N0LWxpYnVzYi5jCkBAIC0yODUsNyArMjg1LDcgQEAgc3RhdGljIGludCB1
c2JfaG9zdF9nZXRfcG9ydChsaWJ1c2JfZGV2aWNlICpkZXYsIGNoYXIgKnBvcnQsIHNpemVfdCBs
ZW4pCsKgIMKgIMKgaW50IHJjLCBpOwrCoArCoCNpZiBMSUJVU0JfQVBJX1ZFUlNJT04gPj0gMHgw
MTAwMDEwMgotIMKgIMKgcmMgPSBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVycyhkZXYsIHBhdGgsIDcp
OworIMKgIMKgcmMgPSBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVyKGRldiwgcGF0aCwgNyk7CsKgI2Vs
c2UKwqAgwqAgwqByYyA9IGxpYnVzYl9nZXRfcG9ydF9wYXRoKGN0eCwgZGV2LCBwYXRoLCA3KTsK
wqAjZW5kaWYKLS3CoAoxLjguMy4xCgoKLS0tLS0tLS0tLS0tLQpiYXVlcmNoZW4=

