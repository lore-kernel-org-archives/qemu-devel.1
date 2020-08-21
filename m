Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5238EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1083F20FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJf7ngnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1083F20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9D89-0007Yp-0o
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D73-000684-Qt
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21087
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D71-0002dY-Az
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5dvDSTwK/sm4bmCoGMcnPXPBmiGf7AigqZtA3BenlX4=;
 b=eJf7ngnS4iJ0r6QX/jZvT+RHgzFmVnifNjnDsbqO5n8gJoRVaY0iYwXfe0mQD938Tozx0N
 DCvMgV5P0P1hTpywzdpXYoBjE1nKbvcu9jQ24Ru5TslPZP2m3Gzafc2OAKrx5JPM20kOIw
 Mc9WdxYqOZ+Pxe/IBOnYveq2ox/xYoM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-FG8ZFMe_MmmZ9uKbzX7TNw-1; Fri, 21 Aug 2020 15:54:03 -0400
X-MC-Unique: FG8ZFMe_MmmZ9uKbzX7TNw-1
Received: by mail-wr1-f70.google.com with SMTP id f7so899732wrs.8
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5dvDSTwK/sm4bmCoGMcnPXPBmiGf7AigqZtA3BenlX4=;
 b=keXY9z8iE3xVRE0gxi8nPiB4QvQ0xeA3qcDKAARo09c6tuE50gKBNk6VbCpMRKLuD1
 jhMIAbVy0noejYdILsZ3DnlC8iDcQVUrBjLAJW9TTtm/MIxkvDhp0arbFyDu+WWTh0qu
 vhXyKB8XWDjeqDI4qA9v8XbFSHwNRBH/onkb0XTQy5x4k4dT2BK8Cc/u1juvAYkZo7cV
 2sELVcFW/uVUKq90r7fp00pe/B2IRr1dxf9Rp8vrp9A5apOE69cSx9f8zhdvMmfRUfS9
 nx7MYimUq7VqvN3/2GGdxvGwCc6GA9TPDALyLvhj/Mg+Y1OZlJOIWgKaByfIUqjO0P5v
 DRaQ==
X-Gm-Message-State: AOAM5320UJI04sRPY1fT8pON0I2KKioQZnGizZCXH6qyS8N7Q+vPc0Ai
 zX6EnN3uWgrY21cPflnoBF/Tgj256vAOXXMDH2ihCjlVNcidSGuPpWqYaSmg2V78QiX3Snv6DKy
 O4YppHrlNRIqJXHs=
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr4156885wrn.345.1598039642139; 
 Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzTRlfXgLnVakGYfxU6VYIjVhaU45kH6qVx1tsykFeES+Jw3MBnyNQ6nz0y0CRJ/TuQ2zjwg==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr4156862wrn.345.1598039641767; 
 Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 3sm6909875wms.36.2020.08.21.12.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/15] block/nvme: Various cleanups required to use
 multiple queues
Date: Fri, 21 Aug 2020 21:53:44 +0200
Message-Id: <20200821195359.1285345-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kevin,

This series is mostly code rearrangement (cleanups) to be
able to split the hardware code from the block driver code,
to be able to use multiple queues on the same hardware, or
multiple block drivers on the same hardware.

All this series is reviewed.

Since v5:
- audit rebase on "block/nvme: support nested aio_poll"
- addressed Stefano's review comments
- added Stefano's R-b tags

Since v4:
- added 'block/nvme: Use an array of EventNotifier' patch

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

Philippe Mathieu-Daudé (15):
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
  block/nvme: Use an array of EventNotifier

 block/nvme.c | 211 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 125 insertions(+), 86 deletions(-)

-- 
2.26.2


