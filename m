Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CF5C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D623A206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tz60S+C6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D623A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCj7-0002tn-VV
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ipCiV-0002MC-Qx
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ipCiU-00049l-AE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:53:51 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ipCiU-00048f-3u
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:53:50 -0500
Received: by mail-pf1-x442.google.com with SMTP id w62so1746278pfw.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 06:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AjdNpjSTzIXvK5TJRDwa33zTflDFXaUtZ+UpigZK9FI=;
 b=tz60S+C6AwDtZhBQUSvMvsfBEJ9mK7UbtUcvvkDZbKXx0SCCKtDZSpve3vq145ZcsD
 ksjlqAS+cjjkGbSiP0ZUJ1DfQGg5BuBQeUYiiRrOnxbnFyAtIx+J33bmnDG1We1hF/Jz
 q2N1cmID7hlK+/3HCeWTusdu25J8InZ4bnina9AIsXgkO1TATLgd8IrkKrQTQuWutY6X
 yPEslY34HhxlXUFpEsMqaI/gVc1oELcwhUlmFgKf4qBWElK/VADaHlJuFF+yS/ZAdUfL
 eEV7+QCU91imLAbpF+QydLGJx/RWDjtbtj37SP44V4pmlQOfPJpr1hsjKvSRwDkmR8dG
 g4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AjdNpjSTzIXvK5TJRDwa33zTflDFXaUtZ+UpigZK9FI=;
 b=qiTom/HNQurvSGlGbAmJNxBTxVCczaWmNDAaVF/zfXqMgACrRlgI3xcKqmpf2kO4Rw
 XnzdYZEJVZLC9QEoq46NUd25h64u90LeBwf+f3sK7Bdb9LvwYSzCEwniVVju5torYmhn
 JD+uDbNW2ig5YqyhgMJsbv7TWGAJxKU7DfhfcbLGfol+GvDZwW0bcxOhuyL+EB7OC0vR
 6+qs2u27WtnAO9CTE2ahul3KfWAR7+Ilq4Thh5FkjDlyjpCNK8UKcxsggo30Lkf09/Dh
 A3MxYSHHWZ7ux30F+1G2FwnHYOaJ9ZuXqRDFDuh6oK5sFpIcCJ0dGD/M5k9Gi73uBy07
 jyTA==
X-Gm-Message-State: APjAAAWZAeiQLs3WScYjClcieFcwU7kFchB4avmET5nXCt+ufTjwyeEh
 P3/4iDXCOkActodyMMKkQsvuEDnn
X-Google-Smtp-Source: APXvYqwDLtvGYTrssEpPvYmiMrqHnnp5YUagpuGmGhlIpOJBfoKLfs1rPxWWzosF/T7dl6CAiMiocw==
X-Received: by 2002:ad4:4f84:: with SMTP id em4mr4417119qvb.119.1578494782057; 
 Wed, 08 Jan 2020 06:46:22 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id d5sm1495372qke.130.2020.01.08.06.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 06:46:21 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] s390x/event-facility.c: remove unneeded labels
Date: Wed,  8 Jan 2020 11:46:07 -0300
Message-Id: <20200108144607.878862-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' label from write_event_mask() and and write_event_data()
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
---

This is the v2 of patch 37 sent in the series:

https://patchwork.kernel.org/cover/11319771/

after this review from Cornelia:

https://patchwork.kernel.org/patch/11319847/#23088037

 hw/s390x/event-facility.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 6afe278cad..8a93b8a1da 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -182,11 +182,11 @@ static void write_event_data(SCLPEventFacility *ef, SCCB *sccb)
 {
     if (sccb->h.function_code != SCLP_FC_NORMAL_WRITE) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_FUNCTION);
-        goto out;
+        return;
     }
     if (be16_to_cpu(sccb->h.length) < 8) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
-        goto out;
+        return;
     }
     /* first do a sanity check of the write events */
     sccb->h.response_code = cpu_to_be16(write_event_length_check(sccb));
@@ -196,9 +196,6 @@ static void write_event_data(SCLPEventFacility *ef, SCCB *sccb)
         sccb->h.response_code =
                 cpu_to_be16(handle_sccb_write_events(ef, sccb));
     }
-
-out:
-    return;
 }
 
 static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
@@ -262,17 +259,18 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
 
     if (be16_to_cpu(sccb->h.length) != SCCB_SIZE) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
-        goto out;
+        return;
     }
 
-    sclp_cp_receive_mask = ef->receive_mask;
-
-    /* get active selection mask */
     switch (sccb->h.function_code) {
     case SCLP_UNCONDITIONAL_READ:
-        sclp_active_selection_mask = sclp_cp_receive_mask;
+        sccb->h.response_code = cpu_to_be16(
+            handle_sccb_read_events(ef, sccb, ef->receive_mask));
         break;
     case SCLP_SELECTIVE_READ:
+        /* get active selection mask */
+        sclp_cp_receive_mask = ef->receive_mask;
+
         copy_mask((uint8_t *)&sclp_active_selection_mask, (uint8_t *)&red->mask,
                   sizeof(sclp_active_selection_mask), ef->mask_length);
         sclp_active_selection_mask = be64_to_cpu(sclp_active_selection_mask);
@@ -280,18 +278,14 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
             (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
             sccb->h.response_code =
                     cpu_to_be16(SCLP_RC_INVALID_SELECTION_MASK);
-            goto out;
+        } else {
+            sccb->h.response_code = cpu_to_be16(
+                handle_sccb_read_events(ef, sccb, sclp_active_selection_mask));
         }
         break;
     default:
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_FUNCTION);
-        goto out;
     }
-    sccb->h.response_code = cpu_to_be16(
-            handle_sccb_read_events(ef, sccb, sclp_active_selection_mask));
-
-out:
-    return;
 }
 
 static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
@@ -303,7 +297,7 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
     if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX) ||
         ((mask_length != 4) && !ef->allow_all_mask_sizes)) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_MASK_LENGTH);
-        goto out;
+        return;
     }
 
     /*
@@ -328,9 +322,6 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
 
     sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
     ef->mask_length = mask_length;
-
-out:
-    return;
 }
 
 /* qemu object creation and initialization functions */
-- 
2.24.1


