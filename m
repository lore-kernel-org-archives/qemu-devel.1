Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFA9CA9EC3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8022086A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjVFXopP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8022086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iParj-0007FS-0B
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPaq1-0005bt-Np
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPaq0-0000iC-LS
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:23:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPapw-0000TQ-KD
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572391415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mj7uSch+BUDoZBclmj8iSeHg/OI80GlSoLCJ13li/U=;
 b=RjVFXopPCvoTJK1nbYxYedt2IhPKEi+a8IfYV0PC8NrdakOG8YlN/YkcuovnQB7FeV10D4
 Lw8nvDuylrVfWZ/PRy5UJqeq/JXQyzpCwqiox9b72mQZswac1q/3pSjDWD3d4lr0oyQXt6
 Sj7QUmStunADbcWIo7adDtEe5WgMJ04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-51HFJwBrP1utzDEXCZPM9Q-1; Tue, 29 Oct 2019 19:23:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FCFB180496F;
 Tue, 29 Oct 2019 23:23:31 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 004FA5D9C3;
 Tue, 29 Oct 2019 23:23:29 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] Acceptance test: update kernel for m68k/q800 test
Date: Tue, 29 Oct 2019 19:23:20 -0400
Message-Id: <20191029232320.12419-3-crosa@redhat.com>
In-Reply-To: <20191029232320.12419-1-crosa@redhat.com>
References: <20191028181643.5143-12-laurent@vivier.eu>
 <20191029232320.12419-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 51HFJwBrP1utzDEXCZPM9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Willian Rampazzo <wrampazz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's an updated version of the Debian package containing the m68k
Kernel.

Now, if the package gets updated again, the test won't fail, but will
be canceled.  A more permanent solution is certainly needed.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index c439fd90fc..8f676d8e92 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -385,14 +385,14 @@ class BootLinuxConsole(Test):
         :avocado: tags=3Dmachine:q800
         """
         deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m68k/m=
ain'
-                   '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.ude=
b')
-        deb_hash =3D '0797e05129595f22f3c0142db5e199769a723bf9'
+                   '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.ude=
b')
+        deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
         try:
             deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
         except OSError as exp:
             self.cancel(exp)
         kernel_path =3D self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-5.2.0-2-m68k')
+                                            '/boot/vmlinux-5.3.0-1-m68k')
=20
         self.vm.set_machine('q800')
         self.vm.set_console()
--=20
2.21.0


