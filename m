Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C2FC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD8522265
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OD+qk3uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD8522265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOUW-00022G-JH
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQD-0002E0-UH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:34813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ6-0004ug-HT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id k21so903753wmi.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4ZJVmhzSHTO2kkTsFOTgxlLYB4AqZRDQadlY+p5spSw=;
 b=OD+qk3uqtGLNXFCvpQsZo8slztoTynv1RkQgtnGygrqvRhiX5/uKcDojTWjJVXRI1s
 UO23Uy2XvYyMAlI75cvvMNwfdEuGgU1IxMczYPZ67A1joNi5e5YGpPKJlaeD/YzSYTdY
 Z5+5kVaYnWYEt8D3jgUaCVQj6MNz3SgnOG5uPh5ZCQit5uNZsTNP4Kn+ueggG7aaB6yE
 08dV/zQxIEZ1sPgdAtHdd2JxkpWqS3syN8Mr7jHuMYqYnxjgb1Ky2o671zFqDbzbWxTj
 VanSUs/tM6prm3vwpXqG1VB+Tcy7D0j5X5kE71SULqUwOjmawFVvVnZ8P0dkQXcGFxEW
 06EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4ZJVmhzSHTO2kkTsFOTgxlLYB4AqZRDQadlY+p5spSw=;
 b=hGK5btsOaNoqyGjASaNkl7ky1SwOXvsjiWtahPXFeqlKAz/duXtetkAheuogXEdCc4
 +d2Uo5PSObWmJH/lx6VIhuqIPWCETEdTnyAFuQq3ow4Ysp2VcGF+8mqRMH1xNY2snAU3
 pFuEvoIW+7ypQvUYKq+E3AEF/BZgFZoX4G7/zxS+wIe1hs+jcYBogdu7BdwYo9YqFYFj
 lxFrEAhwxZmfz9jWG2a1wn3Xo7powRtsX29a1kZyDNjo2yilqEDDXc1WU8qh5QcOJqKH
 NJnfvVC6VQMYTk2tNX35IPnslZi0j9Uk8kGjcL4x+3W4U/GxiL7+Pvs3mPBaGcKW3xhf
 /4UA==
X-Gm-Message-State: AOAM5325zqV/78m3Hvi08Tsgy8ibShO5U/OvGhwXAh2BKMBYLcaFw4vd
 1RL3R3Ygf1zKgwbgUXBZQ/89zM7GUDtUnA==
X-Google-Smtp-Source: ABdhPJyFPZCnPvJUN3xYS5AyX15JXK/RIQEKu3JUQK+4YjFJXAWmHb5sZT3YDNN9Yy97DDUxnmVFow==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr2355360wmi.68.1603799140672;
 Tue, 27 Oct 2020 04:45:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/48] hw/core/ptimer: Support ptimer being disabled by timer
 callback
Date: Tue, 27 Oct 2020 11:44:37 +0000
Message-Id: <20201027114438.17662-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In ptimer_reload(), we call the callback function provided by the
timer device that is using the ptimer.  This callback might disable
the ptimer.  The code mostly handles this correctly, except that
we'll still print the warning about "Timer with delta zero,
disabling" if the now-disabled timer happened to be set such that it
would fire again immediately if it were enabled (eg because the
limit/reload value is zero).

Suppress the spurious warning message and the unnecessary
repeat-deletion of the underlying timer in this case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20201015151829.14656-2-peter.maydell@linaro.org
---
 hw/core/ptimer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index c6d2beb1dac..2aa97cb665c 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -117,6 +117,10 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
     }
 
     if (delta == 0) {
+        if (s->enabled == 0) {
+            /* trigger callback disabled the timer already */
+            return;
+        }
         if (!qtest_enabled()) {
             fprintf(stderr, "Timer with delta zero, disabling\n");
         }
-- 
2.20.1


