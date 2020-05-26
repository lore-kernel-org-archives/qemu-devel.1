Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCBBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711A720776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ta/vaGFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711A720776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdT0P-0008Dx-Jb
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzK-0006QF-Ce; Tue, 26 May 2020 02:22:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzJ-0002SZ-G4; Tue, 26 May 2020 02:22:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id u188so2074415wmu.1;
 Mon, 25 May 2020 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=avhE6gBkKAagMNQwah93PXvXm+qCCybJNaChmafxJlE=;
 b=ta/vaGFr7PG4JnNYRXOhieU1dgVy64h71choukCvtW+fFr2AtnKo+Gt7Jpt9mo0OhQ
 KSYTa8L0AzrxafMe9wcIbrt21Fepckh/nDfE+II7zXC91yHBmnYhYzBhBZG/QQMLg7K5
 SLTvsH1FjbgwOSQRTFuOtcOCI/M1BP8w7rDCmmvIRx9z0F5b+aSblb9lhdpG10t0h7A2
 D9XX17grFIzlV3/gxeUJAnn0rBBHbmJKFfvFi45rpTitjADVEuDEvF2i7YsfDsxc2Jt0
 0uAbi851W3/7SplCjmpvMOqJvUHOKfHYe0PY6diavvpBCpprhmVl0QHG9ky0RQQK8wPU
 8E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=avhE6gBkKAagMNQwah93PXvXm+qCCybJNaChmafxJlE=;
 b=itqOWk2CB18HcpnZmrSKQHnoA8NMH9mo3OT/GhXsWvQCjcqRNtBNax0faQA4RmaOgi
 sAt+wk8nK5h1rfjnAOhYaC30W092ASofFwedOB0VZvi8NkMhsfTLRa5EiMdqSWII8Hyr
 A16tphS/vsHXPpt7tNz37LhS7W0D+227LisOGEok7OiHMKxlUEDdzHKYs17Jb54CwoPx
 AvCRONhaodXy3qrr4i9buCfMGrgjacsIkc+Tv6IBpgIH9BjgKV+G7A6lVfl6gaQZfYH5
 quysnaF9VgoI0cGMg3tcz9H6WS4oBcmCmT0gp5yrt213rwQ/IF5pVAFECAt0SdaDbNur
 ar6g==
X-Gm-Message-State: AOAM531oZqmB6JZ3g/zWahByNEpzugvHbEgJzT23Q8ygVPJA2CDp/Z/g
 Ga+zOP9dRvgdV+nM5EuVBQg=
X-Google-Smtp-Source: ABdhPJxRnCi2fEQ6pKg1wLP6+CnvMx6JrzGzy4Ey1z4LOkdKFA/aSpw9N2V/2U0/Gc3YZ0ggSsX/UQ==
X-Received: by 2002:a1c:a905:: with SMTP id s5mr6431547wme.120.1590474175000; 
 Mon, 25 May 2020 23:22:55 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:22:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 00/14] hw/display: Omnibus cleanups
Date: Tue, 26 May 2020 08:22:38 +0200
Message-Id: <20200526062252.19852-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd, for your convenience I joined all the hw/display/
patches I sent recently altogether in a series.

Regards,

Phil.

Philippe Mathieu-Daudé (14):
  hw/display/edid: Add missing 'qdev-properties.h' header
  hw/display/cg3: Convert debug printf()s to trace events
  hw/display/cirrus_vga: Convert debug printf() to trace event
  hw/display/cirrus_vga: Use qemu_log_mask(UNIMP) instead of debug
    printf
  hw/display/cirrus_vga: Use qemu_log_mask(ERROR) instead of debug
    printf
  hw/display/cirrus_vga: Convert debug printf() to trace event
  hw/display/dpcd: Fix memory region size
  hw/display/dpcd: Convert debug printf()s to trace events
  hw/display/xlnx_dp: Replace disabled DPRINTF() by error_report()
  hw/display/vmware_vga: Replace printf() calls by qemu_log_mask(ERROR)
  hw/display/vmware_vga: Let the PCI device own its I/O MemoryRegion
  hw/display/exynos4210_fimd: Use qemu_log_mask(GUEST_ERROR)
  hw/display/omap_dss: Replace fprintf() call by
    qemu_log_mask(LOG_UNIMP)
  hw/display/pxa2xx_lcd: Replace printf() call by qemu_log_mask()

 include/hw/display/edid.h    |   1 +
 hw/display/cg3.c             |  14 ++---
 hw/display/cirrus_vga.c      | 119 +++++++++++++++--------------------
 hw/display/dpcd.c            |  20 ++----
 hw/display/exynos4210_fimd.c |  46 +++++++++-----
 hw/display/omap_dss.c        |   2 +-
 hw/display/pxa2xx_lcd.c      |  26 ++++----
 hw/display/vmware_vga.c      |  18 ++++--
 hw/display/xlnx_dp.c         |  14 +++--
 hw/display/trace-events      |  10 +++
 10 files changed, 136 insertions(+), 134 deletions(-)

-- 
2.21.3


