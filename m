Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A580AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7458D20707
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRDwUXvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7458D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joszU-0002Hy-Oh
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrw-0007d3-Qs
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrm-0001KB-Iw
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id o8so9637669wmh.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=efB7wfcutdBc5W3t5fL1ob0gckNKfFStml2EZYTXVio=;
 b=hRDwUXvVIWaARXFCCFsx6zabkJvV3F9JCos2bdgxxnogZNLArtzH0z849AR33zvX4f
 CAxxh0TCuzxEwJ3cA4JWgOwOKK5WyLExZ/TgpvUG/Dl9jhXxaOWNRYYbuIUYd59F4MBC
 wOqtvBrp1eL3cHNotdYN+if6KstPPD5H+FifU3AfdscPwe9ou2mkeW1AYu8vu04Jdt6l
 Ve+z7t7BPDdO8kSofZIYOJPUWAKyFIvdcrkfEZukHSqBA/hbePfTCHvY1TbvWuQGWOAR
 b7602qHC2FbeSmnjqdV48q28mFO1wtmleMX4VAA2rRbIL4tUFtmTU/589i++tDqovxmv
 Ryzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=efB7wfcutdBc5W3t5fL1ob0gckNKfFStml2EZYTXVio=;
 b=V5kvFmYpcVRdWH/CzVxtJdL+J7aVt28C0hXbqavNYMInJmp9BZD0qB462nFWV5TsIS
 /Q8T0x4t7Mp3ZgtcrOl7aF7ajuwuCO2u0HsepwfC2Sv7QQh/9Tfs0HWrw+VcFGwIGY7b
 5RbmMwITEYDStKj0fjdIUeOFxji/bYQNjPEFYW+coq9EwFmXBSyih8Ku011AbcnGLdgd
 6OdLHkSzHHh9TJVxotyNVpA8UGMQxQJY8KkJXzkmx/OznAcQGzVkBFVB3tUxUBtq7SdM
 mj1D/m2GagauiVTAiX9iE9tgPbK4oOlHzLKkw+Oxg8bjveGcYtMGeyfAWc+XMGmSXLzv
 Y5aw==
X-Gm-Message-State: AOAM531HqdPhQCN8IUUi51FpXPO7WjS94YpuOymAJ/3r1W0/P0Ghzl0E
 b6oRLvFpyjemuTbpnBLpOk7Mrw==
X-Google-Smtp-Source: ABdhPJwLa+J4WA6bngxodc2EB5uHRUirH/QkEs2MfYSEY5vkCkFMtAw2vLteQOwNpU1C2UlVB5JJ9g==
X-Received: by 2002:a1c:98cc:: with SMTP id a195mr4654221wme.89.1593195259961; 
 Fri, 26 Jun 2020 11:14:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m10sm18440235wru.4.2020.06.26.11.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:14:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4AD641FF9B;
 Fri, 26 Jun 2020 19:14:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 13/30] tests/vm: allow us to take advantage of MTTCG
Date: Fri, 26 Jun 2020 19:13:40 +0100
Message-Id: <20200626181357.26211-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently limit TCG guests to -smp 1 but now we have added some
aarch64 guests we can do better when running on x86_64 hardware.
Raise the limit for TCG guests when it is safe to do so.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 890bbc5549a..b8c60803e2d 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -553,6 +553,12 @@ def parse_args(vmcls):
     def get_default_jobs():
         if kvm_available(vmcls.arch):
             return multiprocessing.cpu_count() // 2
+        elif os.uname().machine == "x86_64" and \
+             vmcls.arch in ["aarch64", "x86_64", "i386"]:
+            # MTTCG is available on these arches and we can allow more cores.
+            # But only up to a reasonable limit. User can always override
+            # these limits with --jobs.
+            return min(multiprocessing.cpu_count() // 2, 8)
         else:
             return 1
 
-- 
2.20.1


