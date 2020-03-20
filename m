Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8498C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756052072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbpCvalN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756052072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJMt-0000hD-Kn
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jFJLt-0008E7-Kb
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jFJLs-0003Jg-Iw
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:14:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26605)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jFJLs-0003JS-Fj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584717263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1hj3jjxnIgr5QAPOoV7dIk1rBSKlElTSizMfMRJ5h8=;
 b=FbpCvalNbBVgn//Wu93CkuVFivFey+sOYhl5K5RnUnZKnaH8G99TM/iaHKGORpCVVN631p
 ROy85cAALr+l5WzEl67EYoI8xBg06Fs+3nWq6oYzCBII1mDn/2wRrl9Y+AOeY6xMlhHhyi
 qsUG7d7Bt7SnN/fHfOXL5Nbo8l1tjyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-ha1bPiMcPPCDjggQYmCDnw-1; Fri, 20 Mar 2020 11:14:22 -0400
X-MC-Unique: ha1bPiMcPPCDjggQYmCDnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0DA018A5505
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 15:13:39 +0000 (UTC)
Received: from kh066.redhat.com (unknown [10.40.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6ACF10372C1;
 Fri, 20 Mar 2020 15:13:34 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] Acceptance test: provides new functions
Date: Fri, 20 Mar 2020 17:12:53 +0200
Message-Id: <20200320151254.16766-3-ovoshcha@redhat.com>
In-Reply-To: <20200320151254.16766-1-ovoshcha@redhat.com>
References: <20200320151254.16766-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: ovoshcha@redhat.com, philmd@redhat.com, ehabkost@redhat.com,
 wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provides new functions related to the rdma migration test
Adds functions to check if service RDMA is enabled and gets
the ip address on the interface where it was configured

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index e4c39b85a1..a783f3915b 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -11,12 +11,17 @@
=20
=20
 import tempfile
+import json
 from avocado_qemu import Test
 from avocado import skipUnless
=20
 from avocado.utils import network
 from avocado.utils import wait
 from avocado.utils.path import find_command
+from avocado.utils.network.interfaces import NetworkInterface
+from avocado.utils.network.hosts import LocalHost
+from avocado.utils import service
+from avocado.utils import process
=20
=20
 class Migration(Test):
@@ -58,6 +63,31 @@ class Migration(Test):
             self.cancel('Failed to find a free port')
         return port
=20
+    def _if_rdma_enable(self):
+        rdma_stat =3D service.ServiceManager()
+        rdma =3D rdma_stat.status('rdma')
+        return rdma
+
+    def _get_interface_rdma(self):
+        cmd =3D 'rdma link show -j'
+        out =3D json.loads(process.getoutput(cmd))
+        try:
+            for i in out:
+                if i['state'] =3D=3D 'ACTIVE':
+                    return i['netdev']
+        except KeyError:
+            return None
+
+    def _get_ip_rdma(self, interface):
+        local =3D LocalHost()
+        network_in =3D NetworkInterface(interface, local)
+        try:
+            ip =3D network_in._get_interface_details()
+            if ip:
+                return ip[0]['addr_info'][0]['local']
+        except:
+            self.cancel("Incorrect interface configuration or device name"=
)
+
=20
     def test_migration_with_tcp_localhost(self):
         dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
--=20
2.21.1


