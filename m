Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D227DC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE3024672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8GZRRFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE3024672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMtA-0003ga-7M
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1irMsH-0002iS-VD
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1irMsG-0007od-M6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:08:53 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1irMsG-0007nI-GH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:08:52 -0500
Received: by mail-pg1-x541.google.com with SMTP id a33so6444350pgm.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 06:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eqpHpcBHEyjdo/6G7dO0iakVYP03mTE30OY47PRFuaw=;
 b=r8GZRRFeMC1PGSmggHdcECJhk4UAVeRdMySbq74E0jIJGAZt92BlnK2IwUTy2WS7A9
 VWyrCWuKPgT1YZ2u0oDCPCgurMea3wU+hszc7d/ohQMCnytcNXGcdECF33b55vV4Kp9V
 tp8JFCNetdHByAJXiXYLabiD9KOTyVvwicr5PSubiirGAkfffF0qwkSCW3l1WGfjbwpU
 mng7kzTo1ge5h8XkAA2ezIMSnbm7qtTfsnBaKu3+y1b32LuApl77AL9FHLby7/VFcoXc
 Gf4OvhpUgE4bNE1xBWhcFwr3HMVBtwXZg83wMkXAjDYcydAF5fo1g5jejigagq30d8Xp
 JY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eqpHpcBHEyjdo/6G7dO0iakVYP03mTE30OY47PRFuaw=;
 b=PpzvXpP07GeDuy0WIAtlAGuNcfN0/nlBjxqmaNE3YCioQtKYnvngU+UpxhOqW+C0BN
 DTH80ledy2QVwEBTk2LxWa8Tx4z6QVOr/DGuGajogFjCRfOgDep+DeUr2BjnWthWHZ0i
 PPwAgxx+REUtfYu+roxudbsugQQ6Rp9srs8Bq+C5E/AbsBrAQ1ftj1KbQifn9xbjmPLL
 Ms+usNqrZqlCqIudRjcPd3WHVrjQyvV6oxjnoY/VMHkfJCxdrK45iFKfhOZ/b+Suuu7n
 nJuXW+PWfVrMyGAXlMvDRf+sHUXG58h/I+n5qxjUq4PpZMWd14HqGtNUz8fwkGcm8G25
 V+Hg==
X-Gm-Message-State: APjAAAWR5OwtVeD9Ja9NLg0FPL6SZEG/AspK/NdFklSgrqVevodHrdYU
 S6M+vVtFRL5ik+gp/oixGCST2UUY8a4Jng==
X-Google-Smtp-Source: APXvYqzcASPZrXMUfutlKAAtUON3/pnua1JB27hfFGlCuQD5OPhvWXX8BPdHcO3PYBGzASaJzRE6EQ==
X-Received: by 2002:aa7:98d0:: with SMTP id e16mr24723326pfm.77.1579010930361; 
 Tue, 14 Jan 2020 06:08:50 -0800 (PST)
Received: from localhost.localdomain ([175.124.145.172])
 by smtp.googlemail.com with ESMTPSA id a17sm17264773pjv.6.2020.01.14.06.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 06:08:49 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] vhost-user block device backend implementation
Date: Tue, 14 Jan 2020 22:06:15 +0800
Message-Id: <20200114140620.10385-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

v2:
 * Only enable this feauture for Linux for eventfd is a Linux-specific
   feature

This patch series is an implementation of vhost-user-backend server, thanks to Stefan's guidance after reviewing the draft version and the instructions on https://wiki.qemu.org/Google_Summer_of_Code_2019#vhost-user-blk_device_backend,

Vhost-user-backend server is a UserCreatable object and can be started using object_add,

 (qemu) object_add vhost-user-server,id=ID,unix_socket=/tmp/vhost-user-blk_vhost.socket,name=DRIVE_NAME,writable=off
 (qemu) object_del ID

or appending the "-object" option when starting QEMU,

  $ -object vhost-user-server,id=disk,unix_socket=/tmp/vhost-user-blk_vhost.socket,name=disk,writable=off

Then vhost-user client can connect to the server backend. For example, QEMU could act as a client,
  $ -m 256 -object memory-backend-memfd,id=mem,size=256M,share=on -numa node,memdev=mem -chardev socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket -device vhost-user-blk-pci,id=blk0,chardev=char1

And guest OS could access this vhost-user block device after mouting it.

patches are against commit 035eed4c0d257c905a556fa0f4865a0c077b4e7f.

Coiby Xu (5):
  vhost-user block device backend
  extend libvhost to support IOThread
  a standone-alone tool to directly share disk image file via vhost-user
    protocol
  new qTest case for the vhost-user-blk device backend
  building configuration files changes

 Makefile                              |    1 +
 Makefile.objs                         |    2 +-
 Makefile.target                       |    1 +
 blockdev-vu.c                         | 1008 +++++++++++++++++++++++++
 configure                             |    2 +-
 contrib/libvhost-user/libvhost-user.c |   64 +-
 contrib/libvhost-user/libvhost-user.h |   36 +-
 include/block/vhost-user.h            |   46 ++
 qemu-vu.c                             |  264 +++++++
 tests/Makefile.include                |    5 +-
 tests/libqos/vhost-user-blk.c         |  125 +++
 tests/libqos/vhost-user-blk.h         |   44 ++
 tests/vhost-user-blk-test.c           |  691 +++++++++++++++++
 vl.c                                  |    4 +
 14 files changed, 2277 insertions(+), 16 deletions(-)
 create mode 100644 blockdev-vu.c
 create mode 100644 include/block/vhost-user.h
 create mode 100644 qemu-vu.c
 create mode 100644 tests/libqos/vhost-user-blk.c
 create mode 100644 tests/libqos/vhost-user-blk.h
 create mode 100644 tests/vhost-user-blk-test.c

--
2.24.1


