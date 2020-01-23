Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D09BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC28F20684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQN9kUtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC28F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf0H-000640-Ml
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrD-0004lg-UX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrC-00036P-Tk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:33948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrC-000358-NJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id s144so1922914wme.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e6FP2ihGyimY4vj+dOSdMZBpX4HIMQWZAgOG4qQpKUc=;
 b=EQN9kUtpRS3FItvt7DfiHy6IyyEQD2oDGD7zuuczFNfbzVlQ8lbAv4pmpOpvdU0AMF
 uDdHw/RQe54jGQYPWMguWMmPmRKshBPoQWPI4Bu9jdlhXyOOV730xll3JMfplfCfl+aD
 J2hlw/zMTgimuNXdeSKgaU3QYhMryZz+ItVaDklMzifMchKUj8GdLJRKrEhqMhuAHv1w
 7x4gSt5iqa4duqHgCs5F+NjNIXTHETvXPLsbzqxlGcJ17txgc6nHmmxoQTc7iUE5fLOC
 sBP0qfSJ9hclWpYShmvp6x3fieYzlKAVqN9ARiVcH21N+d7TajyNm8haAbEpY1VWI6LY
 ck1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=e6FP2ihGyimY4vj+dOSdMZBpX4HIMQWZAgOG4qQpKUc=;
 b=uhe2gNKpOWIqKO/E9ZCKg1u2VG/LRxDhugQJx7CO004KFSOlAqqyYchVh3mphGfhuu
 Gc6ZUXVDW/9DXwSLdr8STn4HmKtI1AEKPKoaGeS1E3cD1qpU0An9VVsbpygVyg0QqGHP
 l/UjhGWfvbVgMwt2WLEx8+xSjFPdgDFyw8PzBn0BOPJLg4T4x3V7XMsvopE1VQ5DokHc
 t8MqggAOOH8uSPsQHMN+QT0mvjjjkyHXaJyOQ03eQ5PSxc2J3QCfogeAD3dfDeEg8Zlu
 m/q2LRF5SInSLtXhKjPNCtd3T3gAlHChCxDPRS75DbqNvAwZ5dzu5w6Kc16v5M+f5Fok
 C0qQ==
X-Gm-Message-State: APjAAAXcAu2XwomMzuoyb85tiGdfxDVWwgKam87BROeMJy/87GmguCS4
 6DiW660XnrFlXgiwrRI9LJhBJc3L
X-Google-Smtp-Source: APXvYqwDTn8oMJPb7dsuAp5iCB7OI1Q7OsICH9eiMaz6XbBIrJbgaONUHTA14OMdGJaJVG9iuslpoQ==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr4381755wma.139.1579787353575; 
 Thu, 23 Jan 2020 05:49:13 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/59] hw/timer/aspeed_timer: Add a fall through comment
Date: Thu, 23 Jan 2020 14:48:11 +0100
Message-Id: <1579787342-27146-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reported by GCC9 when building with CFLAG -Wimplicit-fallthrough=2:

  hw/timer/aspeed_timer.c: In function ‘aspeed_timer_set_value’:
  hw/timer/aspeed_timer.c:283:24: error: this statement may fall through [-Werror=implicit-fallthrough=]
    283 |         if (old_reload || !t->reload) {
        |             ~~~~~~~~~~~^~~~~~~~~~~~~
  hw/timer/aspeed_timer.c:287:5: note: here
    287 |     case TIMER_REG_STATUS:
        |     ^~~~
  cc1: all warnings being treated as errors

Add the missing fall through comment.

Fixes: 1403f364472
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191218192526.13845-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/aspeed_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index a8c38cc..c91f184 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -283,7 +283,7 @@ static void aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
         if (old_reload || !t->reload) {
             break;
         }
-
+        /* fall through to re-enable */
     case TIMER_REG_STATUS:
         if (timer_enabled(t)) {
             uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-- 
1.8.3.1



