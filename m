Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232EC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0C42067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ssLJo+eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0C42067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33777 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLBKv-00083Y-Ge
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 14:49:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF2-0003Hg-3E
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF1-0002Qt-2w
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:03 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hLBF0-0002Pf-QS; Mon, 29 Apr 2019 14:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Message-Id:Date:Subject:Cc:To:From;
	bh=Wgj5uF7kqUZ1VqMW90TBeCP0doa49kZO3PSioGbmiB0=; 
	b=ssLJo+eI9OaLRQNzOwUFq9uJVdyzO3e1/NIe+RjpsQoU8ggBgaKqmZOjUhYcLZeu64QWJGCylQuv/3yfiV1eRh9aPpAalP0yX1CSBJVRLAHpAa4ZNoevc+NhSkfRAqoE4GxSwmxih2pc/f5b7TLkkDPZdnO7lepljOx6YBeqjBbgt+ptyBaO1l8L/DoGbnxlXkbglsoT44wjXQpNtYrdfVdBy4TRxq7f2+CW+f2asF54dxklXHQ2o2yDpqbDIEGMxHUkOIltljP2qd0aRYWsWKCTtBfwmQugve9XUK9f/XAkN78oUqO/nHtBLyVYWQz5U6IrgPxd0VSwBFkpIeWM+A==;
Received: from static-191-95-145-212.ipcom.comunitel.net ([212.145.95.191]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hLBEx-0006XF-Iu; Mon, 29 Apr 2019 20:42:59 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hLBEk-0002ZJ-UR; Mon, 29 Apr 2019 21:42:46 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 20:42:35 +0200
Message-Id: <cover.1556562150.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH 0/5] Remove bdrv_read() and bdrv_write()
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
Message-ID: <20190429184235.fAg4C8BzvqEqYIEdBNEOwC_kSbXRLWHike0o6HT7Okc@z>

Hi,

this API only had a few users left so it can be easily removed.

Regards,

Berto

Alberto Garcia (5):
  qcow2: Replace bdrv_write() with bdrv_pwrite()
  vdi: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
  vvfat: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
  block: Remove bdrv_read() and bdrv_write()
  qcow2: Remove BDRVQcow2State.cluster_sectors

 block/io.c             | 36 ------------------------------------
 block/qcow2-refcount.c |  4 ++--
 block/qcow2.c          |  1 -
 block/qcow2.h          |  1 -
 block/vdi.c            | 11 ++++++-----
 block/vvfat.c          | 10 ++++++----
 include/block/block.h  |  4 ----
 7 files changed, 14 insertions(+), 53 deletions(-)

-- 
2.11.0


