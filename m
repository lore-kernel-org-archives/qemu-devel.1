Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD4DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2739206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VAE7/2Ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2739206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsHl-00062p-Uu
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kDsFc-0002Kw-OE; Thu, 03 Sep 2020 12:38:16 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:40627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kDsFZ-0003v8-4O; Thu, 03 Sep 2020 12:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Chtlc5CuptQATyKkRPvXZLK+rkXSeQl8f2zRB9Ijl1E=; 
 b=VAE7/2IivqlWvSmDkU7gVZDMkdrTbWdMMTKZD13iJm9tMYBhtv0BdEQTF7sLEFs+Yj6uZ3xDNVJw71q8yaJW3Uxsv47/Eq0RuoRX8SnKpRNDIJtPbAWpYMpHimP4Y88YrPwhSjZBONBgrDETZDbaUZhe/paZ3OwdmhKHq9H5eOq4bQL7Pkmghb8b+iFqSVc/vIJfxlEq5eKpQ5nHt6DNwF03AH6k1hBSdFvvqQnlT9fgsAzKnaFR2SUKyaV95tKz0X4wDeyeJGph7sHYUyY9Qjm8Gb0Qr31gZdOHdJleDrHo4CKfw0vvOfsZjWwKMp/WIW0I1Uf0tJLxpXSe+5QteA==;
Received: from [81.0.33.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kDsFW-0002FF-Ob; Thu, 03 Sep 2020 18:38:10 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kDsFJ-00082o-TM; Thu, 03 Sep 2020 18:37:57 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] qcow2: Rewrite the documentation of
 qcow2_alloc_cluster_offset()
Date: Thu,  3 Sep 2020 18:37:49 +0200
Message-Id: <bb5bd06f07c5a05b0818611de0d06ec5b66c8df3.1599150873.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1599150873.git.berto@igalia.com>
References: <cover.1599150873.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:38:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current text corresponds to an earlier, simpler version of this
function and it does not explain how it works now.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 25e38daa78..f1ce6afcf5 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1713,18 +1713,22 @@ out:
 }
 
 /*
- * alloc_cluster_offset
+ * For a given area on the virtual disk defined by @offset and @bytes,
+ * find the corresponding area on the qcow2 image, allocating new
+ * clusters (or subclusters) if necessary. The result can span a
+ * combination of allocated and previously unallocated clusters.
  *
- * For a given offset on the virtual disk, find the cluster offset in qcow2
- * file. If the offset is not found, allocate a new cluster.
+ * On return, @host_offset is set to the beginning of the requested
+ * area. This area is guaranteed to be contiguous on the qcow2 file
+ * but it can be smaller than initially requested. In this case @bytes
+ * is updated with the actual size.
  *
- * If the cluster was already allocated, m->nb_clusters is set to 0 and
- * other fields in m are meaningless.
- *
- * If the cluster is newly allocated, m->nb_clusters is set to the number of
- * contiguous clusters that have been allocated. In this case, the other
- * fields of m are valid and contain information about the first allocated
- * cluster.
+ * If any clusters or subclusters were allocated then @m contains a
+ * list with the information of all the affected regions. Note that
+ * this can happen regardless of whether this function succeeds or
+ * not. The caller is responsible for updating the L2 metadata of the
+ * allocated clusters (on success) or freeing them (on failure), and
+ * for clearing the contents of @m afterwards in both cases.
  *
  * If the request conflicts with another write request in flight, the coroutine
  * is queued and will be reentered when the dependency has completed.
-- 
2.20.1


