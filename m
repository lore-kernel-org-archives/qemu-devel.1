Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFA9C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BF8206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izryyqpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BF8206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuVC-0003kS-Db
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVuUV-0003JK-Kv
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:07:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVuUV-0008Rs-2q
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:07:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id k12so1616344wmj.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mZ32u4RQsUPS+55+SrB1wa+ss5bJ7TXvtKJLOFqxawY=;
 b=izryyqpXXx/9YDovpwLjcemU9roWgS8IqlDynlmxTiE0yn/zltAieJAFLzCaJJzzds
 NdHh6LUeVaZ9eachfELQwv8ReWQSIXjPEP4XL5B3YZTO2P4XYaiNaEvGlv0D9o9CVi9S
 NrkxNMgkoz+2z4IdBzRsHe3IbKrXxS+jqukzyJf9A3mY/+P4aF2Qp7EoNCfe93LTahEo
 jSWfCtF+NNJ/ZszA9rOlhpSjsdg/6j27erqQaE2b9frx89tPVl6VUeCXZpDutlLVIrXB
 zxMeI//4NRCiG9HVQjgZHJSn3ByiMLHvBjaaLrWAyFYUkXJAbBf/xcR1cfvbmKm4rXz2
 tUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=mZ32u4RQsUPS+55+SrB1wa+ss5bJ7TXvtKJLOFqxawY=;
 b=kZx5tvEN48kQoxj+vUZaYo9dNgiyzhva2r7dDbBE34NEnN4JOAXnc2hm8FlWMGvB0j
 qGmFd81HUP67mDVpk9hr56/xDOCZmWpikTS8imj+EK80bGS17vmV3R5qYjcIqJzGgdrV
 iKh5WNRK38w/n+vvxyEy1GkQsaFxK8znXIuZp+ZaWAWIGVcVQ67L2YVLIjQTBpL+UUQK
 liUVF5gYN2AJR8IyoxzClS+O+8KQxIJCUWYBQzd60oKeSriyxHxGCCXfr9PQOvREW1X/
 qfxl6ZTKM+2hwczNT/B/tg3myCrQeFZn8nxU4po972qB5DMYjdJ0zLQy5BJc9BonCACm
 ZviQ==
X-Gm-Message-State: AGi0Puaprzm1pv+rKbhcjBtQKyVaHnAm+R+WYNGxF8NBg9EXVVs/RjLJ
 K1BeDMU+TRO85v2CWRqxGHNZw58U
X-Google-Smtp-Source: APiQypKaNTKp30c0tirtQQ3t2D9PFnTNao4aXlHSVdN52WYGySl/Mt42lTcC6DKg5GINAZNgmEGv1Q==
X-Received: by 2002:a1c:44b:: with SMTP id 72mr2423439wme.58.1588673273273;
 Tue, 05 May 2020 03:07:53 -0700 (PDT)
Received: from localhost.localdomain (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id l6sm2599934wrb.75.2020.05.05.03.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 03:07:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/audio/gus: Use AUDIO_HOST_ENDIANNESS definition from
 'audio/audio.h'
Date: Tue,  5 May 2020 12:07:50 +0200
Message-Id: <20200505100750.27332-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the generic AUDIO_HOST_ENDIANNESS definition instead
of a custom one.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Who/what machine is using this device anyway?
---
 hw/audio/gus.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index eb4a803fb5..c8df2bde6b 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -41,12 +41,6 @@
 #define ldebug(...)
 #endif
 
-#ifdef HOST_WORDS_BIGENDIAN
-#define GUS_ENDIANNESS 1
-#else
-#define GUS_ENDIANNESS 0
-#endif
-
 #define TYPE_GUS "gus"
 #define GUS(obj) OBJECT_CHECK (GUSState, (obj), TYPE_GUS)
 
@@ -256,7 +250,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     as.freq = s->freq;
     as.nchannels = 2;
     as.fmt = AUDIO_FORMAT_S16;
-    as.endianness = GUS_ENDIANNESS;
+    as.endianness = AUDIO_HOST_ENDIANNESS;
 
     s->voice = AUD_open_out (
         &s->card,
-- 
2.21.3


