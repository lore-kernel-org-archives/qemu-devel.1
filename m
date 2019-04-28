Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E0FC43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5310D2075D
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5310D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKdew-0003Kn-Ln
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 02:51:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbf-0000Jp-2J
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbe-0006Ab-5v
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbc-00065W-8S
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93FFB8666B;
	Sun, 28 Apr 2019 06:48:06 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 161B5171EE;
	Sun, 28 Apr 2019 06:48:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 08:47:29 +0200
Message-Id: <20190428064731.29913-5-philmd@redhat.com>
In-Reply-To: <20190428064731.29913-1-philmd@redhat.com>
References: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Sun, 28 Apr 2019 06:48:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/6] hw/acpi: Always build the 'core' ACPI
 functions
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
Cc: Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190428064729.NYBdkVBieNw9dPBzNODZ4qy62cou_vI0hrBAAhT1jQw@z>

The 'core' ACPI functions are not X86-specific.
Let this file be built unconditionally, this will allow
us to use ACPI on non-X86 architectures.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/Makefile.objs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index b5515c626a6..0427253816b 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -1,4 +1,5 @@
-common-obj-$(CONFIG_ACPI_X86) +=3D core.o piix4.o pcihp.o
+common-obj-$(CONFIG_ACPI) +=3D core.o
+common-obj-$(CONFIG_ACPI_X86) +=3D piix4.o pcihp.o
 common-obj-$(CONFIG_ACPI_X86_ICH) +=3D ich9.o tco.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu_hotplug.o
 common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotplug.o
--=20
2.20.1


