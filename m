Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391A2C2BB55
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DAD2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdY+9/Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DAD2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqaG-00035C-5t
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVg-0003XE-9T
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVf-0004Na-9H
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLqVf-0004Ml-2f
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id h2so2238715wmb.4
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=22H5f+VrayDXYFN091+N51uEFPxm5X5X7vqYpPPYKEE=;
 b=vdY+9/RanPH02Og0zqVqXQJ8zeEnVHCBBM0x/MsuihZfSKddKQVMFTv79kkfDhCwiB
 KenpP3/bQYmkzTwHlpoQOFTUMrfkR7D5pm+QdViQR3dKGEngfLWlWjpbAoAlg8syE2v2
 FexBmiD7CxU0h34QmM7zQ7B8akp7AaJoqmsvesH7FXnjyO6BSByp0UcmSJcrKGT81967
 xldqCMqjlbkAl5p6eB5aCIjYB6KmGf23HybCr7cWMHFtzdmOrulnASPbCSO4K0SEMiOT
 W4PoTT+HZmOG97pebhOkSBVzNX1e5ORLLsI3cpr4+dnN8ATjh4y0PcWHmVDB4w9Ueeos
 Xi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=22H5f+VrayDXYFN091+N51uEFPxm5X5X7vqYpPPYKEE=;
 b=Vya8MyYjqiMdq049sqGRFB2ECHdM/rzqA2cOuHZPh/mjoOD7/HFf7/1BwYbBE/GHx7
 DsWgRuwyLUM3bHlbJ/xXBtaqCGq8iAA3gATUQZlOWgyThIXmsa00+AIOW7PTbwY413Vd
 fNDQy0qYkjyaiKYiO63s8se7opfk9504aObUbHPiaiTvb5odoM6IrOCH0qcSahP2uK7u
 wrRa6YXW+WZ5/X4VbSHMIUwhK4g+7I7DFH4iR0E+U61SCbTHVAgI5juQt1WAaDOy+mhs
 o/l1S0fTo1/vkjvpzbpfD4uEtahD+TCaYBrh6R9dIkPocbu28ePf/GWqZuO2zell39c7
 +2dg==
X-Gm-Message-State: AGi0PuYERZygujEbx+Pjxv0ku/pAvGDxPdNVFPtvA0etpoqVOCxzHgKQ
 5+8Iap50UzFJbXcnHky99rVEoA==
X-Google-Smtp-Source: APiQypJ220s9iUFXB37RXcqMf3svw57wo+uQ4ms2OwAynnEsx7zZ63JVgHZL5htAyOVanMe+3Jjlyg==
X-Received: by 2002:a7b:cd8c:: with SMTP id y12mr3171798wmj.106.1586274689979; 
 Tue, 07 Apr 2020 08:51:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 145sm1751033wma.1.2020.04.07.08.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 08:51:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DDF561FF93;
 Tue,  7 Apr 2020 16:51:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 07/13] gdbstub: fix compiler complaining
Date: Tue,  7 Apr 2020 16:51:12 +0100
Message-Id: <20200407155118.20139-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407155118.20139-1-alex.bennee@linaro.org>
References: <20200407155118.20139-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Miroslav Rezanina <mrezanin@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

    ./gdbstub.c: In function ‘handle_query_thread_extra’:
        /usr/include/glib-2.0/glib/glib-autocleanups.h:28:10:
    error: ‘cpu_name’ may be used uninitialized in this function
    [-Werror=maybe-uninitialized]
        g_free (*pp);
               ^
    ./gdbstub.c:2063:26: note: ‘cpu_name’ was declared here
        g_autofree char *cpu_name;
                         ^
    cc1: all warnings being treated as errors

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-Id: <20200326151407.25046-1-dplotnikov@virtuozzo.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
Reported-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Miroslav Rezanina <mrezanin@redhat.com>
Message-Id: <20200325092137.24020-1-kuhn.chenqun@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200403191150.863-7-alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 013fb1ac0f1..171e1509509 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2060,8 +2060,8 @@ static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
         /* Print the CPU model and name in multiprocess mode */
         ObjectClass *oc = object_get_class(OBJECT(cpu));
         const char *cpu_model = object_class_get_name(oc);
-        g_autofree char *cpu_name;
-        cpu_name  = object_get_canonical_path_component(OBJECT(cpu));
+        g_autofree char *cpu_name =
+            object_get_canonical_path_component(OBJECT(cpu));
         g_string_printf(rs, "%s %s [%s]", cpu_model, cpu_name,
                         cpu->halted ? "halted " : "running");
     } else {
-- 
2.20.1


