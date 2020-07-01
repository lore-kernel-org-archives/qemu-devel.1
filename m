Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F278C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A46207F5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS5huDh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A46207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhSN-000282-3e
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqhR0-0000W5-Be
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:26:14 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:34979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqhQy-00048o-Do
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:26:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id e15so20970954edr.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j68hPYqEMJMZ3rGlnwM5uic6ONmX+W9a/BqNwfTd7aM=;
 b=AS5huDh5SgD4vRgCISD1So56KTyNgOf1tyHGt5ZXk0wuDQzby4w5wpB8VpksBe52q+
 Oo0lX0VD/Kr1ImD9VFclkOBEkLunZ7VLQiG/HYn+O7iMK5tE2RsONVfhfP8mI7GPoS2T
 4ATLkbFDpKBEGhgTEm9EfFmgI1pmJdC+uuDyQ+9B7kG102OsRYm84ny33O62iTIgEra5
 xwcwbkYzxkCHDnzNlT+ExBVtyRPW7i5Pheb0+AGAw35LHvkojm4iIuox+xAT5XbbrvuW
 LkvuS+v7hC/3zrZCq5tbvsDvDC49HNN56c7thKg1c5vDSIOPn1ptdHpI5d5guGcUhZhC
 IInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j68hPYqEMJMZ3rGlnwM5uic6ONmX+W9a/BqNwfTd7aM=;
 b=hNVJBhRe7/2u1rLlilOWlrKhJ2GikhCrIA6++H2NgtXL92tNFfUp5WJ+o2y1CG2Bqu
 sr0xKoUjdA6TcFbSlU0dXoH+aJhuc82zt50+P1Hx4krGJTyYUgAtkX6ZQE729ExFzLLm
 9nBMrWVrL/YI1XGoOCWYLswSm0oBmILsSQxedjDMr0IPQEh3Pik0fwWcxtqwICMPXzdW
 pRKm4H6eARV9gHNsnxXVm/QbNBDD0MnIZHGcleRcYEt52i5u2rlZv25BfWFDIhVDpQhH
 vsk5x++UhboXYS8jHXRp3dq0pchmen2jMoItiiyXR/DRBHdf1tNPtvo98/Dq//7pD4xP
 14iA==
X-Gm-Message-State: AOAM531Vlw3WeQpdMwde5MyLnBxZcUX1ExJUrax2b+Bbmfc9vIujAsSp
 /MEanXAD5VnrqpLLOP8GOiB+YcDL
X-Google-Smtp-Source: ABdhPJyo+FVvNAe9t/o8sPp/taw4KBY94UvhwUmY/PGmILfajKzoyBBJGRHjHsM4+MR3RJUkqXmnvA==
X-Received: by 2002:a05:6402:b84:: with SMTP id
 cf4mr6738661edb.21.1593627970511; 
 Wed, 01 Jul 2020 11:26:10 -0700 (PDT)
Received: from localhost.localdomain ([109.245.225.97])
 by smtp.gmail.com with ESMTPSA id y22sm4809333ejf.108.2020.07.01.11.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 11:26:10 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] target mips: Misc fixes and improvements
Date: Wed,  1 Jul 2020 20:25:56 +0200
Message-Id: <20200701182559.28841-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x530.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A collection of pending fixes and improvements.

v2->v3:

    - minor content and commit message changes

v1->v2:

    - minor content and commit message changes

Aleksandar Markovic (2):
  target/mips: Remove identical if/else branches
  MAINTAINERS: Adjust MIPS maintainership

 MAINTAINERS              | 11 +++++------
 target/mips/cp0_helper.c |  9 +--------
 2 files changed, 6 insertions(+), 14 deletions(-)

-- 
2.20.1


