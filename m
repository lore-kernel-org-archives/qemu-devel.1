Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4EEC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987CD21479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l07XlAj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987CD21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSqS0-0003AV-Rh
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 18:08:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSqQa-00024l-CX
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSqQZ-0007wZ-Hg
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:06:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSqQZ-0007vu-Ba; Mon, 20 May 2019 18:06:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id f10so850220wre.7;
	Mon, 20 May 2019 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=BJpTOa9I9iAAGoqiRWwnp8ZjNrCFVt/LqLntdOkI0yA=;
	b=l07XlAj+KcfoCuTH/JfIrjm7/oO7HzyEN7lWZ9O5aUJw6dR8y+FG+FwGlP3DEeKkVx
	Bxzv0N/6tCxGzcc6Bw2X//IXe3axkfR2iXufrYgEjQolvkgby9P9BHfAjrJyOgFK4Es1
	3HrIxxLrxaJCiIPZVqL1J+qCXvZ3O2uHiuDqfU/czgN+wTcFz9wz9VobXBRH413zFdow
	+AH2vQ2b56y601i5XbpAdpMIyTzKdXB7by9HjvyoocryXqXE2yjMC5OOjA+kou3YNUeW
	drE5R08Ri6WrnIz8M43gbvko/IBCPDelrst1mZcZnopLsbO3sf2dQtshDQBRxVpV6xyW
	y/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=BJpTOa9I9iAAGoqiRWwnp8ZjNrCFVt/LqLntdOkI0yA=;
	b=LW15WR23ZTXwxGeb3VYxHUJsz3objvwkxUpnCH71T2lYArK6BaW+uckn12PH90yHmI
	qb4aqKQlwM6xoF3L4gf4dKUsFJEsvGXcMINc8YFnjyvqgIJD4BNy9iMyrz5VqVyLhw0D
	JQoSOLhBCRVwnpxixWIBILDxJQ01pVuzUmPIYXoGrCc4UV46RInZWPQkusvYoc7Q5lhz
	2EyXDZ9QaL9sbyQodqxeffy2rnxc9tVxsDNdTjNSJxEzFalTkN61jODszPL0kF084kpE
	mIf/nnCQsQ0xbPb2awVhQ/IzDNALBT4yphNGyN5MhszJLYBwD4CudybarIcSUtCYhIia
	DYAg==
X-Gm-Message-State: APjAAAUmk9H7jzUVy2Ymu8hAW9RA2G7JOB3pX1MyXog5RkM7nyzKAiVV
	kTQ4TnFMgo/Su0Vhw1s/NUlTQyvz5rE=
X-Google-Smtp-Source: APXvYqwdA0UAeKHmK26oy+f+VLqpFXGaEfYleaBA4lu9rjJRjXjlwoaVekOsrsZCdJWik4AeBgQjNQ==
X-Received: by 2002:a5d:628d:: with SMTP id k13mr25898694wru.319.1558389998133;
	Mon, 20 May 2019 15:06:38 -0700 (PDT)
Received: from x1.local (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	y40sm35462259wrd.96.2019.05.20.15.06.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 15:06:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 00:06:34 +0200
Message-Id: <20190520220635.10961-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190520220635.10961-1-f4bug@amsat.org>
References: <20190520220635.10961-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 1/2] BootLinuxConsoleTest: Do not log empty
 lines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Caio Carrara <ccarrara@redhat.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
	Cleber Rosa <crosa@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid to log empty lines in console debug logs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index d5c500ea30..f593f3858e 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -37,8 +37,10 @@ class BootLinuxConsole(Test):
         console = self.vm.console_socket.makefile()
         console_logger = logging.getLogger('console')
         while True:
-            msg = console.readline()
-            console_logger.debug(msg.strip())
+            msg = console.readline().strip()
+            if not msg:
+                continue
+            console_logger.debug(msg)
             if success_message in msg:
                 break
             if failure_message in msg:
-- 
2.19.1


