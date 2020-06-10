Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C29C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D1A2067B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuxIFPyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D1A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0oe-0003eh-Uj
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jj0c1-0001HF-Sf
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:17:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jj0c0-0005b8-1A
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591795066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glj1UX0IRZ08E8I1uYNUtVXZVxJdi16Aw7I/UGOZ4Fk=;
 b=IuxIFPyigVSQpBtV880CCDFksPEDd3wuOLcHh+GZoYCV1JyrF9zk6vTvlCyBGerb6eJ7g9
 6mckN5CBlN/M+M5UUFmbgUVJcpCzlw31OOF8d4Ju2xTb1FQGyCNLKPilzGCVgL4xWsuwzY
 ZYJmtVkznW4MHR2s8TY6D+n5EbNxHgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-QVh-Zd7jM2mC9HqkWbfZ4Q-1; Wed, 10 Jun 2020 09:17:44 -0400
X-MC-Unique: QVh-Zd7jM2mC9HqkWbfZ4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A767281A3FF
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26B32100238E
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:17:42 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] qemu-options.hx: Mark all hmat-cache attributes
 required
Date: Wed, 10 Jun 2020 15:17:34 +0200
Message-Id: <b6d3bc2ac8b38a419c98fb5eb1454ffbcb4fa172.1591794890.git.mprivozn@redhat.com>
In-Reply-To: <cover.1591794890.git.mprivozn@redhat.com>
References: <cover.1591794890.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The documentation to `-numa hmat-cache` says that @node-id, @size
and @level are the only required attributes. The rest
(@associativity, @policy and @line) is optional. Well, not quite
- if I try to start QEMU with only the three required attributes
defined the QAPI code is complaining about associativity missing.

According to QAPI all attributes are required. Make the docs
reflect that.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 93bde2bbc8..b1a399079a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -188,7 +188,7 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa dist,src=source,dst=destination,val=distance\n"
     "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
     "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n"
-    "-numa hmat-cache,node-id=node,size=size,level=level[,associativity=none|direct|complex][,policy=none|write-back|write-through][,line=size]\n",
+    "-numa hmat-cache,node-id=node,size=size,level=level,associativity=none|direct|complex,policy=none|write-back|write-through,line=size\n",
     QEMU_ARCH_ALL)
 SRST
 ``-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
@@ -201,7 +201,7 @@ SRST
   \ 
 ``-numa hmat-lb,initiator=node,target=node,hierarchy=hierarchy,data-type=tpye[,latency=lat][,bandwidth=bw]``
   \ 
-``-numa hmat-cache,node-id=node,size=size,level=level[,associativity=str][,policy=str][,line=size]``
+``-numa hmat-cache,node-id=node,size=size,level=level,associativity=str,policy=str,line=size``
     Define a NUMA node and assign RAM and VCPUs to it. Set the NUMA
     distance from a source node to a destination node. Set the ACPI
     Heterogeneous Memory Attributes for the given nodes.
-- 
2.26.2


