Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552F6C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 09:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274D62148D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 09:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274D62148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJEXR-0007lC-EM
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 05:50:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJEVX-0006f2-IF
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJETb-00062b-8c
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:46:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hJETb-00061e-3N
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:46:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D2C530BC755;
	Wed, 24 Apr 2019 09:46:02 +0000 (UTC)
Received: from thuth.com (ovpn-116-69.ams2.redhat.com [10.36.116.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B4DD5DC1B;
	Wed, 24 Apr 2019 09:46:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Berger <stefanb@linux.ibm.com>
Date: Wed, 24 Apr 2019 11:45:57 +0200
Message-Id: <20190424094557.28404-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 24 Apr 2019 09:46:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests/tpm-tests: Use g_test_skip() to mark
 skipped tests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424094557.Yh5zw4o-f8nfToHFOqPb2JNacvGVh2ttmDRt2W4jW0g@z>

Since we do not use gtester anymore (which had a bug here),
we can now use g_test_skip() to mark skipped tests.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tpm-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
index 582ec0cfd4..e640777aa9 100644
--- a/tests/tpm-tests.c
+++ b/tests/tpm-tests.c
@@ -22,7 +22,7 @@ static bool
 tpm_test_swtpm_skip(void)
 {
     if (!tpm_util_swtpm_has_tpm2()) {
-        g_test_message("swtpm not in PATH or missing --tpm2 support");
+        g_test_skip("swtpm not in PATH or missing --tpm2 support");
         return true;
     }
=20
--=20
2.21.0


