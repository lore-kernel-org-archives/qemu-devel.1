Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247C9C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6082467D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZmygI3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6082467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aLi-00009M-VC
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j6a1f-0005m3-R1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j6a1e-0001Vc-Py
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:13:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35439
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j6a1e-0001VO-M3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582636406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPxAAzds0WoTdWjQSEFw4YGAC34H9/SN87Z1ad/uDqc=;
 b=QZmygI3VPoO16+/zkYDwowvo5phAy8q1QgMKMIMWQVtEKt06cO3y5c0f84nokhtDTu20sy
 NLxs91tTT16EUsHYYj0ge6EmIb56cjJcd6KFZ+sPZGkymgGJOyHMSDCjaGPPAF1nXhAoKL
 9fdLUFeSx97UARn7gVmFJ06VxRf0KU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-Aw60E4I-O8aFe1VVpO-z5Q-1; Tue, 25 Feb 2020 08:13:15 -0500
X-MC-Unique: Aw60E4I-O8aFe1VVpO-z5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 629A218AB2C3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 13:13:14 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-204-125.brq.redhat.com [10.40.204.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B9FD1BC6D;
 Tue, 25 Feb 2020 13:13:12 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] Acceptance test: provides new functions
Date: Tue, 25 Feb 2020 15:13:01 +0200
Message-Id: <20200225131302.4792-4-ovoshcha@redhat.com>
In-Reply-To: <20200225131302.4792-1-ovoshcha@redhat.com>
References: <20200225131302.4792-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: ovoshcha@redhat.com, philmd@redhat.com, wainersm@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provides new functions related to the rdma migration test
Adds functions to check if service RDMA is enabled and gets
the ip address on the interface where it was configured

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index 8209dcf71d..5632d74f14 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -11,12 +11,22 @@
=20
=20
 import tempfile
+import re
 from avocado_qemu import Test
 from avocado import skipUnless
=20
 from avocado.utils import network
 from avocado.utils import wait
 from avocado.utils.path import find_command
+from avocado.utils import service
+from avocado.utils import process
+
+
+NET_AVAILABLE =3D True
+try:
+    import netifaces
+except ImportError:
+    NET_AVAILABLE =3D False
=20
=20
 class Migration(Test):
@@ -58,6 +68,22 @@ class Migration(Test):
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
+                try:
+                     return netifaces.ifaddresses(interface)[netifaces \
+                                                 .AF_INET][0]['addr']
+                except (IndexError, KeyError):
+                    return None
+
=20
     def test_migration_with_tcp_localhost(self):
         dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
--=20
2.21.1


