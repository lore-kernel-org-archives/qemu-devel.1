Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8252C32767
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED552084D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gKvGS9D4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED552084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inGgK-0001se-JS
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 01:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1inGcH-00056t-Dw
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1inGcF-0000Jy-PO
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:39:25 -0500
Received: from ozlabs.org ([203.11.71.1]:34595)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1inGcD-00007V-9A; Fri, 03 Jan 2020 01:39:22 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pwH84R09z9sRd; Fri,  3 Jan 2020 17:39:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578033556;
 bh=TfQTmXYbC8QhW9e6z4YK15NqUFRWl/4wKLoSPI7wBfQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gKvGS9D4uwFyYl8LhsOg4LtTs6g/gVQBewYe78Kzxrwwx43FhUOAOtHEo3WO6BFuk
 ws2ruTCYe7r2IXIH0Zj5NClZojKa1z0IL9R3/lIk22ShuaI2IgUbDA4/m7Lj4oUL/Z
 dW/e+76/Yoe2vMbW0rq56pVHcBlsN2mkgQ+bNY4E=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	philmd@redhat.com,
	clg@kaod.org,
	groug@kaod.org
Subject: [RFC 1/4] ppc: Drop PPC_EMULATE_32BITS_HYPV stub
Date: Fri,  3 Jan 2020 17:39:08 +1100
Message-Id: <20200103063911.180977-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200103063911.180977-1-david@gibson.dropbear.id.au>
References: <20200103063911.180977-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, paulus@samba.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only effect of the PPC_EMULATE_32BITS_HYPV define is to change how
MSR_HVB is defined.  This appears to be something to handle hypervisor mo=
de
for 32-bit CPUs, but there's really no other code to handle this.  The
MSR_THV bit, which it uses is implemented for no cpus we model.

It's unlikely anyone is going to implement this any time soon, so just dr=
op
it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 103bfe9dc2..2de9e2fa2b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -26,8 +26,6 @@
 #include "exec/cpu-defs.h"
 #include "cpu-qom.h"
=20
-/* #define PPC_EMULATE_32BITS_HYPV */
-
 #define TCG_GUEST_DEFAULT_MO 0
=20
 #define TARGET_PAGE_BITS_64K 16
@@ -450,14 +448,9 @@ typedef struct ppc_v3_pate_t {
 #define MSR_HVB (1ULL << MSR_SHV)
 #define msr_hv  msr_shv
 #else
-#if defined(PPC_EMULATE_32BITS_HYPV)
-#define MSR_HVB (1ULL << MSR_THV)
-#define msr_hv  msr_thv
-#else
 #define MSR_HVB (0ULL)
 #define msr_hv  (0)
 #endif
-#endif
=20
 /* DSISR */
 #define DSISR_NOPTE              0x40000000
--=20
2.24.1


