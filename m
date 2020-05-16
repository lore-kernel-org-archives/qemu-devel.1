Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D76EC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47581206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrln+Nkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47581206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja12G-0001q4-BV
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0th-0003e8-LK
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:53 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tg-0008U3-SU
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:53 -0400
Received: by mail-lj1-x242.google.com with SMTP id d21so5549058ljg.9
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z0afUpJkkx4R4jVR4cPPKTN2hxXL/in4qcliTU46vwU=;
 b=Mrln+NknN+SZ//9QLihyIXBZUiDHGUu5KJOEG0jJFCPlxKY3IOrHZwi6CyrbW6xpPS
 9+UFExdtBwS49h4PC8H0jrI4k/oukOfHns46JIivlYHzuLyJgVT64DZqY3/Kxwp6bjb6
 3VzVYPvA3h1UYScPGVayID27m5+w6Q0+9QE7ttP84HWKAq+zvUKAqj5hutDVyNTpJPsK
 KrELbujF48QIoJtRO/Orkmy+7VBsKq2kqDotf2NYZL7ul1aLGu1sqD2/YAbwkd9tlkul
 PLucTN5I06etLnmPmqSUwoT1QIpbmK2DZn6dxEU1aH0MN+Wv5nszr8pKOFXMsNo9pXEx
 m7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z0afUpJkkx4R4jVR4cPPKTN2hxXL/in4qcliTU46vwU=;
 b=BiI0ILkdL9XpJFPqPXk2JS0zEmMNk9GDpJSDGJtn+eFglfvjuFEiLPAeCvBmUP4FUs
 mdXQ4l1uYV3GlTvesPcxoXc7ThLFSzanT1aSMNWjoyYPViCpR6GP1PYclW5kKKSYDMgH
 WNjrg1DNZi6lgPoJLbooLtl8VLQL0Duvxd8dv3Ysc2DgsXD9tVdubXm3v4vCYN0MC0Fq
 F+ZCilBANn/Yh2iy0nh+8u66wNTy/yF3guS/ZsFv9j6b8Jz2w8mrsT0ivjtKxVrAeh2m
 CpKA+WLKFcYzb9sl5nn4uQ/DsKQXzF4jWCdwDp2vKlwcO1Oe6EaLt0w1LA601l3l8QCN
 yJOA==
X-Gm-Message-State: AOAM5310w8/uW1axsZCz4NdhPfgYdoZwIyIZdMVQ8ZZbzDZ7GpaecVKp
 tDP3AukqKI5Q+EFrqCdnD05xZ1aSUvY=
X-Google-Smtp-Source: ABdhPJxz17uT9howp6KHJ4HZrw0YH8vXJtNO0o0ixfzwGf+WWvCIssLT6hIIwOcD5ah9XFggM3VuZg==
X-Received: by 2002:a2e:878b:: with SMTP id n11mr5670764lji.196.1589651211016; 
 Sat, 16 May 2020 10:46:51 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id i1sm3024759lja.3.2020.05.16.10.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 10:46:50 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/18] hw/mips: Add some logging for bad register offset
 cases
Date: Sat, 16 May 2020 19:45:47 +0200
Message-Id: <20200516174548.7631-18-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Log the cases where a guest attempts read or write using bad
register offset.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
CC: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_malta.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e4c4de1b4e..88869b828e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -427,10 +427,9 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "malta_fpga_read: Bad register offset 0x"
+                      TARGET_FMT_lx "\n", addr);
         break;
     }
     return val;
@@ -515,10 +514,9 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "malta_fpga_write: Bad register offset 0x"
+                      TARGET_FMT_lx "\n", addr);
         break;
     }
 }
-- 
2.20.1


