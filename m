Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2751AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E783D2064B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDofVzda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E783D2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YAf-0004FM-Sz
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 06:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2Y9K-0002WB-1u; Mon, 03 Aug 2020 06:56:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2Y9I-00027E-JG; Mon, 03 Aug 2020 06:56:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id x5so13929680wmi.2;
 Mon, 03 Aug 2020 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QRLqvjPZM5QRNmLQDr+tXQzUft3WjflEMoWeAB3UDPs=;
 b=YDofVzda85ykr9fEJEFK62BXHj0/IjkOZ8OHZt2reET5+RD7ncQT8JApdFDmsKKlA5
 4cq4MupOP+lV+rmLY0PNugvyCt1WxIhuN34XbBM9SDqT6fKXx8eRTZXyqO61SLErJpwo
 HnNZTNqvfmf9x0CGZs2KA17Txq8fxZeaWUue2Xm3Leb8AGzCDBuhuKtK+UDAK8uNGAwX
 MHfYZvZLLgnH+pun9QBdGEVT5AqSkN8su9TodvfBdRzB3ekTFu7K6TXS7ZMYREmTXyvf
 uXtTzPysqsvz7EzsfOMTY+qAFGGbEIaaGaNUa56BSz1sJIWoxTRsT6ZSmKI2w9SjDGr0
 3h7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QRLqvjPZM5QRNmLQDr+tXQzUft3WjflEMoWeAB3UDPs=;
 b=DCUV8I6H6frMMvqNA52j/zHQ40xgbfDPZCHkZO4wF6+ifM4aAU1dGzZcKfk/9g11e5
 /FoIxq2O4EqT6tFJbP3OVK6u+D9tZ3/NOI668iQloxG6Hvc1jyGkJDsye8ZwanNrJY9H
 iCfb2EKG4r8UmpOpkanCzY6OfOUu0FGCLkWcC7YcNjtc1ZNJyAufILiweGPhYZmlRTou
 6zlWIQiX/IBHLJydH8PiZcWeLWHP0G3CxbBMR165PcTwibKmGnhYlp7edkGZyNgOzTPU
 aTyXOmggyC37DNzzdelV3P0i/AgR4Qe9VK7jnfbSLUvZyCplvgzkiSNcXMyZQmiGlVPa
 XRYw==
X-Gm-Message-State: AOAM530t/JPzkZi3xBPKdKf0hg1vt88zB27tG7lEb1l/0FdlGjEkwwJO
 ORWGSf9dof9Y3iKdXBWcUnR503d+
X-Google-Smtp-Source: ABdhPJx6zGQZar9ofhQ/mvLKknS+8r+z7D7iqFeYIjdk8JriGACujcinh18/aR3CtMeojPTuqs07mA==
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr4931821wma.111.1596452214171; 
 Mon, 03 Aug 2020 03:56:54 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id z11sm23103477wrw.93.2020.08.03.03.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 03:56:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1? 3/4] hw/qdev-clock: Uninline qdev_connect_clock_in()
Date: Mon,  3 Aug 2020 12:56:46 +0200
Message-Id: <20200803105647.22223-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200803105647.22223-1-f4bug@amsat.org>
References: <20200803105647.22223-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to assert the device is not realized. To avoid overloading
this header including "hw/qdev-core.h", uninline the function first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-clock.h | 6 +-----
 hw/core/qdev-clock.c    | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
index a340f65ff9..a897f7c9d0 100644
--- a/include/hw/qdev-clock.h
+++ b/include/hw/qdev-clock.h
@@ -71,11 +71,7 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name);
  * Set the source clock of input clock @name of device @dev to @source.
  * @source period update will be propagated to @name clock.
  */
-static inline void qdev_connect_clock_in(DeviceState *dev, const char *name,
-                                         Clock *source)
-{
-    clock_set_source(qdev_get_clock_in(dev, name), source);
-}
+void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *source);
 
 /**
  * qdev_alias_clock:
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 5cc1e82e51..f139b68b88 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -183,3 +183,8 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
 
     return ncl->clock;
 }
+
+void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *source)
+{
+    clock_set_source(qdev_get_clock_in(dev, name), source);
+}
-- 
2.21.3


