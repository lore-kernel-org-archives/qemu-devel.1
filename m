Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABEAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9102220780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHsaBkJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9102220780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr645-00023B-Sb
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 16:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanbrankovic96@gmail.com>)
 id 1jr56U-0006n2-TY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:42:38 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanbrankovic96@gmail.com>)
 id 1jr56T-0001p5-FN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:42:38 -0400
Received: by mail-ej1-x643.google.com with SMTP id f12so4921754eja.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=huVk7FxdzfL0zDqPYoSR7xnTDodTmSCUmR0ti5s0N8I=;
 b=bHsaBkJ1WS7LCVimE3WhuMLRgyeQO7PAam+PSwYczht1qlIT77GQzsUWlQvlLvnsZJ
 01/zVNwmNmBB7ffCzQhuZjD1dWI/B0P7ihQp+dF9UA5xePvH9Zs97FIa8xtY9NJYTFLf
 cguPnviNcm3OMFgPsITqueT1im5Oiw0GALR0+2WYBs90hZyDQf0ETdK6VKv3j6cvsGby
 /6f5UytWft3JdYT5AHDNfiC+ignI7TMaPXJSRPTYxiq064I55F2knE7ncZpeGL0U/HBG
 TKQNNqvT9AILyanhsMTGCDucMVaWJfUVEOUVSzSmrSQo+L5rDMhN+qG/KizKibu3zM6n
 b/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=huVk7FxdzfL0zDqPYoSR7xnTDodTmSCUmR0ti5s0N8I=;
 b=aiVZqMmrQR/ux4OfGHZixplKJRiA4Wl4HcVj0YTteHz9ST0RQILigDRtitwUT9txgm
 gq+Re7Tsi3tHCMBZ2ao46Dycgk9RwUnHafYd3IBKzG6zqL3qHPXaz0PigRk4r+agVz8m
 WZNxguOm3059lbHpc38aGuUHTTkmJTuG2kTVf+AjYC2pOhzyQgSdGt4HM0qgeGbaZhyz
 XSacNAqwNWzGyTwfk2Cs/5SCwSTTtjHAWRoDUqOE9McVL2EFZrApv5/l0h5S5VVsUgqT
 dXWvS7FSb4w9DY3r2SpxR0hHP094veOqgmJp2pf7DC5YpnaNSnQMYv+0pNxHkuBfs5su
 zgUQ==
X-Gm-Message-State: AOAM530VfY787wytPECnqkAy7C1FV/5T68M6CsZUctrYY/ir9eH6wTE0
 +M4GTD/VOMoemIKhVUccHRgzBMd42A9nBg==
X-Google-Smtp-Source: ABdhPJys+uwprsqjIjBrT6dPV4woNtcAcGhOqj7JVYooUWBOZiWyZVmr/mbSqdRlwfYLebGVr7QMtw==
X-Received: by 2002:a17:906:c35a:: with SMTP id
 ci26mr13499950ejb.451.1593718955524; 
 Thu, 02 Jul 2020 12:42:35 -0700 (PDT)
Received: from localhost.localdomain (109-93-62-240.dynamic.isp.telekom.rs.
 [109.93.62.240])
 by smtp.gmail.com with ESMTPSA id u60sm10775736edc.59.2020.07.02.12.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 12:42:35 -0700 (PDT)
From: Stefan Brankovic <stefanbrankovic96@gmail.com>
X-Google-Original-From: Stefan Brankovic <stefan.brankovic@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] Add Loongson 2F disassembler
Date: Thu,  2 Jul 2020 21:42:29 +0200
Message-Id: <20200702194230.10769-1-stefan.brankovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=stefanbrankovic96@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 02 Jul 2020 16:42:26 -0400
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
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 stefan.brankovic@syrmia.com, aleksandar.rikalo@syrmia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds disassembler for Loongson 2F instruction set.

Stefan Brankovic (1):
  disas: mips: Add Loongson 2F disassembler

 MAINTAINERS             |    1 +
 configure               |    1 +
 disas/Makefile.objs     |    1 +
 disas/loongson2f.cpp    | 8134 +++++++++++++++++++++++++++++++++++++++
 disas/loongson2f.h      | 2542 ++++++++++++
 include/disas/dis-asm.h |    1 +
 include/exec/poison.h   |    1 +
 target/mips/cpu.c       |    4 +
 8 files changed, 10685 insertions(+)
 create mode 100644 disas/loongson2f.cpp
 create mode 100644 disas/loongson2f.h

-- 
2.17.1


