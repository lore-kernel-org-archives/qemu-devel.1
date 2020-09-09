Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2988206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAqYIJkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2988206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG3dy-0000XU-Sz
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG3dP-0008Vz-3x; Wed, 09 Sep 2020 13:11:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG3dN-0006cS-Po; Wed, 09 Sep 2020 13:11:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so3765254wrw.11;
 Wed, 09 Sep 2020 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d81tBxera59r+QBv4qfS3qn3lY3f1nlRZZ5taVnlkes=;
 b=nAqYIJkfiF8AVD3X8BLej5FUMz6pZxjwW2ZEThPpXszQdDUQn+wT3xhzu/9JfnQDb3
 wTb27GDrSO/ibXHOiiwUAr9iK9OLP3Mz0ZwNM/nEQl0XzByfHcKvRoJ21BNWnwbLr6ut
 jiqz7mjIs6yDGgISJ1YQxbWXHInvri9bjz2x3tfgv6unjgX9v8g+VtQAsBJVmm/oj0Fk
 igBXntSwUs3B+Ynd5UZwczkAcX1RCtw6RHQst8Agr4cIGsTxWTOcYPTiFZviIHH+alFD
 ifAOkKOtnCz5OxH2jLWfrh2FkGx/IaeYByy9FnEx9EMT61yzodyFxNia/3frP+uBs1m3
 DyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=d81tBxera59r+QBv4qfS3qn3lY3f1nlRZZ5taVnlkes=;
 b=oCajWuuhU+PMMuppPZ4AO1QRSj1lnWbU+roxjYl+mzCJIaf5S8wEBdLK7jrTcWGS9k
 oqnkaGHDVm2tA3ZGHfSrFUt8F8GFGWN3YOINwQ/MsQ7qUy6PK5z2xjizB0rkvlf0d5lD
 JZDDgAx6NErWNNbk1Utl1eaYEUBm4BHSCiccl+Git5LJuKLsRs/JcNhz2E6kFsStcqwc
 ddfVKD6tmCt+rmWOgBoNthx4OyWhUH/gKv9hdRblxX8jYI+KuLStCk92WKmYNIihBvhJ
 gQZxFCtQxydHZNkIPpg6RHxxBACCLLt2YyLmZN0PCWywpf/21ZHtUCKJv78y3mlF0NAH
 wnqg==
X-Gm-Message-State: AOAM530ahMFwV+ECncMzb73LuybPd/fNl33OXpIKGz0timBrrYxCRLug
 II3w7P10dGOlp1WaE6jmgRqMIuyYylo=
X-Google-Smtp-Source: ABdhPJzPIWI4WvqcLJxrIKgOdVarzCFE0+Stx3UnV3N+WjtHcugkDRJc68R3PHgufgdJly0z7/9a3w==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr4837039wrq.282.1599671507754; 
 Wed, 09 Sep 2020 10:11:47 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m13sm4927224wrr.74.2020.09.09.10.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 10:11:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/spice-input: Remove superfluous forward declaration
Date: Wed,  9 Sep 2020 19:11:45 +0200
Message-Id: <20200909171145.350360-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only need to forward-declare kbd_push_key() and kbd_get_leds()
which are used in kbd_interface, not kbd_leds(). Remove this
superfluous forward declaration.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 ui/spice-input.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index d5bba231c95..21990fa9962 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -36,7 +36,6 @@ typedef struct QemuSpiceKbd {
 
 static void kbd_push_key(SpiceKbdInstance *sin, uint8_t frag);
 static uint8_t kbd_get_leds(SpiceKbdInstance *sin);
-static void kbd_leds(void *opaque, int l);
 
 static const SpiceKbdInterface kbd_interface = {
     .base.type          = SPICE_INTERFACE_KEYBOARD,
-- 
2.26.2


