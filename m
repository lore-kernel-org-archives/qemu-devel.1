Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F8CC43218
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 14:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D742D2087F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 14:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D742D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60891 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKOBW-0001Lb-Ru
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 10:20:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOAh-0000o3-Rb
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOAg-0004vC-Si
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:19:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKOAg-0004uS-NE
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:19:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02335308AA12;
	Sat, 27 Apr 2019 14:19:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-83.brq.redhat.com [10.40.204.83])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17B875D70A;
	Sat, 27 Apr 2019 14:19:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 27 Apr 2019 16:19:04 +0200
Message-Id: <20190427141905.20393-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Sat, 27 Apr 2019 14:19:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] hw/i386: The i440fx is not a machine,
 remove it from the machine list
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427141904.KW2rJGn2O-zEbWzzzX3TBA7sLPJEYJYbHC8BtqBGSo4@z>

When building with CONFIG_ISAPC=3Dn and CONFIG_I440FX=3Dy we get:

  $ make subdir-x86_64-softmmu
  [...]
  /usr/bin/ld: hw/i386/pc_piix.o: in function `pc_init1':
  /source/qemu/hw/i386/pc_piix.c:261: undefined reference to `isa_ide_ini=
t'
  /usr/bin/ld: /source/qemu/hw/i386/pc_piix.c:261: undefined reference to=
 `isa_ide_init'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:204: qemu-system-x86_64] Error 1

This is because the I440FX device is a North Bridge, not a machine.
It is however used by the ISAPC machine.

Correct the dependency in the ISAPC Kconfig.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/i386-softmmu.mak | 1 -
 hw/i386/Kconfig                  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-soft=
mmu.mak
index ba3fb3ff50a..b33f5952128 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -23,5 +23,4 @@
 # Boards:
 #
 CONFIG_ISAPC=3Dy
-CONFIG_I440FX=3Dy
 CONFIG_Q35=3Dy
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a6aed7c1313..9211adf2bb3 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -69,7 +69,7 @@ config ISAPC
     select VGA_ISA
     # FIXME: it is in the same file as i440fx, and does not compile
     # if separated
-    depends on I440FX
+    select I440FX
=20
 config Q35
     bool
--=20
2.20.1


