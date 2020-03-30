Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316F1C2D0E5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CB320771
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q78pbU9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CB320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIucJ-00062A-3A
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub0-0004Om-Sj
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIuaz-00015a-PV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:55505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIuaz-000124-Jk
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id r16so2131404wmg.5
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PufYnFFWvOEHwXvQUfb/F/julwZceuJ2l9pvYd7Xy3Q=;
 b=Q78pbU9YMNlGvhXOjwymFKsjKD4h066c24iqKyuDWpEgtPQpUZvR171LWMoMd1ADz9
 OGpv+bJESLZIG1BlN8aNAXks8JX6modBO7bbp56FrNYAr1ZDs2Gf6U2P3tfxIh2vC/jB
 UZDByl/OFZKXMuORKrRZ7qq76OTWGDMcgt7ywzD3g489QQEjCBLHiGyvYROkczWJJNkb
 8SFNSc2RZLWD1WTpPtFmdoZoYXBp9NkZOWHmuKmWa4cH6ol9CzXGZFuSlSHeIw0Yrq+B
 kNXAjLbADJG0IDgTxsRc92ue7ZqT4VCqwMfymx7/Vf6zgemS3y8xYkeLHsxlV0+EAJht
 2ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PufYnFFWvOEHwXvQUfb/F/julwZceuJ2l9pvYd7Xy3Q=;
 b=A+RXOn0xoInyLWaAt8Pr9oakvKYzRKs9jx/7BZNcZkZwRcA+Yq1uOQugp23gYCumCr
 0p/eH9aRVBW69G6r7nvHL7XVvJvvBX5w8cN3OOYYSgmZuxiZw6pPVh/7AGj0NN//tZka
 1b6Ibp9tOJXey+NWNgm10fCaJdJ/aTTW7giu3r7lDIvywELj3LdUBy9HOmU8Ex90bILs
 otf8q+ajdQiwAo1moCwQjSoXWUP2xyfZouen8ztqYyzHZdhp7MbZeO3aJuTeh5uQxDqG
 JU2nNioTyVO35qHG1NBzXo+2yZW8zmv2wk2mDK2hD5OnInmOx3g83/DmIOA5UG5LYxU2
 O+QA==
X-Gm-Message-State: ANhLgQ1BFlqdORM7TcADwkX4fQQ+5cYr0Lm+x0zf0ncwKyOghmO90tqV
 0WpWrKR/FYFqXYj/d48JdXO8hJs2rvohuA==
X-Google-Smtp-Source: ADFU+vsyv/kA4+QoMn2wbFEhuqkfUsqDYv3YgOIP98INz0UpNrjXxtDT0dA4NFDEu47mstjeW1vWeQ==
X-Received: by 2002:a1c:197:: with SMTP id 145mr12881447wmb.42.1585575410450; 
 Mon, 30 Mar 2020 06:36:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o14sm20756504wmh.22.2020.03.30.06.36.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:36:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] target-arm queue
Date: Mon, 30 Mar 2020 14:36:42 +0100
Message-Id: <20200330133648.22297-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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

A handful of bugfixes before rc1 tomorrow...

thanks
-- PMM

The following changes since commit f9fe8450fa7cdc6268e05c93fa258f583f4514b7:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging (2020-03-30 11:32:01 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200330

for you to fetch changes up to 88828bf133b64b7a860c166af3423ef1a47c5d3b:

  target/arm: fix incorrect current EL bug in aarch32 exception emulation (2020-03-30 13:55:32 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/orangepi: check for potential NULL pointer when calling blk_is_available
 * hw/misc/allwinner-h3-dramc: enforce 64-bit multiply when calculating row mirror address
 * docs/conf.py: Raise ConfigError for bad Sphinx Python version
 * hw/arm/xlnx-zynqmp.c: Avoid memory leak in error-return path
 * hw/arm/xlnx-zynqmp.c: Add missing error-propagation code
 * target/arm: fix incorrect current EL bug in aarch32 exception emulation

----------------------------------------------------------------
Changbin Du (1):
      target/arm: fix incorrect current EL bug in aarch32 exception emulation

Niek Linnenbank (2):
      hw/arm/orangepi: check for potential NULL pointer when calling blk_is_available
      hw/misc/allwinner-h3-dramc: enforce 64-bit multiply when calculating row mirror address

Peter Maydell (3):
      docs/conf.py: Raise ConfigError for bad Sphinx Python version
      hw/arm/xlnx-zynqmp.c: Avoid memory leak in error-return path
      hw/arm/xlnx-zynqmp.c: Add missing error-propagation code

 hw/arm/orangepi.c            |  2 +-
 hw/arm/xlnx-zynqmp.c         | 27 ++++++++++++++++++++++++++-
 hw/misc/allwinner-h3-dramc.c |  4 ++--
 target/arm/helper.c          |  5 ++++-
 docs/conf.py                 |  9 +++++----
 5 files changed, 38 insertions(+), 9 deletions(-)

