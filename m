Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3518C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DE620868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DE620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49761 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU3sj-0005dX-P8
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 02:40:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3oc-0002gj-28
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3oa-0002kL-Vb
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU3oa-0002iI-Qh
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 390F3C0578FA;
	Fri, 24 May 2019 06:36:15 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D51165B68B;
	Fri, 24 May 2019 06:36:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 08:35:34 +0200
Message-Id: <20190524063553.5339-2-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-1-philmd@redhat.com>
References: <20190524063553.5339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 24 May 2019 06:36:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 01/20] hw/i386/pc: Use unsigned type to index
 arrays
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
 hw/i386/pc.c         | 5 +++--
 include/hw/i386/pc.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2632b73f80..fc38b59d2d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -870,7 +870,7 @@ static void handle_a20_line_change(void *opaque, int =
irq, int level)
=20
 int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
 {
-    int index =3D le32_to_cpu(e820_reserve.count);
+    unsigned int index =3D le32_to_cpu(e820_reserve.count);
     struct e820_entry *entry;
=20
     if (type !=3D E820_RAM) {
@@ -902,7 +902,8 @@ int e820_get_num_entries(void)
     return e820_entries;
 }
=20
-bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t =
*length)
+bool e820_get_entry(unsigned int idx, uint32_t type,
+                    uint64_t *address, uint64_t *length)
 {
     if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ty=
pe)) {
         *address =3D le64_to_cpu(e820_table[idx].address);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 43df7230a2..ad3a75d8fa 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -291,7 +291,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
=20
 int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
-bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
+bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
=20
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
--=20
2.20.1


