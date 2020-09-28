Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17E1C47420
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E552100A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMWjm9mN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E552100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwrB-0004Lk-24
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwky-0004PB-EL
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkw-0006OD-UA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id d4so1901209wmd.5
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6214PjQPOVhgozXCT79O8kU552WC0uS2jttLKxOwFYA=;
 b=BMWjm9mNLjl1PAqlo2EOSO6nxaD7VGlRkMy7ZgvyN6YOTLf0tAcVbHx8hKHDskNlg0
 KsaUCCxCVfwwB0lC86bijdwRcNCALocaNggzgqvZ7JFiMlbRnI6zbbfZ/Pyy2dHLcvOj
 LF5qQVVPmmvd211uWS0uiEGg9a4V1AgJDOVDujewXTJtVDJuUC4uPBU1FYUZ24GyS3I0
 c/BghtO7SuRX9ZoEPLRpDZ15N7l2Rx0g7vYp0CdBwoG6XawcuBlkN6tgJ1ZpIGsd4Ciz
 hIhWp0Tl0Pvpg+D1n8Kkx4//0eTNrmbNsniYXJM2q+fo+i77h5PYb0qiuPh7jilUNbfq
 vvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6214PjQPOVhgozXCT79O8kU552WC0uS2jttLKxOwFYA=;
 b=BIy7s4VxKwRO4hFUv6Ucv9tf+GSomz1QiBOMkrWcu5RZoLZEMI5IJIErvqo94Tg+8l
 1dzoHQLyDTy3mkKlLGQWh9clZevcOMwbZuSnh1y5Y++jswmjXDmG7O+PkNai7lfur6wh
 iqaG2T59v1TviZW+gwXmC5M07RBDgQgfEK8wVCLL8Apim4zGOFINi5QbpmdKZ80A5yAx
 38OMpG2fqnEknayqJ4zVxPZlBFq38trTJpRNUyb/qSfzPDdb2EZngQr6gXDrCWG5f5TD
 81c168n9jukKxn5Q2TDYQ1ot6A3OOqo5r6gWONDqkElm68RRfhIKheUDYfOqrY3TDjq7
 WHVw==
X-Gm-Message-State: AOAM530csLkzZOV6FPCNshM+NRef+HuNsi467NLmdyWto6Snl4rEuWJK
 gDV5CUF7fwf+ySOfha5zmjy+gc9WaYA=
X-Google-Smtp-Source: ABdhPJxMDQpmeoeNyk3hJHMB/+kaGSl8h2cum223xqTfMyjapdAJImNwd2JSyC1cMst7MYilnYdRzA==
X-Received: by 2002:a05:600c:20c:: with SMTP id 12mr244507wmi.40.1601313365408; 
 Mon, 28 Sep 2020 10:16:05 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:16:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/16] hw/mips/cps: Do not allow use without input clock
Date: Mon, 28 Sep 2020 19:15:37 +0200
Message-Id: <20200928171539.788309-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now than all QOM users provides the input clock, do not allow
using a CPS without input clock connected.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/cps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index c332609f7b3..e4ff173f8c3 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -74,6 +74,11 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     bool itu_present = false;
     bool saar_present = false;
 
+    if (!clock_get(s->clock)) {
+        error_setg(errp, "CPS clock must be connected to a clock source");
+        return;
+    }
+
     for (i = 0; i < s->num_vp; i++) {
         cpu = MIPS_CPU(object_new(s->cpu_type));
 
-- 
2.26.2


