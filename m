Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A762C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132642146E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmG1B1ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132642146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjHz-0002W8-6u
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1jBjFx-0007o1-5Q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1jBjFw-0005WJ-4P
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:05:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56714
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1jBjFw-0005Tj-04
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583863527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27otnlpCCc6Oj80P4U1wJDCLkbDt2NBJY+YO7yC4c2Q=;
 b=UmG1B1ubsfkdIgiufs6CDrmucLCNkVwNYvXRGDtnfCFkaF9gWqyHDX8eTHGjC/mH44YlFC
 8nWgtrKWD+ZiNTl3A8l/7TYnGLytVw4a8IXPIBH8a459pb0XVSocpXpFowQPKLhk0iKIIe
 1GJWoi7d9F7LYFzlDzZgMLJ5wIXjjZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-7VVRL2bfPayd7ql-Cy4jzw-1; Tue, 10 Mar 2020 14:05:23 -0400
X-MC-Unique: 7VVRL2bfPayd7ql-Cy4jzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19FDC13EA;
 Tue, 10 Mar 2020 18:05:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-115.rdu2.redhat.com
 [10.10.125.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9688519C7F;
 Tue, 10 Mar 2020 18:05:20 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/mem/pc-dimm: Fix line over 80 characters warning
Date: Tue, 10 Mar 2020 15:05:10 -0300
Message-Id: <20200310180510.19489-3-wainersm@redhat.com>
In-Reply-To: <20200310180510.19489-1-wainersm@redhat.com>
References: <20200310180510.19489-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, imammedo@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 hw/mem/pc-dimm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 36edfcf467..6d62588fea 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -218,7 +218,8 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDe=
vice *dimm, Error **errp)
=20
 static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
 {
-    return object_property_get_uint(OBJECT(md), PC_DIMM_ADDR_PROP, &error_=
abort);
+    return object_property_get_uint(OBJECT(md), PC_DIMM_ADDR_PROP,
+                                    &error_abort);
 }
=20
 static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr,
--=20
2.24.1


