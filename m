Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156FCC43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC83208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC83208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdh0j-0001ef-0I
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 16:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35309)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hdgv7-0004JW-W5
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hdgv5-000184-Rv
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:11:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hdgv5-000123-HW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:10:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CED26307D925;
 Wed, 19 Jun 2019 20:10:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-85.ams2.redhat.com
 [10.36.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0331001B3D;
 Wed, 19 Jun 2019 20:10:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B8F041138536; Wed, 19 Jun 2019 22:10:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 22:10:40 +0200
Message-Id: <20190619201050.19040-8-armbru@redhat.com>
In-Reply-To: <20190619201050.19040-1-armbru@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 19 Jun 2019 20:10:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 07/17] MAINTAINERS: Merge sections CPU,
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
Cc: kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aef0afaf7..f18fddbbbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1268,8 +1268,12 @@ S: Supported
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


