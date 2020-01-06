Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6260CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B153208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSgpl5Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B153208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXS6-00086u-Qe
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4i-0002zH-SE
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4h-0004lK-Nk
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:00 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4h-0004l9-K3; Mon, 06 Jan 2020 13:25:59 -0500
Received: by mail-qt1-x844.google.com with SMTP id k40so43186044qtk.8;
 Mon, 06 Jan 2020 10:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dFCW/pT3CYgJTCfIMv+vOfdNZ6PcIxCGOVhdGgC1DCo=;
 b=oSgpl5Ca3cVgcfTotPuV6oPNOhUXbeDmGSk8zwp8nSnzWxSkS+fSYd3s7qHkr7kLuP
 LKNlPwfxGyQ0YIlWex+7ezogXdP22mFl9A7QOrMyVGTU/aBh/U4Vw4XW4GkBSFnmuG7o
 F6UKcQiHj6/uoaso0x2kYzErEBlag08WX+SEB9Kyw8B0aVWFerJwB2f9TyDy54/3OjDa
 bWu9CO4jiE/NBFiUwn6gYil8UwOEvdGFdqocXL3gzzzuQ7Q/o7Ri8/NcTrqnNddffeId
 vGROkOnHE7xn3EocOyRMiAh1yC2Ckv9gYF6uUlJtRzH9LXdAmlvn4c45ddq87HWdyIg5
 GYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dFCW/pT3CYgJTCfIMv+vOfdNZ6PcIxCGOVhdGgC1DCo=;
 b=Mgk41Fq3lrncJIjEBQK2T+WrGhRkx01E+l4Uo1Rx85xvGsHjThnPPOAxtNjlDf927n
 1/E+W8SqInTqQfW0094OoirttabpH+pi9F2UieEJvtyH0m4O1aA6sw3+eI97xoYWhVHQ
 iR4ZNaJOZKLvoL+JTOahmOSzfJZsjyyAexmBd5kKlmwXE49J/6lopGUxxV/0DfqzM7CA
 K6SyTE0NX4a1qDu81KZKzfPdZHOdbVSLl1zbQb8bXXrUUET4182BKs8D5TkCx0hAuz2H
 5Qw39e7gbHV5giJikNdWsAVK/m63sB6lttATW3WrAbJws5qFAfHhT5beBbp18SVwMrmG
 djcw==
X-Gm-Message-State: APjAAAVGtNWjjWV+Sx4d72pj8dhUPlYLhInKJgnRGGy74ayxS9PronUs
 ndSlsrGKOjChu3mvDIcXlz7WdIbm
X-Google-Smtp-Source: APXvYqzhcjveduVulYsE2b+5+6bnrZ4v4OsEJnrftTuEJ50lwBr9HCbWoFJXSIlnlr8iFTsXB+lZnQ==
X-Received: by 2002:ac8:1194:: with SMTP id d20mr75595878qtj.243.1578335159069; 
 Mon, 06 Jan 2020 10:25:59 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:58 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 37/59] s390x/event-facility.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:24:03 -0300
Message-Id: <20200106182425.20312-38-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' label from write_event_mask(), handle_sccb_read_events()
and write_event_data() can be replaced by 'return'.

CC: Cornelia Huck <cohuck@redhat.com>
CC: Halil Pasic <pasic@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/s390x/event-facility.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 6afe278cad..f3b9661f32 100644
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
@@ -262,7 +259,7 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
 
     if (be16_to_cpu(sccb->h.length) != SCCB_SIZE) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
-        goto out;
+        return;
     }
 
     sclp_cp_receive_mask = ef->receive_mask;
@@ -280,18 +277,15 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
             (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
             sccb->h.response_code =
                     cpu_to_be16(SCLP_RC_INVALID_SELECTION_MASK);
-            goto out;
+            return;
         }
         break;
     default:
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_FUNCTION);
-        goto out;
+        return;
     }
     sccb->h.response_code = cpu_to_be16(
             handle_sccb_read_events(ef, sccb, sclp_active_selection_mask));
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


