Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB18C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360AA20675
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dJx+M+fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360AA20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38033 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLtnw-00011R-G1
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 14:18:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtkc-0007Nb-Jg
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtka-0002bI-0L
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:38 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:38862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hLtkZ-0002RJ-F1; Wed, 01 May 2019 14:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=KkctMI72rLkwiXwR9ML3+BCZSH3Ea3Z75mAt/xOnaeM=; 
	b=dJx+M+fcDDAF5opcX6cWe+0xUJNZEk2K0jn9/zVepN30Fi5mMbhK+qIXU70PeiiOt6s+G6CwMK3C21fIneiiQPWXn/PyykC1sQ90XfIJKQgYncR/HOwrUoRNIx5ch9auNbSJglyFwwp3LuFYYtMy2Uw5gpPsCmjKVRWiGvqqw02KZyeC2cBjyE93ExpHD+b1zk0KKLRp3tGaYBCDWsjLIMvvssRZo+cK1EgSXfjD9zWPQLdip2BXDPwt41LXsqkN1XHIw58l5sDNldcxruizqJgDVgRRRUiihKZuqXpyqNHe4ji8ZJvYjDSNFPEMFL9vrLYuYEBzJWJTgTwNKETnbQ==;
Received: from 87-92-6-174.bb.dnainternet.fi ([87.92.6.174] helo=perseus.local)
	by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hLtkH-0002EA-53; Wed, 01 May 2019 20:14:17 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hLtk2-0002yR-NK; Wed, 01 May 2019 21:14:02 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 21:13:59 +0300
Message-Id:
 <6026d9eb2851d22f6ff031e208120735361ea606.1556732434.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1556732434.git.berto@igalia.com>
References: <cover.1556732434.git.berto@igalia.com>
In-Reply-To: <cover.1556732434.git.berto@igalia.com>
References: <cover.1556732434.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH v2 5/5] qcow2: Remove
 BDRVQcow2State.cluster_sectors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501181359.jGnBfLwqSJh4rTR6TWyk_rnlYoHC-D8u05RpwiVRZJc@z>

The last user of this field disappeared when we replace the
sector-based bdrv_write() with the byte-based bdrv_pwrite().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 1 -
 block/qcow2.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index a520d116ef..8e024007db 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1259,7 +1259,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 
     s->cluster_bits = header.cluster_bits;
     s->cluster_size = 1 << s->cluster_bits;
-    s->cluster_sectors = 1 << (s->cluster_bits - BDRV_SECTOR_BITS);
 
     /* Initialise version 3 header fields */
     if (header.version == 2) {
diff --git a/block/qcow2.h b/block/qcow2.h
index fdee297f33..e62508d1ce 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -266,7 +266,6 @@ typedef struct Qcow2BitmapHeaderExt {
 typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
-    int cluster_sectors;
     int l2_slice_size;
     int l2_bits;
     int l2_size;
-- 
2.11.0


