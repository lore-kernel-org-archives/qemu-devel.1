Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57862C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C89A205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BADQaGkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C89A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDklA-0000aW-7f
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfU-0008RP-L0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:28 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfT-0001Yc-0i
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:28 -0400
Received: by mail-pf1-x444.google.com with SMTP id t9so1714797pfq.8
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kZMPJvEMdwYjQlePlaJK6nWLcDjpDXuUWt/8zY2tP2A=;
 b=BADQaGkTcxVwXilGxDbX4m+keTi1jHwnslluuVw5g2EYD9A5v7ombJlwFfhBed+7/W
 lKmNZjipVrvbZZLylahXp6/k0cd/FN0Ezwb+LndyiW/MpXx4iAjACcqOhME6O8YCMVUj
 0qTkOEoph82hx6cmK9Sw5yJfBrmLlJqbuezdhajeckL/3+KkwTBUG/jrk2w2y83ECRQZ
 ELbWLoD8lYDZw0L/SzKUUd2tolNUByipRA4Hw/TmNoRX5FGmQ5YDaB03fUPzbDbd9RJJ
 9G26lBZaiRKtd9Sdg9ZLzPOQOKvBJr9+R0zwoBPk+12fEk5pNy6PqgD4h4qRAUZF4PnY
 jgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kZMPJvEMdwYjQlePlaJK6nWLcDjpDXuUWt/8zY2tP2A=;
 b=l4r5Pm+vBdFve0CT2ff16aO7UCCmiS5wiP5UoAgpOCLrPTVRSne598uGZ9/C+VlSqP
 diWLbYUbHohPOJ23a+bmAWF8A6NUBzA3aZyVHzD7KFA87/RNZzHsMApRiS3X2jIYAKUZ
 Aa9cY139qGeZwB1JfF6KpsjRblHcaGNy2fBE02iSBPOT6PIjkgSf5piqQYmm2i0hRQMt
 kuKN1X71fOqQ8ocu0/vP29F16S/+doDSju4jphYE6ufX3qEs8hFTY0KiGZZfHbZ9enIX
 NWW9ETXc+kuzE+8V4EgF299gJoNRc7fvGi34lRkha/gWdP3rhRSDHNMZf3CJO6S8H/9S
 XefA==
X-Gm-Message-State: AOAM533cmy6m7m+9OKjrjC+0N+x6HqbTIAujrAkS93oVekPl34B9sBMs
 wlwfRyh2C8nOLQv6oDM5hbbobtPR2Sj3qu0D
X-Google-Smtp-Source: ABdhPJyk2hBg3FwMAALD570n1B3wYBIZ4u1ppXvf3qep9nkjClfkBo6yb5Srmsf6stmxAP63WhA2eg==
X-Received: by 2002:a63:6d4c:: with SMTP id i73mr2132904pgc.63.1599121945286; 
 Thu, 03 Sep 2020 01:32:25 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id e7sm1759201pgn.64.2020.09.03.01.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 01:32:24 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/12] tests: Disable test-image-locking that not works
 under Win32
Date: Thu,  3 Sep 2020 16:31:46 +0800
Message-Id: <20200903083147.707-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903083147.707-1-luoyonggang@gmail.com>
References: <20200903083147.707-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9ac8f5b86a..497f1f21ff 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -87,7 +87,9 @@ check-unit-$(CONFIG_BLOCK) += tests/test-blockjob$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-blockjob-txn$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-block-backend$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-block-iothread$(EXESUF)
+ifeq ($(CONFIG_POSIX),y)
 check-unit-$(CONFIG_BLOCK) += tests/test-image-locking$(EXESUF)
+endif
 check-unit-y += tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
 ifeq ($(CONFIG_SOFTMMU),y)
-- 
2.28.0.windows.1


