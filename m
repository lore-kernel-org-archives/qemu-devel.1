Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5457C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F3424969
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="SX4O32lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F3424969
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2iv-0005Pm-OV
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2bR-0000rw-N9
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:59:45 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2bP-0006cN-Uf
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:59:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id u16so10445387wmc.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=vcmawNGolcSr0FlfA8Z05/mM0RwBuCRKaqBzUPxedkw=;
 b=SX4O32lzEB13Jm8tv+YOWCp4+ImlVBmEaNxloqZYtCx12rycD1sDzG+kZjDODHTt1b
 ckoIOGGPDXa/SfS0WuKNykYkXh1OkrVWjEHrlIxZUVlM3Ag3dV+cH0ow5cldoeT77/vv
 N0AiOAjJVbjEVib9redkFlrDkLQZYVzBt3121Bj89ZdtGOgZ0qxuEGetMqMEF6acJy8w
 nFmWknAzXWNwDKuiBws9JoOp1gV7xka3o0QhjRtV35xGWBHmYMzcaE7JIW/7yjbe69AR
 2wuA3O6ey0QsfvzULzgN0ew2/T2O4LIV9IU6GjxcgAmck64mPGDIPeA+dhBJfj0kLdv+
 /vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=vcmawNGolcSr0FlfA8Z05/mM0RwBuCRKaqBzUPxedkw=;
 b=NbVgzV+GtAO9z6PNcXxGjczlop9dlNc/cYIpG28stH/Y4/htUmHeXX7k+V4yssLqg3
 a7gDQCwpswWKYoY2Xzd5+gzLghPTA+mLsRB7wuAqMuUJDkzACLu2xVDwHuCy6CosAE4i
 spLyxWySrr52oV3wCLc/yVEr1Wu2qN7BM7zBezZ04CKwH03iAe8ORtZCNanyETQFgMVp
 SbQoLcoLDPDkytvpaYOGw5AyJci+bAfcjwG/pbw4/iavTbQAwMS4NWrw4RsJL+NqzsNV
 i7jROhInkxXheujXmhbHyQLUPzNFWpVYt7SJReECllLMbW2SkpfR1Ou0ey456GFfM/Cs
 38zQ==
X-Gm-Message-State: AGi0PubcVS/Fa4jC8VJVpejEaq6EWAlBUboasyVN12+cECJhppxNdlVt
 Pkr0MtbNW5Tp/BPyvzuWoQYCx0vwcxqi0g==
X-Google-Smtp-Source: APiQypKftAYF1/Wo36/M1oP2BrQvFh07TktlgoLFbqDnruM2DkLkEEjencAICorC+rs5vvSWBcbNbw==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr16792095wmb.4.1588942782269; 
 Fri, 08 May 2020 05:59:42 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-19-16.red.bezeqint.net.
 [79.183.19.16])
 by smtp.gmail.com with ESMTPSA id g6sm2915974wrw.34.2020.05.08.05.59.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 May 2020 05:59:41 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v8 0/7] reference implementation of RSS and hash report
Date: Fri,  8 May 2020 15:59:27 +0300
Message-Id: <20200508125934.7861-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
features in QEMU for reference purpose.
Implements Toeplitz hash calculation for incoming
packets according to configuration provided by driver.
Uses calculated hash for decision on receive virtqueue
and/or reports the hash in the virtio header

Changes from v7:
Patch 7.1: removed (RSS and hash report definitions)
Patch 7.2: delete configuration struct with RSS definitions
Patch 7.4: delete duplicated packet structure
Added patch 7 - adapt RSC definitions to updated header

Yuri Benditovich (7):
  virtio-net: implement RSS configuration command
  virtio-net: implement RX RSS processing
  tap: allow extended virtio header with hash info
  virtio-net: reference implementation of hash report
  vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
  virtio-net: add migration support for RSS and hash report
  virtio-net: align RSC fields with updated virtio-net header

 hw/net/trace-events            |   3 +
 hw/net/virtio-net.c            | 387 +++++++++++++++++++++++++++++----
 include/hw/virtio/virtio-net.h |  16 ++
 include/migration/vmstate.h    |  10 +
 net/tap.c                      |   3 +-
 5 files changed, 379 insertions(+), 40 deletions(-)

-- 
2.17.1


