Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696A9C55178
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A598B22202
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJLaOVpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A598B22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3fm-00050K-GU
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3eV-0003QE-CT
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:27:47 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:56165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3eS-0001HB-Sp
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:27:47 -0500
Received: by mail-wm1-x32a.google.com with SMTP id c9so1803438wml.5
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 07:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AdiicdP64VmJgYQJM0rUTlbseLHHNCO1CIl4JFbRXFA=;
 b=dJLaOVpvFVj5cqkmypEsd5EZP6rMR0/+TX+mgnP41qzxyUYyq9Y9QujpplmEyO4RGH
 yD5QYIw+FPwRky07w2ZoxmTrSaefKD2zYE/cIAN0NTyhE9A2GUM8f+9VyKcUIqNfKH7v
 +sDVk0jkyCnpEAZlw5K+ZB5ltsdV6ZhAOEpZsZT2xN3sQbHWae/6PqrfkEYIhscbRVXo
 uNlNV/Yx7tAHijUcaqIZrEHCY8FueQOz/Fl/sjfqJO0mRr5edIC+qW1mXXstzQ9Yxu04
 yh0Q24eWiHbuhlrsYlZvfjKPH1xe1ZaaDhBad95eGuZjJjhR25x1tY5hewIsJ7LTUTuD
 kCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AdiicdP64VmJgYQJM0rUTlbseLHHNCO1CIl4JFbRXFA=;
 b=h9IEtN1FxR/4fG8B379Jn0kZ8pL+c+lwjjZu59ZbkyKh+mbZo6OfDLVIIehRZsqRCO
 bky85VY4nP4P1+AyODqf9VaEKidZsoSqt0cVj/mNNz8IRmyh65uDufRaIdVBoEShas5U
 YdR7NryCy3znAvv7MzrbBmTOdhcxdyAHX2nm5udzcb7mH+KUK0dUvPdyIluz91/QmxYg
 NaXhHSG8nZ/hfa6Iw5jjQmmScKyV6sR85PYoMPBfb9tuKfv+7UOvmojq5yl4gxb8z5/D
 wAqX5gpDtixJB86KvGatXRXsfWTxbQCMhKHYeLjFKuCOSxEvovZNjEb4NYz3SS/4rbwE
 M8YA==
X-Gm-Message-State: AOAM533IKW1r3XbYrXsNh71vFA6ZyqMDdQWJUWItnW5FMuNz4Pp4cTXe
 439JivUKABTSh7IJnAePPNZk8/7Iu2B7PQ==
X-Google-Smtp-Source: ABdhPJyhAEHZ9WSxroJ0PT8RrG0deY1TAu3RdgvdnzC1wf96JmK5Zoy0Rweg0VRg41vRVeu98xydow==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr145407wmh.46.1604676460875;
 Fri, 06 Nov 2020 07:27:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 109sm2723462wra.29.2020.11.06.07.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:27:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] linux/sparc: more get/set_context fixes
Date: Fri,  6 Nov 2020 15:27:34 +0000
Message-Id: <20201106152738.26026-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: 20201105212314.9628-1-peter.maydell@linaro.org
("[PATCH for-5.2 0/3] linux-user: fix various sparc64 guest bugs")

This series fixes a few more issues with our sparc linux-user
sparc64_get_context() and sparc64_set_context() implementation:
 * we weren't handling FPU regs correctly, and also the way
   we coded the handling triggered Coverity warnings
 * some stray pointless error checks
 * we shouldn't restore %g7 in set_context
 * we weren't saving and restoring tstate correctly

My main aim here was to deal with the Coverity errors, but
the rest are things I noticed while I was working on the
code or which had fixme comments, and I figured I'd fix
them while the code was fresh in my mind.

thanks
-- PMM

Peter Maydell (4):
  linux-user/sparc: Correct sparc64_get/set_context() FPU handling
  linux-user/sparc: Remove unneeded checks of 'err' from
    sparc64_get_context()
  linux-user/sparc: Don't restore %g7 in sparc64_set_context()
  linux-user/sparc: Handle tstate in sparc64_get/set_context()

 target/sparc/cpu.h          | 28 +++++++++---
 linux-user/sparc/signal.c   | 87 ++++++++++++++++++++-----------------
 target/sparc/int64_helper.c |  5 +--
 3 files changed, 71 insertions(+), 49 deletions(-)

-- 
2.20.1


