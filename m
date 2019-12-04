Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF9C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D16B2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6aFAtes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D16B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icYMk-0000bk-Hl
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 12:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1icY6V-0005Sa-08
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1icY6L-0008Ei-02
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:06:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1icY6K-0007pd-Ev
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575479167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TqJTzapMD48SAnuXvSZ6ni4aF2WLRnsexaD2qQGsFgo=;
 b=g6aFAtesY2pBQrtrvwU3x2QOn9nxIdCY1yC2KdiusEcmdmoYCIj3l4ceLbSXXfP/XDgTBT
 6rr7Zuqyff8Irh8z5mBk9atajSzptp0kjx+zVZhXqHD0Bi5LvaQm5OWjPC7w59Gud9onWo
 CZb2RsFSXTPZoUv8G/KnVi51YIV2cfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-0Rwf_ThgOKmzxVGdVfLX0A-1; Wed, 04 Dec 2019 12:05:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0625C1083E8F
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 17:05:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D207F5D6BB;
 Wed,  4 Dec 2019 17:05:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 8/8] acpi: cpuhp: spec: document procedure for
 enabling modern CPU hotplug
Date: Wed,  4 Dec 2019 18:05:47 +0100
Message-Id: <1575479147-6641-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0Rwf_ThgOKmzxVGdVfLX0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Describe how to enable and detect modern CPU hotplug interface.
Detection part is based on new CPHP_GET_CPU_ID_CMD command,
introduced by "acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command" patch.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index bb33144..667b264 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -15,14 +15,14 @@ CPU present bitmap for:
   PIIX-PM  (IO port 0xaf00-0xaf1f, 1-byte access)
   One bit per CPU. Bit position reflects corresponding CPU APIC ID. Read-o=
nly.
   The first DWORD in bitmap is used in write mode to switch from legacy
-  to new CPU hotplug interface, write 0 into it to do switch.
+  to modern CPU hotplug interface, write 0 into it to do switch.
 ---------------------------------------------------------------
 QEMU sets corresponding CPU bit on hot-add event and issues SCI
 with GPE.2 event set. CPU present map is read by ACPI BIOS GPE.2 handler
 to notify OS about CPU hot-add events. CPU hot-remove isn't supported.
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-ACPI CPU hotplug interface registers:
+Modern ACPI CPU hotplug interface registers:
 -------------------------------------
 Register block base address:
     ICH9-LPC IO port 0x0cd8
@@ -105,6 +105,24 @@ write access:
               other values: reserved
=20
     Typical usecases:
+        - (x86) Detecting and enabling modern CPU hotplug interface.
+          QEMU starts with legacy CPU hotplug interface enabled. Detecting=
 and
+          switching to modern interface is based on the 2 legacy CPU hotpl=
ug features:
+            1. Writes into CPU bitmap are ignored.
+            2. CPU bitmap always has bit#0 set, corresponding to boot CPU.
+
+          Use following steps to detect and enable modern CPU hotplug inte=
rface:
+            1. Store 0x0 to the 'CPU selector' register,
+               attempting to switch to modern mode
+            2. Store 0x0 to the 'CPU selector' register,
+               to ensure valid selector value
+            3. Store 0x3 to the 'Command field' register,
+               sets the 'Command data 2' register into architecture specif=
ic
+               CPU identifier mode
+            4. Read the 'Command data 2' register.
+               If read value is 0x0, the modern interface is enabled.
+               Otherwise legacy or no CPU hotplug interface available
+
         - Get a cpu with pending event
           1. Store 0x0 to the 'CPU selector' register.
           2. Store 0x0 to the 'Command field' register.
--=20
2.7.4


