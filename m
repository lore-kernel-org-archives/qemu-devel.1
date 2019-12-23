Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B46C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B02F20663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B02F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijRuw-0000Y1-71
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 12:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1ijRu3-0007uq-1B
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 12:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1ijRu2-00019y-3d
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 12:53:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1ijRtz-00014p-PL; Mon, 23 Dec 2019 12:53:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so13240826lfm.5;
 Mon, 23 Dec 2019 09:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=70ATbs8bPWzrnp3lDAUDWRJLJrMJ8ecBYWppY5sTlJI=;
 b=MRIU8WHKC1IdWL6OfphuD8aGN9MA4/5mNLjv9g6qkrcA2XHcTABuwLyJc8XIQDttJo
 DvznYlzY30qQ50jhw3QjfWmF+1+6X4NCjlKdAdDRabvj2YbRvAdaKV3Hc4bp1HtHzIp4
 nZPSiZNKZmyvg95vZMPWsKcAOhVl51SMWh6oZ4rRBcA24GwcX3CfNLYMD0mbhdmAOZ++
 /+J7MwDKzlLK7LCXxhpmOjS3rNIQtJLPha8hv7UEy4ywyrn90FBZN6KnINSVePaJWLOu
 9NopDKjqmSDIH1p5XDEc7jr6076cz/aFn2QZunzZR+CboGqAFMSWsvruITDLcZIWXyZe
 FCYQ==
X-Gm-Message-State: APjAAAWKLg18xPElErehlhUVREQKzU+HAqtAmoB/wjyIkdlYAqGaz3k9
 I/EJCWtbdWR+rzxKCewGWV8=
X-Google-Smtp-Source: APXvYqx3OtIhpfuc/A7KcmdZgOTDmV2kg6+w0dNpUqmWFnA9vyLmxJVcl+kRc6iiKYTL2cbb4mHdtw==
X-Received: by 2002:a19:f80a:: with SMTP id a10mr18056126lff.107.1577123634254; 
 Mon, 23 Dec 2019 09:53:54 -0800 (PST)
Received: from localhost.localdomain ([213.87.155.175])
 by smtp.gmail.com with ESMTPSA id y14sm8892345ljk.46.2019.12.23.09.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 09:53:53 -0800 (PST)
From: Alexander Popov <alex.popov@linux.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 pmatouse@redhat.com, sstabellini@kernel.org, mdroth@linux.vnet.ibm.com,
 pjp@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Alexander Popov <alex.popov@linux.com>
Subject: [PATCH v3 0/2] ide: Fix incorrect handling of some PRDTs and add the
 corresponding unit-test
Date: Mon, 23 Dec 2019 20:51:15 +0300
Message-Id: <20191223175117.508990-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.65
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

Fuzzing the Linux kernel with syzkaller allowed to find how to crash qemu
using a special SCSI_IOCTL_SEND_COMMAND. It hits the assertion in
ide_dma_cb() introduced in the commit a718978ed58a in July 2015.

This patch series fixes incorrect handling of some PRDTs in ide_dma_cb()
and improves the ide-test to cover more PRDT cases (including one
that causes that particular qemu crash).

Changes from v2 (thanks to Kevin Wolf for the feedback):
 - the assertion about prepare_buf() return value is improved;
 - the patch order is reversed to keep the tree bisectable;
 - the unit-test performance is improved -- now it runs 8 seconds
   instead of 3 minutes on my laptop.

Alexander Popov (2):
  ide: Fix incorrect handling of some PRDTs in ide_dma_cb()
  tests/ide-test: Create a single unit-test covering more PRDT cases

 hw/ide/core.c    |  30 +++++---
 tests/ide-test.c | 174 ++++++++++++++++++++---------------------------
 2 files changed, 96 insertions(+), 108 deletions(-)

-- 
2.23.0


