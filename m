Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A37DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364122074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRupkXgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364122074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRwB-00060H-9E
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 13:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfRum-0004A1-OW; Sun, 31 May 2020 13:38:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfRuf-0004F7-0h; Sun, 31 May 2020 13:38:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id l10so9153025wrr.10;
 Sun, 31 May 2020 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=szrK4QZPlIWx7hRKiEEGeyw3BNLUYHyOmBgpWr2R+Zs=;
 b=RRupkXgrGQxJyX5hU1YPGP3v77tjIwZaUEnwXH0Ycbz02nIC6z6jqL9K8VtpiGoZir
 oA5pe+0bmwn1mXRbgMEVLrpCh0d0sQKIqycavfwLuiXSOjZIKwvCbubwBhoyDEBNPMCT
 s+JJpU2UR3ihqsLIA18rk+lRx9dyVpfl+cDN3EjfVf2e36iXhgEEGnJ27Qv/8ZBGlMox
 ykuYCjITpXiI6USr1w2maE1SCHGk41hkpnblFQV9vLwdJzdQ3YlpFxieC+56rAU2D7yq
 5PNPRsTkvV+wrpFl90mqzCJzSIssp7+Q7OTmU3vfT7rPQLnXsnh1Vs2G+XHB/+/JcrN8
 ISPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=szrK4QZPlIWx7hRKiEEGeyw3BNLUYHyOmBgpWr2R+Zs=;
 b=A9nPsFj/HRHNagZdFmj4b1pgkOxxLmlWFOOGHfQw09jOo8w/DYvlrCbrPPNVC+O7p5
 JbfBVKzEUFhlE8CeiIp7uaUvpt2YZHnXs+DnRVVdRCOQ+Cn/tSqn4dxbZDVtgvm4N2/2
 aeCDnxV+MGK4T09CX2cR4PjhOWNcJqrg3rh1OIlM7EcEqR0J0H+gzenhvwI2fRvbxgL+
 UspJmyCyWHFisJOL5MAdQVLBJltR1arSJhOlfNt+RE1GiIlpp8ICshky5c0INBiSaaVq
 7gMLlZcOv8BSv0rDBOJnk4cbM3h92Bx9QfNlwe+X4UAHP2JRceUmRg+fNbJF0bepw75F
 PDrQ==
X-Gm-Message-State: AOAM532GAqvRTE5J6zyjCMm1Ol6l8EEdPQb3GUTlhAf2vg+9bs7A+9Lf
 y9ChUS3ElTSPM2nu8acmbgJ6RUP7
X-Google-Smtp-Source: ABdhPJzi1VbONK1FgNfUM2ScOB+Tk4wTN8mIKjCc/CNlbtzbBZvFo/IjBHFzqkbrQE86Hdu0UVxctg==
X-Received: by 2002:adf:8b55:: with SMTP id v21mr19093025wra.187.1590946697876; 
 Sun, 31 May 2020 10:38:17 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id l19sm7973121wmj.14.2020.05.31.10.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 10:38:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] hw: Fix some incomplete memory region size
Date: Sun, 31 May 2020 19:38:06 +0200
Message-Id: <20200531173814.8734-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_set_size() handle the 16 Exabytes limit by
special-casing the UINT64_MAX value.
This is not a problem for the 32-bit maximum, 4 GiB, but
in some places we incorrectly use UINT32_MAX instead of
4 GiB, and end up missing 1 byte in the memory region.

This series fixes the cases I encountered.
Also included few patches while reviewing, I replaced some
magic values by the IEC binary prefix equivalent.

Regards,

Phil.

Philippe Mathieu-Daudé (8):
  hw/arm/aspeed: Correct DRAM container region size
  hw/pci-host/prep: Correct RAVEN bus bridge memory region size
  hw/pci/pci_bridge: Correct pci_bridge_io memory region size
  hw/pci/pci_bridge: Use the IEC binary prefix definitions
  hw/pci-host: Use the IEC binary prefix definitions
  hw/hppa/dino: Use the IEC binary prefix definitions
  hw/i386/xen/xen-hvm: Use the IEC binary prefix definitions
  target/i386/cpu: Use the IEC binary prefix definitions

 hw/arm/aspeed.c         | 2 +-
 hw/hppa/dino.c          | 4 ++--
 hw/i386/xen/xen-hvm.c   | 3 ++-
 hw/pci-host/i440fx.c    | 3 ++-
 hw/pci-host/prep.c      | 2 +-
 hw/pci-host/q35.c       | 2 +-
 hw/pci-host/versatile.c | 5 +++--
 hw/pci/pci_bridge.c     | 7 ++++---
 target/i386/cpu.c       | 2 +-
 9 files changed, 17 insertions(+), 13 deletions(-)

-- 
2.21.3


