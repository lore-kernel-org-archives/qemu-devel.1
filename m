Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9A5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E04D20CC7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgtqJmFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E04D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrplo-0003Tu-Lm
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpkR-0001yI-Cs
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:30:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpkP-0003qA-H0
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u6ujgWiYU0GSvCKZfDXHXmA89oAGrzCembUDOl7/A6o=;
 b=UgtqJmFYvTSgiK+DLC5htsfNlCwwuR+BfCmJKve2apNlXFj9hmoWXLmGB3ZRN1q/AauiBc
 TvD52GCtGyZw8IJ6wuJlNt4FuHHsrW5PqFecy+xpbf/6vtSrtDAStcWGfqywwSHw+xkKvK
 o5l11OM6SjlPhmHDdtK4xGHw67Z/nXc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-WYCayG_GNmyNB_LarIKMvA-1; Sat, 04 Jul 2020 17:30:55 -0400
X-MC-Unique: WYCayG_GNmyNB_LarIKMvA-1
Received: by mail-wr1-f70.google.com with SMTP id b14so37050727wrp.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u6ujgWiYU0GSvCKZfDXHXmA89oAGrzCembUDOl7/A6o=;
 b=osZIt2v6jKrWtpdPvv/RUmcUW+CtTiaXLI20FmPVls/cLEmAPiqUp0rdi8h2PQEht/
 Vho6blNDb2KZ4nVF/fqJvRY6/MX2LesuUwvuuWkfbVH6eYl4s+0WuidOklfnF3w0+rdt
 EzwX0PQn+mbQVdhxnGuBnLc88MH58eqtoGQwS7bCR1XS3q6zvaoIGZ3cKcsjv+ziE1uU
 4dpJBKvsz9QvgyKpxqQdNO0nl9Kk5xJVdyTsnsa8lw/lEGlMFgVUI6dPKMZnJPo0Y10X
 3WM9Lo2anw87WruJ5tQCknl+LjuuCeaE8+NOt8y5dPJY+ZdEYngsRqqi9LWuRQ76KL3S
 YGqA==
X-Gm-Message-State: AOAM532uFiRSUB/D5T7qhpSNBBLFPvdr7Seb9JOCnQh5XXLgoFtmlKDd
 hrnQ7AMZrF4AASh9YK0jHWebrRZ8a0SP0uDCVs/oL9b903/NOwT2ZmH3/RshcJOMSVJLoEDYOFO
 n7q4tIjwdDspzaCw=
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr41749009wmh.8.1593898253865; 
 Sat, 04 Jul 2020 14:30:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvcxlEH0CgUIBg4PenRFdK7MxmIvggN9JG6DftwIikyDbPPv69b952zwMd+lAV0tGDkx/9/Q==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr41749002wmh.8.1593898253688; 
 Sat, 04 Jul 2020 14:30:53 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v7sm18774609wrp.45.2020.07.04.14.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:30:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 00/16] block/nvme: Various cleanups required to use
 multiple queues
Date: Sat,  4 Jul 2020 23:30:35 +0200
Message-Id: <20200704213051.19749-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:28:03
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is mostly code rearrangement (cleanups) to be
able to split the hardware code from the block driver code,
to be able to use multiple queues on the same hardware, or
multiple block drivers on the same hardware.

Missing review: 5, 6, 14, 15 and 16.

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

Please review,

Phil.

$ git backport-diff -u v2
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/16:[----] [--] 'block/nvme: Replace magic value by SCALE_MS definition'
002/16:[----] [--] 'block/nvme: Avoid further processing if trace event not enabled'
003/16:[----] [--] 'block/nvme: Let nvme_create_queue_pair() fail gracefully'
004/16:[----] [--] 'block/nvme: Define QUEUE_INDEX macros to ease code review'
005/16:[down] 'block/nvme: Improve error message when IO queue creation failed'
006/16:[down] 'block/nvme: Use common error path in nvme_add_io_queue()'
007/16:[----] [--] 'block/nvme: Rename local variable'
008/16:[----] [--] 'block/nvme: Use union of NvmeIdCtrl / NvmeIdNs structures'
009/16:[----] [--] 'block/nvme: Replace qemu_try_blockalign0 by qemu_try_blockalign/memset'
010/16:[----] [--] 'block/nvme: Replace qemu_try_blockalign(bs) by qemu_try_memalign(pg_sz)'
011/16:[----] [--] 'block/nvme: Simplify nvme_init_queue() arguments'
012/16:[----] [--] 'block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE'
013/16:[----] [--] 'block/nvme: Simplify nvme_create_queue_pair() arguments'
014/16:[down] 'block/nvme: Extract nvme_poll_queue()'
015/16:[down] 'block/nvme: Move nvme_poll_cb() earlier'
016/16:[0039] [FC] 'block/nvme: Use per-queue AIO context'

Philippe Mathieu-Daudé (16):
  block/nvme: Replace magic value by SCALE_MS definition
  block/nvme: Avoid further processing if trace event not enabled
  block/nvme: Let nvme_create_queue_pair() fail gracefully
  block/nvme: Define QUEUE_INDEX macros to ease code review
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
  block/nvme: Move nvme_poll_cb() earlier
  block/nvme: Use per-queuepair IRQ notifier and AIO context

 block/nvme.c | 268 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 148 insertions(+), 120 deletions(-)

-- 
2.21.3


