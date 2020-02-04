Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05020C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35EC2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HF+UPwe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35EC2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1AL-00040e-VT
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz18n-0002Te-F5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz18l-0003SK-68
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:33:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz18k-0003JK-QE
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580834009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oJswGVqRYMwRbH/XCx1YLK78Ml072Qtmy9FeAa7fA4o=;
 b=HF+UPwe+kZbnSE7B41v8JAL5muvfw3JA2oTKYm6qusW6e9LndJGa21ZodnCKYkRCfH/Kc+
 FENqJ4HDj4pYRS6GVITX44n+EK4w5Gc0AbLnMff+mdZfkzEpsu594ZPJ4dt0McIQjnCewH
 tCxmtUZDry8XCZ3qF5+BjQKW2oV3t9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-HQumBBFENUCOrE1GUDM39w-1; Tue, 04 Feb 2020 11:33:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D49B1137841
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 16:33:13 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD1CE10018FF;
 Tue,  4 Feb 2020 16:33:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Oksana Vohchana <ovoshcha@redhat.com>
Subject: [PATCH] tests/acceptance/migration: Add the 'migration' tag
Date: Tue,  4 Feb 2020 17:33:04 +0100
Message-Id: <20200204163304.14616-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: HQumBBFENUCOrE1GUDM39w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Based-on: <20200203111631.18796-1-ovoshcha@redhat.com>
https://www.mail-archive.com/qemu-devel@nongnu.org/msg676230.html
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


