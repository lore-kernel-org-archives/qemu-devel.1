Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB74EC43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B255A208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B255A208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgxA-0006Ke-RU
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 16:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35256)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hdgv5-0004JF-M3
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hdgv4-00015y-49
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hdgv3-00010n-7S
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:10:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5E3A230860B9
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 20:10:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-85.ams2.redhat.com
 [10.36.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B05760142;
 Wed, 19 Jun 2019 20:10:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 90BC811386B0; Wed, 19 Jun 2019 22:10:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 22:10:35 +0200
Message-Id: <20190619201050.19040-3-armbru@redhat.com>
In-Reply-To: <20190619201050.19040-1-armbru@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 19 Jun 2019 20:10:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 02/17] Makefile: Don't add monitor/ twice to
 common-obj-y
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
Cc: kwolf@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both commit f1b3ccfaa68 "monitor: Move {hmp, qmp}.c to monitor/{hmp,
qmp}-cmds.c" and commit 7e3c0deab1b "monitor: Split out monitor/qmp.c"
added monitor/ to common-obj-y ifeq ($(CONFIG_SOFTMMU),y).  Revert the
second addition.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile.objs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile.objs b/Makefile.objs
index 658cfc9d9f..7494d6143b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -85,7 +85,6 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
 # qapi
=20
 common-obj-y +=3D qapi/
-common-obj-y +=3D monitor/
 endif
=20
 #######################################################################
--=20
2.21.0


