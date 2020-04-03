Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC5C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F5420737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxY59y0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F5420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQCL-0003vs-MQ
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQ8S-0007sl-2r
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQ8O-0006aT-Fk
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQ8N-0006Zu-VM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585934974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IySQfSoliK7L1y64dc2+4knq4GDTJOqI5a2WNZld2yk=;
 b=JxY59y0ehk+Hp1vKqaJXitohfs67op3PAzW+JUTMkVbhRidRZWf+4TPlB9E0lLwRrkFUwf
 UJ9BGUkGnrl+XPVU2LE8INYHAfy91NqHRDA71IZ46eZUHbOf1zl3tS/gUwaXPeCNZTW0A+
 opzQD1HsvMYY6oret0fxkpRad1jyKdc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-bCNv9Z1CO8mRVG3Uhgb9nQ-1; Fri, 03 Apr 2020 13:29:32 -0400
X-MC-Unique: bCNv9Z1CO8mRVG3Uhgb9nQ-1
Received: by mail-wm1-f70.google.com with SMTP id j18so2360618wmi.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=efxzJklfdbLE5xyXDAw4RE+zYk98wFqYdSDot6mi/b0=;
 b=iCSphorLLsz/1KEFuAi++ygC8MZHYXXSJcWH02yj0uypJCphmmngL454Je0Uwj1KuR
 qOSrhinNExhAENaAbqRHiHyFLt6I0AJ6WR4HqQHeO5GYumP/gzXsd2iarEFTXn0ooEiA
 9Uyi2vjcmdHqAu9hmF78p1MkyDBsSt6/gIRi3+AKD9PXY0I/eSs5YmvejJ1iUUzP6BWW
 cdkyhO+75cioT9+HTgcfsTeBKL07eJ3XgPfBtIdMN2krjjgaETdkN3erDQVO3xA71m1j
 Q942V2JchPLQ75xETiO6PSF5wcfmD/f2kP59xH29KlK2KmF3ZZrImXdkU+VVul6kbmBx
 Uq8A==
X-Gm-Message-State: AGi0PubdJUcHKZX1h11V048osBFtwut00A/ug3oZiYlnUSzH+BlXrm5b
 D6qlAhRmdNZZOD1c7wIkKnXQRvGX6KNT1odLOlvhcVcdmeuznq6wAH9fy7WJRTPKOWnz2aFOUzW
 Lb3xHv7gVptUR8nM=
X-Received: by 2002:a1c:a754:: with SMTP id q81mr9735527wme.124.1585934970657; 
 Fri, 03 Apr 2020 10:29:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypKjOuNAIL3bzMQXzYoa+mCNMjVeKsr3+FK5ZDCy4b8LRgJ1pqLYkDLxTCgV2kPDAE0NBE4kJQ==
X-Received: by 2002:a1c:a754:: with SMTP id q81mr9735506wme.124.1585934970471; 
 Fri, 03 Apr 2020 10:29:30 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id i8sm13795512wrb.41.2020.04.03.10.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 10:29:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 1/8] Acceptance test: Fix to EXEC migration
Date: Fri,  3 Apr 2020 19:29:12 +0200
Message-Id: <20200403172919.24621-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403172919.24621-1-philmd@redhat.com>
References: <20200403172919.24621-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Oksana Vohchana <ovoshcha@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Oksana Vohchana <ovoshcha@redhat.com>

The exec migration test isn't run a whole test scenario.
This patch fixes it

Fixes: 2e768cb682bf
Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200325113138.20337-1-ovoshcha@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/migration.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index a8367ca023..0365289cda 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -70,8 +70,8 @@ def test_migration_with_unix(self):
=20
     @skipUnless(find_command('nc', default=3DFalse), "'nc' command not fou=
nd")
     def test_migration_with_exec(self):
-        """
-        The test works for both netcat-traditional and netcat-openbsd pack=
ages
-        """
+        """The test works for both netcat-traditional and netcat-openbsd p=
ackages."""
         free_port =3D self._get_free_port()
         dest_uri =3D 'exec:nc -l localhost %u' % free_port
+        src_uri =3D 'exec:nc localhost %u' % free_port
+        self.do_migrate(dest_uri, src_uri)
--=20
2.21.1


