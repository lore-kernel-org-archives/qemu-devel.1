Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9CDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 07:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651EE20723
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 07:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651EE20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jewKE-0005iO-K6
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 03:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jewJS-0004bc-1S
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:53:50 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jewJP-0006nk-N0
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:53:49 -0400
Received: by mail-wr1-f42.google.com with SMTP id x14so6426596wrp.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 00:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D0KOYljSS9kXDgLS9iP8mVId835WQfcnxh34huoPrEo=;
 b=M3fPVvXzvgKhEUvrH9S8EZXmuShn9svAc2uRDWwzRe8Tap3kvGfIn1T1horNZiCqh4
 I41mmNwURCBHWogMzn5W8F9N9UMEv8zOWQgCHdKRR6cGabhATvl8f9QClFmtD58ebQto
 f97YcfNqIQpvuUArraceVas7IsnUYCuBbMVJjNx9lwPbz1xcUr4IxLGpmyocY20/dy5J
 6PUTh4APXiE2NanPnQZuMOf78Y88kdQ90k9xm7NGjwBCpOrIBpCnEMUhUUZ8KEED2miU
 +IFt0Svo2nriZLv/JEW6Y5yQfJm567LM0cHY6cW4Vbl4A71te0pKncD2fwqBkSe9sqg+
 zDcg==
X-Gm-Message-State: AOAM531Yw7EaA7HmwFMB6ESl5MDaGCWNPxEoDhZqAlRpHTLY3oXto9Q0
 gRBY1C6jW0wxlm+IdTh5EAkPzkts
X-Google-Smtp-Source: ABdhPJzqhI47juKZ6fOsd7cKACJt9vbvPu466OUydKtZxtbBpwN/tKq2afgbi/OcXBiK/13dhw89zA==
X-Received: by 2002:adf:fb92:: with SMTP id a18mr6499355wrr.263.1590825225506; 
 Sat, 30 May 2020 00:53:45 -0700 (PDT)
Received: from localhost.localdomain (x590fef72.dyn.telefonica.de.
 [89.15.239.114])
 by smtp.gmail.com with ESMTPSA id o20sm13139310wra.29.2020.05.30.00.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 00:53:44 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/2] m68k coldfire machine cleanup patches
Date: Sat, 30 May 2020 09:53:18 +0200
Message-Id: <20200530075320.18854-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.221.42; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f42.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 03:53:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit c86274bc2e34295764fb44c2aef3cf29623f9b4b:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-tcg-plugins-270520-1' into staging (2020-05-29 17:41:45 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-05-30

for you to fetch changes up to b809667808b1f742a85d6cce0d77800be20bcaa0:

  hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask() (2020-05-30 09:17:46 +0200)

----------------------------------------------------------------
* Replace hw_error() with qemu_log_mask() in the m68k coldfire machine code
----------------------------------------------------------------

Philippe Mathieu-Daudé (2):
      hw/m68k/mcf5206: Reduce m5206_mbar_read/write() offset arg to 16-bit
      hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()

 hw/m68k/mcf5206.c  | 14 +++++++++-----
 hw/m68k/mcf5208.c  | 16 ++++++++++------
 hw/m68k/mcf_intc.c | 10 +++++++---
 hw/net/mcf_fec.c   |  9 ++++++---
 4 files changed, 32 insertions(+), 17 deletions(-)

