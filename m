Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DDBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 16:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF990206E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 16:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOJxdu9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF990206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzMhU-00037t-5c
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 12:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jzMgN-0001qu-UK
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 12:05:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:40536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jzMgL-0001q9-Dp
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 12:05:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id l6so6046733plt.7
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TOiPHdrWGd3USqbgE1Jzqj9/fNwB4MC0K6RANI19f4k=;
 b=EOJxdu9UMt/6ydgPv8fiiYHwSWqjPdR/2dfGUAaN+RsL4mPGMwe4ZI1j/7ZjxY3U0v
 dJSQraaPvvPvj/HWYv5zaj1rQT/KCDn5wDfoo2EuUUxeOj95ziYKUaHVw4SPVIpewEwl
 kh675BwiHbBJzc6X8g4082HmJH2Mi1bmsL/hAUKqUiqJ7iGfNmquTnx2o8hkd8Ie7aUH
 goORagjfSgITvhHFjzChZ8crZT9JqQDFlen/MrbCATVrX4cc8S9Avcz5CKJAs6WSyW4c
 j3oPW6yQ7DqW5Jx8HNAhDKLL+ia94no8HijLJLSbdTlGqUqgHcHCXcKvfTrywIxtcO6j
 tqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TOiPHdrWGd3USqbgE1Jzqj9/fNwB4MC0K6RANI19f4k=;
 b=twA9JgqOxXV30uoRjJ089WuS/LiQNkoMCBPu2aVG1IzBDyNcr5VMm0N0Q11W8OIeHA
 SiYujHfWnvBL5w8T9cK84jAbd3dYmuNwnKWyviSX5RLHgQFoCcBq61TEG+JOpWcRKA/k
 Oz74Fyiwd/EqBg+SVVetFlhIlu9lbiFZ/JaZsIlQ/2uh/jyUEx7O1PnyUy4IJxBdOgJh
 GgfYJTWmSieZbzb1rKn4WxOtfl7qy/5krfUhatdE5ATDTb6f/MhagLfPiBwEZK7QPBvT
 jy8AZOtE5hEURcSHu/1wxJHZLhv/I9kKp7rbuKaYrmqEgBPxS1yhAmf4Q+BfNktzVl5D
 VOnQ==
X-Gm-Message-State: AOAM530S0lZxF02Tp+UqoAlPuyG0ICX8uQ24dJWns8Q9ZlCYoaL+ew+D
 FQVadNhHedR36BrqXxfywEpNy9W4LM8=
X-Google-Smtp-Source: ABdhPJwa1Djp4STd5oNF8JXbRo9vA81SsK3+bSiYCzrwH2YJon2Q5J7nM/eevmTZDy0r1oz48oR8cQ==
X-Received: by 2002:a17:90a:8c7:: with SMTP id 7mr10221855pjn.76.1595693150057; 
 Sat, 25 Jul 2020 09:05:50 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id e18sm9731801pff.37.2020.07.25.09.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 09:05:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] misc tcg-related patches
Date: Sat, 25 Jul 2020 09:05:45 -0700
Message-Id: <20200725160548.750749-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7adfbea8fd1efce36019a0c2f198ca73be9d3f18:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-for-5.1-pull-request' into staging (2020-07-24 10:52:20 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200725

for you to fetch changes up to 3cb3a7720b01830abd5fbb81819dbb9271bf7821:

  target/i386: Save cc_op before loop insns (2020-07-24 14:29:35 -0700)

----------------------------------------------------------------
Fix some cputlb commentary
Fix an hppa temporary leak
Fix an i386 translation issue with loop insns

----------------------------------------------------------------
Alex Bennée (1):
      tcg: update comments for save_iotlb_data in cputlb

Richard Henderson (2):
      target/hppa: Free some temps in do_sub
      target/i386: Save cc_op before loop insns

 accel/tcg/cputlb.c      | 11 +++++------
 target/hppa/translate.c |  2 ++
 target/i386/translate.c |  1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

