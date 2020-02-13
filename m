Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E2C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF052073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pzwh0JRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF052073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FiZ-0005uT-Ry
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgi-0004At-Io
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgh-0001QH-Cv
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:56 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:40363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgg-0001Jw-3X
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:55 -0500
Received: by mail-wr1-x42b.google.com with SMTP id t3so6978710wru.7
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5QW6Q1EJKNnfHRnGkMMq3g240uRrMtzhye8Daf9kap0=;
 b=pzwh0JRNzbgzXLuIIOn36aAf5N0rkLo+dd+BOgXKPjML24IRd/apN5rEnlhmkTkH9X
 fD69ZSNML4jKlH6+pK6Odcv+oWJ/uYoY6TWtpUQxLoXEUGYthpmh5eB78Pmql+zwfpv8
 qP6dH3yH8Da1s+fA6KNjSVwvN58uI1ysrMAm0WQIDeONXGe08lmJZPjwwuIMewTHxF3+
 ttSEPFtbXKiZNGNBvOvtD1H8OSQYRXZFN64wHJ+o8n31BuIGp+XhUslFQkAIa7zWdeZT
 E+TY4BNvTRII0QV5RXkli2vhb5R2A3x69R79oouTYcceFFMiEitKGjzQConhecEu9VuP
 wrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5QW6Q1EJKNnfHRnGkMMq3g240uRrMtzhye8Daf9kap0=;
 b=eBGj8Xpobzkm4vuP2gdqJULZKCsZiwco15J5Df0j9swxSM8VS2VY4wRarwvs35baqp
 Wm+kwrQczO/Tm5GEXKApFqd+SseV5XRU5VZQiTe1+zB40LElJMM/xOAs8QnlgSkIyyVj
 h/KGF8CKUCuKlUUS0ebyyoOhL4RRwAOlG6E6Ik6g7jU1NmzMyI9RPjNss3FeaKRCDE0P
 SMKtw5ebPWUCgYzwx6ZRb8B++wnrrWUSWGe46PgUTf21W8SImoOaMgBODJRkAu1pngUI
 sxh8fBO+JfsFi8C034ieDWSLzJKCBC0FiVRtWMvCYtcLdgnklkcfSeC9FIojocWzttia
 pc4Q==
X-Gm-Message-State: APjAAAWvkS+LJh0jviOt4UlDmDNBfcJyjghrCmeMjLP4xFf0w5EOY5jD
 9136cdDzEz2dvL/APeyeWWdwXULk3Uc=
X-Google-Smtp-Source: APXvYqztGyu3s8i3X8xYVHfovkIMdiGVfNGYiHwr5RYvXd5RKA4df+qv8ehBTQk/tFNr+SE1E/+8ig==
X-Received: by 2002:adf:f986:: with SMTP id f6mr23124895wrr.182.1581604911259; 
 Thu, 13 Feb 2020 06:41:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/46] bios-tables-test: prepare to change ARM virt ACPI DSDT
Date: Thu, 13 Feb 2020 14:41:02 +0000
Message-Id: <20200213144145.818-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Heyi Guo <guoheyi@huawei.com>

We are going to change ARM virt ACPI DSDT table, which will cause make
check to fail, so temporarily add related golden masters to ignore
list.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200204014325.16279-2-guoheyi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..32a401ae35f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/DSDT",
+"tests/data/acpi/virt/DSDT.memhp",
+"tests/data/acpi/virt/DSDT.numamem",
-- 
2.20.1


