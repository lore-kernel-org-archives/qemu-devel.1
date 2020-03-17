Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82A0C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0B0205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="L3LRKVNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0B0205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE994-0007Tc-KD
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95m-000192-EG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95i-0002vI-Pk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:58 -0400
Received: from ozlabs.org ([203.11.71.1]:42747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95i-0002Uf-Bi; Tue, 17 Mar 2020 06:04:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKx3zywz9sT7; Tue, 17 Mar 2020 21:04:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439477;
 bh=g37u8nOXV/YgUYVIEnNjN8EQgGn6qVrqvgUdqDSWUPc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L3LRKVNdXnXXw5NKg1mX5unT1By6ehCLLjG1IwlMA6vGNWAm9uhgib99avkrQyU0e
 chte5FA0+yFXHzQiSeiAkJzR37pvMg0UsNuc2WiECArnCJeZdoOoA8A+l47TpWvJc3
 V5TnFSWPpWVsjzmRSnHN0CFy+GjOOB3w7jS5l7OE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 23/45] hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of
 sizeof flexible array
Date: Tue, 17 Mar 2020 21:04:01 +1100
Message-Id: <20200317100423.622643-24-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Replace sizeof() flexible arrays union srp_iu/viosrp_iu by the
SRP_MAX_IU_LEN definition, which is what this code actually meant
to use.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200305121253.19078-3-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/scsi/spapr_vscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 7d584e7732..7e397ed797 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -671,8 +671,8 @@ static void vscsi_process_login(VSCSIState *s, vscsi_=
req *req)
      */
     rsp->req_lim_delta =3D cpu_to_be32(VSCSI_REQ_LIMIT-2);
     rsp->tag =3D tag;
-    rsp->max_it_iu_len =3D cpu_to_be32(sizeof(union srp_iu));
-    rsp->max_ti_iu_len =3D cpu_to_be32(sizeof(union srp_iu));
+    rsp->max_it_iu_len =3D cpu_to_be32(SRP_MAX_IU_LEN);
+    rsp->max_ti_iu_len =3D cpu_to_be32(SRP_MAX_IU_LEN);
     /* direct and indirect */
     rsp->buf_fmt =3D cpu_to_be16(SRP_BUF_FORMAT_DIRECT | SRP_BUF_FORMAT_=
INDIRECT);
=20
@@ -1088,7 +1088,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_=
crq *crq)
      * in our 256 bytes IUs. If not we'll have to increase the size
      * of the structure.
      */
-    if (crq->s.IU_length > sizeof(union viosrp_iu)) {
+    if (crq->s.IU_length > SRP_MAX_IU_LEN) {
         fprintf(stderr, "VSCSI: SRP IU too long (%d bytes) !\n",
                 crq->s.IU_length);
         vscsi_put_req(req);
--=20
2.24.1


