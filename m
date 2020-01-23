Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDD6C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4562124683
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4562124683
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXnP-0003LX-Pj
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlI-00011Y-D5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlE-0002nn-S6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:48 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:36769)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlD-0002e6-4T
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:44 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N9MYu-1ji7aL2gYW-015Eej; Thu, 23 Jan 2020 09:22:37 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/17] configure: Detect kcov support and introduce CONFIG_KCOV
Date: Thu, 23 Jan 2020 09:22:18 +0100
Message-Id: <20200123082227.2037994-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vw/gO8wDzJ24T7wRq8a05ei+gcep8mZSfAVtR0HjNqe48tPpztH
 hYMGYdsVqSshliBuwcFtcN9dt4luvoQOL3ADpX1c/UYp2j5aMrkhNrk9/lAGTAkXrGoCq8K
 cwtCxGNPyXRWL+8YWnbSX2piGA/N+2/2HymRzBrw8dAy8n41DGUuW7AUbeLbFZ6O/O3DIWh
 dVYS1Np5ZZrZHuCc3uOsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2L5W3dzSbsA=:XYPGBPcozcxkShAWDaUIBz
 MZhuq4YDx4X61FnRZz7S3pL8IULSdhJJbN6IwKOkWbugWUb3fVG6r6kN0bmMdxUxnnTk00Y3G
 KvzlQzDYAwUKxvr+hVCi1tLbgsPbzpZpXXd7k9DlUpKzcbkHUm7XgLH6Lq8mu1pbYBZ3Wc6d3
 w5YQB7HqTIkDMjcAkJVvDrsB/VB+KO9GawiJmDE8qoIB72kDD3LGGYvkBVxlFolzd4tZ3y13U
 F8QKradllu3i+EyL1GNDCp0fIPrb1dXGBLIgSH8baUmFzab3IvEFTBr/gujDfvwf3mOi8Y8kv
 NNqRFxCsYrkQ1n5BvA+G7yu+vUD0RJTqgVKJ0030JpiDZKGiVIz6v85SPDqQ8FNu/167xR9FX
 huYNGuMD/4aPaGq2hSos3AsyO2quNibQr0oZv0X/hEq4VE7ia344/khzLYK4bzg9W8uxyasAv
 TQ/o1dN5ac+HnNW9oPb+CXGrBxskOWUAPl5cxb9Y0GfUzrARfdV8cCnT5Fq1AjVYStEfx19w+
 QyEkySbVAX8Ou3pg+jzTmnV9qN1028pkXJjFUUFAB2/4yy/48dqMCkegBpiUhLyMw3NU95Y0O
 X8q6cMEXTbSAa0mUr9vZYgSPUIm+2dofdpTM5Y++X3IH/fYtwiRN9Zb/dWUQAIK1F6Z3jfZtk
 3WHQNvHeer0aHsCKNK6bK1TXtYwkxudm4Xg3nrWWs2nHOlzdpq22iubetE+7JepAsVQyec7Ti
 bY0Y48uJmA230mHenYsPqOFhH7YpXUG5dPbQV8ACr+rBnH20xRRBqrwOlBY93g5d+63u4oWAb
 Hj+URYc6rRx1Ezfsv8oNoAXr5GEHwJpPJkEN9DQ2Qw46kk9Ozw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

kcov is kernel code coverage tracing tool. It requires kernel 4.4+
compiled with certain kernel options.

This patch checks if kcov header "sys/kcov.h" is present on build
machine, and stores the result in variable CONFIG_KCOV, meant to
be used in linux-user code related to the support for three ioctls
that were introduced at the same time as the mentioned header
(their definition was a part of the first version of that header).

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1579214991-19602-11-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configure b/configure
index 557e4382ea87..d91eab4d65c4 100755
--- a/configure
+++ b/configure
@@ -4761,6 +4761,12 @@ if compile_prog "" "" ; then
   syncfs=yes
 fi
 
+# check for kcov support (kernel must be 4.4+, compiled with certain options)
+kcov=no
+if check_include sys/kcov.h ; then
+    kcov=yes
+fi
+
 # Check we have a new enough version of sphinx-build
 has_sphinx_build() {
     # This is a bit awkward but works: create a trivial document and
@@ -6874,6 +6880,9 @@ fi
 if test "$syncfs" = "yes" ; then
   echo "CONFIG_SYNCFS=y" >> $config_host_mak
 fi
+if test "$kcov" = "yes" ; then
+  echo "CONFIG_KCOV=y" >> $config_host_mak
+fi
 if test "$inotify" = "yes" ; then
   echo "CONFIG_INOTIFY=y" >> $config_host_mak
 fi
-- 
2.24.1


