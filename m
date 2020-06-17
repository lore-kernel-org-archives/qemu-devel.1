Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C597C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 04:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EFE2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 04:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTOYkSuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EFE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlPtu-0003MA-BF
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 00:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlPpw-0006qi-Lb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 00:38:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlPpv-0001Tp-21
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 00:38:08 -0400
Received: by mail-pg1-x541.google.com with SMTP id v11so651632pgb.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 21:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jYIhlgGCq1UUdx/JfqZRUcnP+U2PpbQCAFcsCH7XqwQ=;
 b=kTOYkSuUXu11HGclWCRwxe8yk9zLjb/6dA69WXkVzq8xZNIM38v8qzwUTxktClD4HV
 df6A1LUGS5L3whi1S8/LX3q7wOK/b67wJYhzj18zCcozNpiUOPgN2CStJyb+qek/ztoz
 5YSktlpXZ6Ee8tSHlSZH6K0Rie2cMVCk+VCXJOoLX9Ha5g55NpCAfh56Tt0KAfbNTDzw
 0J6bX/jm4OOD6Juw1o06stXIYZu5zOo17tSYlR9koxNkRLhOfRNipZyQpF2RiQ1uzlgw
 kTmFSEBgL7HMAPFQM/k4z2vGzK+67XQ55RIDN5/JlBPbWUFpH7dXMEjuIDzVjO6SfV9V
 ++gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jYIhlgGCq1UUdx/JfqZRUcnP+U2PpbQCAFcsCH7XqwQ=;
 b=mNuQoBRISmHx4i7S21vcwRxawwhPYi1PhgvCb32+sDI4bDVBnf6LiVCwMfAlDEevRZ
 pMztnLE0o/xYy7Ox0/o80liplXNpnPVdwyThI1pfto5uwfUDV0bKp033PT//I56CGLeN
 3JGuUXEuSUqImHZTN3eaTMnkpAZiUu0oSbSRNqi4BGniT2XfOt7o8BkT1EljHNQG6LID
 8CCj2cLD9P4cvkvmuVoRAkm4FhFe17BcL2ha1W33y8RaWj1O6vwfUWDzyXf/xwWkxp2n
 RHKkxJBFCZHwGvjrIlO/L17Tk1G+AHFFe3sBsPI9l7E7bQ8cMOOqP7EZ1ylD+xcCcXdD
 4qnQ==
X-Gm-Message-State: AOAM531yMPQELYIB+/a+Q0lI/LSSQJplk+er4PS5HXmalqPWn6O/zF7n
 X10lmB41wQYXBlCjFor1RTvUEE8zOHQ=
X-Google-Smtp-Source: ABdhPJxPYez1C36KmAlYobL7dvQyuHcIpHem7WI00m9MjQckpk3q6JLoqgg/Ja9NveEdnACjqHSRSw==
X-Received: by 2002:a63:63c6:: with SMTP id x189mr4723224pgb.36.1592368685518; 
 Tue, 16 Jun 2020 21:38:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x3sm18585808pfi.57.2020.06.16.21.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 21:38:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/5] configure: Add -Wno-psabi
Date: Tue, 16 Jun 2020 21:37:57 -0700
Message-Id: <20200617043757.1623337-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617043757.1623337-1-richard.henderson@linaro.org>
References: <20200617043757.1623337-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On aarch64, gcc 9.3 is generating

qemu/exec.c: In function ‘address_space_translate_iommu’:
qemu/exec.c:431:28: note: parameter passing for argument of type \
  ‘MemTxAttrs’ {aka ‘struct MemTxAttrs’} changed in GCC 9.1

and many other reptitions.  This structure, and the functions
amongst which it is passed, are not part of a QEMU public API.
Therefore we do not care how the compiler passes the argument,
so long as the compiler is self-consistent.

The only portion of QEMU which does have a public api, and so
must have a stable abi, is "qemu/plugin.h".  We test this by
forcing -Wpsabi in tests/plugin/Makefile.

Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
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


