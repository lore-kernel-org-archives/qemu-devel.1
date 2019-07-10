Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD32C606CF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E452620665
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYAy0hbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E452620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9pX-0002pl-8Y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hl9nk-0001In-Kx
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hl9nj-0000lt-C8
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:26:16 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hl9nj-0000P2-4Y
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:26:15 -0400
Received: by mail-wr1-x432.google.com with SMTP id r1so1842841wrl.7
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 03:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p1ccHw8zWsSvS6fMryBQBe81FnVDKc6P4UtR9wq8jPM=;
 b=JYAy0hbX7Gnj2kFTy/qWsUo/iKuQLAV1Rc6YOGNv0jwb5XIpucdWhNCsjw5jXflHJo
 SDYRtREOjSmgqkaDhqSD8nGKFAk77EltLnAGci2StIP7odRaw+ZqjcFJKxZWpldd3SMy
 Ws2OfezhtrzkbTquQ3CgE9zt6MYRIipO9SCvVOHrHNQiPKzF+LrTBx9DS/NjG7aFdyMo
 qGABK5pwA5aUxddynZdI0Mll5llxrI7Ze5gNbKJB5D6+PiJ9uvuv6hS1sntew4uXirsN
 ZmADe0X9VklTumzX0hBl65N5pkKt047szsFk982Y9M13ZI7HyVtJ2LzAtF/U/qLwnwAY
 ZEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p1ccHw8zWsSvS6fMryBQBe81FnVDKc6P4UtR9wq8jPM=;
 b=AXBmiIk2X3iNqltuYB7+s2Va6BCu3qiSRehHUChR+h7rRpoXJmm/3KComB12ybuD+U
 OKggDNLdBWMIWh63wL8F32JMrv+yYi3PLCw3F6EorrQMTTB+pcDZKsLHUfaE0A5cp17s
 TtvLRfi+GeWjvRitTnwSnftqC3O0MtayHW7HwDZNittOlmoLdi0J/gPLJlyQuyor0Lx6
 5D6pUVvREDStwL6kUuGiwyBl9YgU1Lp2O5S+X1eCuVIIb/PwGitLiMxotpOHfq0B3pKT
 rsRmxBpQNinqKTfukHk6D5fYJ51HlChp9jUUKNI4Fs2fks+DE5BVj5mYYZ4JE/RflOpe
 PduQ==
X-Gm-Message-State: APjAAAWE5d0WnhTfdAQ9fLlwsY8/g6cmSaYVhw7R4dnd09D46O87zbAt
 WCt5FCy2rtFaLlMAeEBJxmQGnQ==
X-Google-Smtp-Source: APXvYqyzCj/AXrtRCKUk7xeHKvWIwFZ1lRVhEgWRFyJMw73G71riBgz3Vi4PkCkm5VU4RWC+pPM2xQ==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr11520724wre.205.1562754360160; 
 Wed, 10 Jul 2019 03:26:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z1sm1945444wrv.90.2019.07.10.03.25.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 03:25:59 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E00381FF8F;
 Wed, 10 Jul 2019 11:25:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Wed, 10 Jul 2019 11:25:55 +0100
Message-Id: <20190710102557.3107-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710102557.3107-1-alex.bennee@linaro.org>
References: <20190710102557.3107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 2/4] tests/tcg: fix diff-out pass to properly
 report failure
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A side effect of piping the output to head is squash the exit status
of the diff command. Fix this by only doing the pipe if the diff
failed and then ensuring the status is non-zero.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 6fa63cc8d5..9f56768624 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -45,7 +45,11 @@ run-test = $(call quiet-command, timeout $(TIMEOUT) $2,"TEST",$3)
 endif
 
 # $1 = test name, $2 = reference
-diff-out = $(call quiet-command, diff -u $1.out $2 | head -n 10,"DIFF","$1.out with $2")
+# to work around the pipe squashing the status we only pipe the result if
+# we know it failed and then force failure at the end.
+diff-out = $(call quiet-command, diff -q $1.out $2 || \
+                                 (diff -u $1.out $2 | head -n 10 && false), \
+                                 "DIFF","$1.out with $2")
 
 # $1 = test name, $2 = reason
 skip-test = @printf "  SKIPPED %s on $(TARGET_NAME) because %s\n" $1 $2
-- 
2.20.1


