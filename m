Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4BCC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496A7206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGgHYPRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496A7206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jflT2-0004YY-A2
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 10:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflRY-0002Jo-9P; Mon, 01 Jun 2020 10:29:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:37042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflRX-0002aH-JJ; Mon, 01 Jun 2020 10:29:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id f5so11594846wmh.2;
 Mon, 01 Jun 2020 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZM7/znQriD0UhsswZg6MLv2Z3oBcZnpOAq0NEHbW664=;
 b=GGgHYPRiatHdFDW9BVH8eF+dSyAynNmKp7tCKjge/3dzd5/m4+sDYh6i+4CuC5eLnk
 d0K9s7FRYLtW94rL93bIkN/F7acb+khmY4E/jXZ1+TK0lKJF6DwpIBoGcy9+FjiVQ8J9
 7rFPUqqlrBtnqHcc5XCpn7TgT39xntNtLVatlVAThT01V8OoIhDmcEhbQwH+v9/vTefx
 QbSfJSl1P16H7ir6sCNJi5IW6OyYMHqgHYolpGT/KvNvl6YtjqK/ZBPCr7uPoowpHCVJ
 jwhp67uNSCvqURSdBp37Z4gJjZsIkxpb3v1DRn+Brn7MWWRG4OMLkp7HpEQbF9T+B8Xc
 fbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ZM7/znQriD0UhsswZg6MLv2Z3oBcZnpOAq0NEHbW664=;
 b=bJrDCb60P3ddNJ4IuREcyn4qKrRQdSUOxdrHXv6eCY6nE4pF/UV7dTL9ubXxg0urmG
 qFVUVTZCZ9b5r+a57xcnxSPJLKd3Bg4Tisn/UhFkDX1sAuDqg0Cpc6+4toBV335VonsL
 aclyyseIjvYQhYxd0AdzKlcoCBzig0Ud4NybV9VLoFr9xFoymmAOWJuyE/5h+67LhDFC
 viaBJUr6ZGNAwN00HXOh3qLjVIP3rHjqUZkriaiuI+RgcPD3xJseVZw2ZrabfcNmQjRj
 OIZ8fh9WNfN8PfuXsYh5RKwgoZPODzLn2f8yCsB8xIT4Q2FD9Eerd7vo/2bOGL0i0Geh
 deDQ==
X-Gm-Message-State: AOAM531h0DkD9gSwlmdymy95A4GFmParaFGNxixMaQeO9kWAcHRbEenD
 ZqroOnvSI/TFbqL7gUaczyztWV0D
X-Google-Smtp-Source: ABdhPJwufRnQl4HmwANVRDq93UByxPUJbZfC4pM9aQ9eCt/8cwII0ubngoSEbHzq8tnEDNEvDybD9g==
X-Received: by 2002:a1c:998c:: with SMTP id b134mr22850671wme.78.1591021773028; 
 Mon, 01 Jun 2020 07:29:33 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id u12sm6824954wrq.90.2020.06.01.07.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 07:29:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] hw: Fix some incomplete memory region size
Date: Mon,  1 Jun 2020 16:29:22 +0200
Message-Id: <20200601142930.29408-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32d.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Series fully reviewed.

Since v1:
- Add parenthesis on the Xen patch (Paul Durrant)
- Add Peter's R-b tags

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


