Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74303C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4055D20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSaNzF7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4055D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGcR-0008C1-Dz
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTu-0001CJ-At; Tue, 30 Jun 2020 09:39:26 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTs-0006JG-MC; Tue, 30 Jun 2020 09:39:25 -0400
Received: by mail-ed1-x544.google.com with SMTP id e15so16262211edr.2;
 Tue, 30 Jun 2020 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uCWGmD+bgn4Y2GrUizD+G8/TwFtuJI6lZxJDh/W1Rng=;
 b=RSaNzF7CbF9k8PI5rtmpHuzt9wDkHj4Zs5XVMwjlDQisRmrjnFvTnObBAxtAlRCPQd
 Qf+N3xKg/2WfnVNlersmYkOKpioa3zQeEuMvqW2BMcyqbWKz3UIWEjTVScAur53YzBm1
 XxniCU8Q+wI6wHnf08GIzgtOEaaY5FL4oPE0JVZuFshe5dVbx8drdl605m8KX5sfU7i1
 YPwsmi9AMCZMcPmL9xMu7JVbm35UhPRotE+NRpNLSy2Z8wlP0GvVVqrQDcMdOU7N1xZz
 UiZQHvK+2AFF9b9c9HE9+1hhEY+0bRybgszgg+mDSzDpQ6mgoOmWfCAZXeuD8A5eESfv
 Ce9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uCWGmD+bgn4Y2GrUizD+G8/TwFtuJI6lZxJDh/W1Rng=;
 b=iQzU77zmi8g/BdA73ls7JCs90KcMfMfbiynSd+EzkI6kuomONEehRALNKaZY1tnkEK
 ZPwM9rfp19vr1yYsZtP54yqGgjMG9hJZmTe7lkFCSnr5L3UFIRd9lhFOSZGtMeVQIVRs
 lb+ZVl5IgBTfnDyJndEE8YslMMrBmO99brbvkwEqz8VBGNhcG5+3esS43kdiuxaiddia
 usG6gdcNUp1P7VWcCbLSxX4t3q3b54nwK+TWIFHJUiP1GJfoccMnNJ2msetKo1OLvShd
 YLVpPgJMfm75+6OKu7Z8UR6txC/bXQo4hViKmBom5iIskM3JNuAoWOEx4DtECwPJBUj3
 FInA==
X-Gm-Message-State: AOAM532cD3pMfwqaVcdPkwrXmJOZUmUiu7xuuopdbBuLQl6drT+NBlgc
 +PwfRVIoHQQjT+e4N2Dd1RcUlcqMJeQ=
X-Google-Smtp-Source: ABdhPJxkHlEvFofkVpNPN8Z0SQg13iRYAQr5YwXd4sZOY5ljj4ROIz2pAVG7H5dfZgIENEQGWl0q6g==
X-Received: by 2002:aa7:d3cd:: with SMTP id o13mr22568115edr.176.1593524362774; 
 Tue, 30 Jun 2020 06:39:22 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/17] hw/sd/sdcard: Call sd_addr_to_wpnum where it is used,
 consider zero size
Date: Tue, 30 Jun 2020 15:39:02 +0200
Message-Id: <20200630133912.9428-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid setting 'sect' variable just once (its name is confuse
anyway). Directly set 'sd->wpgrps_size'. Special case when
size is zero.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 078b0e81ee..e5adcc8055 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -556,8 +556,6 @@ static void sd_reset(DeviceState *dev)
     }
     size = sect << 9;
 
-    sect = sd_addr_to_wpnum(size) + 1;
-
     sd->size = size;
     sd->state = sd_idle_state;
     sd->rca = 0x0000;
@@ -570,7 +568,11 @@ static void sd_reset(DeviceState *dev)
 
     g_free(sd->wp_groups);
     sd->wp_switch = sd->blk ? blk_is_read_only(sd->blk) : false;
-    sd->wpgrps_size = sect;
+    if (sd->size) {
+        sd->wpgrps_size = sd_addr_to_wpnum(sd, sd->size) + 1;
+    } else {
+        sd->wpgrps_size = 1;
+    }
     sd->wp_groups = bitmap_new(sd->wpgrps_size);
     memset(sd->function_group, 0, sizeof(sd->function_group));
     sd->erase_start = 0;
-- 
2.21.3


