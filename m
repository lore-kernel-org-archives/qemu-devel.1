Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B95C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA0220899
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjUayAjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA0220899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzVt-0004QQ-MH
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqzOp-0001Bf-6Y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:37:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqzOn-0004Ho-Mb
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:37:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id l2so26498318wmf.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CyrmGwoQb3BeLpvL9CDcgfen6QsTGX52M/4K4nB5w8M=;
 b=RjUayAjVmWBalTcoc/+wqUwOhQUYbSCX0HouxxG4G2yzHoEO5FrGQ5lrnLXZMByKCk
 WDqftqClz7LvWKXmiOMcEDeJ7hGaaiDOkeSdnz851L5qDH+miYiqLbozRcnyMKiGd/iJ
 s5ikDk+rqAYBo1Qe6kQZmG9o4XBW7LZ9lvK2IprzkAuN05tFDrU51yX2TUdlMVLmKeNb
 E/clbavXC2GVhpSlyj4YlRODmgwFwlmcztYad8HX1zLW0wsB6DXTrlF6WSCnE7ziZBjG
 ie5vi9TxvwblphqRJHGOWH9FbKxrDxOfoGIRDOBNgRNXPwFTcDw3jgXNpsGXYqPv0qTc
 D0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CyrmGwoQb3BeLpvL9CDcgfen6QsTGX52M/4K4nB5w8M=;
 b=CoooHjdpLCG+Z4bFGyWrgCW7cIQQBUh7q6KECO4FRvO6WoUc6cKqRxh/H/wf8eudg9
 j49IgIyNarK+uRoGoKgAWT2ietuyvMHyLmhLEegTQtF/Z/bCZk41nsTQyjMHbnwy2Eoe
 PuUKDQ77EpEO6gCEaXyeWCiFPaczZhhVRkg0HxGfXruemuNxT7tjwV5uchVm/+2k3f/8
 CYCucIzLR00vVvuFAF5h+wDi7kXtfS8LtIMvCgKoJ9/59cD41AA6okVoZ74vODeht6Zh
 /zSi1/APEY5LWkGaJVUMu1DXIP4v3BNQnfTgizgZRO9RYBIxV49QLHEIRtyzBwm4mEQ7
 f3wQ==
X-Gm-Message-State: AOAM532r4RdFo0UeRjTQGNgtlG8z7WBv/2Yw08Rx1Lm4crpwynmYMEqc
 MLrESykFD4BeWYLTek1xGMkzT81AwKk=
X-Google-Smtp-Source: ABdhPJxz177DVt1m/X7rhRn48vnS3jZFulP/aFfQV6kDeZXeXb0MNVCvKbmbvRqznuLUjldCnZ/gvA==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr33431290wmc.140.1593697027743; 
 Thu, 02 Jul 2020 06:37:07 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p17sm10190511wma.47.2020.07.02.06.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 06:37:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] MIPS patches queue for 5.1 soft freeze
Date: Thu,  2 Jul 2020 15:36:56 +0200
Message-Id: <20200702133701.25237-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>, Yunqiang Su <ysu@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series contains the current MIPS patch queue:
- Remove unused/unbuilt device (unfortunately the machine won't be
  merged in time for the 5.1 release)
- Trivial fix for LP bug #1885718
- Urgent removal of inactive maintainers
- Huacai Chen and Jiaxun Yang designated as new maintainers

If nothing new appears, I plan to send the pull request during the
week-end.

Regards,

Phil.

Aleksandar Markovic (4):
  target/mips: Remove identical if/else branches
  MAINTAINERS: Adjust MIPS maintainership (remove Aurelien Jarno)
  MAINTAINERS: Adjust MIPS maintainership (remove Paul Burton)
  MAINTAINERS: Adjust MIPS maintainership (Add Huacai Chen & Jiaxun
    Yang)

Philippe Mathieu-Daudé (1):
  Revert "hw/intc: Add Loongson LIOINTC support"

 hw/intc/loongson_liointc.c | 242 -------------------------------------
 target/mips/cp0_helper.c   |   9 +-
 MAINTAINERS                |  12 +-
 hw/intc/Kconfig            |   3 -
 hw/intc/Makefile.objs      |   1 -
 5 files changed, 6 insertions(+), 261 deletions(-)
 delete mode 100644 hw/intc/loongson_liointc.c

Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Yunqiang Su <ysu@wavecomp.com>

-- 
2.21.3


