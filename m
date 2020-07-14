Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B60C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF70224F9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDj7guuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF70224F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLT1-0005hK-HZ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRt-00042f-84; Tue, 14 Jul 2020 09:58:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRr-0003QW-7R; Tue, 14 Jul 2020 09:58:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id z2so21787302wrp.2;
 Tue, 14 Jul 2020 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L451EMYXJ+wjbaT8kDi+FmAdNTf0ehQ4zF8f6L3JvQM=;
 b=YDj7guuobpMlNYeco1f3b8CPHGSVKG0mR1KUZs1ZcbMm5kuaQtmg+4TZrvwsmkfoGx
 iZVbJe0LzWuUcDrB7qy6gQUDSgi0j4km8rbyiGtgdgybbsCk+Bd9B0TTn1xrTsbjpg5R
 UM7xMrgdkFb/Tno/NXPepIfx3X6hrRZZg7frMTo4h9zR1qozrTQdbvUcOzDG0DSK6D07
 S0pyMMbTVzv7lK/tIgJLCDqDerWEGkKIAhJtdZyABp/ctDdqDe5A3n8u6kXZHVeBlkbA
 cHlJnMtVHJcF7fqoBYizQo+VRhTSxgXlxMsHtgXa3OyJTEgILZ9FlUtoPkn4pETBVHA0
 biJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=L451EMYXJ+wjbaT8kDi+FmAdNTf0ehQ4zF8f6L3JvQM=;
 b=sB+VGFOmJsEd7Hctw4CjQxBU1o3Q6hhW3hbVO9PvVhtKQnxnGdglyEdOinIxa8MxdO
 wazkMud7HR/6V9WirOI4h2FJVn2X1H319ozjp2hLIfYePWIGNGL04lio7LV/KAzT9EJJ
 54subU0uPezV0/qEKq49ZFFhzpGg8j0y3XGhDwilze2e4DzwWDU+HfJeVHAf24MLyfIU
 pzywmG8up52xVVvdP8wXs+zyv+Dje53hK97z36aXpf9t996YdsG3iFpkIj+s/CDwFiem
 HuQCkhYtmoNw5yJL0UUj4IFs4v2WW3+tPJRvvotOOTligyrP2DABRHNP+dWqwd42kToC
 xQJA==
X-Gm-Message-State: AOAM531IjsQic+Gg74eNxoJsUgEGN7NQZU1Gjc93kM75Uw62YXT5iCVb
 mVLItBTxPFXgti6a3Q5ps45wqcbxNz4=
X-Google-Smtp-Source: ABdhPJxyqJMIKmB4JPyBj08C++FEwAfAPO7JAoeQzBQt4kIXjtI4POwWQyBfUekvbsNOvpUsDQYeEg==
X-Received: by 2002:a5d:5310:: with SMTP id e16mr5437175wrv.289.1594735096881; 
 Tue, 14 Jul 2020 06:58:16 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm29145343wrn.76.2020.07.14.06.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 06:58:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] sdcard: Fix CVE-2020-13253
Date: Tue, 14 Jul 2020 15:58:05 +0200
Message-Id: <20200714135814.19910-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Prasad J Pandit <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14c46:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-reque=
st' into staging (2020-07-13 16:58:44 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/sdcard-CVE-2020-13253-pull-request

for you to fetch changes up to 790762e5487114341cccc5bffcec4cb3c022c3cd:

  hw/sd/sdcard: Do not switch to ReceivingData if address is invalid (2020-07=
-14 15:46:14 +0200)

----------------------------------------------------------------
Fix CVE-2020-13253

By using invalidated address, guest can do out-of-bounds accesses.
These patches fix the issue by only allowing SD card image sizes
power of 2, and not switching to SEND_DATA state when the address
is invalid (out of range).

This issue was found using QEMU fuzzing mode (using --enable-fuzzing,
see docs/devel/fuzzing.txt) and reported by Alexander Bulekov.

Reproducer:
  https://bugs.launchpad.net/qemu/+bug/1880822/comments/1

CI jobs results:
. https://cirrus-ci.com/build/5157142548185088
. https://gitlab.com/philmd/qemu/-/pipelines/166381731
. https://travis-ci.org/github/philmd/qemu/builds/707956535
----------------------------------------------------------------

Niek Linnenbank (1):
  docs/orangepi: Add instructions for resizing SD image to power of two

Philippe Mathieu-Daud=C3=A9 (8):
  MAINTAINERS: Cc qemu-block mailing list
  tests/acceptance/boot_linux: Tag tests using a SD card with
    'device:sd'
  tests/acceptance/boot_linux: Expand SD card image to power of 2
  hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
  hw/sd/sdcard: Simplify realize() a bit
  hw/sd/sdcard: Do not allow invalid SD card sizes
  hw/sd/sdcard: Update coding style to make checkpatch.pl happy
  hw/sd/sdcard: Do not switch to ReceivingData if address is invalid

 docs/system/arm/orangepi.rst           | 16 ++++-
 hw/sd/sd.c                             | 86 ++++++++++++++++++++------
 MAINTAINERS                            |  1 +
 tests/acceptance/boot_linux_console.py | 34 +++++++---
 4 files changed, 106 insertions(+), 31 deletions(-)

--=20
2.21.3


