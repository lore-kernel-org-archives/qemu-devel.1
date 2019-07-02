Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E4BC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740B620659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740B620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGWW-0002Eh-Pc
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50955)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGJq-0005oT-Hn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJo-0007ki-0Q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJm-0007fP-7P
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E499EC058CA2;
 Tue,  2 Jul 2019 10:47:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7D7567142;
 Tue,  2 Jul 2019 10:47:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C00E4113294C; Tue,  2 Jul 2019 12:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:06 +0200
Message-Id: <20190702104716.9140-9-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 10:47:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/18] MAINTAINERS: Merge sections CPU,
 NUMA into Machine core
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190619201050.19040-8-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecab4310a3..bcd9675f4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1267,8 +1267,12 @@ S: Supported
 F: hw/core/machine.c
 F: hw/core/null-machine.c
 F: hw/cpu/cluster.c
+F: numa.c
+F: qom/cpu.c
 F: include/hw/boards.h
 F: include/hw/cpu/cluster.h
+F: include/qom/cpu.h
+F: include/sysemu/numa.h
 T: git https://github.com/ehabkost/qemu.git machine-next
=20
 Xtensa Machines
@@ -1833,11 +1837,6 @@ M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: scripts/coverity-model.c
=20
-CPU
-S: Supported
-F: qom/cpu.c
-F: include/qom/cpu.h
-
 Device Tree
 M: Alistair Francis <alistair.francis@wdc.com>
 R: David Gibson <david@gibson.dropbear.id.au>
@@ -1945,13 +1944,6 @@ W: http://info.iet.unipi.it/~luigi/netmap/
 S: Maintained
 F: net/netmap.c
=20
-NUMA
-M: Eduardo Habkost <ehabkost@redhat.com>
-S: Maintained
-F: numa.c
-F: include/sysemu/numa.h
-T: git https://github.com/ehabkost/qemu.git machine-next
-
 Host Memory Backends
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Igor Mammedov <imammedo@redhat.com>
--=20
2.21.0


