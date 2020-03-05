Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5680C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9289D20870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fm00lx81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9289D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9lwh-0001s5-NB
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9lvI-0008ED-Ab
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9lvG-0007uo-Oh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:32:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48355
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9lvG-0007uh-Kn
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583397122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmYl/AQK2JY3bpXha9+hiwogRCKB+fBOIoJpW+iscUQ=;
 b=Fm00lx81Fab8uuMrbi5T2N9NNRdWPpJrjuQ1+3FrUG+GV1GRPQksU/Wqe8sjv0dgciqwrF
 gwxyI5um6zC4I+W3Dgb7x8gPPmnqSivh/2Jfzr2sy/+g4NYhuIJDT7EJQ7Tm1AqUrS5gLW
 0mIN8GwGBBHBK3aXG8xrgLRkG9RqDZM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-eVlsilMjO3qoVn4z7MUpzQ-1; Thu, 05 Mar 2020 03:32:00 -0500
X-MC-Unique: eVlsilMjO3qoVn4z7MUpzQ-1
Received: by mail-wm1-f71.google.com with SMTP id c5so1790336wmd.8
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RFIOMEb8wQyUpCH5c4Kh/BXqGMza1oWS+WdSlgnyzm0=;
 b=Q7fh2ngaAbGmWx5eFoqxFX7SabMxnKJ/FTVdkRdVdIncfDLyZkCPxgMpdFcQwrz1c1
 AyoKYmaBjacXVsP7ZSuhB7T6ZR8LYRd3yEKpVHt3j0M6qsHiCPH6cPJHU9dVA18qxBva
 W/IOBn+duEoJkE18Jl85USdlKvQUmtoyjUUwgMlRksQnyT1D9dYNE+6cSWReROhSEUVr
 bmC7+WTilzjLpEuAi+C+7VdJfxReJMeumlyoRH6OIoXIAKqQeDI370jLPSKK4jj/kIl0
 eR43t1JN3jcj96Av+u/LKLHyOlDHAir8+GGgFES9Y5k8H8A2tcNPwba189VHMgK6EbxE
 hOSQ==
X-Gm-Message-State: ANhLgQ1sVUmzKaC4sY5vgcHTX87H3SzVehvH0fIWYvsemz/ndFdtPSg9
 cX5mt3xZjRcHE/pnD5Dc1Ui+sobPirsrrKNo7i73CzepGw8DKJWcAbEEE3XKph9bjNqV0iD1LWE
 JW5B5MDXF8cFHWig=
X-Received: by 2002:a1c:25c5:: with SMTP id l188mr8634807wml.105.1583397119264; 
 Thu, 05 Mar 2020 00:31:59 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtrlEyi32hLhcUOXo8Gw0nEREUDn24KKnEV+Lw1Yy0i78DMK1Gx76LnQhMGWRRGhGOqzEKDNA==
X-Received: by 2002:a1c:25c5:: with SMTP id l188mr8634773wml.105.1583397118954; 
 Thu, 05 Mar 2020 00:31:58 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id s15sm18868827wrr.45.2020.03.05.00.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 00:31:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] hw/scsi/spapr_vscsi: Introduce req_iu() helper
Date: Thu,  5 Mar 2020 09:31:34 +0100
Message-Id: <20200305083135.8270-5-philmd@redhat.com>
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

Introduce the req_iu() helper which returns a pointer to
the viosrp_iu union held in the vscsi_req structure.
This simplifies the next patch.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Simplify req_iu, rename 'ui -> iu' in commit description (dgibson)

 hw/scsi/spapr_vscsi.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 3cb5a38181..70547f98ac 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -97,6 +97,11 @@ typedef struct {
     vscsi_req reqs[VSCSI_REQ_LIMIT];
 } VSCSIState;
=20
+static union viosrp_iu *req_iu(vscsi_req *req)
+{
+    return &req->iu;
+}
+
 static struct vscsi_req *vscsi_get_req(VSCSIState *s)
 {
     vscsi_req *req;
@@ -121,7 +126,7 @@ static struct vscsi_req *vscsi_find_req(VSCSIState *s, =
uint64_t srp_tag)
=20
     for (i =3D 0; i < VSCSI_REQ_LIMIT; i++) {
         req =3D &s->reqs[i];
-        if (req->iu.srp.cmd.tag =3D=3D srp_tag) {
+        if (req_iu(req)->srp.cmd.tag =3D=3D srp_tag) {
             return req;
         }
     }
@@ -188,7 +193,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *req,
     req->crq.s.reserved =3D 0x00;
     req->crq.s.timeout =3D cpu_to_be16(0x0000);
     req->crq.s.IU_length =3D cpu_to_be16(length);
-    req->crq.s.IU_data_ptr =3D req->iu.srp.rsp.tag; /* right byte order */
+    req->crq.s.IU_data_ptr =3D req_iu(req)->srp.rsp.tag; /* right byte ord=
er */
=20
     if (rc =3D=3D 0) {
         req->crq.s.status =3D VIOSRP_OK;
@@ -224,7 +229,7 @@ static void vscsi_makeup_sense(VSCSIState *s, vscsi_req=
 *req,
 static int vscsi_send_rsp(VSCSIState *s, vscsi_req *req,
                           uint8_t status, int32_t res_in, int32_t res_out)
 {
-    union viosrp_iu *iu =3D &req->iu;
+    union viosrp_iu *iu =3D req_iu(req);
     uint64_t tag =3D iu->srp.rsp.tag;
     int total_len =3D sizeof(iu->srp.rsp);
     uint8_t sol_not =3D iu->srp.cmd.sol_not;
@@ -285,7 +290,7 @@ static int vscsi_fetch_desc(VSCSIState *s, struct vscsi=
_req *req,
                             unsigned n, unsigned buf_offset,
                             struct srp_direct_buf *ret)
 {
-    struct srp_cmd *cmd =3D &req->iu.srp.cmd;
+    struct srp_cmd *cmd =3D &req_iu(req)->srp.cmd;
=20
     switch (req->dma_fmt) {
     case SRP_NO_DATA_DESC: {
@@ -473,7 +478,7 @@ static int data_out_desc_size(struct srp_cmd *cmd)
=20
 static int vscsi_preprocess_desc(vscsi_req *req)
 {
-    struct srp_cmd *cmd =3D &req->iu.srp.cmd;
+    struct srp_cmd *cmd =3D &req_iu(req)->srp.cmd;
=20
     req->cdb_offset =3D cmd->add_cdb_len & ~3;
=20
@@ -655,7 +660,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIReques=
t *sreq)
=20
 static void vscsi_process_login(VSCSIState *s, vscsi_req *req)
 {
-    union viosrp_iu *iu =3D &req->iu;
+    union viosrp_iu *iu =3D req_iu(req);
     struct srp_login_rsp *rsp =3D &iu->srp.login_rsp;
     uint64_t tag =3D iu->srp.rsp.tag;
=20
@@ -681,7 +686,7 @@ static void vscsi_process_login(VSCSIState *s, vscsi_re=
q *req)
=20
 static void vscsi_inquiry_no_target(VSCSIState *s, vscsi_req *req)
 {
-    uint8_t *cdb =3D req->iu.srp.cmd.cdb;
+    uint8_t *cdb =3D req_iu(req)->srp.cmd.cdb;
     uint8_t resp_data[36];
     int rc, len, alen;
=20
@@ -770,7 +775,7 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_req =
*req)
=20
 static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
 {
-    union srp_iu *srp =3D &req->iu.srp;
+    union srp_iu *srp =3D &req_iu(req)->srp;
     SCSIDevice *sdev;
     int n, lun;
=20
@@ -821,7 +826,7 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *re=
q)
=20
 static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_req *req)
 {
-    union viosrp_iu *iu =3D &req->iu;
+    union viosrp_iu *iu =3D req_iu(req);
     vscsi_req *tmpreq;
     int i, lun =3D 0, resp =3D SRP_TSK_MGMT_COMPLETE;
     SCSIDevice *d;
@@ -831,7 +836,8 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_=
req *req)
     fprintf(stderr, "vscsi_process_tsk_mgmt %02x\n",
             iu->srp.tsk_mgmt.tsk_mgmt_func);
=20
-    d =3D vscsi_device_find(&s->bus, be64_to_cpu(req->iu.srp.tsk_mgmt.lun)=
, &lun);
+    d =3D vscsi_device_find(&s->bus,
+                          be64_to_cpu(req_iu(req)->srp.tsk_mgmt.lun), &lun=
);
     if (!d) {
         resp =3D SRP_TSK_MGMT_FIELDS_INVALID;
     } else {
@@ -842,7 +848,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_=
req *req)
                 break;
             }
=20
-            tmpreq =3D vscsi_find_req(s, req->iu.srp.tsk_mgmt.task_tag);
+            tmpreq =3D vscsi_find_req(s, req_iu(req)->srp.tsk_mgmt.task_ta=
g);
             if (tmpreq && tmpreq->sreq) {
                 assert(tmpreq->sreq->hba_private);
                 scsi_req_cancel(tmpreq->sreq);
@@ -867,7 +873,8 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_=
req *req)
=20
             for (i =3D 0; i < VSCSI_REQ_LIMIT; i++) {
                 tmpreq =3D &s->reqs[i];
-                if (tmpreq->iu.srp.cmd.lun !=3D req->iu.srp.tsk_mgmt.lun) =
{
+                if (req_iu(tmpreq)->srp.cmd.lun
+                        !=3D req_iu(req)->srp.tsk_mgmt.lun) {
                     continue;
                 }
                 if (!tmpreq->active || !tmpreq->sreq) {
@@ -911,7 +918,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_=
req *req)
=20
 static int vscsi_handle_srp_req(VSCSIState *s, vscsi_req *req)
 {
-    union srp_iu *srp =3D &req->iu.srp;
+    union srp_iu *srp =3D &req_iu(req)->srp;
     int done =3D 1;
     uint8_t opcode =3D srp->rsp.opcode;
=20
@@ -948,7 +955,7 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi=
_req *req)
     struct mad_adapter_info_data info;
     int rc;
=20
-    sinfo =3D &req->iu.mad.adapter_info;
+    sinfo =3D &req_iu(req)->mad.adapter_info;
=20
 #if 0 /* What for ? */
     rc =3D spapr_vio_dma_read(&s->vdev, be64_to_cpu(sinfo->buffer),
@@ -984,7 +991,7 @@ static int vscsi_send_capabilities(VSCSIState *s, vscsi=
_req *req)
     uint64_t buffer;
     int rc;
=20
-    vcap =3D &req->iu.mad.capabilities;
+    vcap =3D &req_iu(req)->mad.capabilities;
     req_len =3D len =3D be16_to_cpu(vcap->common.length);
     buffer =3D be64_to_cpu(vcap->buffer);
     if (len > sizeof(cap)) {
@@ -1029,7 +1036,7 @@ static int vscsi_send_capabilities(VSCSIState *s, vsc=
si_req *req)
=20
 static int vscsi_handle_mad_req(VSCSIState *s, vscsi_req *req)
 {
-    union mad_iu *mad =3D &req->iu.mad;
+    union mad_iu *mad =3D &req_iu(req)->mad;
     bool request_handled =3D false;
     uint64_t retlen =3D 0;
=20
--=20
2.21.1


