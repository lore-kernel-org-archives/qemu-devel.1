Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F3DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCFF222B8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1d09k6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCFF222B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQqHr-0004r7-6z
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 07:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQqGA-00039w-8j; Fri, 09 Oct 2020 07:08:26 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQqG8-0007zl-Rj; Fri, 09 Oct 2020 07:08:25 -0400
Received: by mail-pl1-x641.google.com with SMTP id p11so4299019pld.5;
 Fri, 09 Oct 2020 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=shDbs72Mi+RqLYhm6I3yrmO256TOYZSOuCzg8ZyfMmM=;
 b=H1d09k6RE4jj34vcaEQeQMzLe5zEPjT6tH4jmvv9DbH095Z5p4YpVRQjf5HDSIMffD
 ZylBeg4F/22SJWD7Lhwgy+ec8Of7//ekB103U0LQwYBCuD/rTcDRLo4s7Kvn+Ks86A+s
 eQxGGKKtR+8M1GetdR3AIpCP8T121COvp5o5/jS2W3/50ovZK1EdRMThyXP8TqvdFXB/
 ++XEwoi5unGDvNV/lKD6AM8NiG2TXV2tT5rWnKbBUEtbtzY7v26MQwJnZIqutoL1shgs
 6gZC/UqwoB3LBfAO61js2+wOv7xick0XM49yrUYxK8BfLQoygnYqioJFIOBj+puoQucz
 AoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=shDbs72Mi+RqLYhm6I3yrmO256TOYZSOuCzg8ZyfMmM=;
 b=qxrUCacUBusO4Zsu4Jciy2lmvl4ce9+P3o7+xcrRVkSPVZTuakx/cw85pRK7u5B0FS
 pj+PVjYN/byKzXr7wilumk92izHwoLdFOyetlFpW0TqQLKRvHxgj1WVB4egIHNQTzM2r
 xkB0LXwZ2FfYQN6a/1ppzgur/uCdbqRDJ6ZH7BS4l/Kf4F+cApixZlThMTk3BbGrfyAQ
 d0BEZcgcM55AYI2T5ayG1s/jZJrob2QyniUd+t7goYNKD33HgY/zYjgNM0qjYzBA02hT
 dyTy+CX+Sz93rrwBT34g8kAtA2tpj0kOMjT23p1TvC77j7N4jZF0qaPVv7kum2xblBZr
 9XJw==
X-Gm-Message-State: AOAM5334wctoYyR7jsGQCh/hpKkPSKORd7VCZ6tPb3eFvIXL852a+o9N
 WWU8i5spFaC4caF4+Jrr2EWK9V/+sP0BrUOw
X-Google-Smtp-Source: ABdhPJytRbLv3BgXwe8P0Cvzhgaq+3oi0jSRv3lNYNBEc4mgGKO57C6DupR5W+a08w1DSHR8gjQKGw==
X-Received: by 2002:a17:902:be0c:b029:d2:8ceb:f39c with SMTP id
 r12-20020a170902be0cb02900d28cebf39cmr11438208pls.71.1602241702632; 
 Fri, 09 Oct 2020 04:08:22 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v1sm2619462pjt.2.2020.10.09.04.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 04:08:21 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/4] cirrus: msys2/mingw speed is up,
 add excluded target back
Date: Fri,  9 Oct 2020 19:07:58 +0800
Message-Id: <20201009110800.432-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201009110800.432-1-luoyonggang@gmail.com>
References: <20201009110800.432-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x641.google.com
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
index ed3db10e45..d1fe63b343 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -123,8 +123,7 @@ windows_msys2_task:
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


