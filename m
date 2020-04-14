Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98531C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F396206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alUJg5GD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F396206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOab-0001xp-5P
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOTw-0008C6-5Y
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOTv-0001Su-1c
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:32:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57621
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLeU-0008AW-Uy
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WpXqVRWnwC/7fduD19tFiabBEgGygCctCEDBIM8aWy0=;
 b=alUJg5GDp2rof1gWIFzWwR9WTU7KyOxoRcwyjG8dnUrAko2a3bqc0i5kBgAMSDKZkl1j3y
 WkHgzB2YRieRlzbWMKCQkmCFuU1Cf1lD3IUEA+dg5O3UPKh0MR2891VzVDzPaGBkIV7sCx
 NWd1TnlDZfw4qgdIFHezQpAjSyfJP2Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-95bRvRR0MHe9JsvYzsoG2g-1; Tue, 14 Apr 2020 09:30:57 -0400
X-MC-Unique: 95bRvRR0MHe9JsvYzsoG2g-1
Received: by mail-wr1-f71.google.com with SMTP id s11so3807767wru.6
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uc7TJUs/ixiFyqutC9VIpB13KeQ267/XOs+rA8uW20U=;
 b=NE8CETHU+cDhFgT7KRpJkjTfuVNUPW34OBG5Qpy5F08OOl+yaj1Q7PbqXMB/yW2pyv
 WUJF3UDS0laFKBl2qhKH3rqznSqAaSj4sQytFIJYpl0LwjK+zp9xEFQhgN3EzI5IcUwA
 b/d0BcMrpkQKqyHjdy09NwOP7InAr80RYL4rgGP4Z4Wk/leW22EOKBuzcFfENFTZakwd
 bgXlThmuIowoZ9sYk16H91q28LoePr6v2NvcUXOx2+WBZBlOJCQfuvMqMLFmrGk2AI/k
 aoka0COpIYu2zI9+Q/itsKOLPDvREbPT2F+FywKy7eoRKsGxlnANndIp1iiHo9k68yUB
 a8wQ==
X-Gm-Message-State: AGi0PuY+f1A64j2aueIYzy/XiG29sLeoksGrwauhxL9uREZHFIyAnVaB
 d8sHKlxcDT14fOpYXQBsIQu6DBDj4KTB1xUPBNw7xGv9r1PlxDVdWJKO4kaZZomXWY14OQkfT+b
 6DY8FhAA8wc4liVE=
X-Received: by 2002:a05:600c:29c2:: with SMTP id
 s2mr12029760wmd.111.1586871055679; 
 Tue, 14 Apr 2020 06:30:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypLTafOtZRvlulCPIwRXNLeuETKKAKgsl+vdMjDDb2Z6iAXkvUkCko6Ky3XslGGxi+LvLKJXgg==
X-Received: by 2002:a05:600c:29c2:: with SMTP id
 s2mr12029726wmd.111.1586871055365; 
 Tue, 14 Apr 2020 06:30:55 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v1sm14490755wrv.19.2020.04.14.06.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 06:30:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 00/12] various bugfixes
Date: Tue, 14 Apr 2020 15:30:40 +0200
Message-Id: <20200414133052.13712-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Collection of bugfixes for 5.0.

Only vhost-user-gpu/grlib_ahb_apb_pnp patches are reviewed.

As 5.0-rc3 is tomorrow, I thought it could help to gather
them and resend altogether.

Regards,

Phil.

Mansour Ahmadi (1):
  hw/block/pflash: Check return value of blk_pwrite()

Philippe Mathieu-Daud=C3=A9 (11):
  Revert "prevent crash when executing guest-file-read with large count"
  qga: Extract guest_file_handle_find() to commands-common.h
  qga: Extract qmp_guest_file_read() to common commands.c
  qga: Restrict guest-file-read count to 48 MB to avoid crashes
  vhost-user-gpu: Release memory returned by vu_queue_pop() with free()
  hw/openrisc/pic_cpu: Use qdev gpio rather than qemu_allocate_irqs()
  hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
    registers
  hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
  hw/display/sm501: Avoid heap overflow in sm501_2d_operation()
  gdbstub: Do not use memset() on GByteArray
  gdbstub: Introduce gdb_get_freg32() to get float32 registers

 qga/qapi-schema.json                    |  6 +++--
 include/exec/gdbstub.h                  | 22 ++++++++++++++++
 qga/commands-common.h                   | 21 +++++++++++++++
 contrib/vhost-user-gpu/vhost-user-gpu.c |  4 +--
 contrib/vhost-user-gpu/virgl.c          |  2 +-
 hw/block/pflash_cfi01.c                 |  8 +++++-
 hw/block/pflash_cfi02.c                 |  8 +++++-
 hw/display/sm501.c                      |  6 +++++
 hw/misc/grlib_ahb_apb_pnp.c             | 11 ++++++++
 hw/openrisc/pic_cpu.c                   |  5 ++--
 qga/commands-posix.c                    | 29 +++++---------------
 qga/commands-win32.c                    | 35 ++++++-------------------
 qga/commands.c                          | 33 +++++++++++++++++++++++
 target/arm/gdbstub.c                    |  3 +--
 target/sh4/gdbstub.c                    |  6 ++---
 target/xtensa/gdbstub.c                 |  6 ++---
 16 files changed, 136 insertions(+), 69 deletions(-)
 create mode 100644 qga/commands-common.h

--=20
2.21.1


