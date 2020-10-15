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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8DFC43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487E120714
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCnHByBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487E120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9c6-0000dK-TN
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9ac-0007JJ-4B
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:11:06 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9aY-0001jy-8D
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:11:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id e10so99742pfj.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S+jw+88sOrD1wBdO71U4c/3Vn26m+fCHMRsX5Ywl9XU=;
 b=sCnHByBmxODu1aWys4LED5P/oyYOfLWCcqeechG6+Hx/swMC5uXQTQi5/RcOGg2bfN
 znrswI6RJpkUj+1wxj3mhifDs09Y2N2FIpKLEdnUO2xM8Q7Dd+z+7glG5uDS0jY804mX
 J3pBz3ANUaVJEzkHYr1SlVabO9Q56wuvVtpEDKaAoYo8A+CAILWkwoP9w0TNw/4I3BOk
 eFtzOMhdAoyc5h2aduVpIGv2Gu3YHgEuoELVlJFPYRYuCtyuueo09XTVuk+M7zWExxv2
 ypza48ugu4BlHMqpQqQdmiq30SFimJkg0jS5bAw3o/rHLfLsO7qlcBmn/6c2mi9+hh1N
 XquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S+jw+88sOrD1wBdO71U4c/3Vn26m+fCHMRsX5Ywl9XU=;
 b=Qg4P+43kIhWW60Cherex1f5JwFRU6EsKqzJ7TZwE240Ce+V1eKDlw8W294fNxcrVzd
 2PFylcFQWcaCXY8igWQxKPw162ciKzXhO4tzFz/N8FxyuQ2z6wpBccobZPcy76OJ97dO
 WRfSeFLXlhUcgENypKyYOrvmV50aUQTqvQZXn6s5TJnZN/GRdSFGGFhwDNhdlNrEL3zI
 vlOsIL6a+dSmkrF7depCHtYBbWG5La/EFc/bSoA5t94yZF28Sb6TXJymbQJA8mzz6hQE
 QETALlxqWO+wFDCS7JL8OEmSQ+mt8XPdCxkr+ZlKuAXrbQopRgp572tklglf24+qiHHe
 xoVA==
X-Gm-Message-State: AOAM532huV9isCh2zJBi+Kpio0xW+pNi4a23QGORHFSC/EVjoIezzvFy
 L9EpemSapM03XB4hpKPbyJd4X5iVca55+KAE
X-Google-Smtp-Source: ABdhPJyZalY9chrU+vk01kb+VSwtv1CrTHUW9s4P0Nl+jNRwNyrLWf5opuQ82thN7JPUh5vmgGgqtw==
X-Received: by 2002:aa7:87c7:0:b029:155:f258:99ca with SMTP id
 i7-20020aa787c70000b0290155f25899camr304646pfo.68.1602792660446; 
 Thu, 15 Oct 2020 13:11:00 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x18sm104734pfj.90.2020.10.15.13.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 13:10:59 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] cirrus: Enable doc build on msys2/mingw
Date: Fri, 16 Oct 2020 04:10:35 +0800
Message-Id: <20201015201035.1964-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201015201035.1964-1-luoyonggang@gmail.com>
References: <20201015201035.1964-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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


