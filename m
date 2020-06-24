Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE80C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED7F20706
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6iBPqZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED7F20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6Gq-0002Ir-Nf
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61d-0005Pq-FO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61X-0003Xl-Dv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id g18so2434093wrm.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xcC1dEPRPSwS0guxyTrS7h54huqSdjkxAZKSe+0TYJU=;
 b=H6iBPqZtj/NDjb+zP/vFXoXSJkBu4Ypbg9W0WZqrHWAZjn7mE8c56oQmkQTwU6zRw8
 uK21bRZtmUv4ncvsHCBz7n2kc3ZzrhUQDgT/E58G6kEjQ/BBZqdrlewn8Ay+HAw6Ta3S
 4HMyOH4PTJ7jfGm2MaJIweyAFbiNWOHb+IQEDmFpoGvvmlq4BgFSk64wOQZi2hfxdyns
 A7p9+8CklWqF63sne/90FO+KL4GDAZKjCrjaebYkEUuKnswOB9pdW8E3SZNdJBUlfosS
 UZruaHU7FrSj5k1ygj9Dc1VBEZSde8l7D7Z8rppaUOBmy0by9YEhtyRLO/5CjL2FblS2
 c+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xcC1dEPRPSwS0guxyTrS7h54huqSdjkxAZKSe+0TYJU=;
 b=IRKjF6ginI794f8/DVQt/Y/GSF47VTt9E1+h7Gu0I2vXwRzSB9Lcp23kvmlPnV6+Mu
 HejsA3bXyKukdilAXZqmV6EuF4Vy9NeW0mjq/6UanLUkOmiLeTsJ5SGisP6GTOmKTzb+
 f0n2evAMid3UUZ7bV1NWTrGksLRWsTDUqGdGx8iK0wIjb6cK9gaIFDJd1ky9Ax/34/86
 3v0o9Tu7gm7mLD8wetccMOTmR6tcsHYs2YqaaE/fJHA6IPgreY32T94HPSEs2z4zdYyB
 JS7TYwfCDs+RrCK3HsbCm9EUBKPqFt62H98uYcAhBM5xBvyRfrUPsGRzfvglMsYhL5Ct
 LVIw==
X-Gm-Message-State: AOAM532m+erVib93DP6U7WCeNIZhGWYiDvdpYtlUuS5WeumDsFGLc0My
 R6cpUiRcsvuC16y0/WmzMPLmkA==
X-Google-Smtp-Source: ABdhPJxgZVe55tlw9OjASmiSFYQohPDerTNt4hdeyUYML/UX1zevlHzBntIvcfCgHgYpAbGiprSYpA==
X-Received: by 2002:adf:f608:: with SMTP id t8mr16419707wrp.308.1593007509905; 
 Wed, 24 Jun 2020 07:05:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o29sm19603059wra.5.2020.06.24.07.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:05:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 82D111FF9C;
 Wed, 24 Jun 2020 15:04:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 13/25] tests/vm: allow us to take advantage of MTTCG
Date: Wed, 24 Jun 2020 15:04:34 +0100
Message-Id: <20200624140446.15380-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
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
---
 tests/vm/basevm.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 93859362606..dd96a6d4af6 100644
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


