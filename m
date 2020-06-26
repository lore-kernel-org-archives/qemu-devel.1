Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2A9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7691207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdKirto5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7691207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorHA-0002rf-Pi
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDE-0005CB-Es; Fri, 26 Jun 2020 12:28:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDC-0003IZ-Fv; Fri, 26 Jun 2020 12:28:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so7087714wrw.1;
 Fri, 26 Jun 2020 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x4O7UwIyxT8l9VdKCFKeBxe7B2S05VqXY1cTLrwYfpc=;
 b=QdKirto5kEbgngWxsDaCRv9l4c933QEUEjVWfJE1ROejU2kRth45VMfwPJe09JH4pu
 d6ILjiZ1qXdwCjlR2t8Op+6EO2W9m9A+Ku01D7JVS4U7FCIEGOeQEr4m/NkjCtuNcAFw
 S6brB/IDq5JI2XO40ltNUlIW1P5oJQgy+B3IfVsdfw6qtjo7gXRhh402enqRh3xccZdT
 o4RGhuICtKKQuaeQNXEtN4ilTevKoAzYQ3wjH9ciIf6vHpY7RBDhF5wvkQyHCSdv3IjE
 xY8IMWUvTLp8uTf5oT4+sWAGHWeEURV9hNQw7BqoKp3u2fDw2cmxRXtvn5Vi7sjEunAj
 nTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=x4O7UwIyxT8l9VdKCFKeBxe7B2S05VqXY1cTLrwYfpc=;
 b=Nsu45dZ201W7bIuf4PHiQTwZjH8baR3JZWcpBha3HG5YkarIcPd+UgGuYZXgDqi50J
 7Ui34TrdPixIQfzgt18RBWqhjLhfj+LdUo+BeuebDFXdgeyMLoMEEWHJj/BQGmVjl3JJ
 SfVzNesizWYLPBOndcb8ft2+4AOXtTCIjwxfk/jAVax6hd94WOrSyt0frwAhnCbPJSjn
 TJKan1+9xqDG+sL67PZklZtYH9oWXaQWD5UQ181bmYygHWnOCaMikoR//AF5X1z98QZ/
 b3baKE+A9ZjoXjBMePUaf/qWILOs9msLQ8qaat03hWafDNB80/RFUmlTilMBbW7Wb7C+
 I+YA==
X-Gm-Message-State: AOAM531kDi1n/VNXH0leIjbuCU4Qm+uZFl8VsTiY7aPUw2cyKfpswlQA
 qPzXNvD503HTeUnlPxLAPTJzbvQv
X-Google-Smtp-Source: ABdhPJxt/RLWOFWSKC99kyETU8OEA5swXlUrDAqYMnSvAseWaNOnYiFkKPMazuG2O3g7lYVpOQWH8Q==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr4370675wrm.387.1593188900397; 
 Fri, 26 Jun 2020 09:28:20 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm4867255wmg.6.2020.06.26.09.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:28:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/14] hw/sd/sdcard: Fix CVE-2020-13253 & cleanups
Date: Fri, 26 Jun 2020 18:28:04 +0200
Message-Id: <20200626162818.25840-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patches 5 & 6 fix CVE-2020-13253.
The rest are (accumulated) cleanups.

Missing review:
[PATCH 01/14] MAINTAINERS: Cc qemu-block mailing list
[PATCH 03/14] hw/sd/sdcard: Move some definitions to use them earlier
[PATCH 04/14] hw/sd/sdcard: Use the HWBLOCK_SIZE definition
[PATCH 05/14] hw/sd/sdcard: Do not switch to ReceivingData if address is invalid
[PATCH 07/14] hw/sd/sdcard: Check address is in range
[PATCH 11/14] hw/sd/sdcard: Make iolen unsigned
[PATCH 12/14] hw/sd/sdcard: Correctly display the command name in trace events

$ git backport-diff -u v3
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/14:[----] [--] 'MAINTAINERS: Cc qemu-block mailing list'
002/14:[----] [--] 'hw/sd/sdcard: Update coding style to make checkpatch.pl happy'
003/14:[down] 'hw/sd/sdcard: Move some definitions to use them earlier'
004/14:[down] 'hw/sd/sdcard: Use the HWBLOCK_SIZE definition'
005/14:[0030] [FC] 'hw/sd/sdcard: Do not switch to ReceivingData if address is invalid'
006/14:[----] [--] 'hw/sd/sdcard: Restrict Class 6 commands to SCSD cards'
007/14:[down] 'hw/sd/sdcard: Check address is in range'
008/14:[----] [--] 'hw/sd/sdcard: Update the SDState documentation'
009/14:[----] [--] 'hw/sd/sdcard: Simplify cmd_valid_while_locked()'
010/14:[----] [--] 'hw/sd/sdcard: Constify sd_crc*()'s message argument'
011/14:[0004] [FC] 'hw/sd/sdcard: Make iolen unsigned'
012/14:[----] [-C] 'hw/sd/sdcard: Correctly display the command name in trace events'
013/14:[0004] [FC] 'hw/sd/sdcard: Display offset in read/write_data() trace events'
014/14:[----] [--] 'hw/sd/sdcard: Simplify realize() a bit'

Philippe Mathieu-Daudé (14):
  MAINTAINERS: Cc qemu-block mailing list
  hw/sd/sdcard: Update coding style to make checkpatch.pl happy
  hw/sd/sdcard: Move some definitions to use them earlier
  hw/sd/sdcard: Use the HWBLOCK_SIZE definition
  hw/sd/sdcard: Do not switch to ReceivingData if address is invalid
  hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
  hw/sd/sdcard: Check address is in range
  hw/sd/sdcard: Update the SDState documentation
  hw/sd/sdcard: Simplify cmd_valid_while_locked()
  hw/sd/sdcard: Constify sd_crc*()'s message argument
  hw/sd/sdcard: Make iolen unsigned
  hw/sd/sdcard: Correctly display the command name in trace events
  hw/sd/sdcard: Display offset in read/write_data() trace events
  hw/sd/sdcard: Simplify realize() a bit

 hw/sd/sd.c         | 139 +++++++++++++++++++++++++++++----------------
 MAINTAINERS        |   1 +
 hw/sd/trace-events |   4 +-
 3 files changed, 92 insertions(+), 52 deletions(-)

-- 
2.21.3


