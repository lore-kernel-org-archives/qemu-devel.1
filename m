Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4DEC2D0A7
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523DA2168B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzFtJ9Jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523DA2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHdmo-0003cT-Ao
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 22:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHdm0-00022z-Uf
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:59:16 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:36633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHdly-0008Dt-Se
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:59:16 -0400
Received: by mail-oo1-xc44.google.com with SMTP id z1so3653536ooj.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 18:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6tHekglYjasZ86EUN324pMbjyG2rOQ3Gf9/N7yHoJW4=;
 b=OzFtJ9Jy318wFVA6jAQWH+RD2dk9C3umZiGs0igE5Ch7k6/ZAos4o4OOWnOSX6nLne
 FWO7Et1joOw8yTLKSS2a4vgN8Xz0gnsLoru03RicpB4gvM/bbmlaKg4G+lAKM47RtPI+
 Nd2OzsJebsyat7sTgaCQpvwnGXrgRqh7oS/IBSg1jZHsUyjvdyGF+13bPm1voGYGX4FP
 PQoRS7xNCWIZfkDJxIUOaJHSJi7W/eFdTtmpNz4b2D1VOW3BCVaWyBjvbkGDmsv4Yb21
 HQtKWvrwyTTlVDV7v0nI41q22Sma/iYCvV5PCUx3HVp79/M37kLiZrA3w1v+noOxWXV8
 /uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=6tHekglYjasZ86EUN324pMbjyG2rOQ3Gf9/N7yHoJW4=;
 b=HIvYIyGG4BOaaRe1q3BEoUdS4pZH5mIvIiB13RXtJZhauEgHUXTvhIYYrZkwcrBzST
 LivM+G2tCmGUVvfHP8cb0AU5pGL0Wf/vX7vtdluxukEWPJP0Y+gzt1cHt7om9KMyoJcC
 3+W8wzkZGPBgQN7/2hVt2FW4r23A49WxFfVfkWwqW2mVwCIONtgLI5NwwjHz/vv4RT+L
 FTLBETNzhYAeZo4NGGgtzTdyhaPc+qgk1g8UuhJ19WYE2NdL0fXfPEQG0c8hUiy76wa9
 kmNFopsO8Ai6qRuPTRHit6c9H8I85mTksZoAc71fSr8WsKeBkpdGPdjmCNwEH1QCv3lk
 DfqA==
X-Gm-Message-State: AOAM532kIkFv+9CbYXqdTZm2JuBEjDRWZnprZ/VWqnbBBZO3BQAQZH6l
 9OSFV6gkmJUhMVC0UxY7WrzunHODCl8=
X-Google-Smtp-Source: ABdhPJxYRiMH3ymU7XzI3F1keB93a/yLqOoEnWtguMVGBN3qp3a+y7dBeRVjeNL8qG/6Jc8DDMPXLA==
X-Received: by 2002:a4a:9833:: with SMTP id y48mr8959400ooi.73.1600048752857; 
 Sun, 13 Sep 2020 18:59:12 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id v12sm2385186otn.6.2020.09.13.18.59.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 13 Sep 2020 18:59:11 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] qemu-ga patch queue
Date: Sun, 13 Sep 2020 20:58:58 -0500
Message-Id: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c47edb8dda0660180f86df4defae2a1f60e345db:

  Merge remote-tracking branch 'remotes/berrange-gitlab/tags/crypt-perf-pull-request' into staging (2020-09-12 21:17:22 +0100)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2020-09-12-tag

for you to fetch changes up to 2e4211cee49a666bf0e333011689b0981025879e:

  qga: add command guest-get-devices for reporting VirtIO devices (2020-09-12 20:37:48 -0500)

----------------------------------------------------------------
patch queue for qemu-ga

* add guest-get-devices for reporting virtio devices (w32-only)
* extend guest-get-fsinfo to support non-PCI virtio disk controllers

* NOTE: qemu-ga w32 build currently broken, fixed with pending patch:
    "meson: fix MSI rule"
  w32 tested with patch applied.

----------------------------------------------------------------
Thomas Huth (3):
      qga/commands-posix: Rework build_guest_fsinfo_for_real_device() function
      qga/commands-posix: Move the udev code from the pci to the generic function
      qga/commands-posix: Support fsinfo for non-PCI virtio devices, too

Tomáš Golembiovský (1):
      qga: add command guest-get-devices for reporting VirtIO devices

 qga/commands-posix.c | 166 ++++++++++++++++++++++++++++------------
 qga/commands-win32.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 qga/qapi-schema.json |  51 +++++++++++++
 3 files changed, 378 insertions(+), 49 deletions(-)



