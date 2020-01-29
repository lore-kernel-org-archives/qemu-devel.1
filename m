Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89B9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AB82063A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4yALRlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AB82063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwo3N-0007KI-O6
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 09:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iwo1S-0004Pu-V4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iwo1R-0002sy-A4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:08:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iwo1R-0002r1-5u
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580306927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aGrJCUiTZtSwIQMM8BwBaANR8U8d9yS46d+iW28qHX8=;
 b=I4yALRlDyM815hrWMw46FE25VvTXMiCh8quZAKV9y6+akuYlBA6Bq92juzDKqMDrGP3p0w
 gMLjIYWIVgblusYQzqE/WH8EoboWEby22hCiudP9OIgEAWV67RF1CzZL9U+7oeb6lPA2/I
 KHZkSGOzQVkKu6JetLF5K7qjIg3vANM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-U46XLZ-7PLys-PsVIuYP3g-1; Wed, 29 Jan 2020 09:08:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE18113E5
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 14:08:44 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83E7984773;
 Wed, 29 Jan 2020 14:08:38 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] acpi: cpuhp: document CPHP_GET_CPU_ID_CMD command
Date: Wed, 29 Jan 2020 15:06:21 +0100
Message-Id: <1580306781-228371-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: U46XLZ-7PLys-PsVIuYP3g-1
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
did not sufficiently describe it. Fix it by adding missing command
documentation.

Fixes: 3a61c8db9d25 ("acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index a8ce5e7..9bb22d1 100644
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
--=20
2.7.4


