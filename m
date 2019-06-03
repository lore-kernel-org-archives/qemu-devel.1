Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE5DC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D52423F0A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNjpck8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D52423F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXql0-0004EY-Pa
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:28:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUW-0007X0-CC
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUU-0004fM-Ee
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:24 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUU-0004K8-6n
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:22 -0400
Received: by mail-wr1-x42f.google.com with SMTP id c2so12909378wrm.8
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/LqFWIj4+X0FRNeuxBBYQa+fju4V1g/lIpEfigt6J+8=;
	b=WNjpck8xHI1HeoA5SlnkXwjgBQ2WeSt9lQj08VuAty5+O1hOxHU6T9Jmjd1fNZsPvO
	JCKpWYjGObtkgfMb2pRAH+j3bAnlf7Y45DkxQmP+ZZ9G9EX5/FQUnEU28Lp9hMxS1Pp+
	82rImiJxn++NGTOuSqCFiWgL04U5L1BRinrcgDXe1iVdTQaIgbtUOMprqu9P6N9ZvlSl
	Q0WX8TFf3swobpdqOY7efzQ5LKiU4eVE9VyXaxjUyXJn0IK6VZULEpv+kdIz2Paa3aGu
	CN44f2tQMQXDlYz8o9app8gt0tVRXYAaXWCxC1yOuZMin0OsXhKJfJLzeQHGGR7GB0sK
	VbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=/LqFWIj4+X0FRNeuxBBYQa+fju4V1g/lIpEfigt6J+8=;
	b=g/FjJj+GkTol6BFaWYIYrkT72wUYkBvyarylvzo2807M8DxKvprmU4dbHQApbuC/YX
	Ww2o5TDG+fdmwpCdLbRP9zspHsw6mIFpFx0aLTUVZ5YBNfz59Kg2ZRQsiQjOKyxkWIeQ
	py8tVfFHE42qgVPPdBq1LsrimU++bznbmtCwmjI5KGoPG9zvzk25sTcuZZZGGl5uZxzy
	+CeKyNTuXaNBV7Ug6Ii3IwfzvusxXzaYwUrAFLP9MAywlqfpuTOtTOc+D0ij0Ms9R4VI
	qrX9qLHVlW+hv+qEV6PmS1HdK1t7PME/Bojkd/O9NJ4paI7kHVWgDlDI7vKUgfWelqE+
	ZOxQ==
X-Gm-Message-State: APjAAAVuDe5kZsQFH1y1M/CW3lLuyBko3VClfxvuVaKvPydj+jkl3OWS
	wKa9XSIfDAxCGfKqDq0cCKe5ck32
X-Google-Smtp-Source: APXvYqwx9TwSIK7MZ49pVSEd5g9DXggqeE/mXOUdvj6v5FDBYrji4elNEcxfS5hZ8l1XMPtyAaK2hg==
X-Received: by 2002:adf:8367:: with SMTP id 94mr17655165wrd.179.1559581870361; 
	Mon, 03 Jun 2019 10:11:10 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.11.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:11:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:42 +0200
Message-Id: <1559581843-3968-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 23/24] configure: remove tpm_passthrough &
 tpm_emulator
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This is a left-over from commit 7aaa6a16373 "tpm: express dependencies
with Kconfig".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190524181411.8599-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/configure b/configure
index 6cdcfb2..b091b82 100755
--- a/configure
+++ b/configure
@@ -6452,8 +6452,6 @@ echo "gcov              $gcov_tool"
 echo "gcov enabled      $gcov"
 echo "TPM support       $tpm"
 echo "libssh2 support   $libssh2"
-echo "TPM passthrough   $tpm_passthrough"
-echo "TPM emulator      $tpm_emulator"
 echo "QOM debugging     $qom_cast_debug"
 echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
@@ -7158,14 +7156,6 @@ fi
 
 if test "$tpm" = "yes"; then
   echo 'CONFIG_TPM=$(CONFIG_SOFTMMU)' >> $config_host_mak
-  # TPM passthrough support?
-  if test "$tpm_passthrough" = "yes"; then
-    echo "CONFIG_TPM_PASSTHROUGH=y" >> $config_host_mak
-  fi
-  # TPM emulator support?
-  if test "$tpm_emulator" = "yes"; then
-    echo "CONFIG_TPM_EMULATOR=y" >> $config_host_mak
-  fi
 fi
 
 echo "TRACE_BACKENDS=$trace_backends" >> $config_host_mak
-- 
1.8.3.1



