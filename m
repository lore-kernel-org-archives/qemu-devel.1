Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E5C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF81206DD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riE+IYsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF81206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTCj-0008FA-Oa
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSq6-00044i-HG; Mon, 05 Oct 2020 11:55:50 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:52141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSq4-0001VY-Hm; Mon, 05 Oct 2020 11:55:50 -0400
Received: by mail-pj1-x1029.google.com with SMTP id a17so20285pju.1;
 Mon, 05 Oct 2020 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ws9urbd+LWYd/UwlLgt9Qd/2sSOE/uXLdAEJSjpCLJg=;
 b=riE+IYspqj/qwjvO+Z8j41EXHDd5RA993fJ/FRrGeFIXYpgOWSn6G9ibiYrBK4pn9r
 xSblf40fNZi3x+QAHap2QoN/KAGJvAGXjxW+gmwu9Z8APWIYV/rMotshQ3pnLKuPkw/+
 No8AFX69mbYhTJUeatcIx4xSnBnU3jk18hEVpucR+GvhJejgbDC2SYk6zbhkoTxKEA9g
 T1bm8V5zZeqN7u506Oa3kR/4SbFAVv7DUbEedDB826Ffpf6SOqk/ZGgJUSPWwcxOnELN
 b8YG1j2kk2t6EpbKjlFcDUjWKtN5maDSsDWURT1gPzyLE1+KH64wWe2WVxCDZlyKmdu4
 xSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ws9urbd+LWYd/UwlLgt9Qd/2sSOE/uXLdAEJSjpCLJg=;
 b=oBE6rjXY5r26hGoENSIx0LKEBNcdqO2FmTI2jGc+C8Emd2qF8sHJpDemlXrhIdRTpj
 VxVC8QDuc8NJZR8wgY8ekjy4+L6NItWSGS4scVM0u1JYRJgUHw6FePo6M9nHs+tXFJJw
 DYKhJihTE7c14SZ20u3hlYfTmdqjB2mrmNLXbAU7zF+61+MNzMjo/9dWbLmE1aO+utEA
 d8P/JNi5eTWlh19LmCLad2uqciSbr+GsgzaMYJ19vw+bJ5g2mAtUGp3VeHP9Zdga66Om
 3b7JuShsK0/X/aW4dSTFix0W1FNp7h64L3ch98oxjIQuEEKkBdExLQ72XrrtUkHFyGsN
 isZA==
X-Gm-Message-State: AOAM531M2eKO2oOLqeZCaCdmRf2vF7676FPmsF4r+bYe/G1hsYa1BSrI
 bVM+mFPb/awRP25w742rxs0klvcYfNVKSQ==
X-Google-Smtp-Source: ABdhPJwOfLMcz8k3PnWC4y/OFcI60tj8VzCny6xoBCvZXKhGfmV9+iKjP/+eHmziFzLzRocAUb7YKw==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr81488pjs.68.1601913344586; 
 Mon, 05 Oct 2020 08:55:44 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u22sm34803pgi.85.2020.10.05.08.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:55:43 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v8 1/4] configure: fixes indent of $meson setup
Date: Mon,  5 Oct 2020 23:55:21 +0800
Message-Id: <20201005155524.442-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201005155524.442-1-luoyonggang@gmail.com>
References: <20201005155524.442-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1029.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

convert these line from tab to space

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 66641099fc..7d5ffee29a 100755
--- a/configure
+++ b/configure
@@ -7315,13 +7315,13 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
-	-Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
-	-Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
-	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
-	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
-	-Dcapstone=$capstone \
+        -Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
+        -Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
+        -Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
+        -Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
+        -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
+        -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
+        -Dcapstone=$capstone \
         $cross_arg \
         "$PWD" "$source_path"
 
-- 
2.28.0.windows.1


