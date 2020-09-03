Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED7C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6842078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaCLO/l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6842078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnJb-0003g6-CZ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIn-0002PS-He
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIl-0007Ym-MM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so2822581wrt.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3s9Lh9SuoJBT80PUo0orwYBl9/LamoZzVpQf4w/nqoI=;
 b=jaCLO/l9mIRhNmiQJdUnQk9OxdfYDXeIv76Wq5ChLQDA6An5SvICISX/a6k5Q+Ee3x
 QvW+m/uTUUtmGyhX01vO5gITrGOu4HeCQkP9CP6x6vGtM4o/oRyMXQgYRUSBGKtzA/h0
 elB23/zv9rCvouuIjlRpEB/G6ABVr3Y0oXahli7gHKcuB2nTZHKgNnQDLsNvwCodZMjI
 KEZdnvCCqwDPCxUBs6fiUCGRpZGvrsdj0YCU7Z2ZCdC86NcAhNAb+Gulh9sMlA1avNVr
 EZjy1ExDCbukJTk0XHocKQfF3LE0++0t/ByM73idRxjjhOxaVAon8aUXuStPBVUPgNvI
 ecfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3s9Lh9SuoJBT80PUo0orwYBl9/LamoZzVpQf4w/nqoI=;
 b=siWBC/uvRzEgmE6XhoD1zcf0DAZg5MsnTntlKpsbFy84+Nf6rN3uHbfcxi5UEMkiyh
 wKZxPsbAtvmdCNmAsZehxV17qVty63JVGwQ5UAA+F7fRcCdnAFSyihed9uhfqew08BSv
 mfvSIOl6+QH76txKhjrbD3z01gECMjKDTSkRYo8F849BUeUOGvB/D67ICnBfe6aqj8Af
 r8dZrIQJXb7h8WnoBHZL2EeommtWeGlE8CLCTyDziXs9Wled+r4oLs+RmtzAxs2y6dKo
 7HazTctgq3ZdOhG+n1xRTPav5hXFujCPJvjmYpLzRBMlVpXNrzo5i2J/DyvZ4uv0yQxk
 ILug==
X-Gm-Message-State: AOAM530bGrfDYm5VWOzVBPmNUdGvy9pGKTMbHr6S3O2wL/lDkH5APC7m
 9YwJiMSWDD/FsxqAhneD+9TOhw==
X-Google-Smtp-Source: ABdhPJw0DWiastulfqgHWbtBORI7dnHbvsOgVXPZAF5mZqURBAItdcHWaBLHu3kyybCrPwHn7bixPA==
X-Received: by 2002:adf:82cb:: with SMTP id 69mr1957623wrc.222.1599132070341; 
 Thu, 03 Sep 2020 04:21:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q15sm4393314wrr.8.2020.09.03.04.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:21:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C71CD1FF87;
 Thu,  3 Sep 2020 12:21:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/8] CODING_STYLE.rst: flesh out our naming conventions.
Date: Thu,  3 Sep 2020 12:21:00 +0100
Message-Id: <20200903112107.27367-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903112107.27367-1-alex.bennee@linaro.org>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mention a few of the more common naming conventions we follow in the
code base including common variable names and function prefix and
suffix examples.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - punctuation fixes suggested by Cornelia
  - re-worded section on qemu_ prefix
  - expanded on _locked suffix
v3
  - re-order phrasing around qemu_ prefix
  - drop "while actual..." shortname examples

squash! CODING_STYLE.rst: flesh out our naming conventions.
---
 CODING_STYLE.rst | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
index 427699e0e42..fd8ce9ceaba 100644
--- a/CODING_STYLE.rst
+++ b/CODING_STYLE.rst
@@ -109,8 +109,35 @@ names are lower_case_with_underscores_ending_with_a_t, like the POSIX
 uint64_t and family.  Note that this last convention contradicts POSIX
 and is therefore likely to be changed.
 
-When wrapping standard library functions, use the prefix ``qemu_`` to alert
-readers that they are seeing a wrapped version; otherwise avoid this prefix.
+Variable Naming Conventions
+---------------------------
+
+A number of short naming conventions exist for variables that use
+common QEMU types. For example, the architecture independent CPUState
+is often held as a ``cs`` pointer variable, whereas the concrete
+CPUArchState is usually held in a pointer called ``env``.
+
+Likewise, in device emulation code the common DeviceState is usually
+called ``dev``.
+
+Function Naming Conventions
+---------------------------
+
+The ``qemu_`` prefix is used for utility functions that are widely
+called from across the code-base. This includes wrapped versions of
+standard library functions (e.g. ``qemu_strtol``) where the prefix is
+added to the library function name to alert readers that they are
+seeing a wrapped version.
+
+Public functions from a file or subsystem (declared in headers) tend
+to have a consistent prefix to show where they came from. For example,
+``tlb_`` for functions from ``cputlb.c`` or ``cpu_`` for functions
+from cpus.c.
+
+If there are two versions of a function to be called with or without a
+lock held, the function that expects the lock to be already held
+usually uses the suffix ``_locked``.
+
 
 Block structure
 ===============
-- 
2.20.1


