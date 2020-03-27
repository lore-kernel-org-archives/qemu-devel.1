Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8ECC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DE620578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qY4bcVoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DE620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlhd-0004Fu-3K
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlcj-0003br-4z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlci-00042H-3K
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHlch-0003yI-SX
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id f74so628370wmf.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SKd+3bU+Rf4qaLer/lKG48RI5FY7mtn7Z+QzafPJnHc=;
 b=qY4bcVoyrj9UDssxhyjuqXC8vq/MDVYm4Kco8WPuCa/1FRA85vfW9FYoirvRCf2oXk
 jnJJZjHeFz/QuhpvzYhy36xET487i6LD7Q3OfqxjL0Y5RGK+942BGBeu2Om4ymN3qYAb
 ZYMBATi67tTUzBhpnZMFFEpXsoIl3d9NfnfInFgwWih0IF0Zkl2ZSKRKUuBdiPRZ6jru
 3faOd72M7bFrhKH+qjgj8HxF7iq+k/NB2A4q2qMlbELf6Eq7vtR67PCJ6+5UjJH3q/cC
 idk77TwsUBLHW5hVTLEJoaPlEUcaMK22rbrlC9fLMq8rKdjxgRX3TG2ARvxS2qlVVFkj
 s+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SKd+3bU+Rf4qaLer/lKG48RI5FY7mtn7Z+QzafPJnHc=;
 b=Olpe8WETV7D7/5mUmyq1lw4tDgSdbsMjJSFRmW73wAbo8pqb8xEJAuu6e3GO6hF+QL
 f71rJ/JjMyLSDs5a0dE9fMfuw//3M4q7IOnJr9lK98m4+w403dYhOzaqLoxCaxOoHCBW
 2LFI0KIdjlnje8TOnfIYV/4RMtlXckep2zzeN+mk6eUukKXs7LTZoTHLyQk1P3m3JCVa
 D1M2ZrM6KTNmfcI0Yl+jejbCgQItR+ctgA5diJGo7c6+0tDW3Hzho/JeHSTK1d6zsg9l
 MXf3+3u91mXdACBcv3/LnYAgtfKg6xsZe6BnaE21kiAmIHlWhYEF52ijAQof30JkFjrX
 wsgg==
X-Gm-Message-State: ANhLgQ1pTQPiROgMh0NjkNZbYyipir9WBlDojhgk+ohlVgJTvVR8zoJr
 bZBpabGiKnigc2q4oOxs5i2S8A==
X-Google-Smtp-Source: ADFU+vuLCvy0OQamGzUTj2kLG5IO995mzays8B3zhDVSyqzJPmxKABKTj5GVkw12wSrOn7NUCQX1fg==
X-Received: by 2002:a1c:1bd2:: with SMTP id b201mr896464wmb.181.1585302594857; 
 Fri, 27 Mar 2020 02:49:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y200sm7431526wmc.20.2020.03.27.02.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:49:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 07A491FF93;
 Fri, 27 Mar 2020 09:49:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 7/7] gdbstub: fix compiler complaining
Date: Fri, 27 Mar 2020 09:49:45 +0000
Message-Id: <20200327094945.23768-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327094945.23768-1-alex.bennee@linaro.org>
References: <20200327094945.23768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
 Richard Henderson <richard.henderson@linaro.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


