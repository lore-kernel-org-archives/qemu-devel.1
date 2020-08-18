Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874ACC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E5C2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AXS+c3vJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E5C2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k857n-0007Re-DJ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 13:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k856r-0006Yu-BN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:09:17 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k856p-0002zW-Dq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:09:16 -0400
Received: by mail-pg1-x544.google.com with SMTP id v15so10046215pgh.6
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=22Zz+YwGzBdQSdlyIPwby04sg60ddKWl41y0fTGfHyw=;
 b=AXS+c3vJG4w5Jj1vig1Ym+2gUZRAfqrmSV6PfYov2m9+IkK4Rtgi8IPABOmaECviYF
 O8ntjyM0FJ6uxMJfj1h6ytuWRiCu/PNtF6iKC/4qhGptJ3I+A0rR+9GUoSycyM+ce31U
 v0SBqZfpXqn/hkO+xaYcv++TpS6kkyeY593XgtAKGP1liRXZ9c8GsAHx63XfFTqYPtn1
 SHry6JwJ7S9O0wBsMScTMAUGokAMgt95Av5Mt/sQ7QHwL6gHaCYsD/B3z3r1gOMsIsnz
 +IBethrVkAWA1ZgQlOYFgByQwmV6a6B5RFs3ZF7PAOXXsi69BEwdVYvyFvVJWpJ64HAB
 3WQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=22Zz+YwGzBdQSdlyIPwby04sg60ddKWl41y0fTGfHyw=;
 b=Cja6zliVe3o72NJOKJmSUzhAP9SB6c+pgfc30favSeIAoTEjKM8DFeNr2cUCDe0+Y/
 UEAubHDpzpb8mjUvVBfD/xmKNDAvwsVYQ5w4l9RYFTViUVBGubjqwaUB9vihu3dx+hv8
 trZORVF71kp7UaHfUK6QuNRdYfkQYQJ3o029L3ew7cVdg096ibasPGPs7V0k9OhnUo1e
 SigYdgtKKoA/tF0BG2MhXzcKxF6P4UMwdRNPbz75gjbJbuyysFZxNX1/fO6rYR4vVasH
 bNKRnrAYH9HQi4yZKkfW/WyJkkPS3U1qv2G4mZ1uXo5VpOXNZuP58XB4vUB34w5jfzyK
 gg6Q==
X-Gm-Message-State: AOAM533ctFAFgK3DKzHGfVbdW9MpfoQS9XqzQe3Yu7UFopPkytcRV+Mi
 XCJoHq2+8VCAiPMCy736okzXkA==
X-Google-Smtp-Source: ABdhPJxdXpjFYeUiw7ZhNYnf3yjbbMa7dU67XLWo4wn2yRsEkCIpMeOKEGifFwKMfgbvijcsvFJIxA==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr15520198pfn.62.1597770553446; 
 Tue, 18 Aug 2020 10:09:13 -0700 (PDT)
Received: from localhost.localdomain (114-47-163-2.dynamic-ip.hinet.net.
 [114.47.163.2])
 by smtp.gmail.com with ESMTPSA id m3sm460043pjs.22.2020.08.18.10.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 10:09:12 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v3 0/2] Add file-backed and write-once features to OTP
Date: Wed, 19 Aug 2020 01:08:37 +0800
Message-Id: <20200818170839.20258-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=green.wan@sifive.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Green Wan <green.wan@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First patch is to add file-backed implementation to allow users to use
'-drive' to assign an OTP raw image file. OTP image file must be bigger
than 16K.

For example, '-drive if=none,format=raw,file=otp.img'

Second patch is to add 'write-once' feature to block second write to the
OTP memory. Only keep the 'written' state for non-control register range
from 0x38 to 16KB.

Tested on sifive_u for both qemu and u-boot.

Green Wan (2):
  hw/riscv: sifive_u: Add backend drive support
  hw/riscv: sifive_u: Add write-once protection.

 hw/riscv/sifive_u_otp.c         | 71 +++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u_otp.h |  3 ++
 2 files changed, 74 insertions(+)

-- 
2.17.1


