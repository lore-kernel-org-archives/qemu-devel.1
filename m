Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810F8C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E6B2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHSXGkUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E6B2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZX70-0002pX-Iw
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZX5J-0001Uf-Bf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:29:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZX5H-0004G4-Nq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604312947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=yvuUCr8ABlDxp2zeuuOZnidCYZjmA+G2M67SbKuof7M=;
 b=cHSXGkUEOxjvIVD9REf43m9H3kqzcizzhzQYRettG7s+D1EWKQtvm8n89UWdisdtx9TYbA
 rs6DJviAvtJORyU4A3Ija5cHxPFA5sKN00kBLGK0s5uDHah1O2mUzfj4bQTQi5iSrloPLh
 UyGDOQ7umYutBUBYLldBYPz81q2dlMk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-dbi1_arxPuKpqhvySU8wNA-1; Mon, 02 Nov 2020 05:29:03 -0500
X-MC-Unique: dbi1_arxPuKpqhvySU8wNA-1
Received: by mail-wr1-f71.google.com with SMTP id x16so6213479wrg.7
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=yvuUCr8ABlDxp2zeuuOZnidCYZjmA+G2M67SbKuof7M=;
 b=TFOaZ9wcyXW4p+BI92x4R5KnHI7r8RsyaXGjZQ1vZXEEpyWi9LDpTnTB8ovqrgp9M9
 9Sb1FnOu91/HcvzyUgwLiusBlkITj7fd+y0+oiOWOJyX+8Jyan/MeeZLmm/VsfBiL8GU
 C9LoQPYV7D7+pAl3o9rBwTQdwr97cOkUY8XgGMoNvs/UO/KuFoTMRGxAeTkgATx5B+F2
 ej8mSxWtdwVVel5fhYoJtnglKGzu0xngicXM5qMkPRuoJLddWOX+88G5yRZvLLrtPdNR
 OZoCtcBBaPTcne1WTMwCVK2/pnkqFr1KlpzudzFTZI4x7HpuOOEfRd8B3VW9Ckrv6u9K
 3HXQ==
X-Gm-Message-State: AOAM530cC4H743v4x6d2xDR8j4yr7zlYPklA3mia4pbFHdTlSdDnV8Tx
 nlESRUrcawOGowzSWLI5X0hwz8uVAQ9qYD8Z3YPu3MdqE9lu3asnom2jDY7yj1eGAXiWs8jCjJb
 FVc8MIpXxl/ky0cw=
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr16897995wmk.65.1604312942212; 
 Mon, 02 Nov 2020 02:29:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwailHr16tNUwU5GURfSXhmGknw7HVpp15eOD9lB2Nihli/t6R6/a90SPparBxyiUxIYQKieA==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr16897986wmk.65.1604312942085; 
 Mon, 02 Nov 2020 02:29:02 -0800 (PST)
Received: from redhat.com (bzq-79-181-134-187.red.bezeqint.net.
 [79.181.134.187])
 by smtp.gmail.com with ESMTPSA id z191sm15280436wme.30.2020.11.02.02.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 02:29:01 -0800 (PST)
Date: Mon, 2 Nov 2020 05:28:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] pc: comment style fixup
Message-ID: <20201102102815.1102222-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix up checkpatch comment style warnings.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
    address philippe's comments
:w

 hw/i386/pc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 416fb0e0f6..aae45ba779 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1149,10 +1149,11 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             error_report("couldn't create HPET device");
             exit(1);
         }
-        /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
-            * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
-            * IRQ8 and IRQ2.
-            */
+        /*
+         * For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7 and
+         * earlier, use IRQ2 for compat. Otherwise, use IRQ16~23, IRQ8 and
+         * IRQ2.
+         */
         uint8_t compat = object_property_get_uint(OBJECT(hpet),
                 HPET_INTCAP, NULL);
         if (!compat) {
-- 
MST


