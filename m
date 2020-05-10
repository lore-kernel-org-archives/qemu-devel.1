Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47D0C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 17:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDED20736
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 17:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPVHAz98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDED20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXpVL-0007mT-KG
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 13:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXpUA-0005q6-7N; Sun, 10 May 2020 13:11:30 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXpU9-0000CE-I8; Sun, 10 May 2020 13:11:29 -0400
Received: by mail-ed1-x544.google.com with SMTP id w2so5875810edx.4;
 Sun, 10 May 2020 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=opJWKypD+HXG5axwxyBOWTbtCOfa9yREZFCiYnwvuD0=;
 b=CPVHAz98Cmyf66upvDkvwXPvXF2FlyrWNlWEPK9BTzDafFEvCTWTKyJOZS0FY9y2ep
 FPTd1Ne7PW2YXr1TbXIsAagS5afadsDh/MByCOZzKD1bqwEaTf4Yx5TPXHYvOOiREelY
 fDtUUajWOgEEslD8HRZuRXW4J1GnqT1vvs8YolXnG9sa7m8ydj9MOMHuc44LQ2NsyUoq
 kkDyWNXygnn1uIVd9M0f591pKGA7dEngCSRyKsiOMdjd3oGhmaaTLWetKO0H2f6RY6J+
 m1QU7uaeuiipcM+GURd76Bse9WyOd3sz9V5aRHvbduCYMjLhYnm1JPH4gICKLlApJumZ
 0Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=opJWKypD+HXG5axwxyBOWTbtCOfa9yREZFCiYnwvuD0=;
 b=fDuYmkcZ8HlguyRutVGMkn2sxVvi+4Tp1y0nQEPOPvLEreBYwL6bDccLVlS8DrDg9Q
 cFJD3WNI2RFxfzoqzlRIU4JqavzsqWWkqqgTTqbE+faipntuliySHuv3d8f2NgbSaWon
 hz1UmR5a008AelodGJBAZ4x+dEEnPKD3pjRdxZsCTbOpO73HAwb5TezlR7WVzrWa6sbZ
 bd0rccPuW25oZ32o1XwYEIasgDNlPM3IYfoigp3nc2RY0lKkev7Ar+j0njWD2VNoGIWm
 aflWpZsGmclYT7rJBQZqNY9ZFuyat7HYpfCeXR/UfMgC2zzw/DuEYGK5tWZPthTKJyPD
 8XwQ==
X-Gm-Message-State: AOAM531sYjA8RAuF20gL7oeeyoJo9gMzLJNU/0tp/xmHKXvsy94SdMFn
 DymVUFI7LQlQhLLY3vhAoQbANTsjMH4=
X-Google-Smtp-Source: ABdhPJx6fDzA1yjGn8O/Y7E0YHHrCbPFvmdyGZmtFczPoLoYv7bGshd4zW04ykGRZpFKfm3Pi8fZlg==
X-Received: by 2002:aa7:d496:: with SMTP id b22mr918491edr.301.1589130687702; 
 Sun, 10 May 2020 10:11:27 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w7sm960776edr.20.2020.05.10.10.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 10:11:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] qemu/qemu-plugin: Make qemu_plugin_hwaddr_is_io() hwaddr
 argument const
Date: Sun, 10 May 2020 19:11:19 +0200
Message-Id: <20200510171119.20827-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510171119.20827-1-f4bug@amsat.org>
References: <20200510171119.20827-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: qemu-trivial@nongnu.org, "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename qemu_plugin_hwaddr_is_io() address argument 'haddr'
similarly to qemu_plugin_hwaddr_device_offset(), and make
it const.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Having the variable named similarly to the 'hwaddr' typedef is
slighly confusing. Also if we declare 'hwaddr' typedef poisoned,
GCC complains qemu_plugin_hwaddr_is_io() use a poisoned variable...

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/qemu-plugin.h | 2 +-
 plugins/api.c              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 5502e112c8..89ed579f55 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -331,7 +331,7 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
  * to return information about it. For non-IO accesses the device
  * offset will be into the appropriate block of RAM.
  */
-bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr);
+bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
 uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
 
 typedef void
diff --git a/plugins/api.c b/plugins/api.c
index 53c8a73582..bbdc5a4eb4 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -275,10 +275,10 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
 }
 #endif
 
-bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr)
+bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
 {
 #ifdef CONFIG_SOFTMMU
-    return hwaddr->is_io;
+    return haddr->is_io;
 #else
     return false;
 #endif
-- 
2.21.3


