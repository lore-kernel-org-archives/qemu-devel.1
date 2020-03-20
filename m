Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C796C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD8A20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="XpZaruFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD8A20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLyl-00058y-2q
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <77bfe734689fb2242218674195e202a6757a1644@lizzy.crudebyte.com>)
 id 1jFLxz-0004SZ-PC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <77bfe734689fb2242218674195e202a6757a1644@lizzy.crudebyte.com>)
 id 1jFLxy-0001ID-Qb
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:01:55 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:53025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <77bfe734689fb2242218674195e202a6757a1644@lizzy.crudebyte.com>)
 id 1jFLxy-0000Ik-KD
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=B9RoK2aLNCCKJGUIXCo19T7dVfKYtpjQkK39vXd2DP0=; b=XpZar
 uFq7XuCEK2jWXWhYOjk29Ph4j8Vuad0vq4azYhFq6/ZkcluxTaYDjQc8oyXE/tpSRsVm1Dl4w96Qd
 gPAVEFuCF6XrHFgncJ18F7fMJECpn2m+SwUU9gzPvQpn8el4DWRlCn+43hXbUf9b7RLJXUJT89Xb+
 VPfN1Oc1gDm3ViCPsQa1vs9Dv41JTCfe9jdOlQzKfAawlFcbF+807aNaTyAupRPURqgpEKjZrt58M
 zs4EiXtN3j7DC/G8fdXkVAbsAQ2PB5FVygIsyQKRMaWg0/F6fOdIv3L78PIpZrEMJoMJOmOo5N9v/
 qh1J9kx3VwiAAMquY/5tZLI4kqC/Q==;
Message-Id: <77bfe734689fb2242218674195e202a6757a1644.1584723662.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1584723662.git.qemu_oss@crudebyte.com>
References: <cover.1584723662.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 20 Mar 2020 17:46:38 +0100
Subject: [PATCH v2 1/4] docs: virtfs: add section separators
To: libvir-list@redhat.com
Cc: qemu-devel@nongnu.org,
    Greg Kurz <groug@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
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

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 docs/formatdomain.html.in | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/formatdomain.html.in b/docs/formatdomain.html.in
index 594146009d..cc2c671c14 100644
--- a/docs/formatdomain.html.in
+++ b/docs/formatdomain.html.in
@@ -4084,13 +4084,20 @@
         </dd>
         </dl>
 
+      <p>
       <span class="since">Since 5.2.0</span>, the filesystem element
       has an optional attribute <code>model</code> with supported values
       "virtio-transitional", "virtio-non-transitional", or "virtio".
       See <a href="#elementsVirtioTransitional">Virtio transitional devices</a>
       for more details.
+      </p>
+
       </dd>
 
+      <p>
+      The <code>filesystem</code> element may contain the following subelements:
+      </p>
+
       <dt><code>driver</code></dt>
       <dd>
         The optional driver element allows specifying further details
-- 
2.20.1


