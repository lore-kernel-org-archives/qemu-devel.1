Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F08C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0840221019
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0840221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwkT-0007vd-QH
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48157)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mprivozn@redhat.com>) id 1hlwkJ-0007Pg-0c
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1hlwkI-0000uE-2V
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:41:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>)
 id 1hlwkH-0000tV-Ta; Fri, 12 Jul 2019 10:41:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86AC630821BE;
 Fri, 12 Jul 2019 14:41:56 +0000 (UTC)
Received: from moe.brq.redhat.com (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EE94544F5;
 Fri, 12 Jul 2019 14:41:53 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-trivial@nongnu.org
Date: Fri, 12 Jul 2019 16:41:47 +0200
Message-Id: <db150a03315a89a849ab9968e4a5a26110d41424.1562942402.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 12 Jul 2019 14:41:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] .gitignore: ignore some vhost-user* related
 files
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit d52c454aadc creates
'/contrib/vhost-user-gpu/50-qemu-gpu.json' and '/vhost-user-gpu'
and commit 06914c97d3a creates '/vhost-user-input' neither of
which is ignored by git.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index fd6e6c38c7..e9bbc006d3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -65,6 +65,8 @@
 /scsi/qemu-pr-helper
 /vhost-user-scsi
 /vhost-user-blk
+/vhost-user-gpu
+/vhost-user-input
 /fsdev/virtfs-proxy-helper
 *.tmp
 *.[1-9]
@@ -131,6 +133,7 @@
 /docs/interop/qemu-qmp-ref.info*
 /docs/interop/qemu-qmp-ref.txt
 /docs/version.texi
+/contrib/vhost-user-gpu/50-qemu-gpu.json
 *.tps
 .stgit-*
 .git-submodule-status
--=20
2.21.0


