Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91CEC2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2D820719
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvxZBwwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2D820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWHV-0001Q4-Lk
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrM-0002Pb-Ju
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrL-0003Kh-Jl
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrL-0003K0-Dq; Mon, 06 Apr 2020 13:48:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id w15so466654wrv.10;
 Mon, 06 Apr 2020 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m8ZDXiD3nFiP7GdGwQTV0ex2VskQyj/RhxvXu9V538w=;
 b=TvxZBwwefg4HHk3RUrVE3aZGsrIn1V1rTbJ7ColaRUt8eLxVII90ZDOLWUwkFFOjxI
 5jYM5csNiGm2Ao9A+Q6LgkrOfFMt7v1g0irsmFIXHo+sVFinIQJ9PaNvrYfCh3nWwVee
 SIAa6tGLCOc+XMZS8bnOH5RzHk8j8Zt670rSjDZ2ZEkPdwOyIY8KaJrK1jJdFpVoCAjL
 MjpRZ6QKuuPmBEG5yY7N7zNe52uv5/6Hd80jvqLGw3KQ/rtGoAyuh1t3Te7LSh4K8lNP
 pTLaS2is9oV8HyHgxQZPMhKfGTL2Gp9Bri7IAfiVlnbfBB0YXtINjYipEZl4BSDZt0R3
 rW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=m8ZDXiD3nFiP7GdGwQTV0ex2VskQyj/RhxvXu9V538w=;
 b=UcqYI5BwIGInFfhGEvRredSszalwtaAQLmB5M3qZccqp7z88wOyIj0unGeEH0pjkFz
 jZGQZcOqvPaw0X6S42w2pWcgg4UJZ44K0wYEoTcUhnPjpZ2iaS5Gu8rQXflyDkEBPI2Q
 IIVqoyLeFssWgt9aAmBXl1TD8OZmwsaUs0dKkPI+pHDSEnsyvWfS8wNRcU63+itAw1G5
 Ap4tJmjzLcmdJc3vffxTZgMggJq/mIS3BiZ1QxUlnYn2Hu/QBkD3iboUOkYSAf960rYN
 Ag2t4Ma+VPFuU/XhHWf9X00wbCMrk+vS0RLsr6OEW5fPxkMbAVQqkyVyGRrJ3rpK2R/C
 e3FA==
X-Gm-Message-State: AGi0PubgIVgpiDi+AQIVSQdMtKVNVVC0JVIJ62ulZUrVVlppNVCmwWoH
 7DU8XO3QfhJDcHdV3keYRCZ5ZWzMM9U=
X-Google-Smtp-Source: APiQypKrlsbkyyw56rXAOLnvPlix75IGv4pAIt3YVq5AkS3tCM6lCk3KoxFNni7VjyT0RCTwg+/IUQ==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr359734wrt.213.1586195310312;
 Mon, 06 Apr 2020 10:48:30 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 32/54] hw/arm/armv7m: Add missing error-propagation
 code
Date: Mon,  6 Apr 2020 19:47:21 +0200
Message-Id: <20200406174743.16956-33-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/armv7m.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7531b97ccd..249a7605f6 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -168,7 +168,11 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     }
 
     object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
-                             &error_abort);
+                             &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     if (object_property_find(OBJECT(s->cpu), "idau", NULL)) {
         object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
         if (err != NULL) {
@@ -256,7 +260,11 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
                 return;
             }
             object_property_set_link(obj, OBJECT(s->board_memory),
-                                     "source-memory", &error_abort);
+                                     "source-memory", &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
             object_property_set_bool(obj, true, "realized", &err);
             if (err != NULL) {
                 error_propagate(errp, err);
-- 
2.21.1


