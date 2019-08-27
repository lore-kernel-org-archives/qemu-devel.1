Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A42C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47D421881
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuSUMvAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47D421881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2gjT-0001TU-Mm
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 15:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i2gga-0008JQ-Ar
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i2ggZ-0006Lv-7C
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:59:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i2ggY-0006LY-Qu; Tue, 27 Aug 2019 14:59:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id y8so19849226wrn.10;
 Tue, 27 Aug 2019 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kLp7FcOzZb40rhxHU3D4c3AhMmvNaTIHFw6QzoBaAJ4=;
 b=QuSUMvAd7zSxR2Cx3W45dTi4V60MD0MrNayf5wDrDzb3+aX1TfbLbSkb8A7pGIRj1f
 dgen24PQ1THWVJ9EJhQ2OzsY3NJo3S/2ccfMrhv3XlHibK9ctc7Hk9mtrz2bWVe7Yp6C
 b5SgPCN7I4eDaVb76iKFzTZ+r5kUw2QY5e3UGMgTDHjNAD1IlEF2Ve+nfLcoezF6S61g
 3WEsBTTV4uK6M49gSslOwOrVRH9r7CXHaZkaGEWETMEVffVlA77upFvLJPjPiwC4eN6j
 c6t1mIsltEeTgNcDlqqVyAc3OBd8iuVHhlnoCmLdxKpjQE90f685V6QaTNxRWwvK+/GH
 AiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kLp7FcOzZb40rhxHU3D4c3AhMmvNaTIHFw6QzoBaAJ4=;
 b=uAagGSNIX1JDzJ09xT68wOgknABMRabQ0aza6FbMf1PrBLAyCn/fRhyW09y+T1fd3G
 qxfBWSBZTLYB7gg+0Ugud+JbOm1uvzH/EDzqYYjd+fR3lozOBIJx5RPPLzA+izQ39U5v
 OdxApqJag+zwKKrIHygPB+9jx9SQ5Zk9MIJewQ4sDaFTc9MCUhR3qXRw4nhgOUlHiiw7
 GxOQiYu3tq93HsFTPfmnwTLwqQgGuutvTLO1QYsIdaUDn7aAcO8/M0Qcaox+6HXqWFsr
 Y+Xerc7mYVwrwAEL0+j+5w4EYh2947yjOzcTK+js7CDXGPgYOftjoywlVDgrVQydH0GD
 KogQ==
X-Gm-Message-State: APjAAAXgCAAEUER4z301KO5CroJ4WZhKaPHmsj/filkm+MlCWZJZYoVs
 viZIVv8PidhkSeYyjiPqprX2g5TLFfapyQ==
X-Google-Smtp-Source: APXvYqxnqOvZvpHsz8YsgqGA2gIGb+HvFnVXtK5KDbWQq3VX0FZzoLT66iR/9ShtOM/O7hbGuhuwLg==
X-Received: by 2002:a5d:568e:: with SMTP id f14mr30617782wrv.167.1566932356938; 
 Tue, 27 Aug 2019 11:59:16 -0700 (PDT)
Received: from localhost.localdomain (109-186-142-128.bb.netvision.net.il.
 [109.186.142.128])
 by smtp.gmail.com with ESMTPSA id g26sm9926wmh.32.2019.08.27.11.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 11:59:16 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:59:11 +0300
Message-Id: <20190827185913.27427-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 0/2] Alignment checks cleanup
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
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While working on 4k support, I noticed that there is lot of code using
BDRV_SECTOR_SIZE (512) for checking alignment. I wonder how this can work with
4k storage.

Lets start by cleaning up to make the code easier to understand:
- Use QEMU_IS_ALIGNED macro to check alignment
- Remove unneeded masks based on BDRV_SECTOR_SIZE

Nir Soffer (2):
  block: Use QEMU_IS_ALIGNED
  block: Remove unused masks

 block/bochs.c         | 4 ++--
 block/cloop.c         | 4 ++--
 block/dmg.c           | 4 ++--
 block/io.c            | 8 ++++----
 block/qcow2-cluster.c | 4 ++--
 block/qcow2.c         | 4 ++--
 block/vvfat.c         | 8 ++++----
 include/block/block.h | 2 --
 migration/block.c     | 2 +-
 qemu-img.c            | 2 +-
 10 files changed, 20 insertions(+), 22 deletions(-)

-- 
2.20.1


