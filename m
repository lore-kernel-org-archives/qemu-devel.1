Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B421C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D108021973
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7L0pgKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D108021973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kILf4-00032y-0G
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 20:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILay-0006Ib-G7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:48 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILaw-0001WT-R1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:48 -0400
Received: by mail-pf1-x442.google.com with SMTP id o68so2968042pfg.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 17:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zb/g+Fvikq2LApYjpqfoFSuv71lvaud3AwPVH756moE=;
 b=h7L0pgKPC0W0oEwh5/ubrCmFUy2fLCRxqL/CLrRJ9TigHUTVKt1wHEKBqbQKSHUE7u
 vk5Lc2MSGnPxGOxWtgqPeQWEeO+DzSb0h6n0rzJ1IGjRNbCjiAPRVIcNHgvz5jdJyGPH
 Hj0Zv6TG8TRGZ9/aHUQGHnlr8x1tdUo3OQ9Tb7eJyay1NP03X9kRqOJLmOnKhHMe3xzG
 HX2Hexo9c4YOqOOIkuo4g1xfdSR1C78+iX4kJi8A4I55s3em3iPu3vJHsHJuu+PT9sss
 ebK2nzS0NtlpPV5lptyyjDxZ7wr3hwnprx3F1Q76bKgYXZUuT5TFmZxQrarny/x1fPQt
 w16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zb/g+Fvikq2LApYjpqfoFSuv71lvaud3AwPVH756moE=;
 b=SvYwabpt+3dhp/9TMtKKRPj7AvlxguEsRgt36FtRkV+Llgc1hJJefRMzXkrv+jrGPJ
 Fe0ZJ3hlYKg+eXbLQ6x7Gspmc/3sxsrdC63g0v8V9mwhzgL+G5kFcnsboyYMkm3e3K53
 6BWKGkQb8iRjf139obuWwTWyfWS5VjgZ6ix8pMas+w+YKgWdOBbgOvE5tcpgYxtuxZ8K
 NnuQqu6IsswUbO6f5IXmMUEWPsh8B/KpnmXx1K+Rx5LQQ1W3EhEksnbntBUeivJozRcv
 sj1OV7uSgufAziW6DD6HSXkz2MOl1zjUbMyc808XEeC35ugR26xzVvogayTWezEnsywx
 EQ+w==
X-Gm-Message-State: AOAM531NzQ82NGXNBQG0eFxZqzh4+tFWWg7nZ11DzWNYd8SRujvlqB9K
 8OEtdXNZGosWTKhnil47QMx6Foo8lONeHw==
X-Google-Smtp-Source: ABdhPJznwfBpFEHmNAKipCJRgIBqFEmIs4WQKPT3KH8b9+GwSYJVPRtAbwzl3uI+L3IZT/I5OC+IQg==
X-Received: by 2002:a63:fc04:: with SMTP id j4mr502866pgi.310.1600217205229;
 Tue, 15 Sep 2020 17:46:45 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id kf10sm611723pjb.2.2020.09.15.17.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 17:46:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] target/ppc: Set instance_align on PowerPCCPU TypeInfo
Date: Tue, 15 Sep 2020 17:46:36 -0700
Message-Id: <20200916004638.2444147-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916004638.2444147-1-richard.henderson@linaro.org>
References: <20200916004638.2444147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix alignment of CPUPPCState.vsr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
---
 target/ppc/translate_init.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.inc
index 230a062d29..accb4f2fae 100644
--- a/target/ppc/translate_init.c.inc
+++ b/target/ppc/translate_init.c.inc
@@ -10960,6 +10960,7 @@ static const TypeInfo ppc_cpu_type_info = {
     .name = TYPE_POWERPC_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(PowerPCCPU),
+    .instance_align = __alignof__(PowerPCCPU),
     .instance_init = ppc_cpu_instance_init,
     .instance_finalize = ppc_cpu_instance_finalize,
     .abstract = true,
-- 
2.25.1


