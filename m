Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C7C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E67E2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMzfCm1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E67E2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cLe-0000NI-Nw
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j2cKz-0007qu-2K
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j2cKy-0006Wr-26
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:53:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40652
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j2cKx-0006Vt-US
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581691979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5rJ3etNjhSKdzev20/u1j5eHxwrITzFbaepIADSB1M=;
 b=DMzfCm1+uk/pZ8rm98btQDp60WmsQYd8NLJ5/NDcLx5asjojBw/VlhzTbKhsPN8OoGY97b
 ImpRfuUzngNEurZTyGsZLfkJtyoMjdagpg91L1ZxFWDUzr6AtxZHoYW6hmHxRDwlWiALYz
 3AfRCG8NYXw65yB9z7lyCf5RkEu3ebE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-SXGjImPsMRa72IeIedumlQ-1; Fri, 14 Feb 2020 09:52:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AEA6801E70
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 14:52:47 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-117-55.ams2.redhat.com [10.36.117.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22FD1790D1;
 Fri, 14 Feb 2020 14:52:45 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/4] Acceptance test: provides new functions
Date: Fri, 14 Feb 2020 16:52:34 +0200
Message-Id: <20200214145235.4378-4-ovoshcha@redhat.com>
In-Reply-To: <20200214145235.4378-1-ovoshcha@redhat.com>
References: <20200214145235.4378-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: SXGjImPsMRa72IeIedumlQ-1
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
Cc: philmd@redhat.com, wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds functions to check if service RDMA is enabled and gets the interface
where it was configured

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index 8209dcf71d..bbd88f8dda 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -11,12 +11,16 @@
=20
=20
 import tempfile
+import re
+import netifaces
 from avocado_qemu import Test
 from avocado import skipUnless
=20
 from avocado.utils import network
 from avocado.utils import wait
 from avocado.utils.path import find_command
+from avocado.utils import service
+from avocado.utils import process
=20
=20
 class Migration(Test):
@@ -58,6 +62,19 @@ class Migration(Test):
             self.cancel('Failed to find a free port')
         return port
=20
+    def _if_rdma_enable(self):
+        rdma_stat =3D service.ServiceManager()
+        rdma =3D rdma_stat.status('rdma')
+        return rdma
+
+    def _get_ip_rdma(self):
+        get_ip_rdma =3D process.run('rdma link show').stdout.decode()
+        for line in get_ip_rdma.split('\n'):
+            if re.search(r"ACTIVE", line):
+                interface =3D line.split(" ")[-2]
+                ip =3D netifaces.ifaddresses(interface)[netifaces.AF_INET]=
[0]['addr']
+                return ip
+
=20
     def test_migration_with_tcp_localhost(self):
         dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
--=20
2.21.1


