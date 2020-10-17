Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90BFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2292073A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOM/ZGfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2292073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTqeI-0001LU-4i
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 14:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTqcD-00008f-N7; Sat, 17 Oct 2020 14:07:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:50305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTqcC-000519-9a; Sat, 17 Oct 2020 14:07:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id 13so6497888wmf.0;
 Sat, 17 Oct 2020 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iBE4R9pfzBI4xaKYFcLqM5MiTWNjWCMGj4vnXfaB84Q=;
 b=sOM/ZGfFrTysnntwmFm5O8USfdx0SezkuQneB3zs5rGhhnQTBExfcyhWl+++hmxLnN
 9DV0djE9HeSa2+0ieTfqnGCIOCCnLYGEPP5LDH0r4+TQ1wed61P6w+g7NqW+4Wl8SVDL
 FGyYF4w8JDinETLhnPbhnif+JMmuxhTnooM62gdNUf/OSvrc+k0+n56y8Ae1xP/r4T+n
 OXHM+/fXcA0GADWTvn7Pd59UqdO4W1UqjZim8wbDdZAvbJ5RGGSVCDzOdb3w+4y/Fcy0
 Gbl/yN/m21Kzs9T/dHB9qlpNADZH5xD+0sfPB6/lOmp2PZtX5bFvNstt9XgHUJRZoMvr
 DbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=iBE4R9pfzBI4xaKYFcLqM5MiTWNjWCMGj4vnXfaB84Q=;
 b=VzAvk+ER0r+n+aPRulNNZCqQevzgQ8FjxNRYDq2bnPnuu6vxzmIkLAjXd9jJt4HL6Y
 zrVXidxHbxuqHtCEZUWOjzb74ZGZ92896dGblY35ZF2/alu5bo0N2hx0VzCzyHhGyAJU
 70z0u6KrUGseWoPGrMCB42Z0sSENp080Q6tZboIVXU5ouqRdmlNgtd8NvO+Nd03Qjo34
 S93fdjpIKsCuSZClls/oWrQenjTL0+k+gopIamxYncaBgf/ux7XuxzFK5D4XM5TRoQnQ
 sptJ5D8xpL4fwZOLcOxuXZl0ccl6tqvS8LIE3VQaGvrUqvfuFwuMosJpNbfHEjhkF85b
 6a8Q==
X-Gm-Message-State: AOAM532RdA15S/OstWGNVIKlDXsMJqfAkJWwYE4CzNbRXuyVmOXGEgBa
 E51iyoBFF/Ylsy2WYFyniF//ewjX/lI=
X-Google-Smtp-Source: ABdhPJzCYrVL9Mb+aapMM9XyClol4IRuMdwxz99MtnKt9cRbfcbFcZ411UXQABKMgI2y35TUVS8h4Q==
X-Received: by 2002:a05:600c:258:: with SMTP id
 24mr9120198wmj.167.1602958054299; 
 Sat, 17 Oct 2020 11:07:34 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id u6sm8331807wmj.40.2020.10.17.11.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 11:07:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/intc/bcm283x: Trivial tracing cleanup
Date: Sat, 17 Oct 2020 20:07:29 +0200
Message-Id: <20201017180731.1165871-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add trace event for IRQ from CPU/GPU,=0D
use definitions for IRQ numbers.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (2):=0D
  hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers=0D
  hw/intc/bcm2836_control: Use IRQ definitions instead of magic numbers=0D
=0D
 hw/intc/bcm2835_ic.c      | 4 +++-=0D
 hw/intc/bcm2836_control.c | 8 ++++----=0D
 hw/intc/trace-events      | 4 ++++=0D
 3 files changed, 11 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

