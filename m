Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9123DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C30120868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C30120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49709 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU3qA-0003QB-Jb
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 02:38:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3oc-0002gt-BA
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3ob-0002kY-7F
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU3ob-0002jr-2A
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E8283082132;
	Fri, 24 May 2019 06:36:23 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DB5E05B695;
	Fri, 24 May 2019 06:36:15 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 08:35:35 +0200
Message-Id: <20190524063553.5339-3-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-1-philmd@redhat.com>
References: <20190524063553.5339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 24 May 2019 06:36:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 02/20] hw/i386/pc: Use size_t type to
 hold/return a size of array
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c         | 4 ++--
 include/hw/i386/pc.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fc38b59d2d..df8600ac24 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -104,7 +104,7 @@ struct e820_table {
=20
 static struct e820_table e820_reserve;
 static struct e820_entry *e820_table;
-static unsigned e820_entries;
+static size_t e820_entries;
 struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
=20
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
@@ -897,7 +897,7 @@ int e820_add_entry(uint64_t address, uint64_t length,=
 uint32_t type)
     return e820_entries;
 }
=20
-int e820_get_num_entries(void)
+size_t e820_get_num_entries(void)
 {
     return e820_entries;
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ad3a75d8fa..28b19173b0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -290,7 +290,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
 #define E820_UNUSABLE   5
=20
 int e820_add_entry(uint64_t, uint64_t, uint32_t);
-int e820_get_num_entries(void);
+size_t e820_get_num_entries(void);
 bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
=20
 extern GlobalProperty pc_compat_4_0[];
--=20
2.20.1


