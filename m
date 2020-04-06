Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79836C2D0F4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 03:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E802054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 03:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="dGdO0xJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E802054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLIDW-0006Pq-BA
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 23:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bauerchen@tencent.com>) id 1jLICq-0005zt-Ud
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 23:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bauerchen@tencent.com>) id 1jLICm-0008Tt-VO
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 23:13:45 -0400
Received: from mail6.tencent.com ([220.249.245.26]:35357)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bauerchen@tencent.com>)
 id 1jLICk-0008Ph-LA
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 23:13:44 -0400
Received: from EX-SZ021.tencent.com (unknown [10.28.6.73])
 by mail6.tencent.com (Postfix) with ESMTP id 69B6FCC0E4;
 Mon,  6 Apr 2020 11:14:14 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1586142854;
 bh=8fCEIbDk68Acp+vs6mxoEb2prh1aikrPFzroeCeH/eI=;
 h=From:To:CC:Subject:Date;
 b=dGdO0xJbydrO67m9J7/+35uuzZGQ6r84uF85cj8kCcxFhWB1QeMMaHqURIa8zZd1I
 A3G//U1JEgwCiQl7feRU60WpG78gkgJVZaPgvTLI63RwZ66i9PqrvOSZcrQHAzDTuq
 XV+92GylN6sqXnmcuyIE1oMWZHzEVIipWPYS8078=
Received: from EX-SZ008.tencent.com (10.28.6.32) by EX-SZ021.tencent.com
 (10.28.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 6 Apr 2020
 11:13:35 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ008.tencent.com
 (10.28.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 6 Apr 2020
 11:13:34 +0800
Received: from EX-SZ005.tencent.com ([fe80::5d14:1c60:ce53:dbd6]) by
 EX-SZ005.tencent.com ([fe80::5d14:1c60:ce53:dbd6%4]) with mapi id
 15.01.1847.007; Mon, 6 Apr 2020 11:13:34 +0800
From: =?utf-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Requesting review  about a bugfix in touch_all_pages
Thread-Topic: Requesting review  about a bugfix in touch_all_pages
Thread-Index: AQHWC8D0kmS2yvN+ZEGzd75W8Q0lkQ==
Date: Mon, 6 Apr 2020 03:13:34 +0000
Message-ID: <cfc67cbb15584a25bf44b3a644f44abc@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.78]
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
Cc: pbonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CgpGcm9tIGZhZjkwM2Y3Yjg4OTIxNzllNjRiZDFhMzdmZTM1ODVhNjQ0MWJjNTEgTW9uIFNlcCAx
NyAwMDowMDowMCAyMDAxCkZyb206IEJhdWVyY2hlbiA8YmF1ZXJjaGVuQHRlbmNlbnQuY29tPgpE
YXRlOiBNb24sIDYgQXByIDIwMjAgMTA6MzY6NTQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBGaXg6
IEluIHRvdWNoX2FsbF9wYWdlcywgbWF5YmUgd2UgbmVlZCBhIGxvY2sgdG8gcHJvdGVjdArCoHFl
bXVfY29uZF9ib2FyZGNhc3QsIG9yIHFlbXVfY29uZF9ib2FyZGNhc3QgbWF5IGJlIGNhbGxlZCBi
ZWZvcmUgYWxsIHRvdWNoCsKgcGFnZSB0aHJlYWRzIGVudGVyIHFlbXVfY29uZF93YWl0LiBJbiB0
aGlzIGNhc2UsIMKgbWFpbiB0aHJlYWQgd2FpdHMgdG91Y2gKwqBwYWdlIHRocmVhZHMgcmV0dXJu
LCB0b3VjaCBwYWdlIHRocmVhZHMgd2FpdCBtYWluIHRocmVhZCB3YWtpbmcgdXAsIHRoYXQgaXMg
YQrCoGRlYWQgbG9jayAsdm0gd2lsbCBiZSBpbiBwYXVzZSBzdGF0ZSBmb3JldmVyOwoKU2lnbmVk
LW9mZi1ieTogQmF1ZXJjaGVuIDxiYXVlcmNoZW5AdGVuY2VudC5jb20+Ci0tLQrCoHV0aWwvb3Ns
aWItcG9zaXguYyB8IDMgKysrCsKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3V0aWwvb3NsaWItcG9zaXguYyBiL3V0aWwvb3NsaWItcG9zaXguYwppbmRleCA0
ZGQ2ZDdkLi4wNjIyMzZhIDEwMDY0NAotLS0gYS91dGlsL29zbGliLXBvc2l4LmMKKysrIGIvdXRp
bC9vc2xpYi1wb3NpeC5jCkBAIC00OTIsOCArNDkyLDExIEBAIHN0YXRpYyBib29sIHRvdWNoX2Fs
bF9wYWdlcyhjaGFyICphcmVhLCBzaXplX3QgaHBhZ2VzaXplLCBzaXplX3QgbnVtcGFnZXMsCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFFFTVVfVEhSRUFEX0pPSU5B
QkxFKTsKwqAgwqAgwqAgwqAgwqBhZGRyICs9IG1lbXNldF90aHJlYWRbaV0ubnVtcGFnZXMgKiBo
cGFnZXNpemU7CsKgIMKgIMKgfQorCisgwqAgwqBxZW11X211dGV4X2xvY2soJnBhZ2VfbXV0ZXgp
OwrCoCDCoCDCoHRocmVhZHNfY3JlYXRlZF9mbGFnID0gdHJ1ZTsKwqAgwqAgwqBxZW11X2NvbmRf
YnJvYWRjYXN0KCZwYWdlX2NvbmQpOworIMKgIMKgcWVtdV9tdXRleF91bmxvY2soJnBhZ2VfbXV0
ZXgpOwrCoArCoCDCoCDCoGZvciAoaSA9IDA7IGkgPCBtZW1zZXRfbnVtX3RocmVhZHM7IGkrKykg
ewrCoCDCoCDCoCDCoCDCoHFlbXVfdGhyZWFkX2pvaW4oJm1lbXNldF90aHJlYWRbaV0ucGd0aHJl
YWQpOwotLcKgCjEuOC4zLjEKCg==

