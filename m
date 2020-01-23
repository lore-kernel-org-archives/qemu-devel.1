Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1D4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A0E21569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gICXUHJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A0E21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufe5-0004Ha-7H
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucth-0000Dz-84
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuctg-0008TS-5t
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuctg-0008St-2o
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XoKLnz1wCpI7N5fQNy5KgJy0oRjyvGPIZtTdXsj3npE=;
 b=gICXUHJsbhj6IgrZdjj7tXCTsK1ZyFHL1Ti134cSoGj3yYQ5KkI7CI58SPqpavN2ZGfkaA
 C0in3ByerGMEgUhkjRqdzJgOLJlA/Kglbpgk1Z1kzWEyRSpv2bYSZUijuJkC7ey+DI8hvA
 x+p4ynYCTcliZPcl3FkTv6xo4AFOHSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-rehjp-x8Pv6LhA_RkJEpWA-1; Thu, 23 Jan 2020 08:51:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B801800D48
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:44 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B94F85789;
 Thu, 23 Jan 2020 13:51:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/59] hw/ppc/spapr_rtas: Remove local variable
Date: Thu, 23 Jan 2020 14:50:15 +0100
Message-Id: <1579787449-27599-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: rehjp-x8Pv6LhA_RkJEpWA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

We only access this variable in the RTAS_SYSPARM_SPLPAR_CHARACTERISTICS
case. Use it in place and remove the local declaration.

Suggested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200121110349.25842-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/spapr_rtas.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 6f06e9d..85135e0 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -268,7 +268,6 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *c=
pu,
 {
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
     MachineState *ms =3D MACHINE(spapr);
-    unsigned int max_cpus =3D ms->smp.max_cpus;
     target_ulong parameter =3D rtas_ld(args, 0);
     target_ulong buffer =3D rtas_ld(args, 1);
     target_ulong length =3D rtas_ld(args, 2);
@@ -280,10 +279,10 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU =
*cpu,
                                           "DesMem=3D%" PRIu64 ","
                                           "DesProcs=3D%d,"
                                           "MaxPlatProcs=3D%d",
-                                          max_cpus,
+                                          ms->smp.max_cpus,
                                           ms->ram_size / MiB,
                                           ms->smp.cpus,
-                                          max_cpus);
+                                          ms->smp.max_cpus);
         if (pcc->n_host_threads > 0) {
             char *hostthr_val, *old =3D param_val;
=20
--=20
1.8.3.1



