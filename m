Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971E6C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F601208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F601208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCfc-0000xz-Eg
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55822)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZBaG-0003cO-2b
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZBa9-0003zE-Lp
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZBa3-0003nh-W8; Fri, 07 Jun 2019 05:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC1A73082DDD;
 Fri,  7 Jun 2019 09:54:36 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 524C77D4FD;
 Fri,  7 Jun 2019 09:54:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 11:52:37 +0200
Message-Id: <20190607095237.11364-36-cohuck@redhat.com>
In-Reply-To: <20190607095237.11364-1-cohuck@redhat.com>
References: <20190607095237.11364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 07 Jun 2019 09:54:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 35/35] linux-user: elf: ELF_HWCAP for s390x
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
Cc: Riku Voipio <riku.voipio@iki.fi>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's add all HWCAPs that we can support under TCG right now, when the
respective CPU facilities are enabled.

Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/elf.h        |  1 +
 linux-user/elfload.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index ea7708a4ea9a..3501e0c8d03a 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -598,6 +598,7 @@ typedef struct {
 #define HWCAP_S390_ETF3EH       256
 #define HWCAP_S390_HIGH_GPRS    512
 #define HWCAP_S390_TE           1024
+#define HWCAP_S390_VXRS         2048
=20
 /* M68K specific definitions. */
 /* We use the top 24 bits to encode information about the
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a57b7049dd62..5451d262ec8e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1308,6 +1308,34 @@ static inline void init_thread(struct target_pt_re=
gs *regs,
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
=20
+#include "elf.h"
+
+#define ELF_HWCAP get_elf_hwcap()
+
+#define GET_FEATURE(_feat, _hwcap) \
+    do { if (s390_has_feat(_feat)) { hwcap |=3D _hwcap; } } while (0)
+
+static uint32_t get_elf_hwcap(void)
+{
+    /*
+     * Let's assume we always have esan3 and zarch.
+     * 31-bit processes can use 64-bit registers (high gprs).
+     */
+    uint32_t hwcap =3D HWCAP_S390_ESAN3 | HWCAP_S390_ZARCH | HWCAP_S390_=
HIGH_GPRS;
+
+    GET_FEATURE(S390_FEAT_STFLE, HWCAP_S390_STFLE);
+    GET_FEATURE(S390_FEAT_MSA, HWCAP_S390_MSA);
+    GET_FEATURE(S390_FEAT_LONG_DISPLACEMENT, HWCAP_S390_LDISP);
+    GET_FEATURE(S390_FEAT_EXTENDED_IMMEDIATE, HWCAP_S390_EIMM);
+    if (s390_has_feat(S390_FEAT_EXTENDED_TRANSLATION_3) &&
+        s390_has_feat(S390_FEAT_ETF3_ENH)) {
+        hwcap |=3D HWCAP_S390_ETF3EH;
+    }
+    GET_FEATURE(S390_FEAT_VECTOR, HWCAP_S390_VXRS);
+
+    return hwcap;
+}
+
 static inline void init_thread(struct target_pt_regs *regs, struct image=
_info *infop)
 {
     regs->psw.addr =3D infop->entry;
--=20
2.20.1


