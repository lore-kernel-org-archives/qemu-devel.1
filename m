Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10022C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A8A206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boLuaaNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A8A206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDniJ-000668-FV
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDnhj-0005fX-Fl
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:46:59 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:37742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDnhh-0002B8-Rr
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:46:59 -0400
Received: by mail-pg1-x536.google.com with SMTP id 5so1933456pgl.4
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/soWbwhyXIQvyhXLT89cpgQV3vO3BDPhxGB8xLxnnps=;
 b=boLuaaNZMNMK0K008EdMkYiGACU0jgkAkOoTNWeMj4Qvp36d1YSs5pv9c99GdWdI6o
 TFyfOAC7YYxBrlawV78SbSU/PfN2f/PwTqnuA+HrlGPn5aFpY3IW0Ih+CWWWDKqLVluK
 wEZVHFlRufvhvrwujk0jFQ5Et1HmFUrA6Nn0YyCfmjMRFK/K0K+RhVoFmGi0U4HcilBM
 KVmgSBdC8uLcn/vdH6BCo17AADpsRajnGzKMFYnq8lDZXpQm/tw2PuqojWM3vWcCM7pB
 fMnZF8pHlNGAQXKmVHRuImpz3dr3oQWhpPSvmODbK3vrHEvFupyyi7pIBrhLEDBEBQZb
 hlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/soWbwhyXIQvyhXLT89cpgQV3vO3BDPhxGB8xLxnnps=;
 b=JNJ20UFfPhcj/xSZX29/tlqayxlsFnMBzKdONPyWxkK+2S0mcUrr3pLW0LnhWN6cjb
 UwvlItGh3x9ngLzGj81aX/8fG71YcIhuMLWHkWCo208ryUPAPTuUOzK2v5xrt72gDRI+
 2GRwPU4b2KbMje2VvEt6pq8KtWuuRdCdGtUeQMye+e+NZ84P3poD8nNBUP0/Vs1rizPA
 hhln12aZWFilSngw/G84oM+AjcNPsgewEDxn0T+KYWBaXqysDXvRHGh6jNY56W3AITxK
 0n4MV+KXys+dyVGzxDI4S+PAR3duL0i/Cw1Pp4TLT3cunx0qiac93yrPmDE8xd4PuNqr
 JcQQ==
X-Gm-Message-State: AOAM533S+DhSBk8IgAEjR3VUUoC5vNumvqDlS74coanx1CpQmeiSL6go
 REs93IH5szSr7duVDLgXyxm9rNcsKTO3QdiR
X-Google-Smtp-Source: ABdhPJwYbadXrOXttMHujQbtE/fkhJ0Q/UFsVUDpXcSa73xwFTd7eNBBRl64vsZa11GvzTW20rKKLQ==
X-Received: by 2002:a63:4e5e:: with SMTP id o30mr2627602pgl.254.1599133615914; 
 Thu, 03 Sep 2020 04:46:55 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id y3sm2466717pjg.8.2020.09.03.04.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:46:55 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docker: Add win32/msys2/mingw64 docker
Date: Thu,  3 Sep 2020 19:46:42 +0800
Message-Id: <20200903114642.1620-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x536.google.com
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

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/docker/dockerfiles/msys2.docker | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 tests/docker/dockerfiles/msys2.docker

diff --git a/tests/docker/dockerfiles/msys2.docker b/tests/docker/dockerfiles/msys2.docker
new file mode 100644
index 0000000000..f898e0803d
--- /dev/null
+++ b/tests/docker/dockerfiles/msys2.docker
@@ -0,0 +1,11 @@
+FROM cirrusci/windowsservercore:cmake
+RUN echo | choco install -y --no-progress --ignore-package-exit-codes --params "/NoUpdate /InstallDir:C:\tools\msys64" msys2
+COPY msys2_install.sh C:/tools
+RUN C:\tools\msys64\usr\bin\bash.exe -lc "grep -rl 'repo.msys2.org/' /etc/pacman.d/mirrorlist.* | xargs sed -i 's/repo.msys2.org\//mirrors.ustc.edu.cn\/msys2\//g'"
+RUN C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy"
+RUN C:\tools\msys64\usr\bin\bash.exe -lc "sh /c/tools/msys2_install.sh"
+RUN C:\tools\msys64\usr\bin\bash.exe -lc "rm -rf /var/cache/pacman/pkg/*"
+
+# docker build --tag lygstate/windowsservercore:msys2 -f "../../../tests/docker/dockerfiles/msys2.docker" .
+# docker run -it lygstate/windowsservercore:msys2 cmd
+# docker push lygstate/windowsservercore:msys2
-- 
2.28.0.windows.1


