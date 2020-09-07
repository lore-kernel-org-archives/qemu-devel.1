Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F29C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B982075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT96a143"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B982075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF6Rp-0004wb-Qm
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF6Np-0006FQ-Ir; Sun, 06 Sep 2020 21:55:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF6No-0007M4-2x; Sun, 06 Sep 2020 21:55:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id e11so11335164wme.0;
 Sun, 06 Sep 2020 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rOdtOAtfcg70s6XvC95J7b24iDolYSlhUR8qCVqx1mg=;
 b=TT96a1438TOU1/6XpjJ8jj2zBffaiIoSy0PrPjy/Ye7Lj+J3ZhA8EyX/9nIO75eO27
 OspzVsLIAY4GzBsdrgV2/qCgv9hHMiCL/LUUC2fK74JnxksNAh3ZCVqgpYQxt4Q7pOdQ
 VaHrUjCCooeQSWR3kRfnDbz9K2fn4pOlyBm9xvxUkQ4D0prr0oPhH6JKO6j948TYJuGo
 0AENerUpdiidW8eJgYhJF37rXkvjtHmffAQ5EcZLRR+UtOlTfXF0wWN6aRSXB2JTWHPY
 1gqSeMlrCUC6nx4HRrXe3SVrdS69w4lWdklPqL0z9rtRUhQ1/zABfaWez8LkqBHlqPNb
 GA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rOdtOAtfcg70s6XvC95J7b24iDolYSlhUR8qCVqx1mg=;
 b=k/J7waaRDhtmANu46MTOfYAaQEj5FVoc6QzwLAG7uYtfegJoCPfVtZ7mzd/z6O2L/d
 h+eZKBQUcUEwNTyAkHL2EFz4P2WBsbv+VO+ktj4Nho//8zmKiuCG8DNHL+fUKh+D+RpG
 MEPI14BrGRpYCF15lYgpyAtqVtga9PS23Z+jtQHGsCCiLdc2MBegn6z1mRLjienfijex
 5QDlvspQcpKxhhDNCBLsd0rU1BIF8eklOGN+6t0mZdAOlg194vfQVT/uefVseWUsQX63
 WY+Ez9wmqlKsibsHymC27z2Iujpeg+H7QyoJVm09Rvw7e+R/1vDgzsZObSS/UZJ2tlKA
 tI8g==
X-Gm-Message-State: AOAM532AhrW484EE6AE8Zt8ArDJhp8YFWqIeYCBBE0EaCb1U3y6Yxtsp
 T7ArO5R3jBCU3n3szDAuV+2QzSFAdrc=
X-Google-Smtp-Source: ABdhPJyp8VaHrFYgHeJQJsDHWfkSgg16a4KeNBjBfG3vUUMYvh7lgQs1hEDw1k3xQa+VU3SkLTUYAw==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr19218611wmb.171.1599443746206; 
 Sun, 06 Sep 2020 18:55:46 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b84sm29377773wmd.0.2020.09.06.18.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 18:55:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] hw/char/serial-isa: Alias QDEV properties from generic
 serial object
Date: Mon,  7 Sep 2020 03:55:34 +0200
Message-Id: <20200907015535.827885-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907015535.827885-1-f4bug@amsat.org>
References: <20200907015535.827885-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of overwritting the properties of the generic 'state'
object, alias them.
Note we can now propagate the "baudbase" property.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial-isa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index a0c338796d5..0626edda8d1 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -115,8 +115,6 @@ static Property serial_isa_properties[] = {
     DEFINE_PROP_UINT32("index",  ISASerialState, index,   -1),
     DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
     DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
-    DEFINE_PROP_CHR("chardev",   ISASerialState, state.chr),
-    DEFINE_PROP_BOOL("wakeup",   ISASerialState, state.wakeup, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -137,6 +135,8 @@ static void serial_isa_initfn(Object *o)
     ISASerialState *self = ISA_SERIAL(o);
 
     object_initialize_child(o, "serial", &self->state, TYPE_SERIAL);
+
+    qdev_alias_all_properties(DEVICE(&self->state), o);
 }
 
 static const TypeInfo serial_isa_info = {
-- 
2.26.2


