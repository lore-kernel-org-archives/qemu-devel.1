Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D722C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1952068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="n/FAnp3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1952068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklyG-0001ah-T0
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jklwW-0008ND-Lh
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:02:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jklwU-0001HA-MI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:02:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id x6so16400453wrm.13
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=6uoWWKTPFyIYGbUbYSEp0s2AbL2buoXSCuOMpMcIMZE=;
 b=n/FAnp3iVaK3qelQbX6O5RWF7JLyyUYt1QvxMYdHYK80uZjiTW8Q7T1TzWWKX5V72U
 iuJB20gZXBwU756WqUsDL20RuRukjHhNRreUVH5GvLlsQCjrNIApQn+09t0ABpZA8kE4
 td1VzsXG5vgnYTJlZNB8Byd8iiplOiVCjLCCastbz97xpkZy2LLbpQpqWDNI4IQ2jrLT
 fQazIUX4ZwA4genAlxm8kzIPOjPCDYaNxx/STJFKIoyvsq1c+zccmdv/AVeNTlMQ50ux
 cZ5IupKWQXsuanifEXK6JseOcAzhC4qwISOOv0faGAc4gpOzZZ7npAXen4iVtHZj0Byd
 oloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6uoWWKTPFyIYGbUbYSEp0s2AbL2buoXSCuOMpMcIMZE=;
 b=uBYXl3vB2XSDibZZj3JoDafXeGI4M06I2bO6hS7H2emam7/sgZApJKbwTDWu4Ggk83
 /W1WoGVPf2tDqB9JSvJG+rYA+3hVjyRm4Nb9JHioloWW5BugPO0gf0TMIjeW2NQKzeIG
 Fudt8HrjwdxjZ5nbwr7uX/qdPN247btmzl/JgebJ5LKreZMm4MjJrKizse5PxN9th9uY
 P+8boKCM16KhLjxHYROST1HZaAoBX9F7CXhJZ5P5lNr17LG0MQkOWpiL/q5UotRw6hyk
 t7IILw7NbKdD/ZPLwQQMHfaTEV7zpHAjJJhkvLj2yrW7sAyNooYkkzyGsv+/FdOYYemh
 qSKg==
X-Gm-Message-State: AOAM533blgJO3bfP+KQ36MfntOsHRmRyOW97djv2npk/E4SyLmrhSBNT
 LrIcn4x3LUeTH1aiM8yXDgwlneFW4n5GkQ==
X-Google-Smtp-Source: ABdhPJyVzvQvG6iVcWlwqghHM6ADErOzBnsaCIoA/QfF/AEF0yMrSZinxI3SMqtT0sRAukgInUJeVA==
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr30114468wrs.292.1592215332080; 
 Mon, 15 Jun 2020 03:02:12 -0700 (PDT)
Received: from linux.home ([2a01:cb19:867e:2100:7eef:23e0:9210:3e8])
 by smtp.gmail.com with ESMTPSA id g19sm21122757wmh.29.2020.06.15.03.02.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 03:02:11 -0700 (PDT)
From: konrad@adacore.com
X-Google-Original-From: frederic.konrad@adacore.com
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/2] semihosting: defer connect_chardevs a little more to
 use serialx
Date: Mon, 15 Jun 2020 12:00:51 +0200
Message-Id: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=konrad@adacore.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: philmd@redhat.com, KONRAD Frederic <frederic.konrad@adacore.com>,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

With that we can just use chardev=serial0.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 softmmu/vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index f669c06..9b8b48a 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4123,8 +4123,6 @@ void qemu_init(int argc, char **argv, char **envp)
 
     qemu_opts_foreach(qemu_find_opts("chardev"),
                       chardev_init_func, NULL, &error_fatal);
-    /* now chardevs have been created we may have semihosting to connect */
-    qemu_semihosting_connect_chardevs();
 
 #ifdef CONFIG_VIRTFS
     qemu_opts_foreach(qemu_find_opts("fsdev"),
@@ -4271,6 +4269,9 @@ void qemu_init(int argc, char **argv, char **envp)
     if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
         exit(1);
 
+    /* now chardevs have been created we may have semihosting to connect */
+    qemu_semihosting_connect_chardevs();
+
     /* If no default VGA is requested, the default is "none".  */
     if (default_vga) {
         vga_model = get_default_vga_model(machine_class);
-- 
1.8.3.1


