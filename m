Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B31C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7372B2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7372B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNuM-0004TH-Oj
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNnc-0006RE-C1
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNnb-0008Jk-8a
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNnZ-0008GF-5T; Tue, 15 Oct 2019 10:27:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6492280F98;
 Tue, 15 Oct 2019 14:27:40 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEA4E5C1D4;
 Tue, 15 Oct 2019 14:27:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 03/21] iotests: Add _filter_json_filename
Date: Tue, 15 Oct 2019 16:27:11 +0200
Message-Id: <20191015142729.18123-4-mreitz@redhat.com>
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 15 Oct 2019 14:27:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.filter | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index 9f418b4881..63bc6f6f26 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -227,5 +227,29 @@ _filter_qmp_empty_return()
     grep -v '{"return": {}}'
 }
=20
+_filter_json_filename()
+{
+    $PYTHON -c 'import sys
+result, *fnames =3D sys.stdin.read().split("json:{")
+depth =3D 0
+for fname in fnames:
+    depth +=3D 1 # For the opening brace in the split separator
+    for chr_i, chr in enumerate(fname):
+        if chr =3D=3D "{":
+            depth +=3D 1
+        elif chr =3D=3D "}":
+            depth -=3D 1
+            if depth =3D=3D 0:
+                break
+
+    # json:{} filenames may be nested; filter out everything from
+    # inside the outermost one
+    if depth =3D=3D 0:
+        chr_i +=3D 1 # First character past the filename
+        result +=3D "json:{ /* filtered */ }" + fname[chr_i:]
+
+sys.stdout.write(result)'
+}
+
 # make sure this script returns success
 true
--=20
2.21.0


