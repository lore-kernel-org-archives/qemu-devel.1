Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B3AC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C227A20663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUEsCIvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C227A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENRZ-00040C-SB
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLv-0004dp-Dg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLu-0003Ua-35
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46117)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLt-0003S6-VL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voVjw1fARwKeDsQu+V/Sro8uXISbVenrGia2M0p4Cr0=;
 b=hUEsCIvTUwJSUc5t99IneFrQncUJx46HJOByu3fwg4WFEoqE6asvYtGTfEGhfbDhE8uJaz
 n0qkfdjGBpwY8AZcSZ//RoFNS7Ti1yq4wXopp/+5gz/U7lyijPJOmHzozDT+optlU7cHTK
 N4bRDKjqhC2rpmWP1MQD33b+RV6PvAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-oarIuCOcMAu4_uJfJ3p8gQ-1; Tue, 17 Mar 2020 21:18:29 -0400
X-MC-Unique: oarIuCOcMAu4_uJfJ3p8gQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5429518A5505;
 Wed, 18 Mar 2020 01:18:28 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD66760BF3;
 Wed, 18 Mar 2020 01:18:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/13] hw/i386: Rename apicid_from_topo_ids to
 x86_apicid_from_topo_ids
Date: Tue, 17 Mar 2020 21:17:48 -0400
Message-Id: <20200318011748.2104336-14-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Babu Moger <babu.moger@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

For consistency rename apicid_from_topo_ids to x86_apicid_from_topo_ids.
No functional change.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <158396720748.58170.5335409429390890145.stgit@naples-babu.amd.c=
om>
---
 hw/i386/pc.c               | 2 +-
 include/hw/i386/topology.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ee89fcd1c3..98ee763f68 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1580,7 +1580,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_d=
ev,
         topo_ids.die_id =3D cpu->die_id;
         topo_ids.core_id =3D cpu->core_id;
         topo_ids.smt_id =3D cpu->thread_id;
-        cpu->apic_id =3D apicid_from_topo_ids(&topo_info, &topo_ids);
+        cpu->apic_id =3D x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
=20
     cpu_slot =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 04f01e2a09..b9593b9905 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -112,8 +112,8 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo=
 *topo_info)
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
-static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
-                                             const X86CPUTopoIDs *topo_ids=
)
+static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info=
,
+                                                 const X86CPUTopoIDs *topo=
_ids)
 {
     return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
            (topo_ids->die_id  << apicid_die_offset(topo_info)) |
@@ -165,7 +165,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUT=
opoInfo *topo_info,
 {
     X86CPUTopoIDs topo_ids;
     x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
-    return apicid_from_topo_ids(topo_info, &topo_ids);
+    return x86_apicid_from_topo_ids(topo_info, &topo_ids);
 }
=20
 #endif /* HW_I386_TOPOLOGY_H */
--=20
2.24.1


