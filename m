Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECA6C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF7A206F0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKnU0jk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF7A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNPy-000169-Oz
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNO0-0007FW-Tt
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNNz-00087i-Pv
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:24 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNNz-00085C-Cc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:23 -0500
Received: by mail-pj1-x1044.google.com with SMTP id kx11so439833pjb.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HbO57U5Hq9On8Ktr+WRBLRrRyCTJojmW4JU+oahW540=;
 b=uKnU0jk7th8WOW03TQGS2qQHsZO9iA/QRWb7E+qQDhLvPPw3RJAzfiDPBO7We+Xbcc
 uHAZ6JooqY4A6oR1/FUI4Gp5nKcvKcvIF0eDQuebZoOZWvWM5isWUFAEW0ym/gJI21bV
 ezA/R/SalQ7OApBC62hZKhQ4uxN1t4RnnUddUyS/ORlMZS7TnGEn96uHMDgpDOn+KZVw
 bG3UfejmS8IdRBmbunpEBe67kM4T2baR/GpcO2WSsQXWAsP11PkaCWcmFlPaugj74bpF
 AdjBUmQA/51RNxKjpr9tPvWRYSylmJkVOD6uDKe7sWqPawA/3dRRZCN2SNzSHx0uol13
 vthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HbO57U5Hq9On8Ktr+WRBLRrRyCTJojmW4JU+oahW540=;
 b=mwDM5hG6eXR4P0943kIJHOrHXMoVJoTfgC9l61rNQR8e6uDSWU/THSNQg6xL/+NV/a
 Cu2avQA7El6/6j6Wmud5ZNsDsYpczXqaJzfpkv4OSdSOXXhBEo3aQuoAv3Te5XjiZ5R1
 sNnwAUVUvRRJ3uiBP5B0zaBPVLLTk1Fl10XgikMR9TMMz/tS4s9It/pJcoQKgH5LWUJa
 M+g+TE7rSuakiyNWoQqtdOzXR4/2fe7L0Dz9txvBzlbzSP3xo/rLVo02zXRzcFk7mxoU
 8QFCL5RvuRgCkOMHPkjwJn26SFkmqQd14YUKcXrILdBXXP19BLYxyOIAyXCY9+FTFMKz
 A5zQ==
X-Gm-Message-State: APjAAAXBZ/pUU6KAzmjZz/oiXkDLjb/SoLXSIqXGoUNxgK/a8Esh3ebj
 LVLPnmgqwDNgWhwqoVNjZj+3JlVhvsOuKA==
X-Google-Smtp-Source: APXvYqw1I+cI2qWixqqu2wJ/PBXmvmvMYiyvZRr/UVwCislu/kMjq7JHi5Dz3+svrh0CvYm99zXp3Q==
X-Received: by 2002:a17:90a:19d3:: with SMTP id 19mr2294472pjj.1.1578536240516; 
 Wed, 08 Jan 2020 18:17:20 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id n26sm5166715pgd.46.2020.01.08.18.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:17:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] vl: Free accel_list in configure_accelerators
Date: Thu,  9 Jan 2020 13:17:08 +1100
Message-Id: <20200109021710.1219-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109021710.1219-1-richard.henderson@linaro.org>
References: <20200109021710.1219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We allocate the list with g_strsplit, so free it too.
This freeing was lost during one of the rearrangements.

Fixes: 6f6e1698a68c
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 vl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index be79b03c1a..c9329fe699 100644
--- a/vl.c
+++ b/vl.c
@@ -2748,7 +2748,6 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
 static void configure_accelerators(const char *progname)
 {
     const char *accel;
-    char **accel_list, **tmp;
     bool init_failed = false;
 
     qemu_opts_foreach(qemu_find_opts("icount"),
@@ -2756,6 +2755,8 @@ static void configure_accelerators(const char *progname)
 
     accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
     if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
+        char **accel_list, **tmp;
+
         if (accel == NULL) {
             /* Select the default accelerator */
             if (!accel_find("tcg") && !accel_find("kvm")) {
@@ -2787,6 +2788,7 @@ static void configure_accelerators(const char *progname)
                 error_report("invalid accelerator %s", *tmp);
             }
         }
+        g_strfreev(accel_list);
     } else {
         if (accel != NULL) {
             error_report("The -accel and \"-machine accel=\" options are incompatible");
-- 
2.20.1


