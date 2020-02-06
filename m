Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC183C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B5221775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hast6UUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B5221775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izp0l-0007TH-Ok
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izobu-0003cu-4T
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izobt-00026q-6U
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:22:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izobt-00024x-21
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yof9vsgxINkNpTg2ojEpJpfJ8f841MHINVf7CYLErWc=;
 b=hast6UUVuxSovJVkkoVpxPEbu4eTmVDRm4ZoHqEXEsDF7YkgANPZ+u0R0bMjuENvZjF4xi
 AKxtNiCON39tDgdyUB2czxXQKGE+0qNL4Rj3r5TV2gAcQDWOc33xq3WvzG51wYumHoA0px
 8M5SdQAJyCG+pEMnxLcwjPk83tQ7FlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-JDEZW8gWNXuqCWU6amA6yQ-1; Thu, 06 Feb 2020 16:22:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 489E58010FC
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:22:50 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C48AD60BEC;
 Thu,  6 Feb 2020 21:22:48 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/46] make all Python scripts executable
Date: Thu,  6 Feb 2020 22:19:34 +0100
Message-Id: <20200206211936.17098-45-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JDEZW8gWNXuqCWU6amA6yQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Scripts that have a Python shebang are meant to be executed directly from t=
he
shell; give them 755 permissions.

Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200204160237.16889-1-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/minikconf.py   | 0
 scripts/signrom.py     | 0
 tests/qemu-iotests/222 | 0
 tests/qemu-iotests/245 | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 =3D> 100755 scripts/minikconf.py
 mode change 100644 =3D> 100755 scripts/signrom.py
 mode change 100644 =3D> 100755 tests/qemu-iotests/222
 mode change 100644 =3D> 100755 tests/qemu-iotests/245

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
old mode 100644
new mode 100755
diff --git a/scripts/signrom.py b/scripts/signrom.py
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
old mode 100644
new mode 100755
--=20
2.21.1


