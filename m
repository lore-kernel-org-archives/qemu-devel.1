Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0F320709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STZaIwlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0F320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv0ly-0001z5-La
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 10:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iv0kv-0001Tu-Sr
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iv0kt-0000fK-NM
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:20:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44539
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iv0kt-0000dl-JP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579879218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eTvZW/NuBUyjbIqaM5XAzELe4PNB00uLxVbFzd412W8=;
 b=STZaIwlvOjOx3msN/E8bcNSy+pgbsEsulGh42dvIxyKEWSBv1en3cn3Klrqpk8yQvJeH3v
 ny85O0zEgBNagfKO1LR5Jw4ssXFxm8JsP5T/wfXB+zjJ5ODNlHqkn22JvNrb182PQ2maiz
 osaE3UQj8bTG0W7IWvAmrODNfo28Wx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-ZXwSItErOBebX4xchJR6Bw-1; Fri, 24 Jan 2020 10:20:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D655E10A6430
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 15:20:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E78F8DC16;
 Fri, 24 Jan 2020 15:20:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] acpi: cpuhp: document how to use CPHP_GET_CPU_ID_CMD command
Date: Fri, 24 Jan 2020 16:17:45 +0100
Message-Id: <1579879065-3873-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZXwSItErOBebX4xchJR6Bw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: lersek@redhat.com, philmd@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 3a61c8db9d25 introduced CPHP_GET_CPU_ID_CMD command but
did not sufficiently described how to use it. Fix it by adding
missing command documentation and suggested work-flow to enumerate
possible architecture specific CPU IDs.

Fixes: 3a61c8db9d25 ("acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index a8ce5e7..81b4534 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -94,6 +94,8 @@ write access:
                register in QEMU
             2: following writes to 'Command data' register set OST status
                register in QEMU
+            3: following reads from 'Command data' and 'Command data 2' re=
turn
+               architecture specific CPU ID value for currently selected C=
PU.
             other values: reserved
     [0x6-0x7] reserved
     [0x8] Command data: (DWORD access)
@@ -147,3 +149,16 @@ Typical usecases:
       11. Otherwise store 0x0 to the 'CPU selector' register, to put it
           into a valid state and exit.
           The iterator at this point equals "max_cpus".
+
+    - Enumerate present/non present CPUs architecture specific IDs
+      (in case of x86: ACPIC IDs)
+      01: Use "Enumerate CPUs present/non present CPUs" to get max_cpus
+      02: Store 0x3 in the 'Command field' register
+      03: Set 'current cpu selector' iterator to 0x0
+      04: Store the iterator to the 'CPU selector' register
+      05: Read from registers 'Command data' and 'Command data 2' parts of=
 ID,
+          combine them into ID like following:
+             'Command data 2' << 32 | 'Command data'
+          and store pair 'current cpu selector' : ID for further processin=
g
+      06: Increment the iterator and if the iterator < max_cpus go to step=
 4
+      07: Otherwise store 0x0 to the 'CPU selector' register and exit.
--=20
2.7.4


