Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4000DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B2E2089D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/dyV4EU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B2E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt5Np-0000Fa-94
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 04:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jt5NH-0008ID-Ew
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 04:24:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jt5NF-0007GP-HS
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 04:24:15 -0400
Received: by mail-pl1-x644.google.com with SMTP id k5so2016667plk.13
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6WFQWBYwQGdnG58psXXVaLn8ucvdvgqodc6o5hqkTwk=;
 b=s/dyV4EU/kEa3UOEhLHYULJwCjSirrF1sw3VOtIFe17KpxH8b6UdB/ACq4fiSHVx5/
 4Od84GxcjZkZ41OZdgopfdsZY+m9pF6JDLujMZXpOPwYS5uI/lQN/b7fZEhhMdLMLuTb
 HC29SyPoKeJ5TtILg8rszwhuZUJmXi4Q/a9cpszzpf1rWyWSAbasGz7B2UkdPKJwAk0o
 69Y8bfDB0BbIgaEbwTCguvwO0xqiXFMezc1WnsUl8S7UWgTgKUFdGsc1+ht6ZpzZaXEn
 kjdi9EX34wHfVLFovhknd2I+74k2jcKyS31MhDMQKw7WKfKy/lDFmv2QZkiQicKiiDqm
 Ciaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6WFQWBYwQGdnG58psXXVaLn8ucvdvgqodc6o5hqkTwk=;
 b=Eea0msjKWg+tko1vaPnc8gEklahUiEQp5d5fYRreAYGykGw6dD3r1EHnOmb/v8hX05
 b/yM4hodAMvMLrnjExrn+wfajav/qSrEkFMNg483fLYHBjK9zvHv82wYFtTff5gSfyHJ
 nUmf/fcZIt/fQFkOs1VG2g5nBkp2y9oYXjHD3/D+FGEGOKgYp/pfRWC58lcRvWcnscvT
 c7moQ/dvLggvoejhkJ+6dBsub5kGGaj4PUCSrj15qhP9Jdpx4T8erQnvlCntHYWmBJC7
 5MtZxRWYlVHPo6VRSMf4h/oCGy3dQS2ufF7mXtyOmTGx9FaoAjupcO9enamzfZOvG2E6
 ilww==
X-Gm-Message-State: AOAM533iDSpBW57OpSsI4mwI+XYWHhBW5Vei6KJu9O7iXQMTuD7WH6Vl
 9PkAoYQmKiHnIZ1K3wGcNYHZY0/DUlg=
X-Google-Smtp-Source: ABdhPJwS1Ryoa+7uMx58bfGnYRD+FscCsUGDTu02qjVOI3lNfkENMWVUwWNPPAfTBNibnyfrwPhBKw==
X-Received: by 2002:a17:90a:84:: with SMTP id a4mr4078790pja.110.1594196651446; 
 Wed, 08 Jul 2020 01:24:11 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id 141sm13936403pfw.72.2020.07.08.01.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 01:24:10 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/docker: update toolchain set in debian-xtensa-cross
Date: Wed,  8 Jul 2020 01:23:47 -0700
Message-Id: <20200708082347.27318-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to the prebuilt xtensa toolchains release 2020.07.
Drop csp toolchain as the csp core is not a part of QEMU.
Add de233_fpu and dsp3400 toolchains to enable DFPU and FPU2000 tests.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index beb73f46baa6..ba4148299c5a 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -18,12 +18,12 @@ RUN apt-get update && \
         git \
         python3-minimal
 
-ENV CPU_LIST csp dc232b dc233c
-ENV TOOLCHAIN_RELEASE 2018.02
+ENV CPU_LIST dc232b dc233c de233_fpu dsp3400
+ENV TOOLCHAIN_RELEASE 2020.07
 
 RUN for cpu in $CPU_LIST; do \
         curl -#SL http://github.com/foss-xtensa/toolchain/releases/download/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
         | tar -xzC /opt; \
     done
 
-ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-csp-elf/bin
+ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
-- 
2.20.1


