Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FD3C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F366D2467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IWfUzLGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F366D2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iuP-0001fo-1E
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ike-0002p4-Ae
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ikb-0005Xz-AW
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:36 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ika-0005V5-VO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908273; x=1614444273;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y6iiHgGft838LH+KvRz/qVa7iKXNLC9bLGCEsCi6gNE=;
 b=IWfUzLGxjXbaf2uQLKCKTwlED0McJj0ZIEewMNphL2rno+lCqq+igB7U
 SkKnYl9LLuaq5m/fYYSCiKEf4aVF/M8seVibXvkBhIF4jd/Z/mTcq7leh
 XwzgA86hPu8J5J4prF255HmPKg3Ki8l9NfTx9L4LKJwAHMM0NvCUPQUGX g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Feb 2020 08:44:30 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg01-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:30 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id DB78D1163; Fri, 28 Feb 2020 10:44:29 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 24/67] Hexagon generator phase 2 -
 opcodes_def_generated.h
Date: Fri, 28 Feb 2020 10:43:20 -0600
Message-Id: <1582908244-304-25-git-send-email-tsimpson@quicinc.com>
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

R2l2ZXMgYSBsaXN0IG9mIGFsbCB0aGUgb3Bjb2RlcwoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNp
bXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2RvX3FlbXUu
cHkgfCAxMiArKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZG9fcWVtdS5weSBiL3RhcmdldC9oZXhhZ29uL2Rv
X3FlbXUucHkKaW5kZXggM2Y1MmVmMy4uMTA3ZTFlOCAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFn
b24vZG9fcWVtdS5weQorKysgYi90YXJnZXQvaGV4YWdvbi9kb19xZW11LnB5CkBAIC03ODEsMyAr
NzgxLDE1IEBAIHJlYWxmLndyaXRlKGYuZ2V0dmFsdWUoKSkKIHJlYWxmLmNsb3NlKCkKIGYuY2xv
c2UoKQogCisjIworIyMgR2VuZXJhdGUgdGhlIG9wY29kZXNfZGVmX2dlbmVyYXRlZC5oIGZpbGUK
KyMjICAgICBHaXZlcyBhIGxpc3Qgb2YgYWxsIHRoZSBvcGNvZGVzCisjIworZiA9IFN0cmluZ0lP
KCkKK2ZvciB0YWcgaW4gdGFnczoKKyAgICBmLndyaXRlICggIk9QQ09ERSglcyksXG4iICUgKHRh
ZykgKQorcmVhbGYgPSBvcGVuKCdvcGNvZGVzX2RlZl9nZW5lcmF0ZWQuaCcsICd3dCcpCityZWFs
Zi53cml0ZShmLmdldHZhbHVlKCkpCityZWFsZi5jbG9zZSgpCitmLmNsb3NlKCkKKwotLSAKMi43
LjQKCg==

