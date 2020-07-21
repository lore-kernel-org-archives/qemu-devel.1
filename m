Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E746EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 23:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B006D20771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 23:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ5IvJ8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B006D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy1VG-0007cO-Tq
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 19:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jy1UK-0006Xf-Vb
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 19:15:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jy1UH-0005MT-NO
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 19:15:56 -0400
Received: by mail-wm1-x343.google.com with SMTP id 9so187685wmj.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=PZ8xnpUkyfVoxxI3UEg26zVpwV6Dtq1mji9MXWXMw3A=;
 b=aQ5IvJ8/QoT+CPEi2Jx0xKt3uz6UvwtTcc5TTkVKbuVKx1PTvrckBRSZ8wKY6YnSeJ
 ROY/8+h1SDs1bzFzb0G6curgxpuq1R+TsspZNdP0lRSsJvn4hVHuwGzzcf8EPwZMGo7n
 Mnv+zq+Lfgvpj3bjPx74KoAEg7jPghv42+UAw3qUIfh4j7TzMLco1qiKsNOs4uKQvDho
 f+AOL7xZsdZOLGBGK0QY6LEs4u1lO6XFso3NxT/AizH5qrdJPk5Xh3D4ETLORaX0M+y1
 5X7CpONTLd4Gk8WGuBcKKF2xgI80CRtpqwVMmk9ca9d9bt3UY09TVJEi2FtqqsZbyAHx
 m+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=PZ8xnpUkyfVoxxI3UEg26zVpwV6Dtq1mji9MXWXMw3A=;
 b=r2mxmr+wOIHJJgkJrB0hI38ufzW2/A2RDylYitMak8yCHktQn5Ru5cCO+TgwmtP0xj
 56gST/YPF3WDlrV1hMbfONxqnBfvu30CIP11Szx1Z9ajUxf7sI30qMjoMJqnBD30j8H+
 Bb2TdfQbsCCTi40B4BSSMqbXe4DZ5JuMnp35BU/9VPmdfd2rrb964OhEHhz73iALTFR1
 3xxIejOZqv3Vr9EWMfBmVFgFJhX79zgPS4tNlUyY3bZBaO3oGRzzFydeNeEXT7lBno5A
 /kPTbkV1TCeiLslGi1cKJN06qJGEP8N/oCkGbEPaJKpCAshPxR6pYM+t4/3hIj6SagsA
 fdtA==
X-Gm-Message-State: AOAM531M1M98CiUYfPx5/m+NMEYmgqliRIqB3Gij/tR/x8KYG7xZRlLM
 hlOuXyw6Cs2SQVveDFtA5qY8GuLT
X-Google-Smtp-Source: ABdhPJx0gsjQQ/hWNy61V9H5o5Y4lqq2cE5g229R+SC+SI7Rnf6I2EyF4lv90XygKZCcIcR/Zp15mQ==
X-Received: by 2002:a1c:ab56:: with SMTP id u83mr5825158wme.94.1595373351640; 
 Tue, 21 Jul 2020 16:15:51 -0700 (PDT)
Received: from AK-L.domain.name ([41.40.247.212])
 by smtp.gmail.com with ESMTPSA id l132sm5128412wmf.6.2020.07.21.16.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 16:15:51 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 0/1] Add bisect.py script
Date: Wed, 22 Jul 2020 01:15:35 +0200
Message-Id: <20200721231536.21604-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series adds the new bisect.py script introduced in report 5 of
the "TCG Continuous Benchmarking" GSoC project.

The script is used for locating the commit that caused a performance
degradation or improvement in QEMU using the git bisect command
(binary search).

To learn more about how the script works and how it can be used for
detecting two commits, one that introduced a performance degradation
in PowerPC targets, and the other introducing a performance
improvement in MIPS, please check the
"Finding Commits Affecting QEMU Performance" report.

Report link:
https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05769.html

Best regards,
Ahmed Karaman

Ahmed Karaman (1):
  scripts/performance: Add bisect.py script

 scripts/performance/bisect.py | 374 ++++++++++++++++++++++++++++++++++
 1 file changed, 374 insertions(+)
 create mode 100755 scripts/performance/bisect.py

-- 
2.17.1


