Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9F5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E5F20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc6+1rNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E5F20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZjW5-0004cu-Kv
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZjTc-0003B5-Bo
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZjTb-0004MC-DM
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:38:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39438
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZjTb-0004Lt-9a
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574807910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOw3cVgyxFNk4vzDn7EiINfiKta858f+7/DJp4pf1kk=;
 b=bc6+1rNIKP7lx6HJa8YQ4QBgSvuoyyFJKVdRwCeQmhKdU2YfMSku3PhjQKkbCLP0NRvZ8U
 HQ8Amg3Im/L5g52+L2TLZ1dAP4gAI6lSV6rD0O1uF7VQgkZedTLCR2ruXrbZYMjoG45fzm
 ZOleVUbKsbmwQMjNgvLy9aC7bDZC/zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-z2BmtB6VPyCWqGBtFQSJ-Q-1; Tue, 26 Nov 2019 17:38:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F50B800D54;
 Tue, 26 Nov 2019 22:38:26 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-63.brq.redhat.com [10.40.205.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31847600C8;
 Tue, 26 Nov 2019 22:38:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0? v2 2/2] Revert "Acceptance test: cancel test if m68k
 kernel packages goes missing"
Date: Tue, 26 Nov 2019 23:38:10 +0100
Message-Id: <20191126223810.20180-3-philmd@redhat.com>
In-Reply-To: <20191126223810.20180-1-philmd@redhat.com>
References: <20191126223810.20180-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: z2BmtB6VPyCWqGBtFQSJ-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Willian Rampazzo <wrampazz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now than we use the stable snapshot archive, we can remove this check.

This reverts commit d2499aca4bac613d837e2720e7bbe3378bc91245.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index 752f776f68..ab4c8a5e5a 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -483,10 +483,7 @@ class BootLinuxConsole(Test):
                    '/20191021T083923Z/pool-m68k/main'
                    '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.ude=
b')
         deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
-        try:
-            deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
-        except OSError as exp:
-            self.cancel(exp)
+        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
         kernel_path =3D self.extract_from_deb(deb_path,
                                             '/boot/vmlinux-5.3.0-1-m68k')
=20
--=20
2.21.0


