Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9591C06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B889521721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLwfciAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B889521721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKcq-0004fw-09
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58028)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hiKLz-0004w9-BY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hiKLr-0007Xv-NF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:05:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:32876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hiKLr-0007Vz-GC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:05:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id h19so783882wme.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=XxtQx4thNC8QZP82muBVfDakzL6gTL82HaWuSqOqFvo=;
 b=PLwfciAiMvQjFvihmSL1Ffgqy+PyPAQUepznikFai8dHcXrCQzUsWxJ2qiEoDWrCma
 rvRrhjnWiiFjqNzsA0cxWKGj0ojJgnDRztfE3+35swVaeZ8+5eNDE0JCPB0VLbsPAdmQ
 5Yb7qjql5I2Fqo+rfOs6gjdMcNvxNevyb421MsdszlCCWE9i+HH5VVUYa9m8/qN+BvQy
 +XmX2o1vFRpjJyPZcqgsBoXnwMx1cVLY26NYNB0KIXnTcyHIPfmSBuzgnvUnZNmWMIFc
 TBoUe5ZiJlOTX93lQNtTP6xrNUu45h/uHe4SVTHVUDUwb2d2fm2O3acqGUurnWCC/pJN
 hEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XxtQx4thNC8QZP82muBVfDakzL6gTL82HaWuSqOqFvo=;
 b=pl8dMrkejle9o42K0mmMZPHDVW5TVDXQvpw+iFLMSWSQzpsn38LnZP7bky4zzXJtZq
 TLn1dolG/JGzNqmmg9VNn29+nAS5bFF7UvLhdapJm7YBNG3inP7gojm8X8ayqz4jYstW
 pjz4RA4QpEck9sf80YUfuEe1TVB9ixff5/HRus9FoB2V6NwEdtHA2eoifT20xuD7Lhyp
 7Tm+7qaTfttBBevj+D//bmAI9ChqgoL1MPp1fKr9nxgZejNSRxQn1pzPVq1mpCqMM5Yb
 ApdP1gcrugY/THVNkhdDiao6Rap3fmMigX4Oyt+Y5GaA6Me/mAulANLi1FygrSiXM6KE
 OeoQ==
X-Gm-Message-State: APjAAAWSTuYohVeaWgGOhhyDIv4/EC8MzlC/f+H1Mwf5ZBU2GIax/h6C
 cfce0Bz5d8Q1jy6aODL7PEzzvB1Lli528g==
X-Google-Smtp-Source: APXvYqywYp2iODPwF6NwlCxB4o90MywMmDBIGoINtZ+LzHNbE+z1rRmv8zO2dxsKH9W25zyNun12sg==
X-Received: by 2002:a7b:cb51:: with SMTP id v17mr3729917wmj.20.1562079944120; 
 Tue, 02 Jul 2019 08:05:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id w10sm12975657wru.76.2019.07.02.08.05.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 08:05:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:05:39 +0200
Message-Id: <20190702150542.12008-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 0/3] tcg patch queue
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c4e42a9c2b714de5cddabffe46c7789fcff49c30:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190701' into staging (2019-07-02 12:58:32 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190702

for you to fetch changes up to 0c3c385c62759e1427f88c5fc5b0d9741a456807:

  tcg: Fix expansion of INDEX_op_not_vec (2019-07-02 15:59:42 +0200)

----------------------------------------------------------------
Queued tcg bug fixes

----------------------------------------------------------------
Alistair Francis (1):
      tcg/riscv: Fix RISC-VH host build failure

Richard Henderson (2):
      tcg: Fix mmap lock assert on translation failure
      tcg: Fix expansion of INDEX_op_not_vec

 include/exec/cpu-all.h                    |  1 +
 include/exec/cpu_ldst_useronly_template.h |  8 ++++++--
 accel/tcg/translate-all.c                 | 29 +++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.inc.c                |  4 ++--
 tcg/tcg-op-vec.c                          |  6 ++++++
 5 files changed, 44 insertions(+), 4 deletions(-)

