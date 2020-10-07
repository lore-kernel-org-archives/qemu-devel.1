Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06A4C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816A7208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX0VMui5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816A7208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ0Yq-0006yf-IY
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 23:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ0VC-0003Ap-Kq; Tue, 06 Oct 2020 23:52:34 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ0V7-00020q-KR; Tue, 06 Oct 2020 23:52:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id o25so555428pgm.0;
 Tue, 06 Oct 2020 20:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QoOFcj0BBtVtN0N8jZL22G41FB50g1ddTWqyY3DXOVE=;
 b=KX0VMui5C9KORw0wRkFsQSnAzXVU/BABvNNSv0DBalT9gqGvnBfwmfPNSw+KO84zjs
 Bnp3IvkB8xIqVy2z4kemBwjtsxLxS22TBAhWOguy0vTSUJE9Gr96kX6bzUMyfXikWULp
 474rmpfUscsX27kcv5c1jgTGkfVVIp2XnyXBcsN3i4n++WVcL/13Yh9os1A8hZe004bl
 AOVuiVMaDQ1zuXVOd4DdjcMcOAf2/aWMi56mVeTEc6X18kv6VpLYR+X7t18Y2EgA0mCy
 +dyvEdj89UN1PZ5xPpCt+4aFwDGRqVJFGlvKjsZeVq78EqEySJG67/EyzefdbFa6lAX5
 HXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QoOFcj0BBtVtN0N8jZL22G41FB50g1ddTWqyY3DXOVE=;
 b=dTCFM4yv1Xepwbr/fJYzxYhXjE41t4y/nZEhwUePDT7tpAonBBCFH1LHx/hEG8g2zH
 szAYFUogXhE15B9iEdlWv/PNUOZ5Zwr5lB0bpeYuU/UhPssCdKcbWguSim8g+cXeUtSi
 HIjwV2yZnCda7TKY9BnzUdH87SE1A/LNuTIyT8oEA/9vxlUL6clKonx3OQNdk3zEtdB6
 yQf8qwUEjPNdgQ3bhJLiCOQgQR7FiXsKV7g9TkI64mrIAbcy+UrGpTnHurGSe1U/Pvvr
 KTA4smf1v4WGeHR7LMJq72BGLk0oj1f+RfjM0YPuZqnxyxJIm1FwtW9qL6eGJYbxRBea
 sTeg==
X-Gm-Message-State: AOAM533yF0hfQm/MbIlxl3oTztR5bwJ5EIQyhPnpsjo4z9j7RzeqJ8jC
 ULJ7/Rl4lfGTMJlBPdpPM9MGJqjCCAjg7g==
X-Google-Smtp-Source: ABdhPJz4H6oSYgNrI8q/mc4ap/+s6mS48K70eJVXKiAlQRfkoAsWXOK4ezhfof4+E1yc51VBC3jKXg==
X-Received: by 2002:a63:c5b:: with SMTP id 27mr1307712pgm.80.1602042741974;
 Tue, 06 Oct 2020 20:52:21 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v10sm497031pjf.34.2020.10.06.20.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 20:52:21 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] cirrus: msys2/mingw speed is up,
 add excluded target back
Date: Wed,  7 Oct 2020 11:51:54 +0800
Message-Id: <20201007035154.109-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201007035154.109-1-luoyonggang@gmail.com>
References: <20201007035154.109-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x541.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following target are add back:
i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index bf5a0990ec..39a175d569 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -72,8 +72,7 @@ windows_msys2_task:
   script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
-      --python=python3 --ninja=ninja
-      --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"
+      --python=python3 --ninja=ninja"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j8"
   test_script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-- 
2.28.0.windows.1


