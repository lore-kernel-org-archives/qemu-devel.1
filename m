Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2962AC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBFE2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obr/niMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBFE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIb8-0002GB-LF
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60016)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYh-00006v-NV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYf-0003JX-Ka
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYf-0003IO-Db
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id s15so17666572wmj.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eMIawS30YngPpRftqQLfFq60155CmM2qHe8aA4uFf00=;
 b=obr/niMoaXWIinTfq6TKFcDpWMPOiBQK9HRo/5bjlt7VLa6FlTbrYfQ9DIwr8T2MFh
 oUNrqyt/vomzm0LBEt4DlNREfRQKGvey3JfhGugamKDA2p9VIQVT9YcOe72pNhttAX+s
 w3HDWsAFqOBGjHbCIePL8rnuUMCdmyAEWU1TQaRpvW9l9twdWSE4T4F+vJV0eicRTi6V
 ZLlm1Ir9+NIQKab6yJ9qTEM0pXPUjvD5LGU68h4mW9EivUCT8K3y2KcqxKhizImhahmT
 Yy71O5Ra7n2/+moNB4Q9ELicUw2VbJHu1eH+v4zw6cypjjuUKsa2PePvfDiV3/jO8eua
 cY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eMIawS30YngPpRftqQLfFq60155CmM2qHe8aA4uFf00=;
 b=aeLL5Pi34xkyKXCTsJzGc0UKB/GT5CNBYFWkBpnrqCiVNIWlYIClR1UBy9dDvciCCD
 cJOs1WF0HSKOFPMoECClLwToVOgd5BGDA4NTm1FqvZhp8JyIY9SZdtv3eDVAyzlMU/VL
 aDRFrveCWbpTgvxDr26/t1u5YgDW4Fztu554EWbCfKOO2v+krbe2tw8xp1j8GV8fWUVh
 aLg6OlGQ6INschNhAbbZUouI4W6cMYfCK+iIX5e3l2PP6P78W7P/jrCJWhyVPBRtSQej
 VyGGBaF4YpgL2tsNYJ8sYOOQfcf82XDurM5hc7X+/L654tNdKXzJwE2vgkPxvawcL/Ks
 ChNQ==
X-Gm-Message-State: APjAAAW2Mi9Vo9/7MwzgLi24M1PGFX5AOYijoUaSLct/t7wtjd8Q1Eh1
 sZrBz0t3ZpCgy3UqkI3FUTlG4HNqWqI=
X-Google-Smtp-Source: APXvYqwaq3/eP2Db738+rHSmBgPPGuc1ZsjblSQ9Iij1DeDFgIQ/7/eN88u0hM/t88i7/0et8SCs/g==
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr29993713wma.41.1563264692099; 
 Tue, 16 Jul 2019 01:11:32 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:10 +0200
Message-Id: <1563264677-39718-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 12/19] hw/lm32/Kconfig: Milkymist One provides a
 USB 1.1 Controller
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The Milkymist SoftUSB block provides the OHCI USB standard
(missed in 0858746b835).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190714124755.14356-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/lm32/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/lm32/Kconfig b/hw/lm32/Kconfig
index 3d09c2d..ed2e306 100644
--- a/hw/lm32/Kconfig
+++ b/hw/lm32/Kconfig
@@ -11,3 +11,4 @@ config MILKYMIST
     select PFLASH_CFI01
     select FRAMEBUFFER
     select SD
+    select USB_OHCI
-- 
1.8.3.1



