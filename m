Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30923C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E382C20675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgTc8tb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E382C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSUq-0007uA-4M
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:33:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSI2-0005k9-Da
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSI0-0007eL-8N
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:13 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSHy-0007Xh-Mp
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:10 -0400
Received: by mail-pl1-x643.google.com with SMTP id d21so5714155plr.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=OghAJHs3fOQNasKs983B96RGcVieroO+wnBU19gV5SI=;
	b=PgTc8tb0uGJBUQ91uzPmnpK2qR3CSaZGEtdGDqHMDUErDl+tJkM/06tHP9tg8x8Ri3
	1rTNFUyqAV+ummikZJvkb0txOt7YM7xcSse0YYY3eso7sFXa1eQN7g5WvrMpkG+KCdc+
	R/PrzFOolMpayQgBQEqL2XnD+3N3GrAcP46P0bRDMXGq2Mtby4pCO3d6oFT851VK5G41
	pk1daf4L8E/i+kKgJ/4tclpf2af+IVgO+KViNEsgzmqFAjix6vqnXt0zA2JOuqrCd6x4
	lXg9SCG0MmdNyFk0OdRMHuoJrD9Cvue9Zdow+fR7oHA6U4j3V8i8aAOd3RWpdwIPTWxP
	9lHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=OghAJHs3fOQNasKs983B96RGcVieroO+wnBU19gV5SI=;
	b=pwjbkA3iBZ17ez1gW5xNp8CpuItUldRK1XVCUS/dixNWuFEd9n+qWswuyCwrNTkM7X
	G0KEN/7Jz0UTJ2C986qvQLv6uU/bPqVhn0StyrF0muBinKKEmY4UvKgpEOu0XIULzsnH
	ptlUFat0ZoaqWARYyhxaR2Sgsrv5RwzoLWEoYsIFdA7z0EeIFHbubgq++bpo8korbDn0
	R9l1SGn7Y2jhYzZf0vylTR3ebgmhUfRXyEvXknt0AVURjT3wACzTNqmYqEGHUiJhzXfK
	LBzlWEUG73kZhri6xs0aWqjsDDoLa2wlD6HLHbgnKjK5Qj2i4b5PueeGYwOdAvXQrOT0
	HCJg==
X-Gm-Message-State: APjAAAUoC6z/oZZsruRplR+vkCo1uqiYwK+zWEMCGLFhXwahzO3yGAsk
	3A9rukwcIMfA67q7EemGEkdPFG9ZrZM=
X-Google-Smtp-Source: APXvYqx2hVtHNMo+/6ciJEVghnkVOPLzq5OvLbR4X3DhK2aFNt6360NbTZICNdnC7i3Kg3ioiCAQUw==
X-Received: by 2002:a17:902:ac90:: with SMTP id
	h16mr8998490plr.162.1558297208369; 
	Sun, 19 May 2019 13:20:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.20.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:20:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:50 -0700
Message-Id: <20190519201953.20161-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH 10/13] scripts/qemu-binfmt-conf: Update for
 sparc64
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also note that we were missing the qemu_target_list entry
for plain sparc; fix that at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/qemu-binfmt-conf.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a1..9f1580a91c 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 # Enable automatic program execution by the kernel.
 
-qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
-mips mipsel mipsn32 mipsn32el mips64 mips64el \
+qemu_target_list="i386 i486 alpha arm armeb sparc sparc32plus sparc64 \
+ppc ppc64 ppc64le m68k mips mipsel mipsn32 mipsn32el mips64 mips64el \
 sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
 microblaze microblazeel or1k x86_64"
 
@@ -38,6 +38,10 @@ sparc32plus_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x
 sparc32plus_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 sparc32plus_family=sparc
 
+sparc64_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2b'
+sparc64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
+sparc64_family=sparc
+
 ppc_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14'
 ppc_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 ppc_family=ppc
-- 
2.17.1


