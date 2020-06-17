Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F10C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54F8206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5lpsjvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54F8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jleRw-00075i-3n
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 16:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleR0-0005oC-N7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:22 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleQy-0000Il-R4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:22 -0400
Received: by mail-pg1-x542.google.com with SMTP id l63so1799795pge.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KWMxYf4wO7x5jAN+/hqtYz9dCtHYS2Ay0EvaIwt8nhg=;
 b=K5lpsjvBl0D/4ebX+bdfX/ktGrI2K+BLRJWLwmDpcGmPQgX3zNuq4A/MF8qNzYIh2s
 e2IcBP2+pkHUtepLBDf/aKzFPW1z5D3qv/hpjCpLrFOziZ4kM7NFRlLapDHg0b9S4wMI
 Hu9KeMGWXu9VZURu7BJRZDQhjiUeQkTGKXQjfN3T7PTNPEx9RmW0n/Gs1vt+dsDZWZLj
 JK82MDkVWyo1Ux7GGz3jOYchrULUtwxT6sXZlTZe9+LS7u+kNpVlxr0yXn58Q56If3cD
 b4nigH/yo86WcSCzq5VF2PopQ+mVIFjm2+cFlMbP2sr3FsTNDdNjqhQ+e29yYjN7v7Jd
 x/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KWMxYf4wO7x5jAN+/hqtYz9dCtHYS2Ay0EvaIwt8nhg=;
 b=V/pOUkH44UcgFg//0lcuXtcFL1kymKOhYHqBmAdoMlU75zzcQDY2GB21K59SK4rP5B
 PBkgLQuHKj6+VkbslwlxMf0eipVJX3YlkVB7b6loB3sNaB8nP0l/OqOnHD64DK58kWXv
 whBpbMEWn/EhLcJw0CmuHT2FEvcrL84/+oXhVMwRhxjM5bFmOY6D++4DKHGrz5TuBJBb
 DseL5MZjSt0w18MaQVX9AcRwCDhPeldFNJowMyK/SjASvw/4QvObDx1srJf9BKL9pxYL
 rh+0sHLLHPfZU7BwYACYG6OAvyQYq5SsQBaz24aPh+h8N4u/Ksxpbzx50NnZbU5mlwal
 Aymg==
X-Gm-Message-State: AOAM533XGCVFs3e2ETRs+Ou3MVYgibec8K6TkBiXNxq9OhbdxQ+690jr
 NDqCFb/bprJtbfP9huGGA0TGY1Fcuv4=
X-Google-Smtp-Source: ABdhPJxTNqdRzbkcnz1YeBosTkOLu1f3vOoZVlOs10FPpG55eK0wIRXkyc0tH3dUzn3Kx88HvfAzPA==
X-Received: by 2002:aa7:8bd0:: with SMTP id s16mr466871pfd.80.1592424799099;
 Wed, 17 Jun 2020 13:13:19 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h9sm659259pfe.32.2020.06.17.13.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 13:13:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/6] configure: Add -Wno-psabi
Date: Wed, 17 Jun 2020 13:13:08 -0700
Message-Id: <20200617201309.1640952-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617201309.1640952-1-richard.henderson@linaro.org>
References: <20200617201309.1640952-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On aarch64, gcc 9.3 is generating

qemu/exec.c: In function ‘address_space_translate_iommu’:
qemu/exec.c:431:28: note: parameter passing for argument of type \
  ‘MemTxAttrs’ {aka ‘struct MemTxAttrs’} changed in GCC 9.1

and many other repetitions.  This structure, and the functions
amongst which it is passed, are not part of a QEMU public API.
Therefore we do not care how the compiler passes the argument,
so long as the compiler is self-consistent.

The only portion of QEMU which does have a public api, and so
must have a stable abi, is "qemu/plugin.h".  We test this by
forcing -Wpsabi in tests/plugin/Makefile.

Buglink: https://bugs.launchpad.net/qemu/+bug/1881552
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure             | 1 +
 tests/plugin/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 5e27229f58..ba88fd1824 100755
--- a/configure
+++ b/configure
@@ -2055,6 +2055,7 @@ add_to nowarn_flags -Wno-shift-negative-value
 add_to nowarn_flags -Wno-string-plus-int
 add_to nowarn_flags -Wno-typedef-redefinition
 add_to nowarn_flags -Wno-tautological-type-limit-compare
+add_to nowarn_flags -Wno-psabi
 
 gcc_flags="$warn_flags $nowarn_flags"
 
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index b3250e2504..3a50451428 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -17,7 +17,7 @@ NAMES += lockstep
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
-QEMU_CFLAGS += -fPIC
+QEMU_CFLAGS += -fPIC -Wpsabi
 QEMU_CFLAGS += -I$(SRC_PATH)/include/qemu
 
 all: $(SONAMES)
-- 
2.25.1


