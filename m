Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06997C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB02E20663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y09k1vHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB02E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdFu-0003yH-VD
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdET-00028v-2k
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdER-0005oi-Fz
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id o11so23962721wrv.9
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+TAlbHIsXZGW5UODRkH4obAQs4koVX0V9BG/gRdLybw=;
 b=y09k1vHUBlQF6ueTAew75bX5pYxYqt0PC9MgykKFtA/gJVlmKc7nDYFKeo1XfNNRPs
 3iLZezc0+CT+/fyIz2Ohh5FF3Qh3xJdvO0O+6MbhETkDFBKFoJZrbjI9RRkwTMOfhk0r
 V3SO4T/AuhMj1XxRjcQKx67mMUO8PmZMn7xDi/zJR/rhJWCAb7SPYfP5tS1nvh8zQ65W
 4dxM5hT9LbWkNxeaOqWIKDcDcPDlkeJ2zb/HBe1Xi9zULkpx6mbl4t6SxNHQtV0BWul5
 kRYnsAodSJA8nXSKPvR8baXcvJGKya3r+PJYMEkAM45sGklUwNIytfTbL/OpVICZTdv7
 y81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+TAlbHIsXZGW5UODRkH4obAQs4koVX0V9BG/gRdLybw=;
 b=DSR0X8SsXzOs3nuHIZFuqSKxAiELDv9yOtS2uipBRACn3msc6PHdsyIUBpyOFhbDDs
 z4cCM64a1ZY5cQ7ZntArSUT/Pt/NSKb4Yt742qkRA0593c1H0KPlsGgitxJaNhDHZFXN
 GW6nIkEH1cPIJrdrA3c35SseYOXOOpefBI54PF3DqWkYr/ha4pBknVMM0VqzV9FImFD6
 AnIj+GSU9W2VpJO/OOPTLSuH8GhbmCdDpHsDmddnd49D3rK/ZvTqF+NM55grEdWVITgq
 31czWVPd6BacR7eCTieUunbnzFgxOOWWooCYf1ZxKrCpTIZF2NvT8VAb8YAQxhoTUOqT
 r0cw==
X-Gm-Message-State: AOAM530tXEuDpHpuIkjGO6xdhQ+OdV0xHB7WNJtQB1yaWgFUR8yvOzLP
 JLdRYHokwJiWiNVg3jnkopEfKA==
X-Google-Smtp-Source: ABdhPJzLiB4X3i0qDIl00ICcftlAoLeJuOPbYzJXhxSE5gi26UBKqyyzv2WvfhcZ4qeblUN6hPeyxA==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr25745216wrp.183.1593611818079; 
 Wed, 01 Jul 2020 06:56:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v18sm7914893wrv.49.2020.07.01.06.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:56:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ECC7A1FF87;
 Wed,  1 Jul 2020 14:56:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/40] hw/isa: check for current_cpu before generating IRQ
Date: Wed,  1 Jul 2020 14:56:13 +0100
Message-Id: <20200701135652.1366-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, berrange@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Bug 1878645 <1878645@bugs.launchpad.net>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's possible to trigger this function from qtest/monitor at which
point current_cpu won't point at the right place. Check it and
fall back to first_cpu if it's NULL.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Bug 1878645 <1878645@bugs.launchpad.net>
---
 hw/isa/lpc_ich9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index cd6e169d47a..791c878eb0b 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -439,7 +439,7 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
                 cpu_interrupt(cs, CPU_INTERRUPT_SMI);
             }
         } else {
-            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
+            cpu_interrupt(current_cpu ? current_cpu : first_cpu, CPU_INTERRUPT_SMI);
         }
     }
 }
-- 
2.20.1


