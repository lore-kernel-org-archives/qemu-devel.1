Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E3C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D4F21D81
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYaCnPlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D4F21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFiH7-0000C9-6i
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrW-0005gL-Ai
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrV-0003cL-64
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:26 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrU-0003bR-VD
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:25 -0400
Received: by mail-wr1-x431.google.com with SMTP id n14so20461781wrw.9
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OxyYW3J9MIFejQsNK56crK2gciUo0hC0sFhHCl2w7jI=;
 b=HYaCnPlYntcM5hSBCMZUuZAQDzwHKtUKmr1JeWvYvWT8GYAk2qmr/49Mz/DUvfIfI6
 a9Hd5swVM28R5LxOqrMWxqC1s34VB4s5pVIr2ttNDDKGjTbPpoSEbRFQ5YEKbhURnbj3
 ynlKpHoUvUfzqlRkMlJG2r5Pod7H2YsoE04n5xARfp6NtByp7dXQmWsSmiJrbkDYNGK0
 EzOGf9OFA+peoIbRO/OJZAv36/QLiZDUF7MTCBoV7/1LP6uqw6ki3zVQw2H+otq0Z8qZ
 oDvngD7qlhWufLhC8CdUTXnVKzjku4D8DqjZihJHIdYuu5Va0881M+aoafLTlxa8iBth
 ZfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OxyYW3J9MIFejQsNK56crK2gciUo0hC0sFhHCl2w7jI=;
 b=f+/6TOazd1xaWG6SfDSCoD5TuFYvnx85Iqo3nq1BakTBFnOr80gnEa7iyz0j8wKBZw
 BaoaVoXdPJdfVJEGC5LIqQCAulR9fZ1ikO+jvBEAg5zYZkuY02vgZ+z8HRPjDIlk9dWZ
 nU5HhyS/fLSgmwoH0tcyxWNJOabB5U1ZlNHNiPuAVMTfXxOMx78I6oXgYN7fC2jBBDVs
 XWZd+o8U2wj28tRs1NWmv3UziYFH11Bji2FhpSYDzNoWeuOhaPaQJszpZCCFh0QzgtW9
 cHNNOmjqMtUzOEAsE76zLVRndTOPJNtql9c3as3HMVZf5M+v/dCMSsVJuOKsXLrxnsm2
 v5cQ==
X-Gm-Message-State: APjAAAXAjDjNjBa60qsgiBs9ZG9x80kn0MXBdtP8AhEY3B1DNP9ei8DJ
 xMa/fSjNsf55/6dbtvJaDMucahH7
X-Google-Smtp-Source: APXvYqzot8/kEjrGy2S/ggaM3vBFo4o2tx3CCntza1S442LTDGILtVfOBAyjhhpdQyUQ6QuE2iClQg==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr2219113wre.383.1570035143770; 
 Wed, 02 Oct 2019 09:52:23 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/30] tests: skip serial test on windows
Date: Wed,  2 Oct 2019 18:51:50 +0200
Message-Id: <1570035113-56848-28-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Serial test is currently hard-coded to /dev/null.

On Windows, serial chardev expect a COM: device, which may not be
availble.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index d62de1b..45e42af 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1103,7 +1103,7 @@ static void char_socket_server_two_clients_test(gconstpointer opaque)
 }
 
 
-#ifdef HAVE_CHARDEV_SERIAL
+#if defined(HAVE_CHARDEV_SERIAL) && !defined(WIN32)
 static void char_serial_test(void)
 {
     QemuOpts *opts;
@@ -1460,7 +1460,7 @@ int main(int argc, char **argv)
 #endif
 
     g_test_add_func("/char/udp", char_udp_test);
-#ifdef HAVE_CHARDEV_SERIAL
+#if defined(HAVE_CHARDEV_SERIAL) && !defined(WIN32)
     g_test_add_func("/char/serial", char_serial_test);
 #endif
     g_test_add_func("/char/hotswap", char_hotswap_test);
-- 
1.8.3.1



