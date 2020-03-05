Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F0AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76D420870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+tDiZn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76D420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9lwT-0001QC-UX
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9lv7-0007yQ-D4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9lv6-0007q1-BQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:31:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9lv6-0007pl-8L
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583397111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yA3uLqLrMH4DadSPYrDFTonaKu32GW1DkxhKKfxoUes=;
 b=T+tDiZn4dn/Kr2VcWnOV53WFf8pVOxDc/8vyQHUcVyOZoHAMK+JWAdN/1Bc4onwhHNuS7k
 TtJKer0gZ4HBshcI4zffUzNmGfpgHns3jGBSnw8/WPogkwVr/7YgyhkL5av4n2XP8oHWZI
 5nAWfTRVI4Yq2qXhBoAK7H8ZEbYEZYI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-tZR1ehWUMb-1QCPgkLo5ng-1; Thu, 05 Mar 2020 03:31:50 -0500
X-MC-Unique: tZR1ehWUMb-1QCPgkLo5ng-1
Received: by mail-wm1-f71.google.com with SMTP id y18so2604297wmi.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VKQxZm6oD2b2bzfClTv2OE2sVH6+fKk9xz2Zrpce/2w=;
 b=BUHNMaDDEmvEubH28IHVxVrnU2/gZpzpEsVXxpZkwe6NadpgN/H2hd0EfbNnz04VLL
 JuxcPeHz8AUqH1K4Rwkg1PGFkfM8N2sDbhnxMdxp0pT0lWd1rzPRBD7J8X6Mj0rO1oCU
 hS5s1zh3h1B0MHZcDuQlJT2UhXVR/Ft4JsnBg0fxeFZMr4e2mfilO6Q4SlohLb2d5ytW
 uOmToP+C8nzrFMHQNC7mxBDpS3F6nq0VVHIrhlCIfDxxRWQt+sQTX1Vv+5Mfs6kv/JDC
 Ne1XmQllm7etTaLDqAcVELHBFxibi/ElGN2jnmR3Be64As3Mr/+XpfbsyB9iY1tRQMWN
 57MA==
X-Gm-Message-State: ANhLgQ0ORBJQlT5vc64sWfGX8A6QgySwFqnssh03rwVpgCKsxAAuz/3w
 AOedMpz3iYQZu1e2FBbz4NnV3XO0mtMQcXpMSuSTN1BQUglrYU7xLnmrwVDUu1hYeiuHtX0bX9G
 ufDKnZ7n/06lN6ic=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr8947638wrn.356.1583397108646; 
 Thu, 05 Mar 2020 00:31:48 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsUsw5R1leZm5aRmP0ydzwOEndB9/plL1G0/5f4GqJJXebWrX+QpOUC63nFFMSf57K1JhLMgw==
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr8947623wrn.356.1583397108475; 
 Thu, 05 Mar 2020 00:31:48 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f15sm26583920wru.83.2020.03.05.00.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 00:31:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [MERGED PATCH v2 2/5] hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead
 of sizeof flexible array
Date: Thu,  5 Mar 2020 09:31:32 +0100
Message-Id: <20200305083135.8270-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305083135.8270-1-philmd@redhat.com>
References: <20200305083135.8270-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace sizeof() flexible arrays union srp_iu/viosrp_iu by the
SRP_MAX_IU_LEN definition, which is what this code actually meant
to use.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Patch already applied to ppc-for-5.0.

 hw/scsi/spapr_vscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 7d584e7732..7e397ed797 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -671,8 +671,8 @@ static void vscsi_process_login(VSCSIState *s, vscsi_re=
q *req)
      */
     rsp->req_lim_delta =3D cpu_to_be32(VSCSI_REQ_LIMIT-2);
     rsp->tag =3D tag;
-    rsp->max_it_iu_len =3D cpu_to_be32(sizeof(union srp_iu));
-    rsp->max_ti_iu_len =3D cpu_to_be32(sizeof(union srp_iu));
+    rsp->max_it_iu_len =3D cpu_to_be32(SRP_MAX_IU_LEN);
+    rsp->max_ti_iu_len =3D cpu_to_be32(SRP_MAX_IU_LEN);
     /* direct and indirect */
     rsp->buf_fmt =3D cpu_to_be16(SRP_BUF_FORMAT_DIRECT | SRP_BUF_FORMAT_IN=
DIRECT);
=20
@@ -1088,7 +1088,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_cr=
q *crq)
      * in our 256 bytes IUs. If not we'll have to increase the size
      * of the structure.
      */
-    if (crq->s.IU_length > sizeof(union viosrp_iu)) {
+    if (crq->s.IU_length > SRP_MAX_IU_LEN) {
         fprintf(stderr, "VSCSI: SRP IU too long (%d bytes) !\n",
                 crq->s.IU_length);
         vscsi_put_req(req);
--=20
2.21.1


