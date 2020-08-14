Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DFFC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6253C2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HURiifkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6253C2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6V5s-00056G-JC
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 04:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V4x-0003NR-N7; Fri, 14 Aug 2020 04:28:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V4w-0004LR-6y; Fri, 14 Aug 2020 04:28:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id g75so7219055wme.4;
 Fri, 14 Aug 2020 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dpT3D+sYkIVsipFBLZ+lF49M42Q6Xpp0CzqtCad4hvY=;
 b=HURiifkYLGP4IH0ClQ+QpdJFa4o0xGyD4PiP5isO6ANkHiabFznBq6mw2oQM/KelVq
 ULP44LeIUi78TztuPVD8qBu7mwaEEc5NQ9Eei/tQ4gypVqVdEcLC8/313eDZqYvUh8YU
 IDBpFokmkWioq+yN9R317RWJciGDNPVsKEmQHT+wNg11wUSxzaN+BGwE/QK6CFm2e/p+
 duMYT3C6tUWF5OaVB+BPoAXYDwAcE4UmfpUxGh98D0VQFDZQFh+lof3fdep2Yd7WLBo8
 df/rLbEXxFfaLazsLQfhbwB9kWItSDPMx+zPq7PBepDV4tLBOIBJMLaKmoYOtAyDbHLo
 rvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=dpT3D+sYkIVsipFBLZ+lF49M42Q6Xpp0CzqtCad4hvY=;
 b=i1NK/wRCIQKM86cAeWxj6rYq8WcZA+bivYMKkw8HvxsFNi7pGSsQw0X23Vsh1jOS86
 b/554bxTVKYzUZAgSMcU2hQwIUVm/1UIW4AVfoCPhcXExWQgSjXI03RNyIfCWVmlEInX
 mjF278kGvx2Aa90XnMu2G+UgD+VRN9VWSCmKm+Ev0USZyeU+s3ueG0JtUgwSSVANN88O
 FyOR77n7gmw/P+6zJxC39C+rTqUkdU5m/jqAluFXtEPNPnBngduJZiNwy2o++krd9yQ8
 jqjUB8uY5LJ2MyXRHycLcOzPNS4zaZrzMNKTN4ns1S+ACIxs4Ms8sRQWPQc+aXyvg4tX
 F6pw==
X-Gm-Message-State: AOAM532xrCrfx87/41H2uf5oz6d1wsqBavg4QvnbyemFNJ2/lrs80NqM
 1uTxD4LDgLKP/bPEEuvJc/hUP1h4CkU=
X-Google-Smtp-Source: ABdhPJxca8hfCYE2YUshLao7MnDMCSit06uYnTPlO0Zq8PSoO+QIMf40WBTnXpGPZHB3LSNAAHTQgQ==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr1460999wmb.129.1597393723783; 
 Fri, 14 Aug 2020 01:28:43 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d14sm14668107wre.44.2020.08.14.01.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 01:28:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] block: Use definitions instead of magic values
Date: Fri, 14 Aug 2020 10:28:34 +0200
Message-Id: <20200814082841.27000-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial block patches:
- Fix a typo
- Replace '1 << 30' by '1 * GiB' in null-co
- Replace 512 by BDRV_SECTOR_SIZE when appropriate.

Philippe Mathieu-Daudé (7):
  block/null: Make more explicit the driver default size is 1GiB
  hw/ide/core: Trivial typo fix
  hw/ide/core: Replace magic '512' value by BDRV_SECTOR_SIZE
  hw/ide/ahci: Replace magic '512' value by BDRV_SECTOR_SIZE
  hw/ide/atapi: Replace magic '512' value by BDRV_SECTOR_SIZE
  hw/ide/pci: Replace magic '512' value by BDRV_SECTOR_SIZE
  hw/scsi/scsi-disk: Replace magic '512' value by BDRV_SECTOR_SIZE

 block/null.c        |  4 +++-
 hw/ide/ahci.c       |  5 +++--
 hw/ide/atapi.c      |  8 ++++----
 hw/ide/core.c       | 25 +++++++++++++------------
 hw/ide/pci.c        |  2 +-
 hw/scsi/scsi-disk.c | 44 +++++++++++++++++++++++---------------------
 6 files changed, 47 insertions(+), 41 deletions(-)

-- 
2.21.3


