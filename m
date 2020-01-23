Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8952BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8CB24655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeT+DSfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8CB24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubnu-0004Dh-MJ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuati-0008M0-7k
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuatg-0005Aa-Be
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuatg-0005AI-6U
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyuYiAbao9MpsJV0ffmt+3w7RbAKi4QNjBtbeh2nu1Y=;
 b=BeT+DSfPSs7J+ljsNFvjprKRBIi0tCpuQlY8mBVU5FGVcIy838xCZIHPBAk87rYBZRnah9
 8F2YX2Um6K5PabMYDPqcSLjvUbqNy/c0gw2Yc4lLBbpZpyspeYrjwHduIUp8cqT9wfscMU
 1Cb1IkahrP6sbx3nLCTIXctASE8gkiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-U2Atju1rOYal11espi6rXw-1; Thu, 23 Jan 2020 06:43:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C2B910120AA;
 Thu, 23 Jan 2020 11:43:37 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FFF7100164D;
 Thu, 23 Jan 2020 11:43:35 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 68/80] ppc/virtex_ml507: remove unused arguments
Date: Thu, 23 Jan 2020 12:38:33 +0100
Message-Id: <1579779525-20065-69-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: U2Atju1rOYal11espi6rXw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: edgar.iglesias@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
CC: david@gibson.dropbear.id.au
CC: qemu-ppc@nongnu.org
CC: edgar.iglesias@gmail.com
---
 hw/ppc/virtex_ml507.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 6862552..651d8db 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -89,10 +89,7 @@ static void mmubooke_create_initial_mapping(CPUPPCState =
*env,
     tlb->PID =3D 0;
 }
=20
-static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_size,
-                                      int do_init,
-                                      const char *cpu_type,
-                                      uint32_t sysclk)
+static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t syscl=
k)
 {
     PowerPCCPU *cpu;
     CPUPPCState *env;
@@ -213,7 +210,7 @@ static void virtex_init(MachineState *machine)
     int i;
=20
     /* init CPUs */
-    cpu =3D ppc440_init_xilinx(&ram_size, 1, machine->cpu_type, 400000000)=
;
+    cpu =3D ppc440_init_xilinx(machine->cpu_type, 400000000);
     env =3D &cpu->env;
=20
     if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
--=20
2.7.4


