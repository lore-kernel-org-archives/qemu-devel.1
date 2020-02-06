Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D071C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065E521775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iq+4JyCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065E521775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izoqp-0008Q6-7a
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoac-0000iE-Ru
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoab-00060g-Si
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoab-0005zP-OQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jvez0p+hE1HDRDeppjQXiobXWqeKcO7pLBXKxpNHIdU=;
 b=iq+4JyCGYIV9R/N4K1r6Jxc3sEqPpmmQeXW73Q2E5ZauwVCf6H0vVE3bqMqIXOzJPOtdZV
 r4EXpUpnAtFP78v3h5Xsrzvfhl+/QnKrUgsFrNO6jkQ4AzDhvVWiO9akv0RE7QXAHq1RqZ
 8hPOBtzoSHCgcMGKKqGmY7FsGr9VIXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-qdgL7du3MKm0YwDgvtMl4A-1; Thu, 06 Feb 2020 16:21:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3BCB10509A1
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:21:30 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CAAD60BEC;
 Thu,  6 Feb 2020 21:21:26 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/46] tests/acceptance/migration: Add the 'migration' tag
Date: Thu,  6 Feb 2020 22:19:19 +0100
Message-Id: <20200206211936.17098-30-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qdgL7du3MKm0YwDgvtMl4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using an Avocado tag, we can run all tests described by that
tag as once:

  $ avocado --show=3Dapp run -t migration tests/acceptance/
  JOB ID     : 165477737509503fcfa6d7108057a0a18f2a6559
  JOB LOG    : avocado/job-results/job-2020-02-04T17.29-1654777/job.log
   (1/3) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.38 s)
   (2/3) tests/acceptance/migration.py:Migration.test_migration_with_unix: =
PASS (0.33 s)
   (3/3) tests/acceptance/migration.py:Migration.test_migration_with_exec: =
PASS (0.07 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200204163304.14616-1-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/migration.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index 41b13b9e0d..b342cabe07 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -20,6 +20,9 @@ from avocado.utils.path import find_command
=20
=20
 class Migration(Test):
+    """
+    :avocado: tags=3Dmigration
+    """
=20
     timeout =3D 10
=20
--=20
2.21.1


