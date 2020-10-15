Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE46C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0466F2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiSQny2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0466F2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTBEz-0004Y4-R6
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBCO-000101-IQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:54:13 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBCM-0005Ik-Ak
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:54:12 -0400
Received: by mail-pl1-x642.google.com with SMTP id y1so111027plp.6
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S+jw+88sOrD1wBdO71U4c/3Vn26m+fCHMRsX5Ywl9XU=;
 b=SiSQny2MBx0jJxrJI9/4iAO+PJwtp1iCc4RJ8OmRFIhXk+Q80vtgQfTVUdwddTDInz
 AILclXwY+pyZK12Koin7n0975E3EdkcBSVbyKLgDvSVxf31S29k4l/iCEXOjk1dLuf0v
 tobGMdZEmOS6taZJZhhg1KENgUVv5SdImmonAS/lgd76HekLjs3ucsvJ9+ULn7b7Dtff
 WsbUXHS1i13N4WFjN2Impq4qV2JIRnaizrkopkr4pNrufmrdFrdmTv8h8rH0FTyoEHwg
 /jnBwwsZB8LQG8OvW+J0ZRajafl41/hxfLrRUXCHTuxCn+HM2m1vhoGGnl+nBtUw4rI3
 y7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S+jw+88sOrD1wBdO71U4c/3Vn26m+fCHMRsX5Ywl9XU=;
 b=akmIQ5uq+YBLjnQphqCq+qFMSFLmWAKGeEfq3lwrA26w6fuE7V7i8Yf/slI1l5bGP0
 vITPncjLvnGVnpQMBG14AAJLlrsVsWQjuV9u9ZDOEaSgI9W1LZqEZMqtddhxajsSxe3A
 1DYgjegGbLJDdonhHOatgF/xZKTWLMawS4g6rloe0bSxSVTM4osk7c5jk7fh1IrZj56G
 P9Wbt/fABqAKZizfVU/LOfWVmmIbT2EZRRN5x24iNfRhx70AjZZ1fzVBG2kZ5fdEsp6A
 shZ88ylNkSasfPGwLYYQAekzxfkp26mEneq2VCWUot+3D1+8WoXK/W6Uwy2dXunS5jxt
 ptqQ==
X-Gm-Message-State: AOAM531yzFuFAyBdSZQj2jGUE4vz/xoXVubbMcaKmMAqAuPvOo9JODjl
 ZZSskOF68RTxRin2BAY6LJNgYJPtOVwm80YR
X-Google-Smtp-Source: ABdhPJzo2bNBsc/V138T9LW0/KTEPKzrX+xUv9AIVbauL5KWxHLZPDoU0TJVAXixPXJQtQ5lvYnnDA==
X-Received: by 2002:a17:90a:1bca:: with SMTP id r10mr790205pjr.4.1602798848418; 
 Thu, 15 Oct 2020 14:54:08 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id f66sm252856pfa.59.2020.10.15.14.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 14:54:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] cirrus: Enable doc build on msys2/mingw
Date: Fri, 16 Oct 2020 05:53:45 +0800
Message-Id: <20201015215345.173-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201015215345.173-1-luoyonggang@gmail.com>
References: <20201015215345.173-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
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
Remove the need of university mirror, the main repo are recovered.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 99d118239c..f42ccb956a 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -76,7 +76,6 @@ windows_msys2_task:
         ((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post
         C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
         C:\tools\msys64\usr\bin\bash.exe -lc "export"
-        C:\tools\msys64\usr\bin\bash.exe -lc "grep -rl 'repo.msys2.org/' /etc/pacman.d/mirrorlist.* | xargs sed -i 's/repo.msys2.org\//mirrors.tuna.tsinghua.edu.cn\/msys2\//g'"
         C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
         echo Y | C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Suu --overwrite=*
         taskkill /F /FI "MODULES eq msys-2.0.dll"
@@ -111,6 +110,11 @@ windows_msys2_task:
           mingw-w64-x86_64-curl \
           mingw-w64-x86_64-gnutls \
           "
+        bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND `
+          https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz `
+          C:\tools\mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
+        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -U /c/tools/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz"
+        del C:\tools\mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
         C:\tools\msys64\usr\bin\bash.exe -lc "rm -rf /var/cache/pacman/pkg/*"
         cd C:\tools\msys64
         echo "Start archive"
-- 
2.28.0.windows.1


