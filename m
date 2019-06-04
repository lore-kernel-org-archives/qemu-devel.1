Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5481C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A487823A54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU23sxrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A487823A54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47439 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY40R-0002KQ-9N
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:37:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hY3ym-0001Ev-5j
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hY3yl-0003Qr-16
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:32 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hY3yk-0003Fd-K0
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:30 -0400
Received: by mail-pf1-x442.google.com with SMTP id s11so12137655pfm.12
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=nx44WZQ5GNJlSpzFwdKmrCxN5MW+P4IhW7KSe688TjI=;
	b=BU23sxrnFFY2rECzHWlPmWIEt1puQmjfmVZNeqVAdRiwEomCYsFE5D+K22+ElthMVJ
	4HHBT1/JgzVDxLKqsSlK9MSvEw6e/qjC3b3gjRsckqUTSUXCBiJdeaqTgbu1UVcw6BUY
	N6eDMkUvu4JMzsUaRiKM6R9cpvZVSvw5Y+qhvZIZLZR2OJgWfDsJVTaSUeryaM6bYhFj
	/n2mg763JKTTE9nPAwnVDSWJE2ZKuvCVtH5IqT6yPI/Qnev6UTAK8zsykhxbfHu9bPJe
	ZY9VrnF3T9U/u4PJk0gOKyS9dkiVLV2E9ZT8S8mMkEB/1+V55UMx91M5Ngk9qGUUt9Et
	MfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=nx44WZQ5GNJlSpzFwdKmrCxN5MW+P4IhW7KSe688TjI=;
	b=V8Vees0FxYeL0zHgr2X5uzP6aeTQVwFUjhckf6R2kbURKaUVFqaDS0K/fOKblXj2YO
	zFkqiHsh/O5uchgmDBT40N/1pn9H/dYdYhSPzqAtucaTiHSILu4mhwE7mG8Ljnpor/5K
	licGU31tHwU+ST7dbhgYTJTxOwMu5/DGKuJVVtd899cMi1g5D9rTurgPjw5gVFkZetBA
	AFtL2x2XMFIYwP+yE/VsadQpaZAleTl6QV336XJpPOVj1EnPzyoqs4WX7Y3TZoCgQVj7
	rokRRgP0Q5Zd3xt35nUnjXw7oF3Wed88soY0zfwKkH2boFSFap5Nky8N/Va2RwOPWi0B
	6TdQ==
X-Gm-Message-State: APjAAAW82WG/toARBi5N7q/fd/2Oj6CH8lGUqcoad0eYsXCYRSA7iItW
	11C/3TMd6nwArb/KfedCd8o=
X-Google-Smtp-Source: APXvYqyfkH7xSy55cYHfFkRAngzq5bHRHYToKshZfN1+0bqHtR/Z9UWoLvlyJIE3LL3rSgyWtb0FOg==
X-Received: by 2002:a62:5387:: with SMTP id h129mr37505229pfb.6.1559633728122; 
	Tue, 04 Jun 2019 00:35:28 -0700 (PDT)
Received: from localhost ([116.247.112.152]) by smtp.gmail.com with ESMTPSA id
	d21sm8193035pfr.162.2019.06.04.00.35.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 04 Jun 2019 00:35:27 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Tue,  4 Jun 2019 15:34:54 +0800
Message-Id: <20190604073459.15651-1-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 0/5] virtio: fix some issues of "started"
 and "start_on_kick" flag
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Xie Yongji <xieyongji@baidu.com>, dgilbert@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

We introduced two flags "started" and "start_on_kick" to indicate virtio
device's state before. But there still are some problems with them. So
we try to fixup them in this patchset.

The patch 1 fixes a regression bug that old guest is not able to boot with
vhost-user-blk device.

The patch 2 set "start_on_kick" flag for legacy devices.

The patch 3,4 fix some problems with "started" and "start_on_kick" flag.

The patch 5 introduces a "use-started" property to avoid a migration
issue under Greg Kurz's suggestion [1].

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06247.html

v2:
- Recalculate "start_on_kick" flag after migration instead of migrating
  it
- Set "start_on_kick" flag for legacy devices
- Avoid setting "started" flag when "use_started" property is true
- Set "use_started" to false by hw_compat_4_0_1 instead of hw_compat_4_0

Xie Yongji (5):
  virtio: Set "start_on_kick" on virtio_set_features()
  virtio: Set "start_on_kick" for legacy devices
  virtio: Make sure we get correct state of device on
    handle_aio_output()
  virtio: Don't change "started" flag on virtio_vmstate_change()
  virtio: add "use-started" property

 hw/block/vhost-user-blk.c  |  4 +--
 hw/core/machine.c          |  4 ++-
 hw/virtio/virtio.c         | 53 ++++++++++++++++++++++----------------
 include/hw/virtio/virtio.h | 23 ++++++++++++++++-
 4 files changed, 58 insertions(+), 26 deletions(-)

-- 
2.17.1


