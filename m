Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C289C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9DAE2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dixfeh3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DAE2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFWI-0000Ag-Rw
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFU6-0006IV-Lt
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFTw-00020j-4m
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53628
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFTv-0001rz-Lm
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XUlKyT73AlkHFlQ8zqyTxGozcuh5OB4qVGei5hmsoHw=;
 b=dixfeh3t4sZwYUHsF1Meg05AEJIZCjUqu4I2zUDwtdQdLUj4Ql6UTfVIRS37FQlcVDv2xJ
 ECWPjNlVRu3zQ7ggmZVGdZ2X1vMEag2or23Hv47rReT3Tt272IZB9yUDPvKkS0Twryti7N
 xC/Y4ekxwLM9m/i/eFu2avNiU++NzD8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-Vdnokx-WOi-fTFc5gYt35A-1; Wed, 22 Apr 2020 09:31:56 -0400
X-MC-Unique: Vdnokx-WOi-fTFc5gYt35A-1
Received: by mail-wm1-f70.google.com with SMTP id 14so789745wmo.9
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zqmfue2UwrwiHNMR4TPo8N6a37zrjxPCjDQGfvWFQLs=;
 b=GZhs0adHdR8sbvuwoR3Prp5SpLnzaXaxABGHX8Vq5EQJdbiLDNB6DaKXC1mqoHM0AF
 hGPRhjaizkVGOb6F+ae5nVtcxU1kmIU22TeUPAz05m32xklGtriZ2GmQl9W4IlsCmg4U
 zNzkoi8LCo43MYLzxZBr9lZKH91Bvg1C7ib7Nn3A7PqbkGe6JKenE5DuyyUOrdbqjPZb
 ZOdiNo5UqIK7YXlEAbXgxacaG7yncusVNjWePvJYObAUVSVk4rDrL/ZppOmY6GbwYm1m
 6yMs+39xp0a4L1TVguMT8FWsTWxkapbhUz01gwdABT4p6AcX3wFSEINlkkbZ2MKvDsGa
 R9rw==
X-Gm-Message-State: AGi0PuYfQ2WJNqwJUT9zYPeCxrbZQtIoo1NmyYTT7AKyHS64S4jDQMnl
 iZxJerkH5bIEuopb7JwXdbA7Kp273rVyWDazICKxouufjdvZZApjtvSsOwfVfjSxtsabJtPsv3t
 o8v2HEE+SVVwmgWI=
X-Received: by 2002:a5d:4d8f:: with SMTP id b15mr29991371wru.107.1587562315278; 
 Wed, 22 Apr 2020 06:31:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypLyOb25132StkCLkHX76Eh5KmJs4V9ysBdaVfZ86rojqHY1LjtJXpThxFsh99WOQlyoK7dstQ==
X-Received: by 2002:a5d:4d8f:: with SMTP id b15mr29991348wru.107.1587562314953; 
 Wed, 22 Apr 2020 06:31:54 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j3sm8165750wrw.28.2020.04.22.06.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:31:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] misc: Trivial static code analyzer fixes
Date: Wed, 22 Apr 2020 15:31:43 +0200
Message-Id: <20200422133152.16770-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix trivial warnings reported by the Clang static code analyzer.

Only patch #2 'blockdev: Remove dead assignment' misses review.

The official Clang static code analyzer documentation is on:
https://clang-analyzer.llvm.org/

On Fedora I simply used it as:

  $ sudo dnf install clang-analyzer
  $ ../configure
  $ scan-build make

Since v2:
- Based on lvivier/trivial-patches-for-5.1
- Removed dup patches from Kuhn Chenqun
Since v1:
- Addressed Markus/Zoltan/Aleksandar review comments

Philippe Mathieu-Daud=C3=A9 (9):
  block: Avoid dead assignment
  blockdev: Remove dead assignment
  hw/i2c/pm_smbus: Remove dead assignment
  hw/input/adb-kbd: Remove dead assignment
  hw/ide/sii3112: Remove dead assignment
  hw/isa/i82378: Remove dead assignment
  hw/gpio/aspeed_gpio: Remove dead assignment
  hw/timer/stm32f2xx_timer: Remove dead assignment
  hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning

 block.c                    | 2 +-
 blockdev.c                 | 2 +-
 hw/gpio/aspeed_gpio.c      | 2 +-
 hw/i2c/pm_smbus.c          | 1 -
 hw/ide/sii3112.c           | 5 +++--
 hw/input/adb-kbd.c         | 6 +-----
 hw/isa/i82378.c            | 8 ++++----
 hw/timer/pxa2xx_timer.c    | 1 +
 hw/timer/stm32f2xx_timer.c | 1 -
 9 files changed, 12 insertions(+), 16 deletions(-)

--=20
2.21.1


