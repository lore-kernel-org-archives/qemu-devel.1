Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC9C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E7D2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E7D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40848 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRYk-0005l2-MF
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42525)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbQph-0001Z9-N2
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbQpf-0001YG-WA
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbQpf-0000fM-KQ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:36:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B37CC30BBE97;
 Thu, 13 Jun 2019 14:35:07 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52FA31001B3A;
 Thu, 13 Jun 2019 14:35:01 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 16:34:27 +0200
Message-Id: <20190613143446.23937-2-philmd@redhat.com>
In-Reply-To: <20190613143446.23937-1-philmd@redhat.com>
References: <20190613143446.23937-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 14:35:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 01/20] hw/i386/pc: Use unsigned type to
 index arrays
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Rob Bradford <robert.bradford@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c         | 5 +++--
 include/hw/i386/pc.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2c5446b095..bb3c74f4ca 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -874,7 +874,7 @@ static void handle_a20_line_change(void *opaque, int =
irq, int level)
=20
 int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
 {
-    int index =3D le32_to_cpu(e820_reserve.count);
+    unsigned int index =3D le32_to_cpu(e820_reserve.count);
     struct e820_entry *entry;
=20
     if (type !=3D E820_RAM) {
@@ -906,7 +906,8 @@ int e820_get_num_entries(void)
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
index a7d0b87166..3b3a0d6e59 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -291,7 +291,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
=20
 int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
-bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
+bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
=20
 extern GlobalProperty pc_compat_4_0_1[];
 extern const size_t pc_compat_4_0_1_len;
--=20
2.20.1


