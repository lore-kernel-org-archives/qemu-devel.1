Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88424C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5088D20663
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccGLHO1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5088D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcALU-0004S5-Fe
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKA-0002Xc-Mv
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:40396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAK9-00067X-S5
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id t16so4573432plo.7
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wgvUXG0Vlnhy8HNXWH/V4PveTdhkLExBdueTuZ9bPNI=;
 b=ccGLHO1w5NQPtQ7Rw2MtZFfVYhJ3tP7AAvuRI3xxgode+dWuOLf/ZlQHaYOhMsAEV+
 6OuC/NlscC8vvm/Hntt1b/xO0ulUmOmf8IXNR/elhsvI+Squf/LRqtA9LcpxnNqKyQo1
 dzn3qHuonfPCP+BCcmR1h60l6BKBHTmoNr81QtxxmMr5FopnsbOH7SAgAlmYfaOavJ/a
 lXv4HuWeqvJo8WuBR2B9WcVTRD4KFVfOa8nmS7OagkCM/wO3D0CO+gSZv58KjXK8IX2b
 QBylJNVX295sMt9wW8jHI3jvTSbMg3q1eXkLvLAzwJE/507XtVYaGCKFBUrx+5E6xl2q
 20Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wgvUXG0Vlnhy8HNXWH/V4PveTdhkLExBdueTuZ9bPNI=;
 b=ZFMkpmaMSwWMWObS2a5s2rllt1Xu5HBlnh1RoMBdalAcOlCUf6g8cvRMddVutnrX0S
 lNzTKLFTGkrZJ8Dj0dk04UiHV8tpH/wGZGHNjsG5cu+wT7fpQ6MLNC+aB0HH29EfMhdh
 NkciVFUx4JN/pFURkfPDCu6rctR8DORgaRyv9DleqGoJAhNd4CVPSkHtTUh2lRgxJRTn
 DmlZaYu6gGnQRtN6ONaYdLcTvJqu+hFEWut7P1teWf/rGuThpbofCMOejugbadF8/wwl
 afgPRxOrrkNN9O6odE31WoMN1YXcOPxevMjDyARPn7OqtBH3PZ88wQqQq3lFSZiA3r1a
 lxKQ==
X-Gm-Message-State: AOAM532QksKuXDZwA9rdv2MGiGhzMmMEmuXOQa8BMboFaFhtZlXN9xfZ
 tVcZJKhDDREWm7JgvZM96H587nY0WS80zA==
X-Google-Smtp-Source: ABdhPJyCWEBAqgBlzzZJeZGp6mNgNwpgUuW84wee+Ybay5X/X0tfJmay/ZSt9yK/jPfOXAS580My9w==
X-Received: by 2002:a17:90a:c201:: with SMTP id
 e1mr5603313pjt.162.1590164104261; 
 Fri, 22 May 2020 09:15:04 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:03 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/19] thread: add qemu_spin_destroy
Date: Fri, 22 May 2020 12:07:39 -0400
Message-Id: <20200522160755.886-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

It will be used for TSAN annotations.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/qemu/thread.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index d22848138e..e50a073889 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -215,6 +215,9 @@ static inline void qemu_spin_init(QemuSpin *spin)
     __sync_lock_release(&spin->value);
 }
 
+static inline void qemu_spin_destroy(QemuSpin *spin)
+{ }
+
 static inline void qemu_spin_lock(QemuSpin *spin)
 {
     while (unlikely(__sync_lock_test_and_set(&spin->value, true))) {
-- 
2.17.1


