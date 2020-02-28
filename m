Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293C7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E665D24699
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fU1UqMu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E665D24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jKk-0003Gg-4L
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7im2-0005bH-KL
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7im0-0007BW-G4
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:46:02 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7im0-0005Uz-3z
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908360; x=1614444360;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=egQLU7UL0367O5Ng/6wa9jioXYHpGzCWdOTP3btoBUU=;
 b=fU1UqMu70WKz30whoKIEzhfbIv6Z1DGNa/o0j58cxxcy+l/wNU2RT5Zx
 FBuCGqBtuunudof3Pk0x9ky09kl+ahtw3/Y5OLanQnV9SofqGb34KbSqg
 1HG5rC9UIkbTU7D/nZl883MiPm6MUxh+VTvqaRt065xVC3Bk86KHoKRir c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Feb 2020 08:44:32 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:32 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id D42C01206; Fri, 28 Feb 2020 10:44:31 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 47/67] Hexagon TCG generation - step 09
Date: Fri, 28 Feb 2020 10:43:43 -0600
Message-Id: <1582908244-304-48-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 Taylor Simpson <tsimpson@quicinc.com>, philmd@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T3ZlcnJpZGUgaW5zdHJ1Y3Rpb25zIHRvIHNwZWVkIHVwIHFlbXUKClNpZ25lZC1vZmYtYnk6IFRh
eWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9o
ZWxwZXJfb3ZlcnJpZGVzLmggfCA5NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaGVscGVyX292ZXJyaWRlcy5oIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyX292
ZXJyaWRlcy5oCmluZGV4IGQxOGFlYTQuLjU0NDNhOTRlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9oZWxwZXJfb3ZlcnJpZGVzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyX292ZXJy
aWRlcy5oCkBAIC0xMjMwLDQgKzEyMzAsMTAxIEBACiAgICAgICAgIGdlbl9oZWxwZXJfdmFjc2hf
cHJlZChQZVYsIGNwdV9lbnYsIFJ4eFYsIFJzc1YsIFJ0dFYpOyBcCiAgICAgfSB3aGlsZSAoMCkK
IAorLyoKKyAqIFRoZSBmb2xsb3dpbmcgZldSQVAgbWFjcm9zIGFyZSB0byBzcGVlZCB1cCBxZW11
CisgKiBXZSBjYW4gYWRkIG1vcmUgb3ZlciB0aW1lCisgKi8KKworLyoKKyAqIEFkZCBvciBzdWJ0
cmFjdCB3aXRoIGNhcnJ5LgorICogUHJlZGljYXRlIHJlZ2lzdGVyIGlzIHVzZWQgYXMgYW4gZXh0
cmEgaW5wdXQgYW5kIG91dHB1dC4KKyAqIHI1OjQgPSBhZGQocjE6MCwgcjM6MiwgcDEpOmNhcnJ5
CisgKi8KKyNkZWZpbmUgZldSQVBfQTRfYWRkcF9jKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAg
IGRvIHsgXAorICAgICAgICBUQ0d2IExTQiA9IHRjZ190ZW1wX25ldygpOyBcCisgICAgICAgIFRD
R3ZfaTY0IExTQl9pNjQgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7IFwKKyAgICAgICAgVENHdl9pNjQg
dG1wX2k2NCA9IHRjZ190ZW1wX25ld19pNjQoKTsgXAorICAgICAgICBUQ0d2IHRtcCA9IHRjZ190
ZW1wX25ldygpOyBcCisgICAgICAgIHRjZ19nZW5fYWRkX2k2NChSZGRWLCBSc3NWLCBSdHRWKTsg
XAorICAgICAgICBmTFNCT0xEKFB4Vik7IFwKKyAgICAgICAgdGNnX2dlbl9leHR1X2kzMl9pNjQo
TFNCX2k2NCwgTFNCKTsgXAorICAgICAgICB0Y2dfZ2VuX2FkZF9pNjQoUmRkViwgUmRkViwgTFNC
X2k2NCk7IFwKKyAgICAgICAgZkNBUlJZX0ZST01fQUREKFJzc1YsIFJ0dFYsIExTQl9pNjQpOyBc
CisgICAgICAgIHRjZ19nZW5fZXh0cmxfaTY0X2kzMih0bXAsIFJzc1YpOyBcCisgICAgICAgIGY4
QklUU09GKFB4ViwgdG1wKTsgXAorICAgICAgICB0Y2dfdGVtcF9mcmVlKExTQik7IFwKKyAgICAg
ICAgdGNnX3RlbXBfZnJlZV9pNjQoTFNCX2k2NCk7IFwKKyAgICAgICAgdGNnX3RlbXBfZnJlZV9p
NjQodG1wX2k2NCk7IFwKKyAgICAgICAgdGNnX3RlbXBfZnJlZSh0bXApOyBcCisgICAgfSB3aGls
ZSAoMCkKKworLyogcjU6NCA9IHN1YihyMTowLCByMzoyLCBwMSk6Y2FycnkgKi8KKyNkZWZpbmUg
ZldSQVBfQTRfc3VicF9jKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGRvIHsgXAorICAgICAg
ICBUQ0d2IExTQiA9IHRjZ190ZW1wX25ldygpOyBcCisgICAgICAgIFRDR3ZfaTY0IExTQl9pNjQg
PSB0Y2dfdGVtcF9uZXdfaTY0KCk7IFwKKyAgICAgICAgVENHdl9pNjQgdG1wX2k2NCA9IHRjZ190
ZW1wX25ld19pNjQoKTsgXAorICAgICAgICBUQ0d2IHRtcCA9IHRjZ190ZW1wX25ldygpOyBcCisg
ICAgICAgIHRjZ19nZW5fbm90X2k2NCh0bXBfaTY0LCBSdHRWKTsgXAorICAgICAgICB0Y2dfZ2Vu
X2FkZF9pNjQoUmRkViwgUnNzViwgdG1wX2k2NCk7IFwKKyAgICAgICAgZkxTQk9MRChQeFYpOyBc
CisgICAgICAgIHRjZ19nZW5fZXh0dV9pMzJfaTY0KExTQl9pNjQsIExTQik7IFwKKyAgICAgICAg
dGNnX2dlbl9hZGRfaTY0KFJkZFYsIFJkZFYsIExTQl9pNjQpOyBcCisgICAgICAgIGZDQVJSWV9G
Uk9NX0FERChSc3NWLCB0bXBfaTY0LCBMU0JfaTY0KTsgXAorICAgICAgICB0Y2dfZ2VuX2V4dHJs
X2k2NF9pMzIodG1wLCBSc3NWKTsgXAorICAgICAgICBmOEJJVFNPRihQeFYsIHRtcCk7IFwKKyAg
ICAgICAgdGNnX3RlbXBfZnJlZShMU0IpOyBcCisgICAgICAgIHRjZ190ZW1wX2ZyZWVfaTY0KExT
Ql9pNjQpOyBcCisgICAgICAgIHRjZ190ZW1wX2ZyZWVfaTY0KHRtcF9pNjQpOyBcCisgICAgICAg
IHRjZ190ZW1wX2ZyZWUodG1wKTsgXAorICAgIH0gd2hpbGUgKDApCisKKy8qCisgKiBDb21wYXJl
IGVhY2ggb2YgdGhlIDggdW5zaWduZWQgYnl0ZXMKKyAqIFRoZSBtaW5pbXVtIGlzIHBsYWNlcyBp
biBlYWNoIGJ5dGUgb2YgdGhlIGRlc3RpbmF0aW9uLgorICogRWFjaCBiaXQgb2YgdGhlIHByZWRp
Y2F0ZSBpcyBzZXQgdHJ1ZSBpZiB0aGUgYml0IGZyb20gdGhlIGZpcnN0IG9wZXJhbmQKKyAqIGlz
IGdyZWF0ZXIgdGhhbiB0aGUgYml0IGZyb20gdGhlIHNlY29uZCBvcGVyYW5kLgorICogcjU6NCxw
MSA9IHZtaW51YihyMTowLCByMzoyKQorICovCisjZGVmaW5lIGZXUkFQX0E2X3ZtaW51Yl9SZFAo
R0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIFRDR3YgQllURSA9IHRj
Z190ZW1wX25ldygpOyBcCisgICAgICAgIFRDR3YgbGVmdCA9IHRjZ190ZW1wX25ldygpOyBcCisg
ICAgICAgIFRDR3YgcmlnaHQgPSB0Y2dfdGVtcF9uZXcoKTsgXAorICAgICAgICBUQ0d2IHRtcCA9
IHRjZ190ZW1wX25ldygpOyBcCisgICAgICAgIGludCBpOyBcCisgICAgICAgIHRjZ19nZW5fbW92
aV90bChQZVYsIDApOyBcCisgICAgICAgIHRjZ19nZW5fbW92aV9pNjQoUmRkViwgMCk7IFwKKyAg
ICAgICAgZm9yIChpID0gMDsgaSA8IDg7IGkrKykgeyBcCisgICAgICAgICAgICBmR0VUVUJZVEUo
aSwgUnR0Vik7IFwKKyAgICAgICAgICAgIHRjZ19nZW5fbW92X3RsKGxlZnQsIEJZVEUpOyBcCisg
ICAgICAgICAgICBmR0VUVUJZVEUoaSwgUnNzVik7IFwKKyAgICAgICAgICAgIHRjZ19nZW5fbW92
X3RsKHJpZ2h0LCBCWVRFKTsgXAorICAgICAgICAgICAgdGNnX2dlbl9zZXRjb25kX3RsKFRDR19D
T05EX0dULCB0bXAsIGxlZnQsIHJpZ2h0KTsgXAorICAgICAgICAgICAgZlNFVEJJVChpLCBQZVYs
IHRtcCk7IFwKKyAgICAgICAgICAgIGZNSU4odG1wLCBsZWZ0LCByaWdodCk7IFwKKyAgICAgICAg
ICAgIGZTRVRCWVRFKGksIFJkZFYsIHRtcCk7IFwKKyAgICAgICAgfSBcCisgICAgICAgIHRjZ190
ZW1wX2ZyZWUoQllURSk7IFwKKyAgICAgICAgdGNnX3RlbXBfZnJlZShsZWZ0KTsgXAorICAgICAg
ICB0Y2dfdGVtcF9mcmVlKHJpZ2h0KTsgXAorICAgICAgICB0Y2dfdGVtcF9mcmVlKHRtcCk7IFwK
KyAgICB9IHdoaWxlICgwKQorCisjZGVmaW5lIGZXUkFQX0oyX2NhbGwoR0VOSExQUiwgU0hPUlRD
T0RFKSBcCisgICAgZ2VuX2NhbGwocmlWKQorI2RlZmluZSBmV1JBUF9KMl9jYWxscihHRU5ITFBS
LCBTSE9SVENPREUpIFwKKyAgICBnZW5fY2FsbHIoUnNWKQorCisjZGVmaW5lIGZXUkFQX0oyX2xv
b3AwcihHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBnZW5fbG9vcDByKFJzViwgcmlWLCBpbnNu
KQorI2RlZmluZSBmV1JBUF9KMl9sb29wMXIoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgZ2Vu
X2xvb3AxcihSc1YsIHJpViwgaW5zbikKKworI2RlZmluZSBmV1JBUF9KMl9lbmRsb29wMChHRU5I
TFBSLCBTSE9SVENPREUpIFwKKyAgICBnZW5fZW5kbG9vcDAoKQorI2RlZmluZSBmV1JBUF9KMl9l
bmRsb29wMShHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBnZW5fZW5kbG9vcDEoKQorCiAjZW5k
aWYKLS0gCjIuNy40Cgo=

