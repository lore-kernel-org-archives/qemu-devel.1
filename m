Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C9BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83E02086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njKRZocW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83E02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zVe-0004Nj-Us
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2zUi-0003DA-Ez
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:08:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:36821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2zUg-0005lq-Ot
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:08:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 3so3477751wmi.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A4xGsM0zmyMEO3RL8fJrZLaRnxp2eZLyZdA++cojGtY=;
 b=njKRZocW/VklWQs5Fncu8Lo17cRDLvwf+pOiKdMGUfKJfH/SQ2ZCbQSMa3sqJH3gB2
 FVe062m/I7MNZnFZxOsiaQq0yazYjeihY9YtDDqExAqespjBkXwwJb/UnI1CUIy4YOhJ
 YgVWzWLC6wWrqZM9HFAmBvMEtdZjCW5Wb+gw5DCB5i8D+Wm4bKDqflMqiFEkBPWLl0Gt
 7cV4LJN4TDNudXMdPp21JrMRiBzfpIJEFXP+KIVtwQX5yxvXtnR72dlZUn0+aPSTXayz
 OgWn3jVYB/eqwEXS02QvcBMc+tpwPBtMLTV2GQO5PllcmLiEUV5t7e68SoDWqcGSUhsp
 Ew+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A4xGsM0zmyMEO3RL8fJrZLaRnxp2eZLyZdA++cojGtY=;
 b=XCI3VhNhSQJBvgOmpQIUesjLVUb5OrgPyyCBHIvMjWhSMB2D9zqbDuda9vcdYuWXyA
 ThW1SJQQk9R6iugqPNMglYPTGERy8fu7bpOg0V1/ycmGb4FfIxB0HIV2Nd6NStABBzDr
 czhSI3EWj2jBwdolg+jtrNz5Ebd880E9b4WOnwNhPVn5RwnDOEF7JnhC6ZCJKqCAmN+V
 eiTVwxp82Vf97ong8n7d0eTbuYrSTp12qpqPgPejYXFAq2DOImSl27VsIgtclNYt+u1P
 E4ehAfHs/k8BGGmyx0cfNJDuQztEdt4EmvBbQqpsa8/6JNgzHCdhbHwOTwKyB7naQJK6
 tHEw==
X-Gm-Message-State: AOAM532yOwR+Wv6wbjytNvt1+1a0GNkTPadGN7Qq4+yGo+R1iiH/J/RB
 Iy7jnj4f+Qk16a5HnaAyB+p6xp7zaIbCsw==
X-Google-Smtp-Source: ABdhPJzBBsYU+aoG2CJg+FyNlE3xreQtL6nGR0C/vlQGNmtEyYc/zrtbi+9iq0wy4HmdVLSQqcv+tg==
X-Received: by 2002:a1c:1f0d:: with SMTP id f13mr4942928wmf.53.1596557327625; 
 Tue, 04 Aug 2020 09:08:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b186sm5625928wme.1.2020.08.04.09.08.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 09:08:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] target-arm queue
Date: Tue,  4 Aug 2020 17:08:41 +0100
Message-Id: <20200804160843.30245-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Couple of last-minute things for rc3...

-- PMM

The following changes since commit d15532d91be177e7528310e0110e39f915779a99:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20200804' into staging (2020-08-04 11:53:20 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200804

for you to fetch changes up to d250bb19ced3b702c7c37731855f6876d0cc7995:

  target/arm: Fix decode of LDRA[AB] instructions (2020-08-04 16:40:19 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix decode of LDRA[AB] instructions
 * docs/devel: Document decodetree no-overlap groups

----------------------------------------------------------------
Peter Collingbourne (1):
      target/arm: Fix decode of LDRA[AB] instructions

Richard Henderson (1):
      docs/devel: Document decodetree no-overlap groups

 docs/devel/decodetree.rst  | 29 ++++++++++++++++++-----------
 target/arm/translate-a64.c |  6 ++++--
 2 files changed, 22 insertions(+), 13 deletions(-)

