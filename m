Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05763C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C971B206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONVMm7YY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C971B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjPy-00018Z-UW
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOa-0007t7-Pd
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:24 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOZ-0007lu-Cz
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id l10so11259560wrr.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jkTOq2PXmEwc1GxRKr+8vq1tSIfxuDyzzjRCTdzClcU=;
 b=ONVMm7YY0GG1O4Ohs3j5TE7fE8gk7muSeB178ct+vA0Ie2wSJTeFKbX2ynDQaOojjA
 t9o6ALI6c69Nui8hwIdB/s5pWIXwNvsSoDUvfj+k1t7htn/NII1nzj1jWZiCIyaEKXLv
 /w8tPr+v7CyriwpbufsSdsIT2yoPETTlj1tONt+p7Av7KvcImV478zaZn+b1dbPZqMtH
 nT3ua27Voc5yIZ1O4Oeu4IGjTGGPTBStZylnZEutM+vwZ+JTYsXXVttz1ffwGHvNH2RD
 mFuXsDGIbsFspmgwag4RTACQyhzqqmzyQXOAdwhzA6NjMRSI0hskNRlyxWcZt/4qjfN5
 GMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jkTOq2PXmEwc1GxRKr+8vq1tSIfxuDyzzjRCTdzClcU=;
 b=hAK0QHRAdPBi2Hgyu77xQ+gonPZ6UUsONDdR7XzCgwtvkgcKMrKK/Joj9piIB2rn64
 myE7KkEflvL53I67wnb1QvudILTec23mEcJyiJEOcVKKNwlaL5uUy+M5bk6kFONmXjOI
 6PdnsXkuxaxIJqt+LIdlYbsRvLhrMkhwobDeG9/TIrjmgm21iSoSXxtu+98ixfMtP/cX
 xBezPAZ5VF87aQKjdGSGfVqw/T5gYTfdv20Q/1SSW+dOOxzEIa3ZbcyFRDD7x1v5OWVc
 SpY2x+is4HIpYA4qdPc6amygDo5lGykqKENQbpNCY/c7elt8cSH7rpogNa9jvefJREbI
 JYYQ==
X-Gm-Message-State: AOAM5315CXM6rjbMcIP5bGg1Bv+oGhbCs80EQFUp408AhvY/j6R9EhGN
 fJYgDnlvrTyk34bNqmEOTl8sJYoxc10=
X-Google-Smtp-Source: ABdhPJyGUuNMBQRAHEsn7vbTWNIxAvSWJ1grr7ymwPO6j14jM//lGUFiYRyrWzTZk+KjqotEPYb6uA==
X-Received: by 2002:a5d:4a89:: with SMTP id o9mr9628372wrq.267.1591013901405; 
 Mon, 01 Jun 2020 05:18:21 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y185sm12332136wmy.11.2020.06.01.05.18.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:18:21 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] configure: Add KVM target support for MIPS64
Date: Mon,  1 Jun 2020 14:18:14 +0200
Message-Id: <1591013898-23391-3-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <zltjiangshi@gmail.com>

Preparing for Loongson-3 virtualization, add KVM target support for
MIPS64 in configure script.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1588501221-1205-2-git-send-email-chenhc@lemote.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index af2ba83..f087d2b 100755
--- a/configure
+++ b/configure
@@ -198,7 +198,7 @@ supported_kvm_target() {
         arm:arm | aarch64:aarch64 | \
         i386:i386 | i386:x86_64 | i386:x32 | \
         x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
-        mips:mips | mipsel:mips | \
+        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
         ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
         s390x:s390x)
             return 0
-- 
2.7.4


