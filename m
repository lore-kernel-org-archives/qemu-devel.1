Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D551C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 04:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2419D20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 04:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2419D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnFS0-0002q9-CL
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 00:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38231)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hnFRK-0008L6-UB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 00:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hnFRJ-0007BS-Uj
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 00:51:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hnFRJ-0007Ae-Og
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 00:51:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20BB3C057EC0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 04:51:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1CBE5E7A8;
 Tue, 16 Jul 2019 04:51:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C6A411386B0; Tue, 16 Jul 2019 06:51:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 06:51:40 +0200
Message-Id: <20190716045141.21383-3-armbru@redhat.com>
In-Reply-To: <20190716045141.21383-1-armbru@redhat.com>
References: <20190716045141.21383-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 16 Jul 2019 04:51:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/3] Makefile: Fix missing dependency of on
 qemu-tech.texi
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qemu-doc.{html,info,pdf,txt} depend on qemu-doc.texi and its
include files.  Except qemu-tech.texi is missing.  Has always been
missing as far as I can see.  Fix it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190715055736.15214-2-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 09b77e8a7b..f9791dcb82 100644
--- a/Makefile
+++ b/Makefile
@@ -1021,7 +1021,8 @@ pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf doc=
s/interop/qemu-ga-ref.pdf
 txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref=
.txt
=20
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
-	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
+	qemu-img.texi qemu-nbd.texi qemu-options.texi \
+	qemu-tech.texi qemu-option-trace.texi \
 	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi =
\
 	qemu-monitor-info.texi docs/qemu-block-drivers.texi \
 	docs/qemu-cpu-models.texi docs/security.texi
--=20
2.21.0


