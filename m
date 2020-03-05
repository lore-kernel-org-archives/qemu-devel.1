Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A82BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F3D2072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAiKzlYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F3D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pyw-0001G7-1a
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9psd-0005wU-Fw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9psc-0001I4-3L
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9psb-0001Hq-WA
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583412333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nhwgrxnqpunrz8zBbMeODrFA6z+v6v0KC0yLbmsGqoc=;
 b=eAiKzlYlJOnUY5nVl7U3Z9SJRBqZRZyHZvlEXegFiLAaHTqVCblM2U12USG2tYEWcVG7pI
 bhirRKwWvtoCsW+SxF6Wbyfp5Njb09sJ9nyclQY/LjNf2p2ecv9p7GvypPp7j6b473/TCs
 APuuFJRnaFGaBfRDP9A5Fs0rVP7PXLg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-Uy2ASBgwO3eTBN12HiHQkA-1; Thu, 05 Mar 2020 07:45:30 -0500
X-MC-Unique: Uy2ASBgwO3eTBN12HiHQkA-1
Received: by mail-wm1-f70.google.com with SMTP id i16so174848wmd.9
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VZtzsSVzb5DX3o4pkmW7ktCi9rq5BRkqUN3Jv0Apib8=;
 b=B4b00bMR/7SQIrHkfPUle6wRQr/tlA7TEuJyLo1z6wZpttpJZJNASsXgIIlxhVYIyc
 Po+CEDF7BCqJSaiuBH1cAjtMCWz6hRBziKwwxSrnYmP+Gyjl7BctBBk/aZA0qpSJgczZ
 VrafbszNg1CrLf+9DOZhex1uOt6MYYm+nt5bhYZT2ARZh8rlE0ZYylkjX2GSMzk0DrIf
 EqsSbo1O8HULVRFbdaeXpH6X/VOU1SkJ836tHsc+f3WCDY6Mcp/YAYoNSRcDr6gdqknE
 wwGcYRw0xTsePPmlHgh5I1/ougBEd+KqAWgrK+FRcHv0ogTCUBMZavgw67FSv3jyf/0Y
 jD6A==
X-Gm-Message-State: ANhLgQ0wn7b+FK00TxgXejCgl+Y7W/89HqKDSOOS7EYtcyAPbVxXePPf
 gf9m7RSZ7bLepzWd1ETYWDBgMY61PZukimrbONWy4bfXKXYjVz9ONvW2sxXiod+nT7T0CcbAkDU
 /lIipS/Zj5ZIxGU4=
X-Received: by 2002:a5d:4f85:: with SMTP id d5mr9009099wru.130.1583412328858; 
 Thu, 05 Mar 2020 04:45:28 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsj+5NKjCRIPqq/H/Brzjh0otlE9Qe8SQpdfKd2O3ZmDaikh5SOyIb4K+v2hWE41E3CKuSJxw==
X-Received: by 2002:a5d:4f85:: with SMTP id d5mr9009071wru.130.1583412328568; 
 Thu, 05 Mar 2020 04:45:28 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u17sm8282608wmj.47.2020.03.05.04.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:45:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] hw, ui,
 virtfs-proxy-helper: Reduce QEMU .data/.rodata/.bss footprint
Date: Thu,  5 Mar 2020 13:45:16 +0100
Message-Id: <20200305124525.14555-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1:
- merged 2 series
- reworked hw/usb/quirks
- added R-b/A-b tags

This series reduce the footprint of the QEMU binary:
.bss: 106KiB (moved to .heap)
.data: 1MiB
.rodata: 4.34MiB
(sizes on x86_64 building with -Os)

The elf-dissector tool [1] [2] helped to notice the big array.

[1] https://phabricator.kde.org/source/elf-dissector/
[2] https://www.volkerkrause.eu/2019/06/22/elf-dissector-aarch64-support.ht=
ml
[heap equivalent tool working with QEMU: https://github.com/KDE/heaptrack]

Supersedes: <20200304221807.25212-1-philmd@redhat.com>
Supersedes: <20200305010446.17029-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (9):
  hw/audio/fmopl: Fix a typo twice
  hw/audio/fmopl: Move ENV_CURVE to .heap to save 32KiB of .bss
  hw/audio/intel-hda: Use memory region alias to reduce .rodata by
    4.34MB
  hw/net/e1000: Add readops/writeops typedefs
  hw/net/e1000: Move macreg[] arrays to .rodata to save 1MiB of .data
  hw/usb/quirks: Use smaller types to reduce .rodata by 10KiB
  ui/curses: Make control_characters[] array const
  ui/curses: Move arrays to .heap to save 74KiB of .bss
  virtfs-proxy-helper: Make the helper_opts[] array const

 hw/usb/quirks.h             | 22 +++++++++++++---------
 fsdev/virtfs-proxy-helper.c |  2 +-
 hw/audio/fmopl.c            |  8 +++++---
 hw/audio/intel-hda.c        | 24 ++++++++++--------------
 hw/net/e1000.c              |  6 ++++--
 hw/net/e1000e_core.c        |  6 ++++--
 hw/usb/quirks.c             |  4 ++--
 ui/curses.c                 | 10 +++++++---
 8 files changed, 46 insertions(+), 36 deletions(-)

--=20
2.21.1


