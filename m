Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A682FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794E1207BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ad46nvnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794E1207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdOM-0002W6-LH
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKl-0004ay-TA
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKk-0006og-4F
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so23977259wrc.7
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=utjQK07eZNS2y1B+oG+Ze8AGzZ6ibCv0Se22YqtS0r0=;
 b=Ad46nvnVhRJa7GOwUF6AnPDsT5GSEkYL0Xv32G6ZbRoqanH2T5w+tMFHjZm24ISEl2
 zkD3Nwp5TcS/+d5bK3IPlpGcjW++hW1STGIGqDM1WavtxNrcbCIC/fFi3CcT+S64Ir9x
 RDk2gL+he4GlclDc9PqsdxJxZYGF7Ztwd598Z5g8Lfs+bwe9hAp+BgvmMavy9iwjq2/Y
 QYDdsWpNwZvjyuZlKKymW70JIFidsUBXN8y0zBAMzLjkEF1GLGt263qGGqaTfUIgnONu
 5mpaM8h5v7yDcC2n3ylirnCjCqMTWW3FjZVvECxHGZ77DSjVrp8u0AthxU0CPasp0cOj
 ArDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=utjQK07eZNS2y1B+oG+Ze8AGzZ6ibCv0Se22YqtS0r0=;
 b=tZa55pEocEWkrb45gemwN/rymCqU4EAfrKAwugQyou6WgmOhX5E7P3bjZr4d0LQD2s
 aHrnm8RlUs4psmKbret1PkcBUQpT26pc0PHwan78GmHolqCECDOYnUV/OFhyojhOfaKG
 2/hHuXjv0uladNatnlRTrRunuZBekJpo5TKuWZs1PnZAU2u6+YwLchwu/o79xzDLI6h1
 wpTF4dl8Ox8dWletPMFsTTo339DYUngwL2GGvjOw/9GriY/D/IrxvwYyZ8/CYAbx3TzL
 lEAXPIv7ZkwiXUuBJiEhzsJp9NwwsYNxAgWK+ghwoQ+TVKwGQNAC9E9uz1Jo/TXlf2nj
 LX2w==
X-Gm-Message-State: AOAM531MjHhoXLv/rZe9wsCRKdJuhU1D4Yr8ncEjxm5PfjGWdIL07VbG
 OnPsb5lgGgHoDsrVZFWMm3sr2A==
X-Google-Smtp-Source: ABdhPJyyRBn/+bXYOWoZ8tSNW0GzHH3CYxlSRMXQ1krjJ4BoAwweRoCdAbqse0t2Eplgw385WDC9CA==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr26740295wrp.299.1593612208754; 
 Wed, 01 Jul 2020 07:03:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u20sm7006588wmc.44.2020.07.01.07.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 54CCD1FF9E;
 Wed,  1 Jul 2020 14:56:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 15/40] tests/vm: allow us to take advantage of MTTCG
Date: Wed,  1 Jul 2020 14:56:27 +0100
Message-Id: <20200701135652.1366-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v4
  - only attempt compute a bigger default_jobs is
    multiprocessing.cpu_count > 1
---
 tests/vm/basevm.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 890bbc5549a..21f46d1957d 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -551,8 +551,15 @@ def parse_config(config, args):
 def parse_args(vmcls):
 
     def get_default_jobs():
-        if kvm_available(vmcls.arch):
-            return multiprocessing.cpu_count() // 2
+        if multiprocessing.cpu_count() > 1:
+            if kvm_available(vmcls.arch):
+                return multiprocessing.cpu_count() // 2
+            elif os.uname().machine == "x86_64" and \
+                 vmcls.arch in ["aarch64", "x86_64", "i386"]:
+                # MTTCG is available on these arches and we can allow
+                # more cores. but only up to a reasonable limit. User
+                # can always override these limits with --jobs.
+                return min(multiprocessing.cpu_count() // 2, 8)
         else:
             return 1
 
-- 
2.20.1


