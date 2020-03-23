Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC452C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6232072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diflwBNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6232072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKNr-00079S-MI
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jGKMO-0005T8-GM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jGKMN-000520-6I
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:31:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59557)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jGKMN-00051o-2V
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584959466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Y/vUe8IuFujmp1D2Dhq2zrb6WSPmwZATdRZ6XePBM4=;
 b=diflwBNo79TS5Y+SLAJpVaClpIIH1UeEh6mVLjA6x6pzImxfNcunvG6zcmrmkWHKFqmd9p
 e1OlQX4I+FCVX0aUWIc4+uJIa7b+D7Rs8B056t3msFIlFFAyE1ECCJYT9JR1An9XVIkx/S
 tAv05NRUnZG11hk+qu4CJfPhlepsvl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-WOe_FTHXPz6KnzrgyEqVeg-1; Mon, 23 Mar 2020 06:31:03 -0400
X-MC-Unique: WOe_FTHXPz6KnzrgyEqVeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71D0D802CB5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:30:59 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-112-254.ams2.redhat.com [10.36.112.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E31205DE52;
 Mon, 23 Mar 2020 10:30:43 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/3] Acceptance test: provides new functions
Date: Mon, 23 Mar 2020 12:30:15 +0200
Message-Id: <20200323103016.17368-3-ovoshcha@redhat.com>
In-Reply-To: <20200323103016.17368-1-ovoshcha@redhat.com>
References: <20200323103016.17368-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: ehabkost@redhat.com, crosa@redhat.com, wainersm@redhat.com,
 wrampazz@redhat.com, ovoshcha@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provides new functions related to the rdma migration test
Adds functions to check if service RDMA is enabled and gets
the ip address on the interface where it was configured

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index e4c39b85a1..59144f18fd 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -11,12 +11,44 @@
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
+def _if_rdma_enable():
+    rdma_stat =3D service.ServiceManager()
+    return bool(rdma_stat.status('rdma'))
+
+def _get_interface_rdma():
+    cmd =3D 'rdma link show -j'
+    out =3D json.loads(process.getoutput(cmd))
+    try:
+        for i in out:
+            if i['state'] =3D=3D 'ACTIVE':
+                return i['netdev']
+    except KeyError:
+        return False
+    return False
+
+def _get_ip_rdma(interface):
+    local =3D LocalHost()
+    network_in =3D NetworkInterface(interface, local)
+    try:
+        ip =3D network_in._get_interface_details()
+        if ip:
+            return ip[0]['addr_info'][0]['local']
+    except (KeyError, process.CmdError):
+        return False
+    return False
=20
=20
 class Migration(Test):
--=20
2.21.1


