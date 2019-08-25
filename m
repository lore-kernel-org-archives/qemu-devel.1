Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CBFC41514
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5315520679
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uYaOCVW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5315520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1yNj-0006Yh-Gq
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 15:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1yKx-0004Qx-Mf
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 15:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1yKw-0003Li-0u
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 15:38:03 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:44460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1yKv-0003Kv-Rx
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 15:38:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id t14so8762260plr.11
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=2yiLMaHk4zYpZASibjsiNkmCjKCTCRJfCKxAbE7edDI=;
 b=uYaOCVW+2qsVHuQxUfOvmae6kPvVdD22iC25xrhJNOYU1iv7IJoXWPRxoMAhGngRAD
 2+bXTvIAVBOZRBHUOuvYqw20f9zVk5r/8j9Ch/G7wtY+WJOBSwvnYl1OIZ98GZgQ7+oc
 eKAL6HSiYbNpAMs0iXtC0VTEWPUi5eficlXwWcdntCw9nfriIRPQ4QMR0f0VqFKc5VxX
 1W4n3y7ZYUHkC38FF8licgyaG7eq3+IYv0vs21t9FlEz1YsXEkcsaSxNx1ksjBXKs4k1
 s+dYgDfmtd8MXb5O0kkgeLrIHb722o4J/qx219241w23XrSUeu+psU+bTtaie0GdlWQQ
 fncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2yiLMaHk4zYpZASibjsiNkmCjKCTCRJfCKxAbE7edDI=;
 b=HFG4rVjMPUDHJsjNY67CKaJZyNodM/8GoO9TP6rm69cLLq/geJ6Xh7E+4R33ICDhXD
 +AoXGN/b6rWotS7/ZA5HGX90dRuMMAnXiCRdLlpdutzOD2H5a/7Kat1ds/kfQIzc1qpa
 H5ixZgp66JozqTNrCPCxC/3m3lxkAKyzjFpRr289f2C/r+ORUP9ZGW3vrt3U5eaabUs8
 pey537ysQcOOBwaeTJRAFlRCdD7col3mBp/fbbUn75EFEwds+MYv9SQ534WltdXIn5ZO
 5dQJnvWSv9MD+jQvdW+xmgmEYuxZpfCil0blhMWYANCHXQeMwxpBXM3bgfuhQF/pBBsw
 +zEQ==
X-Gm-Message-State: APjAAAVMqJICLi3vquQjk61zs0lBb90aYcl4vIjhBRwaxgSIcN7ddEH4
 LDFJ6j4Y92y3f4yVWk7bswV/q5MTN8E=
X-Google-Smtp-Source: APXvYqx8Bsze8l21evOg8XNvJXd3+oMCSg75aJg9EaosOnYXfJmVe3PcEHlfZ0+GpNZzgcCJOdyjoA==
X-Received: by 2002:a17:902:fe8c:: with SMTP id x12mr53767plm.55.1566761879188; 
 Sun, 25 Aug 2019 12:37:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a6sm10414039pfa.162.2019.08.25.12.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2019 12:37:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 12:37:56 -0700
Message-Id: <20190825193757.16297-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: [Qemu-devel] [PULL 0/1] target/alpha queue
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

The following changes since commit 586f3dced9f2b354480c140c070a3d02a0c66a1e:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190822' into staging (2019-08-23 15:15:44 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-axp-20190825

for you to fetch changes up to cb1de55a83eaca9ee32be9c959dca99e11f2fea8:

  target/alpha: fix tlb_fill trap_arg2 value for instruction fetch (2019-08-25 12:30:48 -0700)

----------------------------------------------------------------
Fix for alpha_cpu_tlb_fill

----------------------------------------------------------------
Aurelien Jarno (1):
      target/alpha: fix tlb_fill trap_arg2 value for instruction fetch

 target/alpha/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

