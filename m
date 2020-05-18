Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C32C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963E6207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+c5Hz/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963E6207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jagNC-0005Ob-OF
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 10:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jagMN-00045t-Od; Mon, 18 May 2020 10:03:15 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jagMM-00018T-63; Mon, 18 May 2020 10:03:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id m185so5690294wme.3;
 Mon, 18 May 2020 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vfnYOQleJQ6IdyBYvfI24RwcBQWp/agghDF79thh7b4=;
 b=g+c5Hz/pQuLeXvRxlsm+c6ul3Cq+rs+dR3r4d6YCdyyDU0MnlKI0txWzzn8fnoiXlQ
 Tl86scie3/Sf8Rq2fxV78KMe8tahnGnWDRskDjj+Eh3i83HCPVx/FmUnhjd/49km33iM
 mnUWUJ35rg7qJkukGIJO91YKgRiRZ3sySWe+eI5FR5VY91JHlircUXTPYUNeW1VlguQ2
 0HcVnPWVQRclcpzGL8/HrL0iPdHH2DNEr6TdD+Ls7LDIURTSs87Paro2rMGYp5emnb0P
 HYDW/hWVzzRIKrNsXu+QoATjKHP0zDwUad/v6MqvkAstpc0OVLk8IVB9/SxF6Y6/6isW
 HDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=vfnYOQleJQ6IdyBYvfI24RwcBQWp/agghDF79thh7b4=;
 b=YxYZ+BQEhRTHU9CBlI4RzKi7u3mopsuEFedK91JmmFYq3GKhu8y4TghckymddGWxnr
 EWiazE5X4EBGL/6ACMFAAfsrBV+Imlx74oHNOP6nm+4NZbES+5leEku5L4IpT3twOUS9
 yx12kE5cEQ8w9M+dNq2n9b0cDRXKxRwGocjJlUeljAgAAnK3+bewdZarX+wBWB8xD2pQ
 rp2/S35rug6rcciVcYuUKgniLkG+JerdTjEb3Oh64VnEaEcpdqOo49o5pa4GwV+SlGij
 DqF8KnElABc5hTIZDN0Yli0m9zhzWTeNjRfd0ElZF4O8V/RH14jLrcnbtfatyPJSISwz
 mDuQ==
X-Gm-Message-State: AOAM530wBJRHyQMPaU6avasx3/uQmwjLlVpuHRMxmjs9VVz4JEfAo9iS
 3kfPe6h8ww7EbB89gLMJ0a+qaDtU+10=
X-Google-Smtp-Source: ABdhPJwppm43qMlZdeyXHPyIg1cAg01ujTAlG0iaAdVPzrPlB+WHjITUKjfYJ8I2Bc9Z9qNpG7DbXQ==
X-Received: by 2002:a05:600c:1403:: with SMTP id
 g3mr20554009wmi.51.1589810591816; 
 Mon, 18 May 2020 07:03:11 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s67sm16611946wmf.3.2020.05.18.07.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 07:03:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] hw/arm: Replace hw_error() by qemu_log_mask()
Date: Mon, 18 May 2020 16:03:05 +0200
Message-Id: <20200518140309.5220-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When fuzzing the devices, we don't want the whole process to
exit calling hw_error().
Replace these calls by qemu_log_mask LOG_GUEST_ERROR/LOG_UNIMP
when possible.

Since v1: Fixed uninitialized variable

Philippe Mathieu-Daudé (4):
  hw/arm/integratorcp: Replace hw_error() by qemu_log_mask()
  hw/arm/pxa2xx: Replace hw_error() by qemu_log_mask()
  hw/char/xilinx_uartlite: Replace hw_error() by qemu_log_mask()
  hw/timer/exynos4210_mct: Replace hw_error() by qemu_log_mask()

 hw/arm/integratorcp.c     | 23 +++++++++++++++--------
 hw/arm/pxa2xx_gpio.c      |  7 ++++---
 hw/char/xilinx_uartlite.c |  5 +++--
 hw/display/pxa2xx_lcd.c   |  8 +++++---
 hw/dma/pxa2xx_dma.c       | 14 +++++++++-----
 hw/timer/exynos4210_mct.c | 12 +++++-------
 6 files changed, 41 insertions(+), 28 deletions(-)

-- 
2.21.3


