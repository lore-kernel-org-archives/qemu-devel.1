Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11713C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3322067B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFABh77h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3322067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0qz-00071M-1v
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jj0c2-0001I9-0x
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:17:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56029
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jj0c0-0005bD-CT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591795066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UsUrkXC7N0Uw3M1ZNKMfpakBoCCPiiIIV7CKSN7BUQM=;
 b=UFABh77hz6bX0THz61uMbwNnHNhvF0NIg1/VJ+mmv8SewXkF69MM7tUv8DSs/ReNFC+7PN
 Spp3g1chZAu4QhgXBPnftG5sMr3dAwoxnJ7NlY2nocFWL0yxwzzy7p7luLsIRAQSvqbhlz
 wzVqtka36m/VTd7iN9fEOVc25Aami3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-yslS28sDPyamS7iV4HE5lw-1; Wed, 10 Jun 2020 09:17:45 -0400
X-MC-Unique: yslS28sDPyamS7iV4HE5lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8328684B842
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02955100238E
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:17:43 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] qemu-options.hx: Document hmat-lb and hmat-cache order
Date: Wed, 10 Jun 2020 15:17:35 +0200
Message-Id: <5bd3f4a03227658cbdb1d184518c7805c1c0122f.1591794890.git.mprivozn@redhat.com>
In-Reply-To: <cover.1591794890.git.mprivozn@redhat.com>
References: <cover.1591794890.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

To simplify internal implementation the hmat-cache parsing code
expects hmat-lb to be already parsed. This means, that hmat-lb
arguments must come before hmat-cache. Document this restriction
so that management applications can follow it.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qemu-options.hx | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index b1a399079a..3fe9e6d6a0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -319,6 +319,9 @@ SRST
     'none/direct(direct-mapped)/complex(complex cache indexing)'. policy
     is the write policy. line is the cache Line size in bytes.
 
+    Please note, that due to internal implementation, '\ ``hmat-cache``\ '
+    must be configured only after '\ ``hmat-lb``\ ' option.
+
     For example, the following options describe 2 NUMA nodes. Node 0 has
     2 cpus and a ram, node 1 has only a ram. The processors in node 0
     access memory in node 0 with access-latency 5 nanoseconds,
-- 
2.26.2


