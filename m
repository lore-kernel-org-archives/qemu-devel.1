Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9303C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D96A2084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi9xE9F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D96A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXEc-0003cb-Fh
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7d-00071t-2n
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:49 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7b-0002Bs-JO
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:48 -0400
Received: by mail-ed1-x542.google.com with SMTP id i16so17250233edv.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=45UgqB7xiuv75to9D1xtOkBXTGrFM8LHRPwW44N+AXY=;
 b=Oi9xE9F6rOTJgixcMpWfSS/NfUvbfq+cZ18N8xzAXMsVsblxvzRwmW5IZFl/VZZyuO
 m/MHptzNBrrwlhhDV3ougwUuLaWWLtTf6B+B1fpX+hNt/UoNWIGMx1z7NIFSQONiCJW9
 JfRwTQ44mTbc2fk8SX1Jsyy9Eg/Asbk6nTezEWUwO4K3GsTHEWrg5JyTDA33h/lHLrom
 3UJLswgKJMLnUd9fSDQWS/ZoivOXXclYtG4aTPdwyXatELinW8gZbq2kG6sRT7EIwdg9
 BQTC/Kk60fS54gXBogOERLxFnGxlaJgQWWzNQC7g8b1TDOvDnPlFywWzpTJs6z9YXD/k
 tSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=45UgqB7xiuv75to9D1xtOkBXTGrFM8LHRPwW44N+AXY=;
 b=U/8wYveePEWWkjFCuR3TRKufGn9lp/1Vl+epg1rJZ9ilwSrYboOUEIS3Cnz/UMFHlT
 +bPx4j+p92GtUMWoQcF54jpBDlyzGk8G82OEpAchiV+tv92DWOukOo20TXo+TjwzZ7tl
 bLpqYt3/adLNLNkFHUlB007jehtIsJvZIN3BMKs/cJ49V/qrtx+b4QXY7yHVRaiZGcIK
 sQM41wHU/tPdAIDFAtrqGwx96+f9rG/9Dih0DIGgnpprDgEIKnQk81HeJJ2eGkRIqJ0R
 CC+EBK4CA5bpyMlmb0ssslA3UCyRxHuZTvN54wNmI+Ka4mIL0vS0IMK/c5j3C4yzaYKc
 86vQ==
X-Gm-Message-State: AOAM532zZA+6V7B8FXa5RwsyRXJYjI6FNn48w/KuCMZXdyrFQVr4e2IB
 jw15ApuTMdFxJ0U+c+sfF4CeHvqETh0=
X-Google-Smtp-Source: ABdhPJz2BuRcHYEb0vJvbDghC8GF7FUB+ZLTYw4hWm0S4PsoeKn/UWCsOYNfxvHRzf7lUPCp+rcP7g==
X-Received: by 2002:a50:8e56:: with SMTP id 22mr18385165edx.268.1590490066045; 
 Tue, 26 May 2020 03:47:46 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm3342597ejd.19.2020.05.26.03.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:47:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/14] hw/mips/malta: Add some logging for bad register offset
 cases
Date: Tue, 26 May 2020 12:47:24 +0200
Message-Id: <20200526104726.11273-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526104726.11273-1-f4bug@amsat.org>
References: <20200526104726.11273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Log the cases where a guest attempts read or write using bad
register offset.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-id: <20200518200920.17344-21-aleksandar.qemu.devel@gmail.com>
[PMD: Replaced TARGET_FMT_lx by HWADDR_PRIX]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index e4c4de1b4e..b673a3a248 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -427,10 +427,9 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "malta_fpga_read: Bad register addr 0x%"HWADDR_PRIX"\n",
+                      addr);
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
+                      "malta_fpga_write: Bad register addr 0x%"HWADDR_PRIX"\n",
+                      addr);
         break;
     }
 }
-- 
2.21.3


