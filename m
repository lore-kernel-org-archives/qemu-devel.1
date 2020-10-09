Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A6FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CF122248
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+i3xZqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CF122248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvYg-0004Ft-0j
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJG-00005h-2J
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:31:58 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJE-00059P-8U
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:31:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id w5so10932989wrp.8
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SrM1EIqaR85TqAOsCeQOrUwcMNXQ917XAcvls5del/Q=;
 b=R+i3xZqjuxaJPi65/5mSUW7uyfXC6I+y48V/GTT2lD+DellmlEkceY5950rmfdXZ7d
 JKEL3zAlyp7dF1UOu0gfyV/keb1jKJ+tXDm1ixk145IT71akWWGu/UA0cYp2eocwRGDw
 Z4IwVXzk/Ni4fmgF80BSmIxDcx5R7pf5RakdLxvKr94VDfrRZGqbi3YJZNK3y3dlfUQw
 eFzLCDgQcSSR9xcpu/mIhhTiQHBp81cTTKDPlkFzwqTIDwQrEXR8aZZUa6IG1UB0P7XP
 NWJ/97wDn++z1cpkuPUMjeT+7b4TRNUpjKD15RBKd8APVzIi0c/73sJpJJkb1tkbjD17
 DEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SrM1EIqaR85TqAOsCeQOrUwcMNXQ917XAcvls5del/Q=;
 b=ebAAV9cEQ9W6/CYFEXHUv7CGmLatfu63gGuMAS4DGWNyHT96hxLqVKidMVy/fWWwTl
 imBZVev9OqUtnMLM6xf5R75r9TRWHe5riEeetkeZn5Gay1ksonOPDpsKk/GtNsfqVeXO
 egzf4puR1u97iSNEFnx9jU8SnWCNOYDuMVpK/xGE3PJvvVdqyZ0Q22iqPTOnXGaP52ll
 pRrUhU9lrsnf6rW0TAKuqk2lMaDNyeGr7dXkS9UE9gbPvbuea8u8Cir6CABdCb6vf78G
 yL8zHx8uECCreSTTnJVDF5rnn/isXHzRyPnYPU5NsIDgf+E7HgOjo6gL3KyrzonHvueb
 vDcw==
X-Gm-Message-State: AOAM530hWGb7yihZ48XnsYxQngitzauuEVOOPo4zC+nM5LfjebSB+cim
 OouibmJ+wtuhF+B5FhwCysO7oul84wiaJw==
X-Google-Smtp-Source: ABdhPJy98UX/0/KhGNr78pOtzsEUqKrnZ3moR4pBrXKBa4Nbx8rtHiv4ZEW0pfrIgPV8h+ayZ81syA==
X-Received: by 2002:adf:9144:: with SMTP id j62mr11717601wrj.110.1602261114814; 
 Fri, 09 Oct 2020 09:31:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h206sm13089507wmf.47.2020.10.09.09.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:31:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8618E1FF91;
 Fri,  9 Oct 2020 17:31:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 05/22] cirrus: msys2/mingw speed is up, add excluded target back
Date: Fri,  9 Oct 2020 17:31:30 +0100
Message-Id: <20201009163147.28512-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Ed Maste <emaste@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

The following target are add back:
i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20201007145300.1197-3-luoyonggang@gmail.com>
Message-Id: <20201007160038.26953-6-alex.bennee@linaro.org>

diff --git a/.cirrus.yml b/.cirrus.yml
index eb768fa260..301a64f104 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -124,8 +124,7 @@ windows_msys2_task:
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
2.20.1


