Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1413C3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5252087F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFrpcICa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5252087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8S2Z-0006zU-Eh
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 12:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j8S1P-0005qc-Di
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j8S1O-0001hW-I8
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:04:55 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j8S1M-0001eZ-DC; Sun, 01 Mar 2020 12:04:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id g6so3230186plt.2;
 Sun, 01 Mar 2020 09:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=lc1bYhcnqPFlmGbgR5g3n8tVkAtrQ0yFMcwg1XhjNQ0=;
 b=ZFrpcICaWwXThfkufMdPHgSpHrfyorhQjdKSLmHNJSlewSa09bKkJDa0xCZ3RI1tbw
 qQVI+HTmF5Tmkkqg6M3jZAB+OXoAMTQxbFctpOe3mstkaDRHTiN9nnqFHs6jRYe5lKLO
 +a/p6bIsKccitkJGGgdFftx3H2ZizRRNE3iaE9W24l4PkAPtXrw4u2rq7Ha113y35AoC
 WGaMHL6BZC9OhwPl78rtzBM4pZEkTGMiRTr0W2uZEFliixuadMozibkMpTRjdyH2T2Yp
 RuENomUk4+StVIDlR2dE7aVyaYddGUbnw/MTzK6z6x8qAjT/zKZK6hnHtO+LtoEC/JWb
 rQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=lc1bYhcnqPFlmGbgR5g3n8tVkAtrQ0yFMcwg1XhjNQ0=;
 b=qILtqOA2dKVjPGkBBYouckqWRVskHgw6oep9jaH/ytJzfizmoTY7QbEIxKhKjKFOBa
 yhDBfdvD2bPDe5cOwLR+nU/zGR2FRE2d+8C0EUhKl+GuB/hVzXhnbP4FJTKBJPr9Ueaq
 c6J1qIHCNfS+3/OvK9CbxZw3O60xnZmD8ubx4fsE91P/QcmH7IKsX9eNFOApPPuoPJRz
 iHKLtdvmPRWFwEp5CzIU9cu9rCCHCNJxaonKv8y1elSOoSrirl0+equHrHwRfyJHDyWL
 wXOBVYnYM+MiMV3nPnpxvzjczuczOoSblpZFa9nztheq4cCsH6Aeuqvl0YBiurRE2Dx9
 r5KA==
X-Gm-Message-State: APjAAAV9L08978BaxcmFZb6iLc/0M6VLJj29pF+EdeEje1RL+NmuPpI3
 tV5yA23n6oXVhEO/wpEzYSE=
X-Google-Smtp-Source: APXvYqz18YfqhuaSUVg2FbqUBrLAUBRZc/gjCG8MLhGufEcqPzplD84sKzK1dDoExs35aNd+y/Fvnw==
X-Received: by 2002:a17:902:7046:: with SMTP id
 h6mr13075808plt.231.1583082290624; 
 Sun, 01 Mar 2020 09:04:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id y5sm17791710pfr.169.2020.03.01.09.04.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 01 Mar 2020 09:04:49 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/3] Wire up USB controllers on fsl-imx6 and fsl-imx6ul
Date: Sun,  1 Mar 2020 09:04:40 -0800
Message-Id: <20200301170443.12904-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series wires up the USB controllers on fsl-imx6 and fsl-imx6ul
emulations.

The first patch is a prerequisite for the following patches. It provides
a dummy implementation of a register widely used on i.MX systems, and
specifically the reset behavior of this register. This is needed to make
the USB ports operational without full implementation of an emulation
of its PHY controller.

----------------------------------------------------------------
Guenter Roeck (3):
      Add dummy i.MXS STMP register support
      arm: fsl-imx6ul: Wire up USB controllers
      hw/arm/fsl-imx6: Wire up USB controllers

 hw/arm/Kconfig              |   3 ++
 hw/arm/fsl-imx6.c           |  36 +++++++++++++
 hw/arm/fsl-imx6ul.c         |  35 +++++++++++++
 hw/misc/Kconfig             |   3 ++
 hw/misc/Makefile.objs       |   1 +
 hw/misc/stmp.c              | 121 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx6.h   |   3 ++
 include/hw/arm/fsl-imx6ul.h |   7 +++
 include/hw/misc/stmp.h      |  47 +++++++++++++++++
 9 files changed, 256 insertions(+)
 create mode 100644 hw/misc/stmp.c
 create mode 100644 include/hw/misc/stmp.h

