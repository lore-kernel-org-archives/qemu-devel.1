Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61718C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6EC20868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6EC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49763 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU3t2-0005pl-Eh
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 02:41:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3oy-0002vD-45
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3ov-0002uk-RF
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU3ov-0002uM-Im
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE6EF308338F;
	Fri, 24 May 2019 06:36:48 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A5B15B689;
	Fri, 24 May 2019 06:36:38 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 08:35:38 +0200
Message-Id: <20190524063553.5339-6-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-1-philmd@redhat.com>
References: <20190524063553.5339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 24 May 2019 06:36:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 05/20] hw/i386/pc: Add documentation to the
 e820_*() functions
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
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i386/pc.h | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 10e77a40ce..95bf3278f2 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -293,9 +293,42 @@ typedef enum {
     E820_UNUSABLE   =3D 5
 } E820Type;
=20
-ssize_t e820_add_entry(uint64_t, uint64_t, uint32_t);
+/**
+ * e820_add_entry: Add an #e820_entry to the @e820_table.
+ *
+ * Returns the number of entries of the e820_table on success,
+ *         or a negative errno otherwise.
+ *
+ * @address: The base address of the structure which the BIOS is to fill=
 in.
+ * @length: The length in bytes of the structure passed to the BIOS.
+ * @type: The #E820Type of the address range.
+ */
+ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)=
;
+
+/**
+ * e820_get_num_entries: The number of entries of the @e820_table.
+ *
+ * Returns the number of entries of the e820_table.
+ */
 size_t e820_get_num_entries(void);
-bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
+
+/**
+ * e820_get_entry: Get the address/length of an #e820_entry.
+ *
+ * If the #e820_entry stored at @index is of #E820Type @type, fills @add=
ress
+ * and @length with the #e820_entry values and return @true.
+ * Return @false otherwise.
+ *
+ * @index: The index of the #e820_entry to get values.
+ * @type: The @E820Type of the address range expected.
+ * @address: Pointer to the base address of the #e820_entry structure to
+ *           be filled.
+ * @length: Pointer to the length (in bytes) of the #e820_entry structur=
e
+ *          to be filled.
+ * @return: true if the entry was found, false otherwise.
+ */
+bool e820_get_entry(unsigned int index, E820Type type,
+                    uint64_t *address, uint64_t *length);
=20
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
--=20
2.20.1


