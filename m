Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8C4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8478206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5Ay+BPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8478206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1Zz-00058K-TC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <morecache@gmail.com>)
 id 1jg1Z9-0003lO-H8
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:42:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <morecache@gmail.com>)
 id 1jg1Z8-0000Ya-Jm
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:42:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h5so2279501wrc.7
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dl7qwPIjpiReQNrAUIJJVhycR1fAx/sgBtSqOt0jn5g=;
 b=d5Ay+BPfObaxqsRIjUExsIIhnhsOg1N06yvfIXhCXf8y1cn8qRDvdQ104zMJ+ewT0Y
 aVITlfZ/XvgxFQLDj5O1+pRtwfI7MM5T0c0Jwg0u8NdCmUUtF+CmZs1A0Z3FXl/zikMc
 Sok/WdH6iUH4VlTn9DVgQbJPBDrR6nFGFkxmviUnLAWxb5L0PMT5ynHwfmiyzH7NdrJN
 fCbmlbFQuKOVt8CxTPLevvm/y+RxBYySympq+/yxTFZXs8lhSWNZHrDio35+SMtb+z/Y
 YoS0z0xCS4wuJ6ejN0xq07PLD/TDVlBqjnC3CjoVUWD25TIdtMMKJnYaVgY7Sjez9Ax5
 SYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Dl7qwPIjpiReQNrAUIJJVhycR1fAx/sgBtSqOt0jn5g=;
 b=q2lSHIV9sRo5I05ha3jdLFzWFauqtoHmbAJNFAFU8h8p/WkkV8ly492sBqTXq+TmYs
 OEnalOc9I9U6PGUlGgMFSeG4sE02JLhdg017oe04BeDUiqQ1OI2Nrx4X3R2ZgOn99AX0
 qit5pxDR4sDGg/1AMVVymeOkOn3aY7qm6lV3UB2rQrZjOGu0GGtEkqs7DdEaAO37G1V1
 SeSByPWdHGMUSNhrpo5UvDvgc9LystzX7EdPAVaDFoNjQX5pvwSq9i6xzfBbwHbXg7eI
 Gt9Qlg5EtwI8bIH4M5Whgfg3CwqSxpjsmBweYhAlq2erwbjhy5HAYRNCeTcL0QEa/D7f
 v6ug==
X-Gm-Message-State: AOAM531c4n8S/NFI08yS0f/BqO2Zi3/Xd4rg4b42HvJeffhwDxQjMgPL
 mCk5hJnnDQyBtFJ0sCPR4AIcpRO5xGk=
X-Google-Smtp-Source: ABdhPJwzdTdWWqQDmu5doqECE4xAsiAOtEZHRg8phqtTw30HHGTnDKQRrdC8GWpKnWL4REHd/7VduQ==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr26042036wrp.338.1591083748002; 
 Tue, 02 Jun 2020 00:42:28 -0700 (PDT)
Received: from t440p.suse.asia (60-251-47-115.HINET-IP.hinet.net.
 [60.251.47.115])
 by smtp.gmail.com with ESMTPSA id w3sm2294518wmg.44.2020.06.02.00.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 00:42:27 -0700 (PDT)
From: Lin Ma <lma@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Add Support for GET LBA STATUS 16 command in scsi
 emulation
Date: Tue,  2 Jun 2020 15:41:57 +0800
Message-Id: <20200602074201.10879-1-lma@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=morecache@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: pbonzini@redhat.com, stefanha@redhat.com, Lin Ma <lma@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In this current design, The GET LBA STATUS parameter data only contains
an eight-byte header + one LBA status descriptor.

How to test:
host:~ # qemu-system-x86_64 \
...
-drive file=/vm0/disk0.raw,format=raw,if=none,id=drive0,discard=unmap \
-device scsi-hd,id=scsi0,drive=drive0 \
...


guest:~ # dd if=/dev/zero of=/dev/sda bs=512 seek=1024 count=256

guest:~ # sg_unmap -l 1024 -n 32 /dev/sda

guest:~ # sg_get_lba_status /dev/sda -l 1024
No indication of the completion condition
RTP=0
descriptor LBA: 0x0000000000000400  blocks: 32  deallocated

Lin Ma (4):
  block: Add bdrv_co_get_lba_status
  block: Add GET LBA STATUS support
  block: Add block accounting code for GET LBA STATUS
  scsi-disk: Add support for the GET LBA STATUS 16 command

 block/block-backend.c          | 38 ++++++++++++++
 block/io.c                     | 43 ++++++++++++++++
 hw/scsi/scsi-disk.c            | 92 ++++++++++++++++++++++++++++++++++
 include/block/accounting.h     |  1 +
 include/scsi/constants.h       |  1 +
 include/sysemu/block-backend.h |  2 +
 6 files changed, 177 insertions(+)

-- 
2.24.0


