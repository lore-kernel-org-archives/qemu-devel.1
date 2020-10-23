Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5634BC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A92207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1lxkclY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A92207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwzO-0000lE-2f
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVwxT-0007dI-Rh; Fri, 23 Oct 2020 09:18:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVwxR-0000aX-GZ; Fri, 23 Oct 2020 09:18:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so1789308wrv.7;
 Fri, 23 Oct 2020 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KBftcnpB/jWrS0FnkiFyxJZ5PfPjWOrMwtuUTLLDkAU=;
 b=s1lxkclYSfPk3vx4jbe/OQbocZB3NkFebouO74IO0UkuzGSMywsdU09Frw7HUzkRLv
 7A+hDMbTCGtyo1x5ZaSt59T+CMhaGmzdhwHMN6/JmAr9p7uTrIVANWgRpU+cTJbrHySE
 ztRqoFcY/ioWGqyGgQYhLJKHQRADSt30eoCdDbj0VUkyOTs7D5gHF64JGtPSW8qAf+VW
 kvwKxX+eXdDjfMLLZFcegMkjmy1VFadyujufACZYOyT+f2hKorO3BYfUR41ZW/mDnitQ
 70WUe4BTdnLPczl1/ffU3PYaiSTYDQClC8WsznmOdKYRMdGn+jVFrT6TSufBaXKHxTfw
 gUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=KBftcnpB/jWrS0FnkiFyxJZ5PfPjWOrMwtuUTLLDkAU=;
 b=VD/N2An+CbRkmGQ7+zO5Ob17yVKmLkMiPAHtsVt5ko58LXTudmlKNf91gYAaoqC+gv
 ILIEVWEqXuebw65a+KKQvlyVBLJnK06P12yM2SyxZGDg1MAUcZBjPXaqad5aPoKi6Z26
 xwLB2+vKd75GILnNNgCN8NiG0ZwCzfb7CQcSOK1QnqFEHoMFU4jotRx8ptFIYC1CaOSo
 pVholdnseHuoGoATlCZ26644x9FsOkWcEHTZiMNeMCEE96MZGaA+RLCgV915tnr+iSEs
 J1tne+SjA0NdEDvWfsXBE52yC7W/9AoCDrG1/SqOuTWyXE6PALxehaIvf2P+dPrBbmPG
 kHXA==
X-Gm-Message-State: AOAM531F7KS3ZHJ8Ck2uSnOowJx+ReCa/zz7PFM+DUoDWVpY+qUH1/0K
 rJ1bKxl18uD09odlP8olUacjO6OCu74=
X-Google-Smtp-Source: ABdhPJz99c3lU0YDNSnnZsdN9fK6UBk5Nc+ZvOpEEt/Zl569Lsd7WSEfS7pbpxP2foNcsd++ysw8Rg==
X-Received: by 2002:adf:ea4d:: with SMTP id j13mr2649826wrn.345.1603459091286; 
 Fri, 23 Oct 2020 06:18:11 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c18sm3396032wrq.5.2020.10.23.06.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 06:18:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
Date: Fri, 23 Oct 2020 15:18:04 +0200
Message-Id: <20201023131808.3198005-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Series meant to help Bin Meng to debug the SD card issue=0D
reported by Michael Roth.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (4):=0D
  Revert "hw/sd: Fix incorrect populated function switch status data=0D
    structure"=0D
  tests/acceptance: Allow running Orange Pi test using cached artifacts=0D
  tests/acceptance: Extract do_test_arm_orangepi_armbian_uboot() method=0D
  tests/acceptance: Test U-Boot/Linux from Armbian 20.08 on Orange Pi PC=0D
=0D
 hw/sd/sd.c                             |  3 +-=0D
 tests/acceptance/boot_linux_console.py | 68 +++++++++++++++++++-------=0D
 2 files changed, 50 insertions(+), 21 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

