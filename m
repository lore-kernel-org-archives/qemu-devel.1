Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02769CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFBEB206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuDilwro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBEB206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWDq-0007Iq-CA
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBW-0005UE-ID
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBR-00039U-PB
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBP-000381-EN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id e11so4889576wrv.4
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vNMFynTjAmTxUUIwIswr/6MOiNNDJT5kgZOoy66ko1A=;
 b=nuDilwroNJijyV1WSInoXJb25iNFWyRxRGMtDGhqvLqjpMAkuCjMQDHLGOTfW8BTKG
 XSeXLYlV3YZpHJk1vtwtQzyWEscD3yV3OWaYMAw2zfNlKwXyrpveb5ehmaYi6r4D8fWS
 +6wSdTZpwE/erOseZecq86W68SxW7l1ezu7CSzuwN4Ha96g7U0Ji+nRvAiSianxG7vOW
 q4IENIO+3Ps2mH9UdYDrNTimZ0EgGy3IBzWy8zFAgenL8Wmjm3VD13HRbT4nfCDkj9kq
 w48tLEbg0pAQPmPJ3063+n2jhRNS0DE9DHkffbVAtqTCwN+1jZbeoQfErFYyLWCESEGl
 oOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vNMFynTjAmTxUUIwIswr/6MOiNNDJT5kgZOoy66ko1A=;
 b=JpcZRExNU3uMWK6l0wIuj2NYtiddvy7fJgaerMKVrMvzRY8eu2jYLE0JR3Glkn4wmP
 lJuoUHNCBFxeoto6wfFJmEXaqG/iXxE2t1UB66/vd2V3gsPnXLBnCRiDZ8gEziPok3FA
 1DuM9wAawLntPE+kKKlkdqQfNfgfLfuW30Zozf01u71Ofau0kB4hRPyFG1GWUPA6R0Un
 AynCEXp77+f6EuUld7CIbCclNkMyk23rScPnSQvWNlnUcTBaukgZcQrqMiKuHMxTWjXx
 3FGGNMVjfgGdZFUOob2lrRfNzlpvRL+OjzR5WLeMQeJfbLf26vV1scl4LMCqKAb6AUeX
 Bzlg==
X-Gm-Message-State: APjAAAUaoKJUKoVTZ7lLrS3d9t0p+jHVq/ZTviIQas7lUD7IHMZBB9D9
 RXJm2xON4oYPbeg+fGfYapudXVLX
X-Google-Smtp-Source: APXvYqwVJ0air9VZ4mVA/BMhrx7laBNxaLO2+49JsWC8jmbYilD1ZO6xWaEVrDSnfM+m7di9g8w/Tw==
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr14753575wrx.90.1571658541947; 
 Mon, 21 Oct 2019 04:49:01 -0700 (PDT)
Received: from localhost.localdomain
 (129.red-83-57-174.dynamicip.rima-tde.net. [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x5sm17156137wrt.75.2019.10.21.04.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 04:49:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 1/9] linux-user/strace: Display invalid pointer in
 print_timeval()
Date: Mon, 21 Oct 2019 13:48:49 +0200
Message-Id: <20191021114857.20538-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021114857.20538-1-f4bug@amsat.org>
References: <20191021114857.20538-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/strace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index c80e93b5db..f326c357a2 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1243,8 +1243,10 @@ print_timeval(abi_ulong tv_addr, int last)
         struct target_timeval *tv;
 
         tv = lock_user(VERIFY_READ, tv_addr, sizeof(*tv), 1);
-        if (!tv)
+        if (!tv) {
+            print_pointer(tv_addr, last);
             return;
+        }
         gemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
             tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
         unlock_user(tv, tv_addr, 0);
-- 
2.21.0


