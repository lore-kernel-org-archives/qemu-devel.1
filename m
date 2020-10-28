Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2501AC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993E9208C7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYlZlm9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993E9208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXd9c-0000MP-N1
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 00:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kXcwv-0003Z4-Cj
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 00:20:37 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:34591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kXcwt-00083M-Jy
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 00:20:36 -0400
Received: by mail-pj1-x1043.google.com with SMTP id i3so852124pju.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6Vj7rJ1HbGvjo2klZQHezr8aeMv8wuLNCnIvPj2MkoI=;
 b=DYlZlm9zvvdTHTn6hCOuiSokSvZA1RNhqwuamEq37BgYpp4/txOeG19hCPw4QKkqMI
 Oc5zAxi8rgeqmV+M22nn3TG2bEx4jVyV/HJcRlbmlJaCk3j8ok32+tnxuOHS8uT79BGa
 ukbXZTXEagBb48hIvEjMg0xSmJ5zq+utmtJfiHmFU+0HfOxVeavug2r9Govg7INxtzC+
 9yQBqR2h7z04h0ba7HrQsyWIr0MMTK64Gp3pGtVInCRgRBby3hpaRNlboLDZM6jPvC70
 c7EmrUe1HRIHC++KdLCQK/1lqOQLEITtwphfCANnPpeeR4rZd2B9OnTHQZ8RI1JMriru
 u4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6Vj7rJ1HbGvjo2klZQHezr8aeMv8wuLNCnIvPj2MkoI=;
 b=nrJrB4AYRVsqcoJRpGPv7Y7x0rtwYfs9OI0ci+gVLJzxkuFjgXZFwYBDrBUPGACpu4
 ZgW2rxDL5OiCYmUUNwSPgTdflxYCVNlcxDmegXkwSn6suYucBYFJs1Aa/TT79ETIfsJr
 SgBWnjSGmUM/bynWSiJRp2gYXmt5AlLF+7EkbThZkaq3BFf4M2Xkb60rOFAopkvjyGLk
 PWcM1dyin3PDNNlGcYE6YzUsDx0UCz96I+aeOph49Sqf2ArL6dt9H4y/V9FMW7kA0th+
 ECncgIKh6LXgT35QwQf2DMB4qvFqN2CAzl3T0jCPnYrcoX92uxSR4va3eNotdeZz0/kT
 Gyaw==
X-Gm-Message-State: AOAM530CnMtVwg55DnhMc31AfVDCCUbYDUCmvVNTW3Z416t5uReYHFvz
 fm46ljPlORN5iBwe/3/Yh6s=
X-Google-Smtp-Source: ABdhPJyvy/xnbgAIiyB9+pwKW/W3R3odnbhj+vJ4+GHka0nE/s2enF+GaSrNJ0qnIeKAqaFfjwBZzA==
X-Received: by 2002:a17:90a:c207:: with SMTP id
 e7mr3594002pjt.161.1603858834226; 
 Tue, 27 Oct 2020 21:20:34 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id x10sm3882040pfc.88.2020.10.27.21.20.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 21:20:33 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V15 6/6] docs/system: Update MIPS machine documentation
Date: Wed, 28 Oct 2020 12:18:04 +0800
Message-Id: <1603858685-30701-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603858685-30701-1-git-send-email-chenhc@lemote.com>
References: <1603858685-30701-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update MIPS machine documentation to add Loongson-3 based machine description.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 docs/system/target-mips.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index cd2a931..138441b 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -84,6 +84,16 @@ The Fuloong 2E emulation supports:
 
 -  RTL8139D as a network card chipset
 
+The Loongson-3 virtual platform emulation supports:
+
+-  Loongson 3A CPU
+
+-  LIOINTC as interrupt controller
+
+-  GPEX and virtio as peripheral devices
+
+-  Both KVM and TCG supported
+
 The mipssim pseudo board emulation provides an environment similar to
 what the proprietary MIPS emulator uses for running Linux. It supports:
 
-- 
2.7.0


