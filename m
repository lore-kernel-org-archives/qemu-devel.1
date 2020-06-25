Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0DCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D8520789
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsFPvuKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D8520789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWwt-0000ll-BI
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvb-0007df-73
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:48:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvY-0000tD-QH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cn/BtvxMkNXmbHqa5rKXoH5P08BLfhrfSDBAMmkSsss=;
 b=RsFPvuKwXcZf3CUzIgnjEVQ/48h2Hhp68sb8SyS+FjNDYWMCk7dMvfv0mHmnWHopAWP9zX
 F7iTMWMXsFaHSynYgyeHwCU7J3kUso0jtqPvx8DYB8Bu3xIWuD07PEXGe0QRi50+63JRzJ
 WEwBCvkCBjs5cBh4Orjg+lmCYZnVyRQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-Ma0PgyGAMQSmtewQvJeL6g-1; Thu, 25 Jun 2020 14:48:42 -0400
X-MC-Unique: Ma0PgyGAMQSmtewQvJeL6g-1
Received: by mail-wm1-f71.google.com with SMTP id b13so5754289wme.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Cn/BtvxMkNXmbHqa5rKXoH5P08BLfhrfSDBAMmkSsss=;
 b=PZNbv9I262REa5OFSgkHghIzip/3lMV97UZ/xvI6boMbWR24hWht/K6Pc4jYENVBmX
 S0CAXvUVNIbhfjin+r8cTAiUjh8zSCTy5pS345VkVs9JWsWm/FNiV7qmeL3m1EQ+kmYl
 Cnu98/QmByzrtWmS8TG8Lz8ejII2pDUO91YtB14mKkrD5gsWwp0BKrdU6dEioa7Y9O1L
 Qsnc2t/MRNUe753EJ7HNt14JUc31Uby8Q8IoeVWwOsOwT/NszGoRQvIrVflP1iZdJ08Z
 r14RSnXSTPoNrjtIAN66aZrceGLKiWQhX+04OVt6O9yqIBprSnbCDXHg9m2elMsfDwuO
 1Yog==
X-Gm-Message-State: AOAM533z2jpY5WZltEoGJ0AhUTRDD8QGG4A8OfbTXVw0okHQYC9kCGm0
 fGR9zNaX/Hm5sjhZh1JGtSrBpkC9qttfLWvwxxZJu9SLZKU8xOzc+bd1g8fCC9R/E7mnRhFAv0n
 I9oyX8IRVqlGqdYk=
X-Received: by 2002:a05:6000:1006:: with SMTP id
 a6mr19314314wrx.332.1593110920749; 
 Thu, 25 Jun 2020 11:48:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznoPY4gx9S5aAg/JDt6THrW6BMuXQ1eGDndMVk43nt7goEMrsls3lfwQm7OlgxAyhRl3n67w==
X-Received: by 2002:a05:6000:1006:: with SMTP id
 a6mr19314294wrx.332.1593110920504; 
 Thu, 25 Jun 2020 11:48:40 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm2890763wrj.48.2020.06.25.11.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:48:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 00/17] block/nvme: Various cleanups required to use multiple
 queues
Date: Thu, 25 Jun 2020 20:48:21 +0200
Message-Id: <20200625184838.28172-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is mostly code rearrangement (cleanups) to be
able to split the hardware code from the block driver code,
to be able to use multiple queues on the same hardware, or
multiple block drivers on the same hardware.

Flushing my current patch queue.

Regards,

Phil.

Based-on: <20200625162602.700741-1-eblake@redhat.com>
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08384.html

Philippe Mathieu-Daudé (17):
  block/nvme: Avoid further processing if trace event not enabled
  block/nvme: Let nvme_create_queue_pair() fail gracefully
  block/nvme: Define QUEUE_INDEX macros to ease code review
  block/nvme: Be explicit we share NvmeIdCtrl / NvmeIdNs structures
  block/nvme: Replace qemu_try_blockalign0 by qemu_try_blockalign/memset
  block/nvme: Replace qemu_try_blockalign(bs) by
    qemu_try_memalign(pg_sz)
  block/nvme: Move code around
  block/nvme: Use correct type void*
  block/nvme: Remove unused argument from nvme_free_queue_pair()
  block/nvme: Simplify nvme_init_queue() arguments
  block/nvme: Simplify nvme_create_queue_pair() arguments
  block/nvme: Simplify nvme_kick trace event
  block/nvme: Simplify completion trace events
  block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
  block/nvme: Use per-queue AIO context
  block/nvme: Check BDRVNVMeState::plugged out of nvme_kick()
  block/nvme: Check BDRVNVMeState::plugged out of
    nvme_process_completion

 block/nvme.c       | 160 ++++++++++++++++++++++++++-------------------
 block/trace-events |   8 +--
 2 files changed, 96 insertions(+), 72 deletions(-)

-- 
2.21.3


