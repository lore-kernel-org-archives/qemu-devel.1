Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6F2C2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9910A222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFG93EhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9910A222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiKR9-0005zg-OO
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iiKQQ-0005VI-PH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iiKQP-0006VV-Ba
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:42:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iiKQP-0006Ti-4P
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576856563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+/sbYPVXVxyPkew+Bx0snOna0EWL/qFzFAauJtBbj1I=;
 b=VFG93EhSkgu8XTebGPTg6KgcDlbQgva0ihNK5Eg83QUxaZQrNlB0AnG+o/Ryz26+jAplBO
 pFr2alXmShE+jb3Erugc4bNxLCT3XEBYEXZkTwHwUlqpK+2KzWp0dDfFXN9Rb1eUaylSJP
 FPWxDu1xIb90/Y78Ra18VfGfKWSHD0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-BjQbDRumM-6CZ2J488urkA-1; Fri, 20 Dec 2019 10:42:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E66731005502;
 Fri, 20 Dec 2019 15:42:39 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-248.ams2.redhat.com [10.36.116.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94FC360BF3;
 Fri, 20 Dec 2019 15:42:29 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/x86-iommu: Add missing stubs
Date: Fri, 20 Dec 2019 16:42:25 +0100
Message-Id: <20191220154225.25879-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BjQbDRumM-6CZ2J488urkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 6c730e4af9 we introduced a stub to build the MicroVM
machine without Intel IOMMU. This stub is incomplete for the
other PC machines. Add the missing stubs.

Fixes: 6c730e4af9
Reported-by: Travis-CI
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/x86-iommu-stub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
index 03576cdccb..c5ba077f9d 100644
--- a/hw/i386/x86-iommu-stub.c
+++ b/hw/i386/x86-iommu-stub.c
@@ -32,3 +32,12 @@ X86IOMMUState *x86_iommu_get_default(void)
     return NULL;
 }
=20
+bool x86_iommu_ir_supported(X86IOMMUState *s)
+{
+    return false;
+}
+
+IommuType x86_iommu_get_type(void)
+{
+    abort();
+}
--=20
2.21.0


