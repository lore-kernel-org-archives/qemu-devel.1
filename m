Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52730C352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2056020733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B9yxKmRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2056020733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1JfR-0007iX-57
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbv-0000yq-CN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbs-00059q-OR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:07 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jbs-0004qc-AM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381664; x=1612917664;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wUA5ChMziEDR+sp00VBMc885J3oVwqU/uH8Yhd+Ny+U=;
 b=B9yxKmRIwX6v7XOXhoJNj06Yfqs1R1rWRMgpEUZ2hcwsGqEl7SdohN/k
 MgZOB0GXxrD8usvOL7I3EZmsLplFpe+NA6YGICliA7OMVpy7tJj4pP7++
 Xymt80oo3kDyIZDBRcE39QEEx57gH5m7ZXat5ojzcaAjaGXVNPqaZ0y7k o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2020 16:40:59 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:40:58 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id D70AC1BBA; Mon, 10 Feb 2020 18:40:57 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 09/66] Hexagon architecture types
Date: Mon, 10 Feb 2020 18:39:47 -0600
Message-Id: <1581381644-13678-10-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
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

RGVmaW5lIHR5cGVzIHVzZWQgaW4gZmlsZXMgaW1wb3J0ZWQgZnJvbSB0aGUgSGV4YWdvbiBhcmNo
aXRlY3R1cmUgbGlicmFyeQoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29u
QHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleF9hcmNoX3R5cGVzLmggfCA0MiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDQyIGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9oZXhf
YXJjaF90eXBlcy5oCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2FyY2hfdHlwZXMu
aCBiL3RhcmdldC9oZXhhZ29uL2hleF9hcmNoX3R5cGVzLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMC4uM2Y4OTk4NgotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29u
L2hleF9hcmNoX3R5cGVzLmgKQEAgLTAsMCArMSw0MiBAQAorLyoKKyAqICBDb3B5cmlnaHQgKGMp
IDIwMTkgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZl
ZC4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0
cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisg
KiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9n
cmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisg
KiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2Fy
cmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFS
IFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1v
cmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3Jh
bTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgorICovCisKKyNp
Zm5kZWYgSEVYQUdPTl9BUkNIX1RZUEVTX0gKKyNkZWZpbmUgSEVYQUdPTl9BUkNIX1RZUEVTX0gK
KworLyoKKyAqIFRoZXNlIHR5cGVzIGFyZSB1c2VkIGJ5IHRoZSBjb2RlIGdlbmVyYXRlZCBmcm9t
IHRoZSBIZXhhZ29uCisgKiBhcmNoaXRlY3R1cmUgbGlicmFyeS4KKyAqLwordHlwZWRlZiB1bnNp
Z25lZCBjaGFyIHNpemUxdV90OwordHlwZWRlZiBjaGFyIHNpemUxc190OwordHlwZWRlZiB1bnNp
Z25lZCBzaG9ydCBpbnQgc2l6ZTJ1X3Q7Cit0eXBlZGVmIHNob3J0IHNpemUyc190OwordHlwZWRl
ZiB1bnNpZ25lZCBpbnQgc2l6ZTR1X3Q7Cit0eXBlZGVmIGludCBzaXplNHNfdDsKK3R5cGVkZWYg
dW5zaWduZWQgbG9uZyBsb25nIGludCBzaXplOHVfdDsKK3R5cGVkZWYgbG9uZyBsb25nIGludCBz
aXplOHNfdDsKK3R5cGVkZWYgc2l6ZTh1X3QgcGFkZHJfdDsKK3R5cGVkZWYgc2l6ZTR1X3QgdmFk
ZHJfdDsKK3R5cGVkZWYgc2l6ZTh1X3QgcGN5Y2xlc190OworCit0eXBlZGVmIHN0cnVjdCBzaXpl
MTZzIHsKKyAgICBzaXplOHNfdCBoaTsKKyAgICBzaXplOHVfdCBsbzsKK30gc2l6ZTE2c190Owor
CisjZW5kaWYKLS0gCjIuNy40Cgo=

