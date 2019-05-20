Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8869C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8844420863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVAWmZKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8844420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrou-0002vn-QO
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:35:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSrYu-0005nv-D5
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSrYs-0004uW-Fs
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:19:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSrYq-0004qi-I1
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:19:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id w13so5630663wru.11
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=t+fpOzpoYMTvZREMygefSwOqjQyndhbSY04K2Iq39pg=;
	b=jVAWmZKmI6y+r6VDFVkTBi6LAZNWENUiNHOYXG6qPOkHgcZGB5Ci0TKw4Bxrfo5s+A
	9dXyuPzOn0Dgjv6kdVigPzGpiwi81AI7Je9l6f49uG1YeD4pNBBwBb5Xm0n5XWcjWgir
	tLWAx3uWve9ygWbyP7/M9RmGnGuK9TvgCjty2a3eEj88z8lBMgbpasEc5u8buNf1iSJM
	aUMFmEP05m+a9QnJt/+GUEvLvoRNCpd8gPd7u+XOUFqO5lABhijWVtTL3NJ66kNcZAi2
	2ab9bQhiDLjRDl5Fd1WxQzTSSnY0BImL77Az9EbEKvxaLg8Li01JgLAmhMFlMtLheAUZ
	uClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=t+fpOzpoYMTvZREMygefSwOqjQyndhbSY04K2Iq39pg=;
	b=OuLOvYyqrAbXYTCQmviQ6LJxGrkGYNwMZlIOQTdAFjTZgXJjoDQJfnAYtZoOs/VMCD
	gZdQDMyapJJFwYzFwaXqPKlijLsfiDSdtQZQRdgPBIPf3Ksozw5GK6cFfFjxYAhEoDOS
	bJ5ewLWu8TVjnrZgfmoc282ICcm2zSN8FrPGhOORxVafvOfwsrACL4jrBD+3L1ij/RBy
	XbvxGxXYB1un+k8h1gEcjL1rfzfiSt6vMW/+urxujGQAq/N4ueHn8q6qoUbfbQyBPaH2
	hDR09Ux+GWBwb8IpNPa2oBXaVEYs1JDiVfpBfSzQ8stOC76XU1z/6y8AxqXRdK99CaEe
	rCgA==
X-Gm-Message-State: APjAAAXkoHYkrPBlJawXKQeGbDi6bEJx54/ZcGoFdqfek1+Dc/yRd4+T
	3uqpDQj8Sfeknw4b4yyIHG0c9sO17hM=
X-Google-Smtp-Source: APXvYqw6eP1t6lpsFsk5GLbbrjCMA39Gky8ZVPcE6rBeSlAEJgU+YIESrnJ6cQ5Iqg3RNEVKw6TsOQ==
X-Received: by 2002:a5d:638a:: with SMTP id p10mr21118903wru.273.1558394353844;
	Mon, 20 May 2019 16:19:13 -0700 (PDT)
Received: from x1.local (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	b10sm44261849wrh.59.2019.05.20.16.19.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 16:19:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 01:19:07 +0200
Message-Id: <20190520231910.12184-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190520231910.12184-1-f4bug@amsat.org>
References: <20190520231910.12184-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 1/4] BootLinuxConsoleTest: Let extract_from_deb
 handle various compressions
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Caio Carrara <ccarrara@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Debian binary package format supports various compressions.

Per man deb(5):

  NAME
    deb - Debian binary package format

  FORMAT
    ...
    The third, last required member is named data.tar.  It contains the
    filesystem as a tar archive, either not compressed (supported since
    dpkg 1.10.24), or compressed with gzip (with .gz extension),
    xz (with .xz extension, supported since dpkg 1.15.6),
    bzip2 (with .bz2 extension, supported since dpkg 1.10.24) or
    lzma (with .lzma extension, supported since dpkg 1.13.25).

List the archive files to have the 3rd name with the correct extension.

The function avocado.utils.archive.extract() will handle the different
compression format for us.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
This patch is already in Eduardo's queue, but is required in
this series.
---
 tests/acceptance/boot_linux_console.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index d5c500ea30..6aa084e049 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -55,8 +55,9 @@ class BootLinuxConsole(Test):
         """
         cwd = os.getcwd()
         os.chdir(self.workdir)
-        process.run("ar x %s data.tar.gz" % deb)
-        archive.extract("data.tar.gz", self.workdir)
+        file_path = process.run("ar t %s" % deb).stdout_text.split()[2]
+        process.run("ar x %s %s" % (deb, file_path))
+        archive.extract(file_path, self.workdir)
         os.chdir(cwd)
         return self.workdir + path
 
-- 
2.19.1


