Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F352CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A2F22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A2F22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UWR-00073S-AL
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPZ-0006jY-0h
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPY-0005Ji-1V
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPX-0005IZ-Re
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 36F6C3082E55
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:39 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30F7360F9F;
 Wed, 21 Aug 2019 17:28:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:15 +0200
Message-Id: <1566408501-48680-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 21 Aug 2019 17:28:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/13] minikconf: don't print CONFIG_FOO=n lines
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qemu in general doesn't define CONFIG_FOO if it's false.  This also
helps with the dumb kconfig parser from meson, as source_set considers
any non-empty value as true.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 3109a81..40ae198 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -702,8 +702,8 @@ if __name__ =3D=3D '__main__':
=20
     config =3D data.compute_config()
     for key in sorted(config.keys()):
-        if key not in external_vars:
-            print ('CONFIG_%s=3D%s' % (key, ('y' if config[key] else 'n'=
)))
+        if key not in external_vars and config[key]:
+            print ('CONFIG_%s=3Dy' % key)
=20
     deps =3D open(argv[2], 'w')
     for fname in data.previously_included:
--=20
1.8.3.1



