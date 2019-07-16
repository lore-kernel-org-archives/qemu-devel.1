Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81378C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4E42145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FznEp5iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4E42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIZh-00045P-RD
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYZ-0007vw-0p
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYY-0003BI-1M
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYX-0003AW-QV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id n9so19911502wru.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=6MMWJOB60+c75PU76TA7zzCHcU/JiW0qA1hZwYycJq8=;
 b=FznEp5iytJIqBQagO4RHcCJddED8oQyL4M5BKqbd0IdXC+UrbxWjaWpRJjwyCdQXX0
 NQQxMTFOVui3vjBdT5zHKjEryO/I5G0GLj6Z16mWjYKYIxrFyQUWuahSwH20rGZwqCpF
 xaFnD6YCGMwd0FfdwzqMrnbv0l2vNGsoCrVxoNVYV5jFL9TLOrqX7WWjjKdWlIfJ4qQg
 mkLeC4arzRbWbZMcw+z8KcMrhjipkR4v5E9Y93ExhP3IyTICbQomBW5BAiq8Tc65l072
 t0z+rSNM0azodDNDwnonL0XsvozdTGL7oe7dOcLzt2xvsa+9AthaZl8uCmacbLZzsNST
 rz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=6MMWJOB60+c75PU76TA7zzCHcU/JiW0qA1hZwYycJq8=;
 b=ET5zvGtITFyRVF2zdSjmtHcXME353vGFP7CMgaZ4e32Ok7paXoEf0yT2pn0zGbdilP
 99gG3XooDbBVBqVlc5laZamZSXyO5WwfrIapjAj6joWxl+rtGBKJQb+WSlEr9pxaP55S
 KONd7jVFSO2/w5c9m79DtVhh455UU1sMbnFOdrOdPqUbm6IU4HV1gk5uxdfNP5PHy9aK
 xa+wvg5Fuq+5W6MamVEHC5ly5Nvba4Hfmuv91Bp4ZhsdRnzBD2bRJgEADkwVg2YKNuF+
 K387W41LF21BhD3C22JP68fBj7W6Q0uG1HybuB9l2y03zikWPMoZFv/C8dLLl2BdjMq5
 wn2g==
X-Gm-Message-State: APjAAAXNQCzTuWOuOMiDaXOwshvqA36uKmW7i3OUU9fUGWRx/Qyipd4Z
 kK0TQB/YY59HAuHMc+DTDnEW+f3cNEM=
X-Google-Smtp-Source: APXvYqxEGXlnDoXf+3RGVJ2KWxmNd+ZfU4CsF8SkTsGMAfBOJZeno9EL5nQiNTMhLh1FV7QUu0Tftg==
X-Received: by 2002:adf:fb52:: with SMTP id c18mr33761352wrs.216.1563264684383; 
 Tue, 16 Jul 2019 01:11:24 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:02 +0200
Message-Id: <1563264677-39718-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 04/19] iscsi: fix busy/timeout/task set full
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In this case, do_retry was set without calling aio_co_wake, thus never
waking up the coroutine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 267f160..6e238bf 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -272,7 +272,7 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                 timer_mod(&iTask->retry_timer,
                           qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + retry_time);
                 iTask->do_retry = 1;
-                return;
+                goto out;
             }
         }
         iTask->err_code = iscsi_translate_sense(&task->sense);
-- 
1.8.3.1



