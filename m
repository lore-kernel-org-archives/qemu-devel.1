Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16A3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C86222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C86222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSeT-0005Oh-Ab
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLScd-0003gN-Uz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLScc-0005mx-Re
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLScc-0005md-EZ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DF1F4ACDF;
 Fri, 18 Oct 2019 13:48:49 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E50A60BF1;
 Fri, 18 Oct 2019 13:48:37 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/20] Revert "irq: introduce qemu_irq_proxy()"
Date: Fri, 18 Oct 2019 15:47:38 +0200
Message-Id: <20191018134754.16362-5-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-1-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 18 Oct 2019 13:48:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This function isn't used anymore.

This reverts commit 22ec3283efba9ba0792790da786d6776d83f2a92.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/core/irq.c    | 14 --------------
 include/hw/irq.h |  5 -----
 2 files changed, 19 deletions(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index 7cc0295d0e..fb3045b912 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -120,20 +120,6 @@ qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2=
)
     return qemu_allocate_irq(qemu_splitirq, s, 0);
 }
=20
-static void proxy_irq_handler(void *opaque, int n, int level)
-{
-    qemu_irq **target =3D opaque;
-
-    if (*target) {
-        qemu_set_irq((*target)[n], level);
-    }
-}
-
-qemu_irq *qemu_irq_proxy(qemu_irq **target, int n)
-{
-    return qemu_allocate_irqs(proxy_irq_handler, target, n);
-}
-
 void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, =
int n)
 {
     int i;
diff --git a/include/hw/irq.h b/include/hw/irq.h
index fe527f6f51..24ba0ece11 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -51,11 +51,6 @@ qemu_irq qemu_irq_invert(qemu_irq irq);
  */
 qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);
=20
-/* Returns a new IRQ set which connects 1:1 to another IRQ set, which
- * may be set later.
- */
-qemu_irq *qemu_irq_proxy(qemu_irq **target, int n);
-
 /* For internal use in qtest.  Similar to qemu_irq_split, but operating
    on an existing vector of qemu_irq.  */
 void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, =
int n);
--=20
2.21.0


