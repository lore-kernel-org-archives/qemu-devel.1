Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA5C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D65420721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKJs7202"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D65420721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXmS-00041S-FO
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjk-0006cE-O1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjj-0000yp-Ke
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:44 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjj-0000xT-EP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:43 -0500
Received: by mail-wr1-x433.google.com with SMTP id m16so16879750wrx.11
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ketdZJIBB2Zzh/xBKVPQL7tNfdR8XO5kq26WcCcX7Dw=;
 b=GKJs7202od3TNOM2JJXPjtQb3QkzId0kpXTfEfQgyjN2SFa0UGi4cUe/Rvi2qVxj0i
 /wFGuUGcT/kCL8fMqwTnm2WXzEsgB3BxCs8iMCbBrU5A5mwmHltoPPL2H7IBCksh41gS
 md2Ed12W1P+daR0wWc/uOnWh3dFnHpcHxcIxSAJTzulaueM7sTcNcyPzL410yaNe+r+L
 M6qmfOkHLlukdllvKhsD77Tqa79nXXbqm6f/y5ZLGJHrlnZ5xDHaI1Y7Nse3UlYvwbN7
 rLZ0ONeeCnSwkPCPrQv+RMBbYwbPS3Zye36go2GSfaRQVJPUe4fXKZr0YWThnOMax2QC
 F++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ketdZJIBB2Zzh/xBKVPQL7tNfdR8XO5kq26WcCcX7Dw=;
 b=HKoji7veyWeNkwCvWghvtHGgROdjpCBXRTm/SBzKvMge/wNSosxGhVOo6iH7LVNTwD
 AOtLkgRCMtJTBrqYBAYPO95A2T3PHENbJa9Z4BuFFGJ0NFif294S3txTuU9hgvtqH7Yi
 V5FEMo0LM3CHisH/odsMiuCL9fOHvJgPYAgjcVCZU6QQqZSMAo8FwqaLP3TeYj7GP4d2
 DNCykV3/v4tmHd6dh8VRY6qdDJNhih3sk1WlF0ZOboyCQ9Kwy8cwHajWaLhqdwCpuim4
 MSlcyqj6CtQGt3+ck/H+Q1agS8XKVQq3XPCz/uO/mb3PdHrDT0JQP9bCoD0AxtwxhAa/
 Cq0Q==
X-Gm-Message-State: APjAAAUo/dyBupZzt+pqM9YSEEkwVqknX7aVNxGyYQbqcbEKbXCVCkYz
 Z5RQvTU8nCK3C8UypJBB5dSeyg==
X-Google-Smtp-Source: APXvYqxAt8cd8qYOEePTXG3x7AlJrbyrKfmgNTNkitIe86gvm6hWQB9cIH2GnP4J0y+93Fw7KvnD7g==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr13566045wrn.133.1580720982426; 
 Mon, 03 Feb 2020 01:09:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b17sm24880115wrp.49.2020.02.03.01.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DA8621FF93;
 Mon,  3 Feb 2020 09:09:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/17] hw/hppa/Kconfig: LASI chipset requires PARALLEL port
Date: Mon,  3 Feb 2020 09:09:21 +0000
Message-Id: <20200203090932.19147-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Helge Deller <deller@gmx.de>, richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The PARISC Lasi chipset emulation requires some of the common parallel
support and fails to build on a --without-default-devices:

    LINK    hppa-softmmu/qemu-system-hppa
  /usr/bin/ld: hw/hppa/lasi.o: in function `lasi_init':
  hw/hppa/lasi.c:324: undefined reference to `parallel_mm_init'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:206: qemu-system-hppa] Error 1

Fixes: 376b851909d
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20200129192350.27143-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/hppa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index 82178c7dcb7..22948db0256 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -12,4 +12,5 @@ config DINO
     select LSI_SCSI_PCI
     select LASI_82596
     select LASIPS2
+    select PARALLEL
     select ARTIST
-- 
2.20.1


