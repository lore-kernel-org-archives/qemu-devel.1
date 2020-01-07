Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9801C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AA42073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgzZLSYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AA42073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosOx-0003Rh-8C
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1ioroe-0003iA-1T
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1ioroc-0007jt-UZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:34:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26629
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1ioroc-0007je-Qt
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FciTb1JnkpJfkewE7Qw00vHQicOUONHyh71uskT8CX0=;
 b=XgzZLSYZ1JYT7yfuaPrOXNEFGz4CGpNHZUpSOXrjv0dhaIbQOVa3f/cqEKM439kk97Si/d
 a5IetxN8oOTpHhsmPjWJT6yqBSIp0dXP4ZPTObwiK0n1VQ8O9jDEU0IskL7f9VUz3wonz7
 +fbjeBR93VSCrwvjmmWBvQMPVftT+DE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-0dRYtDbAPR-MOD8F36PdKw-1; Tue, 07 Jan 2020 11:34:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F06911800D4E;
 Tue,  7 Jan 2020 16:34:43 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-184.ams2.redhat.com
 [10.36.116.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6812460BFB;
 Tue,  7 Jan 2020 16:34:38 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration-test: ppc64: fix FORTH test program
Date: Tue,  7 Jan 2020 17:34:37 +0100
Message-Id: <20200107163437.52139-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0dRYtDbAPR-MOD8F36PdKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Wei Huang <wei@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit e51e711b1bef has moved the initialization of start_address and
end_address after the definition of the command line argument,
where the nvramrc is initialized, and thus the loop is between 0 and 0
rather than 1 MiB and 100 MiB.

It doesn't affect the result of the test if all the tests are run in
sequence because the two first tests don't run the loop, so the
values are correctly initialized when we actually need them.

But it hangs when we ask to run only one test, for instance:

    QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 \
    tests/migration-test -m=3Dquick -p /ppc64/migration/validate_uuid_error

Fixes: e51e711b1bef ("tests/migration: Add migration-test header file")
Cc: wei@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 53afec439522..341d19092214 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -480,14 +480,14 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
         machine_opts =3D "vsmt=3D8";
         memory_size =3D "256M";
+        start_address =3D PPC_TEST_MEM_START;
+        end_address =3D PPC_TEST_MEM_END;
         arch_source =3D g_strdup_printf("-nodefaults "
                                       "-prom-env 'use-nvramrc?=3Dtrue' -pr=
om-env "
                                       "'nvramrc=3Dhex .\" _\" begin %x %x =
"
                                       "do i c@ 1 + i c! 1000 +loop .\" B\"=
 0 "
                                       "until'", end_address, start_address=
);
         arch_target =3D g_strdup("");
-        start_address =3D PPC_TEST_MEM_START;
-        end_address =3D PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") =3D=3D 0) {
         init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
         machine_opts =3D "virt,gic-version=3Dmax";
--=20
2.23.0


