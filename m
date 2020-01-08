Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D3C33C9B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA7420720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bg7IBiYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA7420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2te-0008Rh-0u
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2sk-0007fJ-Iy
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2sj-0003SR-Cj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:46 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:44399)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2sj-0003RM-60
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:45 -0500
Received: by mail-pg1-x52c.google.com with SMTP id x7so893380pgl.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 20:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XOT2U284lewRggywzzUb+XsTgut238IaHuwqpVxANi0=;
 b=bg7IBiYI/OQtQYJUi2iceigaO+ATTGkitVRMRvrP3prC5eo0eHqfvMxjOvWcWN9t7d
 VO1AGHGKtWZQ+U+002UAeTu981/cu/Fkbx3qtypszWlHyQhlcv5iK0QOnPk+cpjHFt1G
 bUukzukUCy9OTZVKwTev6bDekhXH074SKyIOmvcAdQG5G+fhviU4w/2v/Xc5P/xRemWy
 wBgtNipyyK2mtyW4OS1f6MWDoCQP6EV3QsQoNuRPqToPiU6N+5PXIi7V5u+sGK6JKM4y
 6u433q0tknXdM40B5JmtQowvhSACUGHqFTKp+bpwdAHHQkvuZz2rfo/u1cV89ECfloqb
 pksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XOT2U284lewRggywzzUb+XsTgut238IaHuwqpVxANi0=;
 b=S8DdXG1VwPYYo0UmLtA2RpSVzWiKHNXAQEVfLCiZrGp43UO+p77O0nrz49zRukqh07
 iVV47YmKWGj9ii+4TCxU9WN7RPsuJGBI+OpdHybtMWg7PGUZoMxg8uiP5zCzlecUy6yR
 kyuWds55ypJARPu9xNPJd6l++Cmo03VkmD4SSMkzTPAHYV+2hSZxV0GS0St0SO/MmpMa
 ni2MTYqelGN27IcC/SC3K2vI6dq3YnHOxLr7USm79L6/aucXIQg03hjVsoztrP21HI3K
 t8IejBJehFphSuybxLvvnkOr2Dq2VtWuEaa7LWX2z+IrQ7MO4rTJfEXtIXi3fCR7dV0n
 3z7Q==
X-Gm-Message-State: APjAAAWJ8ESLwiEq9I3uvUQ+QvswVvaDZcMKI+U8cMwyJmRtcLFWHfib
 5/+UELHIekDVtzIn5Gk/a8yC3PM1s0auQQ==
X-Google-Smtp-Source: APXvYqwA/BTYENNrV1RlFnOivUIhjnCIWqkPzYMbvL+EYi/fz5RC6XxepwdrzR6qstS/PR/ymPPqcQ==
X-Received: by 2002:a63:1418:: with SMTP id u24mr3067855pgl.279.1578457423617; 
 Tue, 07 Jan 2020 20:23:43 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f9sm1192702pfd.141.2020.01.07.20.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 20:23:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] capstone update
Date: Wed,  8 Jan 2020 15:23:35 +1100
Message-Id: <20200108042338.9082-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52c
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

The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e7f:

  Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-request' into staging (2020-01-07 17:08:21 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-cap-20200108

for you to fetch changes up to 7cc3836eac04a3e358b2496fbca704b3ee5197ae:

  capstone: Add skipdata hook for s390x (2020-01-08 14:53:54 +1100)

----------------------------------------------------------------
Update capstone to next

----------------------------------------------------------------
Richard Henderson (3):
      capstone: Update to next
      capstone: Enable disassembly for s390x
      capstone: Add skipdata hook for s390x

 Makefile           |  2 ++
 disas.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 target/s390x/cpu.c |  4 ++++
 capstone           |  2 +-
 configure          |  2 +-
 5 files changed, 48 insertions(+), 2 deletions(-)

