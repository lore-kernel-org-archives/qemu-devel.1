Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3BFC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AB120656
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FQEtZVA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AB120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyBF-0006cj-QR
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1jyuMo-0004xS-Mi
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:51:50 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1jyuMl-0002ol-ER
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:51:50 -0400
Received: by mail-pl1-x642.google.com with SMTP id q17so4151319pls.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 02:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=VrIzcegVqGZqnujnuKczVriGy3clDNfKz9O0N+B95RE=;
 b=FQEtZVA+RBLH50gOlUpMbaiWBAjxCw6RBMQx2IL/msW09V4t5iseNP5p5/2a0Ap9a1
 AsgNKw4YLJnH4lvlDpKgaaW4vS2FPTFGuZ25Z11L0xm6llE7NRt06txwBps4boTtxr6V
 YoE1VaKJorUW/7l5oyCx2PGPNHbzI96rdRb9a1aMARsos+HJFLSirrNScQlTRHkxhXhD
 m7qK4i/6rSMUEZr25Z80/jSe7jSNSFdPkuF/siry6v4fqHZ3Okmozdn118GlHR61sYO1
 zJWjGhMGpmN131pdmkWZDUvt3gLUCgsHhLcbSCx+HtvT3SYnEjsdMiSp+KNKxZgA4ZWd
 S1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=VrIzcegVqGZqnujnuKczVriGy3clDNfKz9O0N+B95RE=;
 b=S2cCUZ6YRd+Qw7inZcyMKhw2ENy0e4fLlwRrKp9nrLmLBv1WU6gyiy+rgZDUHuWLQ6
 8wNNzhhNt/hkzvGfG+aQYujDLbBf6jMF8N5mZ9hdvQuqiE5mNn2Y/3fzqfWzu6eHA7xA
 BPX+IbeAB+RfLD48WCyXDn/QSIt9LCuDS6L89moJH4PVVfy+iX8r7WxO719uaqUIyL5W
 14ZzwPhJo5YvjqV6qmzWrwQDUHZfHe0IS0K/4ypj+uOkOgzVX5Db4cMTJl/uJX52V/Qb
 EVwdIUnJRlZCDO3EbgQGozCgmLaRT+iE8oDa/a4iZRneSIGu1VX6RuZwQ6+tow8hBly+
 EX/A==
X-Gm-Message-State: AOAM53167vKZTfPAGWo1N1+VkmGqNHK2kxmIIrFE1qthJc2S4MnSg9v7
 JK8/5/adHnyzwbumkb2x7ITz0g==
X-Google-Smtp-Source: ABdhPJxMCSqOmlCOtofSzHKyyXpsSXk19bFR/uY5dYYvtoWiiKQwXjbZ2yWN00RIn9BmU+YMsbfklQ==
X-Received: by 2002:a17:90a:f00d:: with SMTP id
 bt13mr2836578pjb.109.1595584304882; 
 Fri, 24 Jul 2020 02:51:44 -0700 (PDT)
Received: from localhost.localdomain (111-243-186-54.dynamic-ip.hinet.net.
 [111.243.186.54])
 by smtp.gmail.com with ESMTPSA id x23sm5581636pfn.4.2020.07.24.02.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 02:51:44 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH 0/2] Add write-once and file-backed features to OTP
Date: Fri, 24 Jul 2020 17:51:10 +0800
Message-Id: <20200724095112.2615-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=green.wan@sifive.com; helo=mail-pl1-x642.google.com
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
X-Mailman-Approved-At: Fri, 24 Jul 2020 09:54:21 -0400
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
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add file-backed implementation to allow users to assign an OTP image
file to machine. If '-boot otp-file=filename' is specified, OTP 
device uses otp image file instead of fuse array. In order to keep data
up-to-date due to unexpected crash or CTRL+a-x, every read/write to OTP
memory involves file open, mmap and close operation to the image file.

Add write-once feature to block second write operation to the OTP
memory. Only keep the 'written' state for non-control register range
from 0x38 to 16KB.

Tested on sifive_u for both qemu and u-boot.

Green Wan (2):
  hw/riscv: sifive_u: Add file-backed OTP. softmmu/vl: add otp-file to
    boot option
  hw/riscv: sifive_u: Add write-once protection.

 hw/riscv/sifive_u_otp.c         | 122 ++++++++++++++++++++++++++++++--
 include/hw/riscv/sifive_u_otp.h |   3 +
 qemu-options.hx                 |   3 +-
 softmmu/vl.c                    |   6 +-
 4 files changed, 128 insertions(+), 6 deletions(-)

-- 
2.17.1


