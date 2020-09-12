Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49089C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA5F20770
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZgF2apC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA5F20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHEWi-0000TL-S5
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 19:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEI9-0004wr-JH; Sat, 12 Sep 2020 18:46:45 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:56085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEI7-0004Zy-Tl; Sat, 12 Sep 2020 18:46:45 -0400
Received: by mail-pj1-x102c.google.com with SMTP id q4so3481328pjh.5;
 Sat, 12 Sep 2020 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kzrzivny+4aurKQYh64spFpy22dgRRF/NzeUryxCkkI=;
 b=jZgF2apCgO2xLk6HU/6pB9mRE25hR9rBRh4bweqL5LpGc7ntZW9t+MWGSd3gtcDihs
 1e+hf+PeutI4P3CBIhWu3H8gnHkSBRDfUkVocXHfJgJEuJ5bmti4UICZGzeioGz5Oiv6
 nukxj9eXloCHY3hgkRW+TUHFhE1SB6lRH5OEfkgobo3HQvNJIE3sm+ORyvlpL5Ekad/c
 nj74vFN82T9FQ2AJy7NSHEYnVeNs9edDtrwFATOAh8kzlRBu2bC8l/j+v95a1KqgYoCa
 EhMbdlbB5U+nNTp2L7hLQFp8WSxsuust7gBEmgzfU2NfsciYDlvgehFn7FaqKeM5/SIP
 vn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kzrzivny+4aurKQYh64spFpy22dgRRF/NzeUryxCkkI=;
 b=KLFM/D7dGDQsM0DhQYF3aU1OCOlOJ3X7nzSsmIIGPRTXFuMimUNGJZYt7KgMJcCU/l
 J2CNzQlnLVA9KsH6H9Tlf6cK8irI3AAgIXr5imm+cGu4VeISH4j/JLRrA6xBgPnMufQW
 kPuaEXSWyznEwKP1tfV9vFllEGwPKUYZsgOWrzbvT+qeSv4o8txe8UA/1ynoXumIaMGb
 iDeIWQxzz6UThAGQd3ZZ52aPUCjIYfnBrwz6ByaJvPy+Glwmn2K5drTFyTbh+ONW7Xha
 OXJYr/RrK6OiEEkkBv9n+LmdYciBTIHrVgrf3OpVrhJn8grBkw1uJwFuffjEAoZI+e+J
 SBUw==
X-Gm-Message-State: AOAM5330R8s3iVKHxJaOXxLGJdZToN4I+/nymtA537qLdpRLNYcnbLcN
 CXP4k29yWlQZa32Q9Ok6eppw0cxNinljyemnjNw=
X-Google-Smtp-Source: ABdhPJzSwaI1kyf8HYd8KjxbuD5d/nWHS6X13diPEgW/Zq/sZWPWD83nxOgPQRbt6BNdYdnaA5zNGQ==
X-Received: by 2002:a17:902:8c89:: with SMTP id
 t9mr7869466plo.66.1599950801871; 
 Sat, 12 Sep 2020 15:46:41 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t10sm4639266pgp.15.2020.09.12.15.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 15:46:41 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 26/27] meson: remove --ninja option in configure.
Date: Sun, 13 Sep 2020 06:44:30 +0800
Message-Id: <20200912224431.1428-27-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200912224431.1428-1-luoyonggang@gmail.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102c.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 1ff9f0a72f..87bd110d28 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -99,7 +99,7 @@ windows_msys2_task:
         mingw-w64-x86_64-zstd"
   script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure --python=python3 --ninja=ninja"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure --python=python3"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
   test_script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-- 
2.28.0.windows.1


