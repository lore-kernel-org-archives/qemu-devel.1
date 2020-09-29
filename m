Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2451EC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0A620848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="gXXaUSIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0A620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCBg-0000Jz-Ju
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kNCA1-0006cZ-7G
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:43:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kNC9y-0006oW-Va
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:43:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id d4so3933085wmd.5
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hCyV2VoP+/J+PVZ3ArpNT9NKpKtACsKPbdEw4weObvo=;
 b=gXXaUSIT7jEN38OqRCjIEnp+1iskFTKnH9RP/pPW5b4KP3cB3xwiQPyDsblKFLIvZ7
 3geo7aX6Q29tfsGgZ1WfWtJk9+SQiRTlTw3UVZNs5r+XlhyOyOEcqzm5afp1E4XewSI8
 4ATd1mrivgwHecdFDkhltx9/Ac1gcumVmPbPGNU7MH8TVN5jecKr53MAflCtgDof6vTS
 FjOpwUbmw6/k2fP7wsit43gKqiJ6pMvAAto5fPjlXKL/zBfoXGjeADiPGNLruj/nhPAH
 snym6tiP9SNep2TUpwGZoAohEoe/AjujUiAGz4Pfzptyw2Q93o76E6V68ZK8ge9onMcw
 tVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hCyV2VoP+/J+PVZ3ArpNT9NKpKtACsKPbdEw4weObvo=;
 b=nETl8SPT5cJwQfGbjdjoyPed6Zzq5ucu23b73AM5KeGq7akxsT994r2GLglJgd2D/v
 ukJFzxsCJ5i0DNjhLjxQH3mhHac5/Mm9+GmYGByGjTLNGC2JAacupNb7V6J0m8Lv/O7D
 W3O6ClzT3ZR7q496HTU0NAX9Qyrhs9zPGlOA9ZNX2SDs1zK3ZztP4WF8x/tF/yYqk4Mt
 9MfusNbRNGuRhPQdPf5ZqpkOmaPbG0IyyxarDff9y/vUGeebH0kPfxEjkWGW4oo5anSD
 CzThyPTvLTcWLbO5ffEYARjaWEGK9hdVBjBeg9Xm59luiRZD3JXOYuCLMFZpNft6vBFg
 5tgQ==
X-Gm-Message-State: AOAM533eyCjuAEFc6yDDnD6jS1tt6NnQ4Ejd7eqaMuhDPJT66W0Sdo9C
 5HDIeJUPPq3AoopAWWXWFHf+ng==
X-Google-Smtp-Source: ABdhPJw8XRRGlzVvUhAQ0D3Tzo5DyD7bZrqoV+l288dd0PrzDq0fLOR2YYxVgWBi5FUk+/aNPYs+Yw==
X-Received: by 2002:a1c:a988:: with SMTP id s130mr3500762wme.31.1601372577119; 
 Tue, 29 Sep 2020 02:42:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id t6sm5887797wre.30.2020.09.29.02.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 02:42:56 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH 0/2] hw/arm/sbsa-ref : small fixes to smmuv3 initialisation
Date: Tue, 29 Sep 2020 10:42:49 +0100
Message-Id: <20200929094251.151722-1-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Graeme Gregory <graeme@nuviainc.com>, peter.maydell@linaro.org,
 jamie@nuviainc.com, rad@semihalf.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, leif@nuviainc.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix two issues with the smmuv3 initialisation, first where a previous
patch had transposed an i to a 1. The second an assumption that the
IRQs allocated were meant to be unique and not 0 based.

Graeme Gregory (2):
  hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
  hw/arm/sbsa-ref : allocate IRQs for SMMUv3

 hw/arm/sbsa-ref.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.1


