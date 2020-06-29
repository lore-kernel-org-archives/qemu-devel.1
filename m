Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768FCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9E320760
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTxaI2kG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9E320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4Qp-0006Ln-H8
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 20:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dj-0007SP-UQ; Mon, 29 Jun 2020 17:48:36 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:40221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1di-00086J-Ae; Mon, 29 Jun 2020 17:48:35 -0400
Received: by mail-ej1-x634.google.com with SMTP id o18so13923730eje.7;
 Mon, 29 Jun 2020 14:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=5JW7XhAd9PoeujhWI0tmLjXYrg+1Y7BEZ6l7rd1Kig0=;
 b=FTxaI2kG5IK3qYFHM2UgT6Yl2u57tm9PLrZH6VsSrNga3BsbedSnECIoDFDKtta9rO
 F+N3iYw9d8HCthuJX8+Gp5fi/ClymQni7xvUvtSSgcnDQBMFg1ta6FlIsdxr36esYGvq
 Zq69lgfDlNeEbZ0VYUHZSNzxmQG9F3mQuDl4CaADFxRMUqctJbGQw/CRBe8Mg2aVu+7L
 xA5KhFV8/EjYyXJ9Z6tRKLfyWZInh4jPjk6uAsoiL33YUPUb3DH0B1bx6pUeLgxERoVq
 4NzzOevM/ms57Bb9UHA9QUxYElW67JPpQnHaZYUGqZZXsSjEa7iORiPWZUYy0EZ/KfjV
 5KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=5JW7XhAd9PoeujhWI0tmLjXYrg+1Y7BEZ6l7rd1Kig0=;
 b=LU+8l/zNwtbYOY7OPHeTCaxS0IqfzmiIQCyH16RK1OvaAZTfYynpZtUtrsowslIY9g
 bGETymGFRbM/QduNwVvatRicJJuorOpN/Lwz53ez818S0Xysmxp4XoKvLJyrD/di472z
 ngEEq0pq+B/1+J3HNPvImhPX1C0cg/VIYwAaQxLzigrt6KmGFGH0lf3c06uEfDWQYDT/
 x0ud5JYZ3uhK9Xgpxj1Q0zGjlcUsumqMN+JtlHP7OdPQJB1ZX+qM3UJ7d5W9xxaS8+jt
 yoV8M9AYt8dk96Y+AJpeWdq8MvDGDJQp1gmjdY/WbvZhp2f+5K9Es/A2fZTrw6Ude/cp
 Vpkw==
X-Gm-Message-State: AOAM533Vg1nWHcoJIoQjPukgATYmvzPriLHZ0IUwlg3jobUYhsiabG8Y
 rIjdsHEENIpgD1JYk0e8xjWJ227ZktG9uvBvi4uBSPGDIXA=
X-Google-Smtp-Source: ABdhPJyrUi0VpLdgW+p5Terkr1pGKvBiL7BpHlDt7ORDP7KqKiAJaGbqtObvBbUMINPGBvcDcgLdSvJkrMvtWNbrbc8=
X-Received: by 2002:a17:906:33ca:: with SMTP id
 w10mr7936711eja.171.1593467312452; 
 Mon, 29 Jun 2020 14:48:32 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:48:22 +0100
Message-ID: <CA+XhMqyoDM3EZwvP353aMAELYZ85RF_4vsOw0A=HD1_rSgfrDA@mail.gmail.com>
Subject: [PATCH 5/9] Define SIGIO constant with SIGPOLL equivalence
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x634.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jun 2020 20:42:18 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 93c001e7da19c76a73a687dc6584bc31385a2693 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:18:32 +0000
Subject: [PATCH 5/9] Define SIGIO constant with SIGPOLL equivalence,

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/qemu/osdep.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 6e0cf9132d..e090ead826 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -425,6 +425,10 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #define HAVE_CHARDEV_PARPORT 1
 #endif

+#if defined(__HAIKU__)
+#define SIGIO SIGPOLL
+#endif
+
 #if defined(CONFIG_LINUX)
 #ifndef BUS_MCEERR_AR
 #define BUS_MCEERR_AR 4
--
2.26.0

