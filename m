Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29278C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29E521548
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dphRM0c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29E521548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH3uy-00035J-DQ
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 07:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3te-0001PQ-Td; Sat, 12 Sep 2020 07:40:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3tc-0000Sq-SP; Sat, 12 Sep 2020 07:40:46 -0400
Received: by mail-wm1-x342.google.com with SMTP id z9so7056386wmk.1;
 Sat, 12 Sep 2020 04:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FQvkJn1GQASYjh2tCAEKRHVEfvoL4XB1f3Wl9kk0OVM=;
 b=dphRM0c5taPWbwIajeayxOcez0nx+HzzwCNalHMh8H+IQn136C2v2yttquCvVfP0yw
 raJQLiNcr7Gr5W5D3NYP7djRbd3Ek2MPZeCsbEytwNF3IhOld8Ns9n0RORNkW3oj2c1l
 5xDkQfzM37jwXLlMiVThC/L5/g5UaIpj1Xjjp0mj+rj27gXejH4k9S+DR3L3mfT/NWCG
 ddSkr5orQEaYUchiyXa8snLRrKTfxVUM7CfbjAC+VRnYqC/OFkG3rbOtdO4cRJzNLrN6
 DSbq+bott7M++8TWVJMQlQzbFZVkECcCI43nPihNcHv7Wh88yFgCtzNdl4PDhGQ3FOMZ
 m2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=FQvkJn1GQASYjh2tCAEKRHVEfvoL4XB1f3Wl9kk0OVM=;
 b=UY1nT8kDUZVoq6O2TCtYZTU8ABlT1PDlvttda8y8pQDfxqaGNF2d5XtDq2qsVPxRu0
 x1hiVmhZOTTIRb/nTnF2+NzxsGsjwPJA3hBEKRlYlDRkp5csjgXCrp7FhA+izBIWNpbP
 zT8iOuqFzR2ccEx9s4+LIMBGsl1/q4NJAVB53Vq8Gquyp25S3B0ywMxzalT5iT8bRWIn
 RIZDrhV4s0Oi1ZD25ckLbu1V5wvNy3nroT4xjX0vJ6yI0T5aDU1PTY69YB4sc70uq+++
 +Bcvo8RgeKtOaByKiJldPCMXjgWmFjCPiPieGNtuVyq4bRSfCFFqjhYya8/ZsPgUsO+m
 WVfg==
X-Gm-Message-State: AOAM530Yl+jA0zdACMcdJ97AVsDtNKWL3Wwt9uJM7pR0tihG5Vq6hOg4
 PetQl2pGJ8tkPpczFnWmFic=
X-Google-Smtp-Source: ABdhPJygLScMMJapyzGRP3SwYj+aFQkBBf5tM7gsBRHjdlaVhSLjO0I2AxYdRlJqRLo5B0xobNMIEw==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id
 t15mr6794523wmn.41.1599910842884; 
 Sat, 12 Sep 2020 04:40:42 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h6sm9373895wmb.22.2020.09.12.04.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 04:40:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] hw/char/serial: Housekeeping
Date: Sat, 12 Sep 2020 13:40:33 +0200
Message-Id: <20200912114040.918464-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nothing very exciting, cleanups before more serious changes.

Since v1: addressed Paolo's comments
- Also alias QDev properties on the PCI device (patch 6)
- Initialize the 'id' property on the PCI multi-UART device (patch 7)

Patches 1-6 already queued by Paolo.

$ git backport-diff -r v2 -u v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respective=
ly

001/7:[----] [--] 'hw/char/serial: Assert serial_ioport_read/write offset fit=
s 8 bytes'
002/7:[----] [--] 'hw/char/serial: Replace commented DPRINTF() by trace event'
003/7:[----] [--] 'hw/char/serial: Remove old DEBUG_SERIAL commented code'
004/7:[----] [--] 'hw/char/serial: Rename I/O read/write trace events'
005/7:[----] [-C] 'hw/char/serial: Make 'wakeup' property boolean'
006/7:[0003] [FC] 'hw/char/serial: Alias QDEV properties from generic serial =
object'
007/7:[0001] [FC] 'hw/char/serial: Let SerialState have an 'id' field'

Paolo, can you take this #6 (instead of v1) and #7 now?

Thanks,

Phil.

Philippe Mathieu-Daud=C3=A9 (7):
  hw/char/serial: Assert serial_ioport_read/write offset fits 8 bytes
  hw/char/serial: Replace commented DPRINTF() by trace event
  hw/char/serial: Remove old DEBUG_SERIAL commented code
  hw/char/serial: Rename I/O read/write trace events
  hw/char/serial: Make 'wakeup' property boolean
  hw/char/serial: Alias QDEV properties from generic serial object
  hw/char/serial: Let SerialState have an 'id' field

 include/hw/char/serial.h   |  3 ++-
 hw/char/serial-isa.c       |  4 ++--
 hw/char/serial-pci-multi.c |  1 +
 hw/char/serial-pci.c       |  3 ++-
 hw/char/serial.c           | 25 +++++++------------------
 hw/char/trace-events       |  5 +++--
 6 files changed, 17 insertions(+), 24 deletions(-)

--=20
2.26.2


