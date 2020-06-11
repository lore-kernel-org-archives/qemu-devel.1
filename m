Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5744AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3062020760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3062020760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjNSd-0006Hb-8a
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjNRP-0004Vz-Qv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:40:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39375
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjNRO-0005sV-UV
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:40:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-FnKNYJrHPC6zL4zbAWh8AQ-1; Thu, 11 Jun 2020 09:40:14 -0400
X-MC-Unique: FnKNYJrHPC6zL4zbAWh8AQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B689805730;
 Thu, 11 Jun 2020 13:40:13 +0000 (UTC)
Received: from bahia.lan (ovpn-114-202.ams2.redhat.com [10.36.114.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEAAA19931;
 Thu, 11 Jun 2020 13:40:11 +0000 (UTC)
Subject: [PATCH v3 1/4] spapr: Simplify some warning printing paths in
 spapr_caps.c
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 Jun 2020 15:40:11 +0200
Message-ID: <159188281098.70166.18387926536399257573.stgit@bahia.lan>
In-Reply-To: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We obviously only want to print a warning in these cases, but this is done
in a rather convoluted manner. Just use warn_report() instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_caps.c |   28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index efdc0dbbcfc0..0c2bc8e06e44 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -248,23 +248,18 @@ SpaprCapPossible cap_cfpc_possible =3D {
 static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
                                  Error **errp)
 {
-    Error *local_err =3D NULL;
     uint8_t kvm_val =3D  kvmppc_get_cap_safe_cache();
=20
     if (tcg_enabled() && val) {
         /* TCG only supports broken, allow other values and print a warnin=
g */
-        error_setg(&local_err,
-                   "TCG doesn't support requested feature, cap-cfpc=3D%s",
-                   cap_cfpc_possible.vals[val]);
+        warn_report("TCG doesn't support requested feature, cap-cfpc=3D%s"=
,
+                    cap_cfpc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
                    "Requested safe cache capability level not supported by=
 kvm,"
                    " try appending -machine cap-cfpc=3D%s",
                    cap_cfpc_possible.vals[kvm_val]);
     }
-
-    if (local_err !=3D NULL)
-        warn_report_err(local_err);
 }
=20
 SpaprCapPossible cap_sbbc_possible =3D {
@@ -277,23 +272,18 @@ SpaprCapPossible cap_sbbc_possible =3D {
 static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_t =
val,
                                         Error **errp)
 {
-    Error *local_err =3D NULL;
     uint8_t kvm_val =3D  kvmppc_get_cap_safe_bounds_check();
=20
     if (tcg_enabled() && val) {
         /* TCG only supports broken, allow other values and print a warnin=
g */
-        error_setg(&local_err,
-                   "TCG doesn't support requested feature, cap-sbbc=3D%s",
-                   cap_sbbc_possible.vals[val]);
+        warn_report("TCG doesn't support requested feature, cap-sbbc=3D%s"=
,
+                    cap_sbbc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe bounds check capability level not supported by kvm,"
                    " try appending -machine cap-sbbc=3D%s",
                    cap_sbbc_possible.vals[kvm_val]);
     }
-
-    if (local_err !=3D NULL)
-        warn_report_err(local_err);
 }
=20
 SpaprCapPossible cap_ibs_possible =3D {
@@ -309,24 +299,18 @@ SpaprCapPossible cap_ibs_possible =3D {
 static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
                                            uint8_t val, Error **errp)
 {
-    Error *local_err =3D NULL;
     uint8_t kvm_val =3D kvmppc_get_cap_safe_indirect_branch();
=20
     if (tcg_enabled() && val) {
         /* TCG only supports broken, allow other values and print a warnin=
g */
-        error_setg(&local_err,
-                   "TCG doesn't support requested feature, cap-ibs=3D%s",
-                   cap_ibs_possible.vals[val]);
+        warn_report("TCG doesn't support requested feature, cap-ibs=3D%s",
+                    cap_ibs_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe indirect branch capability level not supported by kvm,"
                    " try appending -machine cap-ibs=3D%s",
                    cap_ibs_possible.vals[kvm_val]);
     }
-
-    if (local_err !=3D NULL) {
-        warn_report_err(local_err);
-    }
 }
=20
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"



