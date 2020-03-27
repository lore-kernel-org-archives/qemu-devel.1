Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106CBC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE57420748
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIX8aE2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE57420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43005 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHqpR-0003iO-2Y
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHqmQ-00075s-9Y
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHqmP-0005bE-3y
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHqmO-0005ZJ-UA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585322416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9CGBWC4c2QdM3PaT19uZbr2BjwnTY3bkj2aVcI89BVU=;
 b=DIX8aE2p2d5IOSfSS/Nfc2PoC34ozZsJQxKv++UbsBvU3PkdHnzjQoNNMcRW6AvaS9bo8F
 bKs9ol+9AQecWcZVcZKhD/qGFLna5ii0hjkUJBZMxfha+kCue07NFoCVb3SZtb1ooqfMK9
 RSiaZ39fg8iYELH5dKAteK0+gyFZ3Lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-EEIjfD_9NreaGg1TXIOilA-1; Fri, 27 Mar 2020 11:20:14 -0400
X-MC-Unique: EEIjfD_9NreaGg1TXIOilA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48AE313F6;
 Fri, 27 Mar 2020 15:20:13 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F2BE5F709;
 Fri, 27 Mar 2020 15:20:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 6/6] qcow2: Remove unused fields from BDRVQcow2State
Date: Fri, 27 Mar 2020 16:19:50 +0100
Message-Id: <20200327151950.11820-7-kwolf@redhat.com>
In-Reply-To: <20200327151950.11820-1-kwolf@redhat.com>
References: <20200327151950.11820-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These fields were already removed in commit c3c10f72, but then commit
b58deb34 revived them probably due to bad merge conflict resolution.
They are still unused, so remove them again.

Fixes: b58deb344ddff3b9d8b265bf73a65274767ee5f4
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200326170757.12344-1-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 0942126232..f4de0a27d5 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -301,9 +301,6 @@ typedef struct BDRVQcow2State {
     QEMUTimer *cache_clean_timer;
     unsigned cache_clean_interval;
=20
-    uint8_t *cluster_cache;
-    uint8_t *cluster_data;
-    uint64_t cluster_cache_offset;
     QLIST_HEAD(, QCowL2Meta) cluster_allocs;
=20
     uint64_t *refcount_table;
--=20
2.20.1


