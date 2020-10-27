Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A0EC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29E220747
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJJHCxFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29E220747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXEJ2-0003bp-87
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 22:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kXEGr-0002PK-6f
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 21:59:34 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36]:45420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kXEGo-0000zJ-Lv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 21:59:32 -0400
Received: by mail-qv1-xf36.google.com with SMTP id w5so5334858qvn.12
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 18:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=P73OfQ/GabEbetkpZWCyqL1d/D+m78Hvu8J2m1tjPOU=;
 b=FJJHCxFZ5q7OJ5/uMgu/JxtkzMwjMRkwqCq020VzCzd0HoU9bXyxFbhpnKae8iUIrh
 bgitjZHZX6nShY4K+BcD6cZKMGBc6Yo2CqdZcxQ4KF9GrWNTFzde4cUmP9usNnjJTrQk
 giPZJtvcdL+wSvv/+nB2q2yU/aZmxueWYt+Ps7eWPmYuytbtEoI6s/0I6BUlMU3Vfjnw
 1MGM2u++O8uCkollIbyb7wufu/BzNOyms4F+rnGauqLYt0yT0kJo6drNyJzI2FE+Sr9c
 5Vz/OjyPZwcnu8r1kV0pYOvpc2BZxQuItyZgvOm5NdCLMBBhCwFw+kgOjweA/M/nvQeI
 WVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=P73OfQ/GabEbetkpZWCyqL1d/D+m78Hvu8J2m1tjPOU=;
 b=oCztqruVXRrKWYmsQ/NMzi0wz1IviwHUMhbxnG4YAV1PdcIC85SzF3SPS8J468ijlZ
 NtwlBBNEE7EENGmJ/4jQ45aEylzvbBDM+4DWecw/7WUa3paLLpdDB1SnqTkrVu+GRWbJ
 N31/FbTDy6qZoDW2kM+U4vc1CxE8HQHhRlnWo66m9PpghrFeBp9iX4AEJafS2h5c+wjC
 6CtI4yL0P4sUl0yDf4UWg8bcqH4KC6CSQxmFFATzft9j7bFUZ1XAqhaXvqfMS44zgfnE
 fwsiic0B3rVf9FI/qHcHqQUhcOBPw8XfxLrLleFITYbfoRTKD3qMAq/9HnmXztZfd5CC
 a+og==
X-Gm-Message-State: AOAM531HtqQ7Oo2d/+Coe1YFNknqQqHf4eJwk5A2vAoi31CPyST8qeCa
 mnpHEsRo3u+nPuSW+UXUaouvwQ==
X-Google-Smtp-Source: ABdhPJy699jopClTon+3yj7Lj3Aa2M9fGNVibGrpBOorGYgXXco73L9Iye/Cv4E9AWVYtwIpMbp6tA==
X-Received: by 2002:a0c:dd14:: with SMTP id u20mr31526qvk.56.1603763969259;
 Mon, 26 Oct 2020 18:59:29 -0700 (PDT)
Received: from localhost.localdomain ([142.114.143.244])
 by smtp.googlemail.com with ESMTPSA id 61sm19317qta.19.2020.10.26.18.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 18:59:28 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v8 0/2] Add watchdog support for SbsaQemu
Date: Mon, 26 Oct 2020 21:59:25 -0400
Message-Id: <20201027015927.29495-1-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qv1-xf36.google.com
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds watchdog timer support for SbsaQemu platform.

The watchdog timer has been implemented first based on the generic
watchdog timer specifications from ARM SBSA v6.0 and then used 
in the SbsaQemu reference platform

Changes in v8:
- cleared irq also along with ws0 clear on each explicit refresh
- addressed additional review comments

Shashi Mallela (2):
  hw/watchdog: Implement SBSA watchdog device
  hw/arm/sbsa-ref: add SBSA watchdog device

 hw/arm/Kconfig                  |   1 +
 hw/arm/sbsa-ref.c               |  23 +++
 hw/watchdog/Kconfig             |   3 +
 hw/watchdog/meson.build         |   1 +
 hw/watchdog/sbsa_gwdt.c         | 293 ++++++++++++++++++++++++++++++++
 include/hw/watchdog/sbsa_gwdt.h |  79 +++++++++
 6 files changed, 400 insertions(+)
 create mode 100644 hw/watchdog/sbsa_gwdt.c
 create mode 100644 include/hw/watchdog/sbsa_gwdt.h

-- 
2.18.4


