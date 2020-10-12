Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2279C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F06920776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFmegpwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F06920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRufN-0004MG-BW
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRub9-0000El-1c
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRub7-0002ng-GY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id x7so9839970wrl.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MCMj0TR+Fl9dY8Kl27uG0iFSZwgVew5RPBCHaa3rL38=;
 b=dFmegpwxb8euMMRQQEGMouVsG2+0bmiCmTc0ht6OmWPSLFoSoSMjMpADS5CUOatHvg
 DQr5Wm7vAKUd7yPABbRsudghPUAhLKC7yT3RfcwGdno1nmgLNpiDOM1f3ZgzrFGhHoaQ
 T8UlI23l9kcsPTzqhyAM2N/YS1OKnHQgQMymlhZrQ7bo6qHorS2YJ7Kp7LbYkzo6BhYz
 872jVlV0QZuOblFYoZNfBdK/1YsUjsODx29mYRBO2GfVK0fMFq14q9+jVWcYuIR8ZUeu
 U5Q+Oe7Q5gel/TsmRi7ks2TIm7K25tZJeZk7DyTt4mybBZ6eq1IVTYQy/RELLevpmV1E
 IfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MCMj0TR+Fl9dY8Kl27uG0iFSZwgVew5RPBCHaa3rL38=;
 b=N0MRifu63EDE7q3fPHhTygGOv5/jSBiXbThaJ/y2x13GUB1U9RQ+CCHHS0+XTA/h9Z
 mhkducvMosEjNtd6lToCG9jtfzrPImmTghsk2jS2SEnGXJw+UDoUhrPn94wJAyxcUV9I
 IxJxdpa9UfSMmW18In8GPrmNr2jXsthJSU7qT+MmYwUvjOiGfrDLPQDLws4/qXGukJBU
 22mK0UlVQ10EHVXXAzrS060m99xir2tHp68mNc2eLiyTITtsDvCM/dbWznt+d2X7l5Cz
 6XiJo31Zqj1PB7R/47b5kmmgTB2lWADaeOl+iM0cbleJrW1BGh+mxXHeNk48ZE5mnv7u
 WJPQ==
X-Gm-Message-State: AOAM530kKNICav45GwHAF5gFN6W1uEID1LPLwpBJhNgKZlWLyfzAKdn5
 yQyTlQbj5we2E6pXVDKPjNL3ZArnXPM=
X-Google-Smtp-Source: ABdhPJwFbeoXx9XHDBEuZvQYFu1qwSYmmyjHufFRObDw6JwXbGePhOXWueLuA/0O56yomKzXYNqYwg==
X-Received: by 2002:adf:de89:: with SMTP id w9mr6094617wrl.212.1602496707924; 
 Mon, 12 Oct 2020 02:58:27 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o4sm5818180wrv.8.2020.10.12.02.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:58:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/21] hw/core/clock: add the clock_new helper function
Date: Mon, 12 Oct 2020 11:57:47 +0200
Message-Id: <20201012095804.3335117-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Luc Michel <luc@lmichel.fr>

This function creates a clock and parents it to another object with a given
name. It calls clock_setup_canonical_path before returning the new
clock.

This function is useful to create clocks in devices when one doesn't
want to expose it at the qdev level (as an input or an output).

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Message-Id: <20201010135759.437903-4-luc@lmichel.fr>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/clock.h | 13 +++++++++++++
 hw/core/clock.c    | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index d357594df99..cbc5e6ced1e 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -90,6 +90,19 @@ extern const VMStateDescription vmstate_clock;
  */
 void clock_setup_canonical_path(Clock *clk);
 
+/**
+ * clock_new:
+ * @parent: the clock parent
+ * @name: the clock object name
+ *
+ * Helper function to create a new clock and parent it to @parent. There is no
+ * need to call clock_setup_canonical_path on the returned clock as it is done
+ * by this function.
+ *
+ * @return the newly created clock
+ */
+Clock *clock_new(Object *parent, const char *name);
+
 /**
  * clock_set_callback:
  * @clk: the clock to register the callback into
diff --git a/hw/core/clock.c b/hw/core/clock.c
index 7066282f7b9..f866717a835 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -23,6 +23,21 @@ void clock_setup_canonical_path(Clock *clk)
     clk->canonical_path = object_get_canonical_path(OBJECT(clk));
 }
 
+Clock *clock_new(Object *parent, const char *name)
+{
+    Object *obj;
+    Clock *clk;
+
+    obj = object_new(TYPE_CLOCK);
+    object_property_add_child(parent, name, obj);
+    object_unref(obj);
+
+    clk = CLOCK(obj);
+    clock_setup_canonical_path(clk);
+
+    return clk;
+}
+
 void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque)
 {
     clk->callback = cb;
-- 
2.26.2


