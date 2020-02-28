Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD7C3F2D3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA78F246AC
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WIAbdj4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA78F246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jFC-0002n3-2w
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7imF-0005lx-Nv
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7imE-0007M6-DP
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:46:15 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7imD-0005Uz-U5
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908373; x=1614444373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aUnucCXNDqTLAKibifQCy+WW+56jaP4aw4DAtOOja18=;
 b=WIAbdj4qt6PeID/ef7pR2tdO2JacSC27sZbzlbGnebWbVTc2o4lRTTl9
 4cn1KGjrjej38eLFF8auDcp13DFO7XKOSYdE5TV+z5VcWABe66c+BNBKJ
 wxyO2WtFgmojW8vmgKdopfjORLRdpGctbWaayGdpRQY7nmsgYjMNDVMZl I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Feb 2020 08:44:32 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg02-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:31 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 8567C11D2; Fri, 28 Feb 2020 10:44:31 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 43/67] Hexagon TCG generation - step 05
Date: Fri, 28 Feb 2020 10:43:39 -0600
Message-Id: <1582908244-304-44-git-send-email-tsimpson@quicinc.com>
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

T3ZlcnJpZGUgcHJlZGljYXRlZCBzdG9yZSBpbnN0cnVjdGlvbnMKClNpZ25lZC1vZmYtYnk6IFRh
eWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9o
ZWxwZXJfb3ZlcnJpZGVzLmggfCA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaGVscGVyX292ZXJyaWRlcy5oIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyX292
ZXJyaWRlcy5oCmluZGV4IGZkY2M1MTcuLmE2Y2JjZTAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2hlbHBlcl9vdmVycmlkZXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXJfb3ZlcnJp
ZGVzLmgKQEAgLTg3Nyw0ICs4NzcsNTggQEAKICNkZWZpbmUgZldSQVBfUzJfc3RvcmVyaW5ld2dw
KEdFTkhMUFIsIFNIT1JUQ09ERSkgXAogICAgIGZXUkFQX1NUT1JFKFNIT1JUQ09ERSkKIAorLyog
UHJlZGljYXRlZCBzdG9yZXMgKi8KKyNkZWZpbmUgZldSQVBfUFJFRF9TVE9SRShHRVRfRUEsIFBS
RUQsIFNSQywgU0laRSwgSU5DKSBcCisgICAgZG8geyBcCisgICAgICAgIFRDR3YgTFNCID0gdGNn
X3RlbXBfbG9jYWxfbmV3KCk7IFwKKyAgICAgICAgVENHdiBORVdSRUdfU1QgPSB0Y2dfdGVtcF9s
b2NhbF9uZXcoKTsgXAorICAgICAgICBUQ0d2IEJZVEUgPSB0Y2dfdGVtcF9sb2NhbF9uZXcoKTsg
XAorICAgICAgICBUQ0d2IEhBTEYgPSB0Y2dfdGVtcF9sb2NhbF9uZXcoKTsgXAorICAgICAgICBU
Q0dMYWJlbCAqbGFiZWwgPSBnZW5fbmV3X2xhYmVsKCk7IFwKKyAgICAgICAgR0VUX0VBOyBcCisg
ICAgICAgIFBSRUQ7ICBcCisgICAgICAgIFBSRURfU1RPUkVfQ0FOQ0VMKExTQiwgRUEpOyBcCisg
ICAgICAgIHRjZ19nZW5fYnJjb25kaV90bChUQ0dfQ09ORF9FUSwgTFNCLCAwLCBsYWJlbCk7IFwK
KyAgICAgICAgICAgIElOQzsgXAorICAgICAgICAgICAgZlNUT1JFKDEsIFNJWkUsIEVBLCBTUkMp
OyBcCisgICAgICAgIGdlbl9zZXRfbGFiZWwobGFiZWwpOyBcCisgICAgICAgIHRjZ190ZW1wX2Zy
ZWUoTFNCKTsgXAorICAgICAgICB0Y2dfdGVtcF9mcmVlKE5FV1JFR19TVCk7IFwKKyAgICAgICAg
dGNnX3RlbXBfZnJlZShCWVRFKTsgXAorICAgICAgICB0Y2dfdGVtcF9mcmVlKEhBTEYpOyBcCisg
ICAgfSB3aGlsZSAoMCkKKworI2RlZmluZSBOT0lOQyAgICBkbyB7fSB3aGlsZSAoMCkKKworI2Rl
ZmluZSBmV1JBUF9TNF9wc3RvcmVyaW5ld2ZuZXdfcnIoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisg
ICAgZldSQVBfUFJFRF9TVE9SRShmRUFfUlJzKFJzViwgUnVWLCB1aVYpLCBmTFNCTkVXTk9UKFB2
TiksIFwKKyAgICAgICAgICAgICAgICAgICAgIGhleF9uZXdfdmFsdWVbTnRYXSwgNCwgTk9JTkMp
CisjZGVmaW5lIGZXUkFQX1MyX3BzdG9yZXJkdG5ld19waShHRU5ITFBSLCBTSE9SVENPREUpIFwK
KyAgICBmV1JBUF9QUkVEX1NUT1JFKGZFQV9SRUcoUnhWKSwgZkxTQk5FVyhQdk4pLCBcCisgICAg
ICAgICAgICAgICAgICAgICBSdHRWLCA4LCB0Y2dfZ2VuX2FkZGlfdGwoUnhWLCBSeFYsIElNTU5P
KDApKSkKKyNkZWZpbmUgZldSQVBfUzRfcHN0b3JlcmR0bmV3X2lvKEdFTkhMUFIsIFNIT1JUQ09E
RSkgXAorICAgIGZXUkFQX1BSRURfU1RPUkUoZkVBX1JJKFJzViwgdWlWKSwgZkxTQk5FVyhQdk4p
LCBcCisgICAgICAgICAgICAgICAgICAgICBSdHRWLCA4LCBOT0lOQykKKyNkZWZpbmUgZldSQVBf
UzRfcHN0b3JlcmJ0bmV3X2lvKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZXUkFQX1BSRURf
U1RPUkUoZkVBX1JJKFJzViwgdWlWKSwgZkxTQk5FVyhQdk4pLCBcCisgICAgICAgICAgICAgICAg
ICAgICBmR0VUQllURSgwLCBSdFYpLCAxLCBOT0lOQykKKyNkZWZpbmUgZldSQVBfUzJfcHN0b3Jl
cmh0bmV3X3BpKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZXUkFQX1BSRURfU1RPUkUoZkVB
X1JFRyhSeFYpLCBmTFNCTkVXKFB2TiksIFwKKyAgICAgICAgICAgICAgICAgICAgIGZHRVRIQUxG
KDAsIFJ0ViksIDIsIHRjZ19nZW5fYWRkaV90bChSeFYsIFJ4ViwgSU1NTk8oMCkpKQorI2RlZmlu
ZSBmV1JBUF9TMl9wc3RvcmVyaXRuZXdfcGkoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgZldS
QVBfUFJFRF9TVE9SRShmRUFfUkVHKFJ4ViksIGZMU0JORVcoUHZOKSwgXAorICAgICAgICAgICAg
ICAgICAgICAgUnRWLCA0LCB0Y2dfZ2VuX2FkZGlfdGwoUnhWLCBSeFYsIElNTU5PKDApKSkKKyNk
ZWZpbmUgZldSQVBfUzJfcHN0b3JlcmlmX2lvKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZX
UkFQX1BSRURfU1RPUkUoZkVBX1JJKFJzViwgdWlWKSwgZkxTQk9MRE5PVChQdlYpLCBcCisgICAg
ICAgICAgICAgICAgICAgICBSdFYsIDQsIE5PSU5DKQorI2RlZmluZSBmV1JBUF9TNF9wc3RvcmVy
aXRfYWJzKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZXUkFQX1BSRURfU1RPUkUoZkVBX0lN
TSh1aVYpLCBmTFNCT0xEKFB2ViksIFwKKyAgICAgICAgICAgICAgICAgICAgIFJ0ViwgNCwgTk9J
TkMpCisjZGVmaW5lIGZXUkFQX1MyX3BzdG9yZXJpbmV3Zl9pbyhHRU5ITFBSLCBTSE9SVENPREUp
IFwKKyAgICBmV1JBUF9QUkVEX1NUT1JFKGZFQV9SSShSc1YsIHVpViksIGZMU0JPTEROT1QoUHZW
KSwgXAorICAgICAgICAgICAgICAgICAgICAgaGV4X25ld192YWx1ZVtOdFhdLCA0LCBOT0lOQykK
KyNkZWZpbmUgZldSQVBfUzRfcHN0b3JlcmJuZXdmbmV3X2FicyhHRU5ITFBSLCBTSE9SVENPREUp
IFwKKyAgICBmV1JBUF9QUkVEX1NUT1JFKGZFQV9JTU0odWlWKSwgZkxTQk5FV05PVChQdk4pLCBc
CisgICAgICAgICAgICAgICAgICAgICBmR0VUQllURSgwLCBoZXhfbmV3X3ZhbHVlW050WF0pLCAx
LCBOT0lOQykKKwogI2VuZGlmCi0tIAoyLjcuNAoK

