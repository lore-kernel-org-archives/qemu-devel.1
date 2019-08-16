Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF273C3A59E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5AE2133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnqjF3Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5AE2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyc0M-0000JO-FZ
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hybzF-0007is-7f
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hybzE-00007A-6n
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:09:45 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hybzE-00006c-1h; Fri, 16 Aug 2019 09:09:44 -0400
Received: by mail-pl1-x643.google.com with SMTP id 4so2433278pld.10;
 Fri, 16 Aug 2019 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=88KEde7YkVoVNSoBTtcGhqy65Ps/dUdsNvg15v2sUCA=;
 b=NnqjF3Q74eLrIm4RdfOIXN35/xk7hdhJsm7ti11HbmaOvTrrsLymFFNdjilwpY6k+j
 KWZ24TFUxv3FtJO/b99eYFD08hx/NPrAOUNANisuyipkwHFGz+aVCWa5iX47oxV/rYEo
 uIC2BrR/xZlQbrfs4dXZoOODJzJwnDJueU6zhCcm0RKMyzfy74rrQhN0ZrAh0K4UU+lp
 wsL9JvocFAv1CqAix/AnbkJ9oqA1fg3oRnhpHTcyfdrdaspamRehoA06zNdZ8iYveBIH
 Q8rAj7MOZSCaC8PkLajpk3UKVqPZL0b1vhZjHfDCw3efwhmqjvveIK1Kr1DZgYoAYjRw
 zPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=88KEde7YkVoVNSoBTtcGhqy65Ps/dUdsNvg15v2sUCA=;
 b=Ztp9OTjZ7uFV0PglN9ykpYInSxNGw2mNsblIRgX2Mq3Ymmz1wHJB8YgFmsrZoXkUBC
 fJ1TN5BEG67zGKWrrFpcAdrNJ2B13Lfw+MAkoed/LxazSPKyd0XqSRrG6VtYfLEUnE2Y
 UpcTUOJImtM9YbmMTy2fVrM8SH2vSRQiwz15aABkcHw/LuWm4uUWFbO3TgKXiKRLPqR/
 MWtFyBx9IWBfRQS998q3EcX4NklobY4lzkhMQDk1/hohjGCEFi6CHQ7aWU6Z7TvPjXQO
 vXUrG/u78fXOMV82fibblskFxm4srnCH+irtVtdLJ7c1IPeH83kBD9132T4y6GI9+9I6
 aMlw==
X-Gm-Message-State: APjAAAVw8v+CyXtAV/g3sloqI6MSUIsqy6J6yK99ed89Jg8RxXMb/Y0C
 iiJzaeAQbaISnls6kMGzaew=
X-Google-Smtp-Source: APXvYqwbFMEtJmMGCNHNkM78/istep6+PAbtdlgjiUwdLvYLPmi2hjNElomwjrNTKJU5oWF9gukl2A==
X-Received: by 2002:a17:902:9689:: with SMTP id
 n9mr9371698plp.241.1565960982650; 
 Fri, 16 Aug 2019 06:09:42 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id t7sm6122743pfh.101.2019.08.16.06.09.41
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 16 Aug 2019 06:09:41 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri, 16 Aug 2019 06:09:34 -0700
Message-Id: <1565960976-6693-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH 0/2] riscv: Fix "-L" not working for bios image
 search path
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently when QEMU is given a bios image with only a file name and
its file path passed in "-L", it still reports file not found.

This series fixes the issue. This is especially helpful for creating
distro QEMU packages.


Bin Meng (2):
  riscv: Add a helper routine for finding firmware
  riscv: Resolve full path of the given bios image

 hw/riscv/boot.c         | 26 +++++++++++++++++---------
 include/hw/riscv/boot.h |  1 +
 2 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.7.4


