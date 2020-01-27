Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E278C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0862067C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpjS47SZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0862067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3Qa-0004nZ-HZ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3Nc-0008Bs-Pr
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3Nb-0006at-DB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50989
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3Nb-0006aQ-AG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cncAuSOMFbgiPUwOSEdisJBUTZXFaD6Po/LyaOSBQ18=;
 b=JpjS47SZXsTgQcopq1RTpP1s5Ox/DEZb39/QAhwi+oZBfB/Zsmmzs051KlYvQDYqr4aTQM
 n6CIGlnME+YwTF/MCUgAhFhAoLQfv1IO/icRlMZAzjVz3HBLE5fwl9y+kTpvo0emmaXVD7
 NUAVRZEkjbJ7EHaKSBx6Ws0mILHeVNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-RsQ4mHZrODSU8ioZD_IoTQ-1; Mon, 27 Jan 2020 07:20:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 890B5800D48;
 Mon, 27 Jan 2020 12:20:29 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26221451F;
 Mon, 27 Jan 2020 12:20:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/15] s390x/event-facility.c: remove unneeded labels
Date: Mon, 27 Jan 2020 13:20:04 +0100
Message-Id: <20200127122016.18752-4-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: RsQ4mHZrODSU8ioZD_IoTQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

'out' label from write_event_mask() and write_event_data()
can be replaced by 'return'.

The 'out' label from read_event_data() can also be replaced.
However, as suggested by Cornelia Huck, instead of simply
replacing the 'out' label, let's also change the code flow
a bit to make it clearer that sccb events are always handled
regardless of the mask for unconditional reads, while selective
reads are handled if the mask is valid.

CC: Cornelia Huck <cohuck@redhat.com>
CC: Thomas Huth <thuth@redhat.com>
CC: Halil Pasic <pasic@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200108144607.878862-1-danielhb413@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/event-facility.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 6afe278cad15..8a93b8a1da97 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -182,11 +182,11 @@ static void write_event_data(SCLPEventFacility *ef, S=
CCB *sccb)
 {
     if (sccb->h.function_code !=3D SCLP_FC_NORMAL_WRITE) {
         sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_FUNCTION);
-        goto out;
+        return;
     }
     if (be16_to_cpu(sccb->h.length) < 8) {
         sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LE=
NGTH);
-        goto out;
+        return;
     }
     /* first do a sanity check of the write events */
     sccb->h.response_code =3D cpu_to_be16(write_event_length_check(sccb));
@@ -196,9 +196,6 @@ static void write_event_data(SCLPEventFacility *ef, SCC=
B *sccb)
         sccb->h.response_code =3D
                 cpu_to_be16(handle_sccb_write_events(ef, sccb));
     }
-
-out:
-    return;
 }
=20
 static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
@@ -262,17 +259,18 @@ static void read_event_data(SCLPEventFacility *ef, SC=
CB *sccb)
=20
     if (be16_to_cpu(sccb->h.length) !=3D SCCB_SIZE) {
         sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LE=
NGTH);
-        goto out;
+        return;
     }
=20
-    sclp_cp_receive_mask =3D ef->receive_mask;
-
-    /* get active selection mask */
     switch (sccb->h.function_code) {
     case SCLP_UNCONDITIONAL_READ:
-        sclp_active_selection_mask =3D sclp_cp_receive_mask;
+        sccb->h.response_code =3D cpu_to_be16(
+            handle_sccb_read_events(ef, sccb, ef->receive_mask));
         break;
     case SCLP_SELECTIVE_READ:
+        /* get active selection mask */
+        sclp_cp_receive_mask =3D ef->receive_mask;
+
         copy_mask((uint8_t *)&sclp_active_selection_mask, (uint8_t *)&red-=
>mask,
                   sizeof(sclp_active_selection_mask), ef->mask_length);
         sclp_active_selection_mask =3D be64_to_cpu(sclp_active_selection_m=
ask);
@@ -280,18 +278,14 @@ static void read_event_data(SCLPEventFacility *ef, SC=
CB *sccb)
             (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
             sccb->h.response_code =3D
                     cpu_to_be16(SCLP_RC_INVALID_SELECTION_MASK);
-            goto out;
+        } else {
+            sccb->h.response_code =3D cpu_to_be16(
+                handle_sccb_read_events(ef, sccb, sclp_active_selection_ma=
sk));
         }
         break;
     default:
         sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_FUNCTION);
-        goto out;
     }
-    sccb->h.response_code =3D cpu_to_be16(
-            handle_sccb_read_events(ef, sccb, sclp_active_selection_mask))=
;
-
-out:
-    return;
 }
=20
 static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
@@ -303,7 +297,7 @@ static void write_event_mask(SCLPEventFacility *ef, SCC=
B *sccb)
     if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX) ||
         ((mask_length !=3D 4) && !ef->allow_all_mask_sizes)) {
         sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_MASK_LENGTH)=
;
-        goto out;
+        return;
     }
=20
     /*
@@ -328,9 +322,6 @@ static void write_event_mask(SCLPEventFacility *ef, SCC=
B *sccb)
=20
     sccb->h.response_code =3D cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
     ef->mask_length =3D mask_length;
-
-out:
-    return;
 }
=20
 /* qemu object creation and initialization functions */
--=20
2.21.1


