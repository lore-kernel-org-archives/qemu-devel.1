Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FF3C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 17:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8313120721
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGXVy3uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8313120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jf55w-0007UK-MA
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 13:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jf54b-0006Wq-B9
 for qemu-devel@nongnu.org; Sat, 30 May 2020 13:15:05 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:46954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jf54Y-00035u-Pd
 for qemu-devel@nongnu.org; Sat, 30 May 2020 13:15:05 -0400
Received: by mail-pg1-x52c.google.com with SMTP id p21so1428521pgm.13
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FvO26/xgMag/yX++zMrFrB9DA7FvQUcqwhSlYfN6mb4=;
 b=eGXVy3ujf273KK2E+tgttR5jFMydVfmNZgQwb2TSz5pCVkGzr4hWyDXDWFo5WQSr6I
 xI2FTDJFAEaHHRXK5sKFrJiwZA3uw0AQEQZBhVi6Jg5FkqB0p25CuodyTKAAQeheggJ6
 JL975vVMUveZeBTUeliAWhqovuG+Wo05mrtMnbsv7HNsMElHWh6Jd/zDJCpgMYkdAUZ6
 XpjOw4aZM1l2CdqgxSTXy5lEZ0xwExp8GSjqolIs+e1c9hoDnFcHfkU28tIKGpFIL0TN
 kR4E3/uiDw8HyfA3R/jeWJUVhBjqcIYIJFPBgPNk74fFN8L9UzmQUu0XuK5ZRcCKL34S
 neUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FvO26/xgMag/yX++zMrFrB9DA7FvQUcqwhSlYfN6mb4=;
 b=FGYis9y1FlVcRJHaRDNmkvyInwALp+K1OeKLRVfL4L9kgw1K2KbM94McphrXCk70dH
 0wH50+jP006SXN0LRJPQrpLvI2Um22AhQ902JhVAheF8OJUwmkbQQCJKkEUaTbBiWnTZ
 Ef56+8Bzf55lJQrxOJQzDRef1BZ9eiHh5cgk/HgUgu+s+fptt931FInRmvIqhsxOXc57
 Qb+SxV78syiGRAC98FIhuQOwDFE+V3PcoMk5dcbjJDpvxfbwz9dBY817ez9/OoV/HuDV
 A/huQK36WT4J1x6KL12pCRcUZwDjc5Kb2V69eqhQIvlNFKmcKR/9o49cwnGtgC83L0O7
 yIRg==
X-Gm-Message-State: AOAM5315HW4BjNH/kKqUIfrL3qzgoOZ+0tp528JjRFPfrNnGmBEZi2zR
 EkJdShMLqzwT5H3BtNkBoouNSkwNZaoQxA==
X-Google-Smtp-Source: ABdhPJxOexIOxV+kI05iLL+rMq701HB6+JqU0LhSMkgfcv9LFvsGmSnaXmNyoi9geyURCL7dq6AN8g==
X-Received: by 2002:a63:78b:: with SMTP id 133mr13717271pgh.161.1590858899810; 
 Sat, 30 May 2020 10:14:59 -0700 (PDT)
Received: from localhost.localdomain
 (tunnel570486-pt.tunnel.tserv25.sin1.ipv6.he.net. [2001:470:35:3d5::2])
 by smtp.googlemail.com with ESMTPSA id 191sm1229731pfy.161.2020.05.30.10.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 10:14:59 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/4] vhost-user block device backend implementation
Date: Sun, 31 May 2020 01:14:37 +0800
Message-Id: <20200530171441.660814-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=coiby.xu@gmail.com; helo=mail-pg1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, Coiby Xu <coiby.xu@gmail.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v6
 - add missing license header and include guard
 - vhost-user server only serve one client one time
 - a bug fix in custom vu_message_read
 - using qemu-storage-daemon to start vhost-user-blk-server
 - a bug fix to pass docker-test-clang@ubuntu

Coiby Xu (4):
  Allow vu_message_read to be replaced
  generic vhost user server
  vhost-user block device backend server
  new qTest case to test the vhost-user-blk-server

 block/Makefile.objs                        |   1 +
 block/export/vhost-user-blk-server.c       | 715 ++++++++++++++++++++
 block/export/vhost-user-blk-server.h       |  34 +
 contrib/libvhost-user/libvhost-user-glib.c |   2 +-
 contrib/libvhost-user/libvhost-user.c      |  11 +-
 contrib/libvhost-user/libvhost-user.h      |  21 +
 softmmu/vl.c                               |   4 +
 tests/Makefile.include                     |   3 +-
 tests/qtest/Makefile.include               |   2 +
 tests/qtest/libqos/vhost-user-blk.c        | 126 ++++
 tests/qtest/libqos/vhost-user-blk.h        |  44 ++
 tests/qtest/libqtest.c                     |  44 +-
 tests/qtest/libqtest.h                     |  38 ++
 tests/qtest/vhost-user-blk-test.c          | 741 +++++++++++++++++++++
 tests/vhost-user-bridge.c                  |   2 +
 tools/virtiofsd/fuse_virtio.c              |   4 +-
 util/Makefile.objs                         |   1 +
 util/vhost-user-server.c                   | 404 +++++++++++
 util/vhost-user-server.h                   |  59 ++
 19 files changed, 2216 insertions(+), 40 deletions(-)
 create mode 100644 block/export/vhost-user-blk-server.c
 create mode 100644 block/export/vhost-user-blk-server.h
 create mode 100644 tests/qtest/libqos/vhost-user-blk.c
 create mode 100644 tests/qtest/libqos/vhost-user-blk.h
 create mode 100644 tests/qtest/vhost-user-blk-test.c
 create mode 100644 util/vhost-user-server.c
 create mode 100644 util/vhost-user-server.h

--
2.26.2


