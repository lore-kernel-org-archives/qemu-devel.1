Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764B5C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F5B20759
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F5B20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTAfS-0005I2-8t
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kTAe8-0004Jt-9r
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:18:48 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:27988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kTAe6-0001Cz-Nz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:18:48 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-IfEXydzVMKe9jT1HNtmcYQ-1; Thu, 15 Oct 2020 17:18:42 -0400
X-MC-Unique: IfEXydzVMKe9jT1HNtmcYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0172F1019625;
 Thu, 15 Oct 2020 21:18:41 +0000 (UTC)
Received: from bahia.lan (ovpn-112-78.ams2.redhat.com [10.36.112.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43914610F3;
 Thu, 15 Oct 2020 21:18:40 +0000 (UTC)
Subject: [PATCH v2 3/5] spapr: Drop spapr_delete_vcpu() unused argument
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 15 Oct 2020 23:18:39 +0200
Message-ID: <160279671929.1808373.10333672533575251075.stgit@bahia.lan>
In-Reply-To: <160279669833.1808373.9524145092720289601.stgit@bahia.lan>
References: <160279669833.1808373.9524145092720289601.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 17:18:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'sc' argument is unused. Drop it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index e4aeb93c0299..45eb2121876e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -212,7 +212,7 @@ static void spapr_cpu_core_reset_handler(void *opaque)
     spapr_cpu_core_reset(opaque);
 }
=20
-static void spapr_delete_vcpu(PowerPCCPU *cpu, SpaprCpuCore *sc)
+static void spapr_delete_vcpu(PowerPCCPU *cpu)
 {
     SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
@@ -233,7 +233,7 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
         spapr_unrealize_vcpu(sc->threads[i], sc);
     }
     for (i =3D 0; i < cc->nr_threads; i++) {
-        spapr_delete_vcpu(sc->threads[i], sc);
+        spapr_delete_vcpu(sc->threads[i]);
     }
     g_free(sc->threads);
 }
@@ -345,7 +345,7 @@ err_unrealize:
     }
 err:
     while (--i >=3D 0) {
-        spapr_delete_vcpu(sc->threads[i], sc);
+        spapr_delete_vcpu(sc->threads[i]);
     }
     g_free(sc->threads);
 }



