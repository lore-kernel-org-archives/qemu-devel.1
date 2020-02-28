Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE8DC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BC824691
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kz+AiOtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BC824691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7j9n-0002mx-Nl
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ilM-0004J8-NN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ilK-0006RS-GA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:45:19 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ikw-0005U4-38
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908294; x=1614444294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hl3c1PPffgT0DZUEFvDjHJlbmHMk6/W2TQ7gMUsroKo=;
 b=Kz+AiOtKdYZsddYNGATrWtbav3kZA7x+si312lpirBSFmXM2t1y1WKez
 U35LwKOSq0Vk7iKgN80c4dH8JP5hArX6Tal5Evzj5EHKvz4ZUFOMtSimV
 rkL9inN6JJ6PDgEBXgzmDfY0cyTF3MxiwO4uz/B1GhBho7AqDFru1CtlI w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Feb 2020 08:44:31 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 28 Feb 2020 08:44:31 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 062071110; Fri, 28 Feb 2020 10:44:31 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 37/67] Hexagon TCG generation helpers - step 4
Date: Fri, 28 Feb 2020 10:43:33 -0600
Message-Id: <1582908244-304-38-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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

SGVscGVycyByZWZlcmVuY2VkIGluIG1hY3Jvcy5oCgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2lt
cHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyX2hl
bHBlcnMuaCB8IDY3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2dlbnB0cl9oZWxwZXJzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5wdHJfaGVscGVycy5oCmlu
ZGV4IDBlMmQ3YjkuLjk5MTdkNzIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbnB0cl9o
ZWxwZXJzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyX2hlbHBlcnMuaApAQCAtNDYzLDQg
KzQ2Myw3MSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3N0b3JlOGkoVENHdl9lbnYgY3B1X2Vu
diwgVENHdiB2YWRkciwgaW50NjRfdCBzcmMsCiAgICAgdGNnX3RlbXBfZnJlZV9pNjQodG1wKTsK
IH0KIAorc3RhdGljIGlubGluZSBUQ0d2X2k2NCBnZW5fY2FycnlfZnJvbV9hZGQ2NChUQ0d2X2k2
NCByZXN1bHQsIFRDR3ZfaTY0IGEsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFRDR3ZfaTY0IGIsIFRDR3ZfaTY0IGMpCit7CisgICAgVENHdl9pNjQgV09SRCA9
IHRjZ190ZW1wX25ld19pNjQoKTsKKyAgICBUQ0d2X2k2NCB0bXBhID0gdGNnX3RlbXBfbmV3X2k2
NCgpOworICAgIFRDR3ZfaTY0IHRtcGIgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7CisgICAgVENHdl9p
NjQgdG1wYyA9IHRjZ190ZW1wX25ld19pNjQoKTsKKworICAgIHRjZ19nZW5fbW92X2k2NCh0bXBh
LCBmR0VUVVdPUkQoMCwgYSkpOworICAgIHRjZ19nZW5fbW92X2k2NCh0bXBiLCBmR0VUVVdPUkQo
MCwgYikpOworICAgIHRjZ19nZW5fYWRkX2k2NCh0bXBjLCB0bXBhLCB0bXBiKTsKKyAgICB0Y2df
Z2VuX2FkZF9pNjQodG1wYywgdG1wYywgYyk7CisgICAgdGNnX2dlbl9tb3ZfaTY0KHRtcGEsIGZH
RVRVV09SRCgxLCBhKSk7CisgICAgdGNnX2dlbl9tb3ZfaTY0KHRtcGIsIGZHRVRVV09SRCgxLCBi
KSk7CisgICAgdGNnX2dlbl9hZGRfaTY0KHRtcGMsIHRtcGEsIHRtcGIpOworICAgIHRjZ19nZW5f
YWRkX2k2NCh0bXBjLCB0bXBjLCBmR0VUVVdPUkQoMSwgdG1wYykpOworICAgIHRjZ19nZW5fbW92
X2k2NChyZXN1bHQsIGZHRVRVV09SRCgxLCB0bXBjKSk7CisKKyAgICB0Y2dfdGVtcF9mcmVlX2k2
NChXT1JEKTsKKyAgICB0Y2dfdGVtcF9mcmVlX2k2NCh0bXBhKTsKKyAgICB0Y2dfdGVtcF9mcmVl
X2k2NCh0bXBiKTsKKyAgICB0Y2dfdGVtcF9mcmVlX2k2NCh0bXBjKTsKKyAgICByZXR1cm4gcmVz
dWx0OworfQorCitzdGF0aWMgaW5saW5lIFRDR3YgZ2VuXzhiaXRzb2YoVENHdiByZXN1bHQsIFRD
R3YgdmFsdWUpCit7CisgICAgVENHdiB6ZXJvID0gdGNnX2NvbnN0X3RsKDApOworICAgIFRDR3Yg
b25lcyA9IHRjZ19jb25zdF90bCgweGZmKTsKKyAgICB0Y2dfZ2VuX21vdmNvbmRfdGwoVENHX0NP
TkRfTkUsIHJlc3VsdCwgdmFsdWUsIHplcm8sIG9uZXMsIHplcm8pOworICAgIHRjZ190ZW1wX2Zy
ZWUoemVybyk7CisgICAgdGNnX3RlbXBfZnJlZShvbmVzKTsKKworICAgIHJldHVybiByZXN1bHQ7
Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fd3JpdGVfbmV3X3BjKFRDR3YgYWRkcikKK3sK
KyAgICAvKiBJZiB0aGVyZSBhcmUgbXVsdGlwbGUgYnJhbmNoZXMgaW4gYSBwYWNrZXQsIGlnbm9y
ZSB0aGUgc2Vjb25kIG9uZSAqLworICAgIFRDR3YgemVybyA9IHRjZ19jb25zdF90bCgwKTsKKyAg
ICB0Y2dfZ2VuX21vdmNvbmRfdGwoVENHX0NPTkRfTkUsIGhleF9uZXh0X1BDLCBoZXhfYnJhbmNo
X3Rha2VuLCB6ZXJvLAorICAgICAgICAgICAgICAgICAgICAgICBoZXhfbmV4dF9QQywgYWRkcik7
CisgICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9icmFuY2hfdGFrZW4sIDEpOworICAgIHRjZ190ZW1w
X2ZyZWUoemVybyk7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fc2V0X3Vzcl9maWVsZChp
bnQgZmllbGQsIFRDR3YgdmFsKQoreworICAgIHRjZ19nZW5fZGVwb3NpdF90bChoZXhfZ3ByW0hF
WF9SRUdfVVNSXSwgaGV4X2dwcltIRVhfUkVHX1VTUl0sIHZhbCwKKyAgICAgICAgICAgICAgICAg
ICAgICAgcmVnX2ZpZWxkX2luZm9bZmllbGRdLm9mZnNldCwKKyAgICAgICAgICAgICAgICAgICAg
ICAgcmVnX2ZpZWxkX2luZm9bZmllbGRdLndpZHRoKTsKK30KKworc3RhdGljIGlubGluZSB2b2lk
IGdlbl9zZXRfdXNyX2ZpZWxkaShpbnQgZmllbGQsIGludCB4KQoreworICAgIFRDR3YgdmFsID0g
dGNnX2NvbnN0X3RsKHgpOworICAgIGdlbl9zZXRfdXNyX2ZpZWxkKGZpZWxkLCB2YWwpOworICAg
IHRjZ190ZW1wX2ZyZWUodmFsKTsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGdlbl9jb25kX3Jl
dHVybihUQ0d2IHByZWQsIFRDR3YgYWRkcikKK3sKKyAgICBUQ0d2IHplcm8gPSB0Y2dfY29uc3Rf
dGwoMCk7CisgICAgdGNnX2dlbl9tb3Zjb25kX3RsKFRDR19DT05EX05FLCBoZXhfbmV4dF9QQywg
cHJlZCwgemVybywgYWRkciwgaGV4X25leHRfUEMpOworICAgIHRjZ190ZW1wX2ZyZWUoemVybyk7
Cit9CisKICNlbmRpZgotLSAKMi43LjQKCg==

