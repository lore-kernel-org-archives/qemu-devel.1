Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3220EC2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF77C20768
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bi3H38ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF77C20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqkR-0000HJ-58
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 12:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jLqb0-0004zs-Lh
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jLqat-0002Ly-Ay
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:57:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34204
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jLqat-0002Le-7k
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586275014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aXzluHzsPxunzb4ZMnygfPekmc8HBAlxXCColyKm/6Y=;
 b=bi3H38zeJPFuf1ZkMvOPC+UqHQEXT1smZt+rntQnuMSkCvypJCKNRsBfDCfmVWNMmHC7m/
 +zxg0YVytx/xBAz1go2oVdYuwss8fS6Fh0wDOPkCRVZkB37vHqm8h/kNvnwUm4doZ6gs4+
 k9mkOU44QrbTydWaLGcmquhbD8+lYtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-kTpm-eDPNeCM4Zphk2KyDQ-1; Tue, 07 Apr 2020 11:56:53 -0400
X-MC-Unique: kTpm-eDPNeCM4Zphk2KyDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D693DB60
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 15:56:52 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-114-200.ams2.redhat.com [10.36.114.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8A485DA7B;
 Tue,  7 Apr 2020 15:56:50 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/3] Acceptance test: provides new functions
Date: Tue,  7 Apr 2020 18:56:41 +0300
Message-Id: <20200407155642.10716-3-ovoshcha@redhat.com>
In-Reply-To: <20200407155642.10716-1-ovoshcha@redhat.com>
References: <20200407155642.10716-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 tests/acceptance/migration.py | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index e4c39b85a1..1c3a684395 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -11,12 +11,57 @@
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
+
+
+def get_rdma_status():
+    """Verify the status of RDMA service.
+
+    return: True if rdma service is enabled, False otherwise.
+    """
+    rdma_stat =3D service.ServiceManager()
+    return bool(rdma_stat.status('rdma'))
+
+def get_interface_rdma():
+    """Get the interface name where RDMA is configured.
+
+    return: The interface name or False if none is found
+    """
+    cmd =3D 'rdma link show -j'
+    out =3D json.loads(process.getoutput(cmd))
+    try:
+        for i in out:
+            if i['state'] =3D=3D 'ACTIVE':
+                return i['netdev']
+    except KeyError:
+        pass
+    return False
+
+def get_ip_rdma(interface):
+    """Get the IP address on a specific interface.
+
+    :param interface: Network interface name
+    :return: IP addresses as a list, otherwise will return False
+    """
+    local =3D LocalHost()
+    network_in =3D NetworkInterface(interface, local)
+    try:
+        ip =3D network_in.get_ipaddrs()
+        if ip:
+            return ip
+    except:
+        pass
+    return False
=20
=20
 class Migration(Test):
--=20
2.21.1


