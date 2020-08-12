Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C14C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268F82087C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ec4tRBWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268F82087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vqa-0001Ia-6E
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpS-0007z7-1p
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23681
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpO-0004UR-Rm
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PvNeJ/ov6u3t46DJZYV/gAu5tpHPR3D1BWOksjmW7fw=;
 b=Ec4tRBWNAt5QU3cKu03D6XJr4R/ZkNcHQN4B5usQraJky9z6cVqT0S+nqzjR5i31esHpFS
 OPzTF9YHSLPhXhUschWgHfiU5QI2098l1w+UlY4Ho4tr/4NuVBPoN2OyBinfWSUqqwqbEA
 wKyX2NY1BdocRtg/qcc/FvttqdfIM7A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-dqiBljE_Ohes37bNE3sHow-1; Wed, 12 Aug 2020 14:50:19 -0400
X-MC-Unique: dqiBljE_Ohes37bNE3sHow-1
Received: by mail-wr1-f69.google.com with SMTP id j2so1221043wrr.14
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PvNeJ/ov6u3t46DJZYV/gAu5tpHPR3D1BWOksjmW7fw=;
 b=sJ+Y5GxVeFph9LcVG6ReJ3WSwXZzNsYnHCl7lazYkGXUczjwh/+d/sQ1ZTNWU2rLB3
 /xD3xq1EdupMY0aPd/r0e3P63rjic6FKN/LIxzUajEjQ362qHnCPLi23/JfJ/OCjDovi
 abSkyJqu4m5Cqw8qWGGHU762j7MsGjZ6C3p8eI2b8PO1EnfgZQAAsAm5kV/N0P+G+KCH
 5v6yP6XSRe9mQjRswpIMvCtklUc57J1RjRgY1f3QMuLTvFGwfQFbPGHGDQLcp+1+3jJo
 MNyEyCQVmvX3GIocT34B8vIg4hTqKnrSY/JcuxtU8XrVDW/Ds4VR0pUzCG4fgSMKtyWc
 Mf3w==
X-Gm-Message-State: AOAM530LlA64f3DSMLTWZLOIdN0hN68c+rfGUxpf5d1Gavyp5KeqTHox
 +M7Qxxy7ANndJ9YQY3JCLNCYZlntkdVZUck0Q7YFsN58VJkBhpFtOjlpJ8x6fd4CJeLu1E1r9tR
 DK3Q/LfYlQH5wt18=
X-Received: by 2002:a1c:6845:: with SMTP id d66mr944012wmc.36.1597258218332;
 Wed, 12 Aug 2020 11:50:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi6LvHc2pnHQyEz8M5FniEmtr8MGXLP/fcsbOIu8qYVQU2G9iQtI5+eOGP5aqzq2dFd+Rt/Q==
X-Received: by 2002:a1c:6845:: with SMTP id d66mr943993wmc.36.1597258218008;
 Wed, 12 Aug 2020 11:50:18 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id k4sm5883917wrd.72.2020.08.12.11.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:50:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/14] block/nvme: Various cleanups required to use
 multiple queues
Date: Wed, 12 Aug 2020 20:50:00 +0200
Message-Id: <20200812185014.18267-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 03:52:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is mostly code rearrangement (cleanups) to be
able to split the hardware code from the block driver code,
to be able to use multiple queues on the same hardware, or
multiple block drivers on the same hardware.

All this series is reviewed.

Since v3:
- renamed QUEUE_INDEX_{ADMIN/IO} -> INDEX{ADMIN/IO}
- added stefanha tags

Since v2:
- addressed stefanha review comments
- added 4 trivial patches (to simplify the last one)
- register IRQ notifier for each queuepair (admin and io)

Since v1:
- rebased
- use SCALE_MS definition
- added Stefan's R-b
- addressed Stefan's review comments
  - use union { NvmeIdCtrl / NvmeIdNs }
  - move irq_notifier to NVMeQueuePair
  - removed patches depending on "a tracable hardware stateo
    object instead of BDRVNVMeState".

Phil.

Philippe Mathieu-Daudé (14):
  block/nvme: Replace magic value by SCALE_MS definition
  block/nvme: Avoid further processing if trace event not enabled
  block/nvme: Let nvme_create_queue_pair() fail gracefully
  block/nvme: Define INDEX macros to ease code review
  block/nvme: Improve error message when IO queue creation failed
  block/nvme: Use common error path in nvme_add_io_queue()
  block/nvme: Rename local variable
  block/nvme: Use union of NvmeIdCtrl / NvmeIdNs structures
  block/nvme: Replace qemu_try_blockalign0 by qemu_try_blockalign/memset
  block/nvme: Replace qemu_try_blockalign(bs) by
    qemu_try_memalign(pg_sz)
  block/nvme: Simplify nvme_init_queue() arguments
  block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
  block/nvme: Simplify nvme_create_queue_pair() arguments
  block/nvme: Extract nvme_poll_queue()

 block/nvme.c | 180 +++++++++++++++++++++++++++++----------------------
 1 file changed, 104 insertions(+), 76 deletions(-)

-- 
2.21.3


