Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE13C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A979208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A979208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFMT-0003i4-Ck
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hZFKk-0001jl-7m
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hZFKi-0003M2-Ty
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:55:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hZFKf-0003Ed-Ex; Fri, 07 Jun 2019 09:55:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9197F3092647;
 Fri,  7 Jun 2019 13:54:47 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D6FB1001B0C;
 Fri,  7 Jun 2019 13:54:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 15:54:26 +0200
Message-Id: <20190607135430.22149-7-kwolf@redhat.com>
In-Reply-To: <20190607135430.22149-1-kwolf@redhat.com>
References: <20190607135430.22149-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 07 Jun 2019 13:54:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH 06/10] Move monitor.c to monitor/misc.c
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a new monitor/ subdirectory and move monitor.c there. As the plan
is to move the monitor core into separate files, use the chance to
rename it to misc.c.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor.c =3D> monitor/misc.c | 0
 Makefile.target             | 3 ++-
 monitor/Makefile.objs       | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)
 rename monitor.c =3D> monitor/misc.c (100%)
 create mode 100644 monitor/Makefile.objs

diff --git a/monitor.c b/monitor/misc.c
similarity index 100%
rename from monitor.c
rename to monitor/misc.c
diff --git a/Makefile.target b/Makefile.target
index ecd856e3a3..72c267f7dc 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -148,9 +148,10 @@ endif #CONFIG_BSD_USER
 #########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
-obj-y +=3D arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o num=
a.o
+obj-y +=3D arch_init.o cpus.o gdbstub.o balloon.o ioport.o numa.o
 obj-y +=3D qtest.o
 obj-y +=3D hw/
+obj-y +=3D monitor/
 obj-y +=3D qapi/
 obj-y +=3D memory.o
 obj-y +=3D memory_mapping.o
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
new file mode 100644
index 0000000000..e783b0616b
--- /dev/null
+++ b/monitor/Makefile.objs
@@ -0,0 +1 @@
+obj-y +=3D misc.o
--=20
2.20.1


