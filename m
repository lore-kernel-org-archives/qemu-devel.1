Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6265AC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7252072C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQpi1KXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7252072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFjZI-00068h-Bz
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 15:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFjYc-0005Pp-51
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFjYa-0005kc-Vz
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jFjYa-0005jR-Q7
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so11610991wrl.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=8gkd+GdKBzH+wNfGQaNS3YPTshXHCvuQpMzwqvS7Fq4=;
 b=IQpi1KXz4ZTBFMAg575mHxGcETK98BhhZVmic2hbVtqZ7wpiCQzQETeLp9pT8uKyh0
 sq6o5q5vP/NeQ20qi6nexWkJ28/Ihbqdj6Prn+3zR7OEH2K/4BfVY4XB0zHLD9Hoz5po
 o7D0OaYigWDL5pu0ZtKYsuVW55+RwUf5HmCtdN5Gk9Wr1IePuVdgkX+6+dLbNRbJ5rr/
 CF88cLOhbaIhOcBitiuv3IF99NQMVchyuT8Zf4Io6rEgGIHlABSkx2TyiRnrhDEXGHpv
 Lfr3Xhanv5kTY/dSEV8966Vdnhca7oqMbNOiX//1CNL080/v5rqk9oUw+q+JfeyNRFv6
 uZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8gkd+GdKBzH+wNfGQaNS3YPTshXHCvuQpMzwqvS7Fq4=;
 b=nhmmmOOGIuSqtOv0x+b/N+sR+MfhyIHhXUKkeICrqxRhXMc8kNe+7FxQUjtYYiTVcK
 mKymAbA1ygGmQ6X14+Nh1/JizueYNU2aiVbwHBTNXZhT1uF1JhoOalYKxmaQgjaos6qv
 OcoNpPJKv7dOxIPIEoaVcvAclmLaOylqOpYtiDQBnvMZafvk9taO2Z19DAtisOlIreRP
 4Mdqi1/5ogc/FqLyCf6wQ7kcySdqaIqrewMB/VtIJWAYKtWqzdiqecWjb+zdCi4yjSfq
 7r6LO4YD7fBXHqJ8HVblTqJA2H8Q0WsHJxlkC6SC7v2yfpbkAKB0NP2OJSlI28GSjFm0
 cGBg==
X-Gm-Message-State: ANhLgQ19S1eKjNDWHjR8kSE1x8q+PB17LaiXKH27pd7Euao4jxEJPFFo
 RsKUym+S+DyvLMXDeFku0XVxZZ24
X-Google-Smtp-Source: ADFU+vuKxl3rfNTyCazUjtAUJMDTrBbs/U2/4hy1Wdj60KHqfUSbqtvmEgsNHSLp16LdaUhYJpkR8A==
X-Received: by 2002:a5d:5092:: with SMTP id a18mr19134256wrt.202.1584817995365; 
 Sat, 21 Mar 2020 12:13:15 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id i1sm15226252wrs.18.2020.03.21.12.13.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 21 Mar 2020 12:13:14 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [Qemu-devel] [PATCH PULL 0/4] RDMA queue
Date: Sat, 21 Mar 2020 21:13:07 +0200
Message-Id: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: jusual@redhat.com, stefanha@redhat.com, yuval.shaia.ml@gmail.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 52a96afaa23d883d281bc7b95b9e69db7d6d3d3f:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging (2020-03-20 16:00:21 +0000)

are available in the Git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to f93cfdc583d4c26b2a878642adf574e11909863c:

  hw/rdma: avoid suspicious strncpy() use (2020-03-21 19:21:20 +0200)

----------------------------------------------------------------
RDMA queue

* hw/rdma: fix gcc 9.2 warnings
* hw/rdma: eliminate data-path processing
* hw/rdma: Replace strncpy with pstrcpy

----------------------------------------------------------------
Julia Suvorova (1):
      hw/rdma/vmw/pvrdma_dev_ring: Replace strncpy with pstrcpy

Stefan Hajnoczi (1):
      hw/rdma: avoid suspicious strncpy() use

Yuval Shaia (2):
      hw/rdma: Cosmetic change - no need for two sge arrays
      hw/rdma: Skip data-path mr_id translation

 hw/rdma/rdma_backend.c        | 61 +++++++++++++++++++++----------------------
 hw/rdma/rdma_backend.h        |  5 ----
 hw/rdma/rdma_rm.c             | 13 +++++----
 hw/rdma/vmw/pvrdma_dev_ring.c |  5 ++--
 4 files changed, 39 insertions(+), 45 deletions(-)

-- 
2.17.2


