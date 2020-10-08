Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A47C43457
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9895720708
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS/+OYfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9895720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQcMI-0001KN-9n
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 16:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQcIs-0006yq-RA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:14:18 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:42564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQcIq-00044Z-VA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:14:18 -0400
Received: by mail-pg1-x52e.google.com with SMTP id n9so5255965pgf.9
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 13:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/fwoI+AZ6jsinDYtKJuxnB/jko+myWthi/38myx/dPg=;
 b=nS/+OYfVeGTB9GtlnHj53WCl9rN4O6aOx5w6x3kbgMiaTDSXzTrI2wiF2H2sYlfNs3
 WBKe/eCrGeCw5lU8FEjA9t9r2vdyB5uR416D5mS4OkebPouYYL0yD2OAU65z9nW+CceH
 UhofiDAx/LYcBsiYuhnVl3oLbZhcI05BQSS8DMHVw1ON+9TTAnKchRJBMrpgMmT0kJ75
 5rA3bawFw0vILwNJWMNLjR7mLVl9FJnLN4vabTepZjYa850PhL+mzUm5GHlcJ3aRHXWc
 nhVlalFkKdyPCqqCNc3MLRTuR2+weVUt8RiUV4Z/yGjuU/Xh/R50NNPd4NBBZ7ihx5Ok
 MiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/fwoI+AZ6jsinDYtKJuxnB/jko+myWthi/38myx/dPg=;
 b=pYxV3fJHnNml5h7d4RtyncLQeubLX9Y1772h6c8Xo+wYVZMg7STTcY/GX6KQ8drdhP
 Xr7TWSqBqYsWjq3+bIWSfTe9AJV31JnBp2pJ1G+/Z/X7auwSlm4rFVEFDkQw4wZe9zkz
 8S/In4afIJTZIpGnLhXUOqfuwg+Tvha5ce1uoAYvRYpgWyBg1kjdN7r62V3xtwKRfUMq
 yJl3+UREz2OGMhFALqBYSnnhXWrPSgGBHVOWFi0isQDvwPFYqQJEMKLh5OgZ/gOoLe3x
 HvlTvCypS/e0kAxYAo04RMc7feSfXKH+sqOT1jj9Cs/cjhUtSzu3jmhZ9lkYGCV9h0V0
 9pGA==
X-Gm-Message-State: AOAM533PMn6FoJ0zMgbYigJdyVr5RpATqKPQKroeZQx9oXEJC5yJY2vz
 3kUPUU0h0esL5F8gwIySlejsB2YpBieW3w==
X-Google-Smtp-Source: ABdhPJw8nE4vCNZpygSUn78yoLLgia6uaBJGaO3Nx2pCbD/oVXhNGXDs7AlZM1Ba4WEsU5u/8UJ/gA==
X-Received: by 2002:a17:90a:ff92:: with SMTP id
 hf18mr595471pjb.171.1602188055157; 
 Thu, 08 Oct 2020 13:14:15 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id s24sm8008454pjp.53.2020.10.08.13.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 13:14:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] cirrus: Enable doc build on msys2/mingw
Date: Fri,  9 Oct 2020 04:13:53 +0800
Message-Id: <20201008201353.465-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201008201353.465-1-luoyonggang@gmail.com>
References: <20201008201353.465-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52e.google.com
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

Currently rST depends on old version sphinx-2.x.
Install it by downloading it.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index 77cfd99afe..b1725bd0c1 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -73,6 +73,7 @@ windows_msys2_task:
         bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND https://github.com/msys2/msys2-installer/releases/download/2020-09-03/msys2-base-x86_64-20200903.sfx.exe C:\tools\base.exe
         Write-Output "Download time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
         C:\tools\base.exe -y
+        del C:\tools\base.exe
         ((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post
         C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
         C:\tools\msys64\usr\bin\bash.exe -lc "export"
@@ -112,6 +113,13 @@ windows_msys2_task:
           mingw-w64-x86_64-gnutls \
           mingw-w64-x86_64-libnfs \
           "
+        bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND `
+          https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz `
+          C:\tools\mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
+        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -U \
+          /c/tools/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
+          "
+        del C:\tools\mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
         C:\tools\msys64\usr\bin\bash.exe -lc "rm -rf /var/cache/pacman/pkg/*"
         cd C:\tools\msys64
         echo "Start archive"
-- 
2.28.0.windows.1


