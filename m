Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CCEC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2669B22470
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lT3XxFmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2669B22470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRIw4-0004SE-2L
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kRIiW-0005Ut-Q7
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:31:36 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kRIiU-0004Up-P8
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:31:36 -0400
Received: by mail-ot1-x344.google.com with SMTP id f10so11976011otb.6
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hV5hJblGW3p/EPj5E1miRqBG8FtRIYgD4mxvFmMBiy0=;
 b=lT3XxFmigGWOa+Z3otl6RzuGLE9Yx477yqWYpozLOW+2vHootJiamRtSsEtvHJAAtv
 Xmhf6MWxoVxbKUPQkEytU1n+YcxmmPOwOR/i/VyTEH6cqc2f05p03562TppE0skPPSff
 UtNxzXw/V9nYZtW3sK+5+06ScxNZNdPJMYYPWpCMeqFKTBXe5AMDjxL5Pky3RSfg6xAE
 ROojw5+CmSK7y9QyT+dgQer2J63pveoB2UJ1ChQB3PAu4HZ+hrZ/m6HqNr7ySvTMYdiz
 Smr8U9Q0LcCFHb+o3yW9MH5NCA/P9yipXWdRqKC83W1AM5Pp+GqRAwNR0Ru4RM/zZ9TR
 mhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hV5hJblGW3p/EPj5E1miRqBG8FtRIYgD4mxvFmMBiy0=;
 b=LwdyPLBt+DrbytyeB50gpzF5N1WM5QWO8Y7Pqboko6JdM6w4KdYIcOR71zWuRreJFk
 9QgZibwpVs/jV8B62k6GilmPcZDSoVB41GHxZcP0SGb4A+6keOXRcH10pnbucNuqShHU
 ybCoP8st1Y682clpTdHj4cTWRbJ4s6zW6L+vqOoT63oGqH67necTdU+KpOOUA+KD5FfH
 09NGBA37R1P4fIrH7a6KVrqVKc9nMGOqZk8+bNq7Le9Lrh3g/8aEfodkN+poVjJI1M29
 UbBpmInOl7xQipB71zSkLlnB+ZIzg+8pmFmOgcZlQLhz7GgvcQudIVi4sZumV6j2oxRe
 h8kg==
X-Gm-Message-State: AOAM530B/44yschu7hcGxih8TQagp06kiziIpIO03XApP6LVeQmR0Z8+
 bEYVVRR1trrDuektOar+gw4do4NWpBbuHzal
X-Google-Smtp-Source: ABdhPJzjauxz0OjyCmufk6J8mcqCzNyGYd+29V1s+wsRU8aLu6n4b4RkVimuHCmXoaEdPgd3BtIGMA==
X-Received: by 2002:a9d:7387:: with SMTP id j7mr7067560otk.18.1602351092877;
 Sat, 10 Oct 2020 10:31:32 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id n185sm7415032oia.28.2020.10.10.10.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:31:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] linux-user/microblaze: update signal handling
Date: Sat, 10 Oct 2020 12:31:28 -0500
Message-Id: <20201010173130.99652-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: edgar.iglesias@gmail.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The linux microblaze port only implements rt signal handing,
not the old style.  This allows our linux-test to pass for mb,
if you have a cross-compiler available for the build.


r~


Richard Henderson (2):
  linux-user/microblaze: Implement rt signal frames
  linux-user/microblaze: Remove non-rt signal frames

 linux-user/microblaze/target_signal.h |   1 -
 linux-user/microblaze/signal.c        | 186 ++++++++++++--------------
 2 files changed, 83 insertions(+), 104 deletions(-)

-- 
2.25.1


