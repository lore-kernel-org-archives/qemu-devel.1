Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ACAC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659D720756
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="K4ldXPWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659D720756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqAq-0006Sa-Ec
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kMq8d-0003g6-TW
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:12:07 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kMq8W-0001RI-FI
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:12:07 -0400
Received: by mail-pf1-x441.google.com with SMTP id k13so560719pfg.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=x+ZLRjzoNSqzQq7ZokkFdwTlzj8XiUz2U3ivXf3qQG0=;
 b=K4ldXPWzNJ2impBYE6dYVYz349g2Wzmpn/KlaVOibK+yM18IH9auXHIZ9zE29y3COD
 Wl2qq6Dh4SpOqhTTciaY99WH45/b/uab+dX5rSzhXQJuFj/pTIl7plDIaX3m6+SYIvn0
 WDYl5HyRxqac/acezL13pFFSDS6bEMNFMN5VaMs8sU4mTt8S4W5L/2FB4+Ye+eLl9PP1
 fi80LBxsjb6fuzdIY988VXoZSUQ6cXcvy8YOMub9fB9KKw+WjEMngo9KUYvhIQLfEwiz
 OrcotIc41/8vPJwJ50GLxRWnVI+45CfwtlyQ1fuCz8hr94HK2ThwoEg59i01sOe1i//N
 JE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=x+ZLRjzoNSqzQq7ZokkFdwTlzj8XiUz2U3ivXf3qQG0=;
 b=rFJZYjS3PJ4TqfmXIDbs3ESXCfBYvzgGIo0AqKU1sPMeHoT9O6HY58uC+rakiKzPhy
 U+JwWPV/c04+0WOYBWg8F6dMyuOvR8xC9CPP2KFXbOueUCQtxMCOpOL844NLNBp0xF+6
 lPVvjvHjwVn8RRDffKsmF+276mnCYlAI6iRM8Ne4SHmm66EbumGyTi0tYALMW0j9VgNe
 eignQmtuy9VIp2IgHfDr8ni54yxMx33gNQXL8HANjGSbSVuo0ygctqzu9zNZZY5E4UeR
 E1VpdQAQCCE5NbA5CmraaRU6mG+e4fg9Sz/QUC+CFMyxDscmu+clKsYisp0fEVBDkLv5
 76MQ==
X-Gm-Message-State: AOAM531xt8oc2qzbC0HYE3dQ9sGzCOd/+MQCtfQ8FnKYPQckc+rR8wAf
 1mFHBmJDw+xJtJ1Yw8Il1rqwmhMuZTDX4g==
X-Google-Smtp-Source: ABdhPJzsTMWhOxKUHfRdpzXz+3WTIPvekiSei257qxqIuvCnuPngmzR4VOkvigW7Fl1NiS6r8ESiDw==
X-Received: by 2002:a05:6a00:1702:b029:142:2501:34d7 with SMTP id
 h2-20020a056a001702b0290142250134d7mr801865pfc.48.1601287918711; 
 Mon, 28 Sep 2020 03:11:58 -0700 (PDT)
Received: from localhost.localdomain (111-241-115-7.dynamic-ip.hinet.net.
 [111.241.115.7])
 by smtp.gmail.com with ESMTPSA id u2sm814747pji.50.2020.09.28.03.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 03:11:58 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v6 0/2] Add file-backed and write-once features to OTP
Date: Mon, 28 Sep 2020 18:11:44 +0800
Message-Id: <20200928101146.12786-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=green.wan@sifive.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Green Wan <green.wan@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelogs:
v5 to v6:
 - Rebase to latest. (sifive_u_otp.* are moved to hw/misc)
 - Put the example command to commit message.
 - Refine errp handle when check backend drive.
 - Remove unnecessary debug message.

v4 to v5:
 - Change the patch order
 - Add write operation to update pdin to fuse[] bit by bit 
 - Fix wrong protection for offset 0x0~0x38
 - Add SIFIVE_U_OTP_PWE_EN definition
 - Refine access macro for fuse[] and fuse_wo[]

Summary of Patches 
 - First patch is to add write opertion to update pdin data to fuse[] bit
   by bit. Add 'write-once' feature to block second write to same bit of
   the OTP memory.

 - Second patch is to add file-backed implementation to allow users to use
   '-drive' to assign an OTP raw image file. OTP image file must be bigger
   than 16K.

       For example, '-drive if=none,format=raw,file=otp.img'

Testing
 - Tested on sifive_u for both qemu and u-boot.

Green Wan (2):
  hw/misc/sifive_u_otp: Add write function and write-once protection
  hw/misc/sifive_u_otp: Add backend drive support

 hw/misc/sifive_u_otp.c         | 81 +++++++++++++++++++++++++++++++++-
 include/hw/misc/sifive_u_otp.h |  5 +++
 2 files changed, 85 insertions(+), 1 deletion(-)

-- 
2.17.1


