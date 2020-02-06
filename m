Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2792C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCB920658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eF3S9HKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCB920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izoj8-0002ve-Lo
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoap-0001DX-5t
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoan-00070I-U5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoan-0006y8-Pa
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IMXt0m0218x0UlqeNnfj4SNNwPOIT8m1iA4SS91+Vc=;
 b=eF3S9HKxeFW9kCVddRu//9X9izfM/E1k7JGMwX9uXMYqCoDHQh/GaP8gSrhxnIKuZsq25a
 47jvmutuZnEfhMELS2g1iby3lHz2w5n4s0ZTfr4mEs2s1xFrmeDfd1KfN0GjAv78LCWGHM
 Ff6/ZqzrSkGVZjippRQJCcFEezWhBuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-eyAeFl50OB2MPeBv0W30Qw-1; Thu, 06 Feb 2020 16:21:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A11C66124F
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:21:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A11060BEC;
 Thu,  6 Feb 2020 21:21:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/46] scripts/checkpatch.pl: Only allow Python 3 interpreter
Date: Thu,  6 Feb 2020 22:19:21 +0100
Message-Id: <20200206211936.17098-32-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: eyAeFl50OB2MPeBv0W30Qw-1
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit ddf9069963 QEMU requires Python >=3D 3.5.

PEP 0394 [*] states that 'python3' should be available and
that 'python' is optional.

To avoid problem with unsupported versions, enforce the
shebang interpreter to Python 3.

[*] https://www.python.org/dev/peps/pep-0394/

Reported-by: John Snow <jsnow@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200130163232.10446-2-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3aef6e3dfe..ce43a306f8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1460,6 +1460,12 @@ sub process {
 =09=09=09}
 =09=09}
=20
+# Only allow Python 3 interpreter
+=09=09if ($realline =3D=3D 1 &&
+=09=09=09$line =3D~ /^\+#!\ *\/usr\/bin\/(?:env )?python$/) {
+=09=09=09ERROR("please use python3 interpreter\n" . $herecurr);
+=09=09}
+
 # Accept git diff extended headers as valid patches
 =09=09if ($line =3D~ /^(?:rename|copy) (?:from|to) [\w\/\.\-]+\s*$/) {
 =09=09=09$is_patch =3D 1;
--=20
2.21.1


