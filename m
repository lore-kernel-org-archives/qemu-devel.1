Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D55C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B032E206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qf4xAEmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B032E206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOza-0001hc-HU
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyR-0000Mt-Vy
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:04 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyQ-0003Ix-KI
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id k10so2669533wru.6
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8dO6pxE4z1oTaZMqwOd3lkigfm7zf47mhBiz92kiT9o=;
 b=qf4xAEmtk1l/CSmroEuAHMkUIV98SnpRptX8+KSMw0btsrR7pXOq9DmeAwh/H6oYSp
 fkc7RsmANZ67x07GPAZTHpL4gKpa/MBrv7vtCOa6bIhJAzkQZNR6M+p/xSVWzT26x8Mn
 1YBzXD1FyE6O60EW7x/nz3alnRfVi2Bg/8191v4WWFzDeN+HyuM/Fah6KAggOfQixVsq
 yPcKs+y0zDVIdZjYtQZbtwNmz5tj87OiVTA1rV4hM/r3+639KKKn/O6Q1/Ib/31zMfDv
 draNFnDqGD7ey4xkH7lvZZgUUApXkPRVTENcGXGCtqKqOs8IB5AZVmHEEOGeMrn7lze1
 4kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=8dO6pxE4z1oTaZMqwOd3lkigfm7zf47mhBiz92kiT9o=;
 b=JFLMfvz8Wrg6euxwKybdXl9/Ur5V7GADlUNLOWMMQ3pLqx3cyQiH/tqYe8RHVfbQ7G
 p9fbVTqzK3H0WcQgRwmunTJKk+wqbG8pO5/rIq7u4gw0yMFulVZZ8lN6lLFSlbIlvRII
 gfItE3uKFJnkRPQ4kNHZMHRVRZ4IbSC0HiymOUDqfScVOffUX7g2eF/aRzEP6G8TN1V9
 3avYi8QKW5iOZRZPbK98LwcmsbJ/E+s9NYtHaXZH4X16i6QsFgsN/9xFRnUg0yoH6mjC
 HvsVTgEth/37L4h9XHxcRSx5+RqlTXvhQiZk0cszj9waRVFR1zHLeoI9SwD73Rf6LqBX
 PSUA==
X-Gm-Message-State: AOAM532wVEe7nhSUDqw1BQcar3Tzp0pGELkaAn/4MbtXC4W6MiBb/hNc
 O9C6iijU10oaVsKKHnZ4cFxWAOWtjBQ=
X-Google-Smtp-Source: ABdhPJxs9jSesZd5HM0qAPoRRW1VQ2xsVwDm7C4nPu/VLypj9Ww/xV6sLI7xz/VoyEiysfBs6ZKV6Q==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr4028528wrv.195.1601660160249; 
 Fri, 02 Oct 2020 10:36:00 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id
 l8sm2516454wrx.22.2020.10.02.10.35.59 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:35:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/10] Fix scsi devices plug/unplug races w.r.t virtio-scsi
 iothread
Date: Fri,  2 Oct 2020 19:35:48 +0200
Message-Id: <20201002173558.232960-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

changes from previous version:
- add comment to patch 1
- fix testsuite breakage by not using drain_call_rcu in qmp_device_del

Maxim Levitsky (7):
  scsi/scsi_bus: switch search direction in scsi_device_find
  device_core: use drain_call_rcu in in qmp_device_add
  device-core: use RCU for list of children of a bus
  device-core: use atomic_set on .realized property
  scsi/scsi_bus: Add scsi_device_get
  virtio-scsi: use scsi_device_get
  scsi/scsi_bus: fix races in REPORT LUNS

Paolo Bonzini (3):
  qdev: add "check if address free" callback for buses
  scsi: switch to bus->check_address
  scsi/scsi-bus: scsi_device_find: don't return unrealized devices

 hw/core/bus.c                |  28 ++--
 hw/core/qdev.c               |  73 +++++++---
 hw/net/virtio-net.c          |   2 +-
 hw/scsi/scsi-bus.c           | 262 ++++++++++++++++++++++-------------
 hw/scsi/virtio-scsi.c        |  27 ++--
 hw/sd/core.c                 |   3 +-
 include/hw/qdev-core.h       |  24 +++-
 include/hw/scsi/scsi.h       |   1 +
 qdev-monitor.c               |  12 ++
 tests/qtest/drive_del-test.c |  10 +-
 10 files changed, 301 insertions(+), 141 deletions(-)

-- 
2.26.2


