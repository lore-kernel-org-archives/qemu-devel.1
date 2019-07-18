Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3531C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D9F21783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noL8vNZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D9F21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3qN-0005YO-NV
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1ho3pm-0003FB-9a
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1ho3pk-0000aJ-5d
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:22 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1ho3pi-0000Wz-25; Thu, 18 Jul 2019 06:40:18 -0400
Received: by mail-pg1-x542.google.com with SMTP id u17so12708893pgi.6;
 Thu, 18 Jul 2019 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jAa9CTlGAyUwS8ryUtwx8J55K0uQzdwgZLDcXfJufxg=;
 b=noL8vNZYn/ERx59hFdgCKcxPJc1qS0Pz6X/tZrXmrHPy/VUuvcyDJdmRRbH5GCy2Ca
 HiMlYelUU+nAORnUiL1DyTf0LJ9hNQidmfconZTUJHwBeneWGvrFmh2F65WT/tJAqlgz
 eReJgn3V1/qY4SomSKhDJlDF8BfL1t2NQ9i99UIYB9jcAub+J7Ts4v88a1Rhqb0CgKAW
 YU0oEF2LovJY82BtCMjirm15BMeHAll/EBqpOIsh0sDqxydvOF8Kx9JmUPdg3jhtJepv
 Rh0ZkOXm6st+h2Bb8aLHqCPfTKfA6g99oUlnSmlmtUo4DiNKxdVPvfMqiN4d0Yb7el0C
 tTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jAa9CTlGAyUwS8ryUtwx8J55K0uQzdwgZLDcXfJufxg=;
 b=Ukj6TqD4xapwzo6pnsOhnK9ZQJNp6M7i/qF5u+5gYvaSSIolvSDW3ckbdYTIZxHvRY
 SedsiGDR2tyvQGgTzvghYDfa2O2Jn9yrJLEqNooNhRUoyRKV8m4OJVv1xmciSW2UeM/M
 Y8zI4lFIwxng6hSIXuiMC/SJsQSg0LGaUjylgVTjAX/roG9chBL1VV4ocYjaiN2UMDZZ
 wuqIvuxmEk8uXMsdQB9cqeg41psJdSo9JMPexW0tc9pW02jOrhahW5CJbH2Up/BrKtaB
 uDkBMAZllgOeXlYsSjzw2SfzEMKf4Gykv6WznTMJjhwYnBC0XDVYZqCw3qkfEsZPycdj
 R2Hw==
X-Gm-Message-State: APjAAAWlprV+QMKmui1d/ug9R3yQvxS9k8fLE4vHwx8oQEzKtfAzyjQ1
 IQnasBh3hyP4YIwSH3peBWSuzxPz
X-Google-Smtp-Source: APXvYqzIR4+E8UWfUBP/biRfH1y72qHD91FvMnORSc1JAQxhS3lDmFKn5LB6e3ww+XvmX0SOQFLHnw==
X-Received: by 2002:a17:90a:d3d4:: with SMTP id
 d20mr51365858pjw.28.1563446417042; 
 Thu, 18 Jul 2019 03:40:17 -0700 (PDT)
Received: from bobo.local0.net (61-68-63-89.tpgi.com.au. [61.68.63.89])
 by smtp.gmail.com with ESMTPSA id y10sm28243415pfm.66.2019.07.18.03.40.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 03:40:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 20:39:49 +1000
Message-Id: <20190718103951.10027-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190718103951.10027-1-npiggin@gmail.com>
References: <20190718103951.10027-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 1/3] qmp: don't emit the RESET event on wakeup
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Luiz Capitulino <lcapitulino@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 1405819637f53 ("qmp: don't emit the RESET event on wakeup from
S3") changed system wakeup to avoid calling qapi_event_send_reset.
Commit 76ed4b18debfe ("s390/ipl: fix ipl with -no-reboot") appears to
have inadvertently broken that logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
I'm not quite sure if this patch is correct and haven't tested it, I
found it by inspection. If this patch is incorrect, I will have to
adjust patch 2.

 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 5089fce6c5..ef3c7ab8b8 100644
--- a/vl.c
+++ b/vl.c
@@ -1550,7 +1550,7 @@ void qemu_system_reset(ShutdownCause reason)
     } else {
         qemu_devices_reset();
     }
-    if (reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
+    if (reason && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
         qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
     }
     cpu_synchronize_all_post_reset();
-- 
2.20.1


