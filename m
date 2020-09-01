Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CDFC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B9A20BED
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjGP/N37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B9A20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7tw-00029p-IK
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD7T8-0004Bm-Dl; Tue, 01 Sep 2020 10:41:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD7T6-0008RS-U0; Tue, 01 Sep 2020 10:41:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id v4so1406175wmj.5;
 Tue, 01 Sep 2020 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UEPkPNTZPjY3iFtK/yQQSSFXpy6Vn5YNcxLoyxOWu68=;
 b=JjGP/N37eCqCPdnn6O7iwffbQ/OkrURsRnXwZM1o3xhqTaqq2ZBPHwku0FA4PssZEK
 c9+6jch+ESEqK5jOc+KqJo2GUZ3jAfr/J7l2Nj+WihuiaDBVZmI7XC5wksSX4Hb9yCpu
 yZGdCF22MgcTXZB5SYuggxYr6aJODzkijDkR7iB0f5jOha7zeM+hNoO2jg+gSdbbliKz
 vMuYaJcbYeHUv6ALWCqeGGYwxe8Ib0zgR5gkhDA4MCJPz77NbQ1ecITu2C3CrYhV2BgM
 2I3aGk+XciHDmw8OuGt/KWYkhFsX4r+VBmn3xNCUFa7Xek+fS6qtCk80eGGvPnXl2zjg
 WGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UEPkPNTZPjY3iFtK/yQQSSFXpy6Vn5YNcxLoyxOWu68=;
 b=OdMm+SeR+lflYmfs+g6QSimlVNV6mbeTffTfHKDZvVKlyqccU4jiSkLU2CmzH/sBKr
 oI9LryJfdw/bGjhRGuXnit9CShfLrSH3E6+ybPuDWQcrfHwwe8SF0utGy9LQL7iyq/MM
 6Pml7Jzew22cDNZ+rRHMyiPp2ZZ721U7U73wLV2KrtNQnHZtFzNATIp2m+4QomhYJ3kM
 cLB99s48SfCVmrcKsjrhc4KEbin7DZOMW/DUMxFXKucrfUn6+caVevk5AaizyXghxgnZ
 IaBfOSP4IZfAn/2HB77Fbqbh2bjXLqse2IXeB6SykURG4jyePV+tRovqaHTlCmi8DXm5
 Kf6g==
X-Gm-Message-State: AOAM532XQyT2Dh+GHkr6e8V+hueGIDB1PBaHqVNXfVUX0BUTJdoFOnzL
 ZM3BLPEnCZZbPVxfW+x5nWgrto39liE=
X-Google-Smtp-Source: ABdhPJwMGlojI0NYyigI9+6SJH3B5wpIHCUVKCci2LOJ0pONdnlI1MGyieuV3zWlKUSs6j/7mdT0Dw==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr2208633wme.46.1598971262564; 
 Tue, 01 Sep 2020 07:41:02 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id a82sm2213204wmc.45.2020.09.01.07.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:41:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/misc/a9scu: Verify CPU count is valid and simplify a
 bit
Date: Tue,  1 Sep 2020 16:40:56 +0200
Message-Id: <20200901144100.116742-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial patches:
- verify the A9 CPU count is in range,
- simplify using MemoryRegionOps valid/impl,
- log unimplemented registers.

Philippe Mathieu-Daudé (4):
  hw/misc/a9scu: Do not allow invalid CPU count
  hw/misc/a9scu: Simplify setting MemoryRegionOps::valid fields
  hw/misc/a9scu: Simplify setting MemoryRegionOps::impl fields
  hw/misc/a9scu: Report unimplemented accesses with qemu_log_mask(UNIMP)

 hw/misc/a9scu.c | 59 +++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

-- 
2.26.2


