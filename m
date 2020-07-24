Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2862BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 21:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6FB206F6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 21:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUf2UV+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6FB206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz5Ah-0005st-4j
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 17:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz5A3-0005Qu-1n
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 17:23:23 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz59y-0000IM-P4
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 17:23:22 -0400
Received: by mail-pj1-x1042.google.com with SMTP id k1so6098894pjt.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7IhsA8lpB2O9xmXjvFVCcN+db4XOS/692WwIKQyfJAk=;
 b=DUf2UV+EbTaIA3b39gYaXsHl/MlF6i404pKAbbZbANXBWh+SXY1ymnO1RVxrO4MTWc
 jfNd5hTODWTtxQbsgtB55zQs6//QdWRvCaXBaNNVYX1NlteWy1iGngUDEjf0I1J1JR2C
 qhMU1V97Xw7DWGfdnjjMBe6/3++2VJ0jA5ZX46vIqGHE6rwjgBD/9MudcyKgRn3iiZc7
 XbBGGtK1GoBSluJSgTF0GHAEpkfoOzf+jIX+WFLjtpDM8ZWvSXO2u1Q8pryrFmFW8ffr
 02weBShd/uTWAjqU/CM4RrL6M39v/S/2uQ76N/8lCcTBJDCeZxYydVnq3klKHOMdFN0J
 EyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7IhsA8lpB2O9xmXjvFVCcN+db4XOS/692WwIKQyfJAk=;
 b=GOoksAu8UNCx3Cekn/BSkJniCvv25EX8v9U/ECTu5mLlkLnDznYMcuq5dnNlqk6XAM
 iX9lOoXmf3uMT+zcY7MYv8O3zXR/Qi4j3yRVpqZmfYC408iJu+2mTqdg/6DA/II0Bt+q
 5jMmHGecbLAdidEbCwhz4+mVxPINXYl1DzWCInp4bDZwHmCRUde2nYAaMSJ13mjgzFe3
 esCYlHSsTMFSAacDbEdUctwzz6GFxWdfrw6LDwXlJHb8BcJ0WpTZFfLyaolKGrVoisHu
 8fV+e5tIxIHIDZ1uf6RwBG/10YdaRAsOoOlsdPkaX3i49vMoOC55DIQpeRmpi1Sdh/YU
 22cw==
X-Gm-Message-State: AOAM531dnfWlyhQJU/99m6iDJD3u/qjF73eAYKQwRRHc+hIpHWsQ7iTW
 1x7/fAmqkRRIrA7QjPaG49fiaG2puNM=
X-Google-Smtp-Source: ABdhPJySl2eOxfqP7uNgiJTUmehPrmzj/cAWJYY8GmGrooQlnZUddr+ZyqVqGmqEJ+DvZZMt/e/FGg==
X-Received: by 2002:a17:902:9682:: with SMTP id
 n2mr9612336plp.11.1595625796698; 
 Fri, 24 Jul 2020 14:23:16 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id o26sm7440028pfp.219.2020.07.24.14.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 14:23:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Ensure mmap_min_addr is non-zero
Date: Fri, 24 Jul 2020 14:23:14 -0700
Message-Id: <20200724212314.545877-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the chroot does not have /proc mounted, we can read neither
/proc/sys/vm/mmap_min_addr nor /proc/sys/maps.

The enforcement of mmap_min_addr in the host kernel is done by
the security module, and so does not apply to processes owned
by root.  Which leads pgd_find_hole_fallback to succeed in probing
a reservation at address 0.  Which confuses pgb_reserved_va to
believe that guest_base has not actually been initialized.

We don't actually want NULL addresses to become accessible, so
make sure that mmap_min_addr is initialized with a non-zero value.

Buglink: https://bugs.launchpad.net/qemu/+bug/1888728
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 3597e99bb1..75c9785157 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -758,14 +758,26 @@ int main(int argc, char **argv, char **envp)
 
         if ((fp = fopen("/proc/sys/vm/mmap_min_addr", "r")) != NULL) {
             unsigned long tmp;
-            if (fscanf(fp, "%lu", &tmp) == 1) {
+            if (fscanf(fp, "%lu", &tmp) == 1 && tmp != 0) {
                 mmap_min_addr = tmp;
-                qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%lx\n", mmap_min_addr);
+                qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%lx\n",
+                              mmap_min_addr);
             }
             fclose(fp);
         }
     }
 
+    /*
+     * We prefer to not make NULL pointers accessible to QEMU.
+     * If we're in a chroot with no /proc, fall back to 1 page.
+     */
+    if (mmap_min_addr == 0) {
+        mmap_min_addr = qemu_host_page_size;
+        qemu_log_mask(CPU_LOG_PAGE,
+                      "host mmap_min_addr=0x%lx (fallback)\n",
+                      mmap_min_addr);
+    }
+
     /*
      * Prepare copy of argv vector for target.
      */
-- 
2.25.1


