Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B5A20674
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfiOpBha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B5A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i20de-000852-5O
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 18:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i20bp-00071t-Lr
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i20bo-0003su-91
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:03:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i20bn-0003qT-AM; Sun, 25 Aug 2019 18:03:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id m125so13961196wmm.3;
 Sun, 25 Aug 2019 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pl2s2KYqjvapVoVVIklZZIVxjm93m0ehwBJpiW8zuvI=;
 b=NfiOpBhakTr29Z8Ql40GuSZdIC684HXK7nZSN6jSJMOikhbWSpETh/Gu4QQgyGc+NT
 XBVBtblEDTHdPl2EHKcznZim2ceszxIyOgc9ao2VAVuHvLy44TOmwfar+pbuz2vq8Mi0
 wKk3C8V5oL9jPNNKCsRsteo6E9W24MwornD8A0J6gRlirRdJm7cDK/iEZo0DQQuBQT8X
 /aMi1KOb3MgqNNNx9AalnBTtAGUn2+PH/GWAHvJSYsXJtKzesVZ1zLegyypeXqfj5nwk
 dSEyo2kOikAJeNyB5empHFTzjQ8MOWEO1SoUodiHe1vvr6X+wg9vlXokbmC8lci5ZC+o
 wxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pl2s2KYqjvapVoVVIklZZIVxjm93m0ehwBJpiW8zuvI=;
 b=bV9CPcj6e8YM2ZUql5WU+hgh7O6yFqCMXiqLVe8huwDK2f9HoEpg+hSEIMC3IgTibL
 2ZLe3bjYJO45EPmW+pzNiAk4yiv8OrmkVo6QkCwJU7wlGpmhZwyCJsWTeu7fvlORzCib
 Zo1dfwO6577e0W8VRjlyxMF7Mw32rioxWA/9YLCrZLxNY6HBZmWID0jj3nbKDTeQirRW
 W+iagyxk+/1O+xkQKFIQ8rWAq967Bq8Itt0aq3jx7vG7aZiqDocJtIS78BXCHaPrmERP
 PW3iZdm49FCiG9qeJy/mSRQ1UhmgD9nO7piDsLp1kzBelHTDUcAtd8639/wpWgkyYj5z
 5J+w==
X-Gm-Message-State: APjAAAVh+BlRmQN8BkI6jpqyQ2+CkyuBwt71OLlNQbKNWTJFoTTtJj2+
 f3jupm9UYUqGyi16WoD+CvaG27891l0=
X-Google-Smtp-Source: APXvYqw5uHfCrLkLGeVAZfV9hRBVqVtt35yLhq0e6KJMTquKvhApx+hD8H8gLfUgDcShmQzSQ7aeCw==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr18707449wmh.90.1566770613270; 
 Sun, 25 Aug 2019 15:03:33 -0700 (PDT)
Received: from localhost.localdomain (93-173-200-237.bb.netvision.net.il.
 [93.173.200.237])
 by smtp.gmail.com with ESMTPSA id f134sm17578257wmg.20.2019.08.25.15.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2019 15:03:32 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 01:03:27 +0300
Message-Id: <20190825220329.7942-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2 0/2] Optimize alignment probing
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When probing unallocated area on XFS filesystem we cannot detect request
alignment and we fallback to safe value which may not be optimal. Avoid this
fallback by always allocating the first block when creating a new image or
resizing empty image.

I tested v1 only with -raw format, and missed some changes in qcow2
tests creating raw images during the tests. This time I tested with both
-raw and -qcow2.

Changes in v2:
- Support file descriptor opened with O_DIRECT (e.g. in block_resize) (Max)
- Remove unneeded change in 160 (Max)
- Fix block filter in 175 on filesystem allocating extra blocks (Max)
- Comment why we ignore errors in allocte_first_block() (Max)
- Comment why allocate_first_block() is needed in FALLOC mode (Max)
- Clarify commit message about user visible changes (Maxim)
- Fix 178.out.qcow2
- Fix 150.out with -qcow2 by spliting to 150.out.{raw,qcow2}
- Add test for allocate_first_block() with block_resize (Max)
- Drop provisioing tests results since I ran them only once

v1 was here:
https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00821.html

Nir Soffer (2):
  block: posix: Always allocate the first block
  iotests: Test allocate_first_block() with O_DIRECT

 block/file-posix.c                            | 43 ++++++++++++++++++
 tests/qemu-iotests/{150.out => 150.out.qcow2} |  0
 tests/qemu-iotests/150.out.raw                | 12 +++++
 tests/qemu-iotests/175                        | 44 ++++++++++++++++---
 tests/qemu-iotests/175.out                    | 16 +++++--
 tests/qemu-iotests/178.out.qcow2              |  4 +-
 tests/qemu-iotests/221.out                    | 12 +++--
 tests/qemu-iotests/253.out                    | 12 +++--
 8 files changed, 123 insertions(+), 20 deletions(-)
 rename tests/qemu-iotests/{150.out => 150.out.qcow2} (100%)
 create mode 100644 tests/qemu-iotests/150.out.raw

-- 
2.20.1


