Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D476FC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164C5222B9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ci0EE4q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164C5222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWqQ-0007gO-UK
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZWms-0004Dp-Pq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:10:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZWmq-0005g4-SN
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604311803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=XCI690buz+9wcPCmcDusTt+GnT6I/ArWLX5xgE3fK90=;
 b=ci0EE4q9JSUduyWGF+dUrouH/D+1CeFm1nyyF8DfxiyySxMQinK5SALNWa+v8+kPL0sT6T
 MbyL3ClwKZzWnlrPeaIHq4dHg9uW7TEnMeJYjdB1Q+h4fPlef7yVpC2riUt1uQfFxP22V2
 anDEovVm3dgANi8J+6Y/0rbzthJz6QI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-jnlLmeUSOf6t5BrHl2-2vg-1; Mon, 02 Nov 2020 05:09:59 -0500
X-MC-Unique: jnlLmeUSOf6t5BrHl2-2vg-1
Received: by mail-wm1-f72.google.com with SMTP id s85so1712236wme.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=XCI690buz+9wcPCmcDusTt+GnT6I/ArWLX5xgE3fK90=;
 b=fjS4VmsN5e8tV11rOjH8JttyyhYGQOjdYSInpu1FqIcW7MIgqhJ8Q5fNHUDZqlF0yz
 fw+o9C/fuM13gPCnUZvonxzGFdq2xqZQlKlNluwuJYTG+3H2G+Mkc5x2HINAv7t+Jsyh
 1Wel+Vb6fMsHNBuSX8eItUiQ3IZ9ELyKo7sXC7Cz3l4CSsTZTE8iaVJPEO3UGoASIwpQ
 MQdZNgoECOkV+0RKXCzIYsZhpvzuADzyA7gp+ObCP8+xUcrCMD6k9D5X61bAbhwpFsO3
 KBa9KRpC7WEtapbjXC/HUBOO81qJBZ+OV4R0sTOmc/OdFO2UtM1yO2r0N4hD7UtA57qr
 uJ+w==
X-Gm-Message-State: AOAM532kb/a0qVpKxjRETmNFp2f1MIwqCmFj89RNvrVyw1/10gGHasxb
 KiDUDX8VQOqYziTtHk/o3QoUOSX86eA7Gwjlv9q6FNJ8e1ExTwZscPepq+nDQtPJUl/QrPm732a
 g0RnwZnmSRnfyq88=
X-Received: by 2002:adf:dc47:: with SMTP id m7mr19268899wrj.21.1604311797534; 
 Mon, 02 Nov 2020 02:09:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWVvXPsMLHSqjz5L/2DDRmtHTC/2X2+4gNpVB8S3m/OCUXM5XlIuBCrpNN/qwsvsdFDtkRKA==
X-Received: by 2002:adf:dc47:: with SMTP id m7mr19268881wrj.21.1604311797405; 
 Mon, 02 Nov 2020 02:09:57 -0800 (PST)
Received: from redhat.com (bzq-79-182-97-190.red.bezeqint.net. [79.182.97.190])
 by smtp.gmail.com with ESMTPSA id x10sm20846341wrp.62.2020.11.02.02.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 02:09:56 -0800 (PST)
Date: Mon, 2 Nov 2020 05:09:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] pc: comment stule fixup
Message-ID: <20201102100948.1101121-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 hw/i386/pc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 416fb0e0f6..5872ae6095 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1150,9 +1150,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             exit(1);
         }
         /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
-            * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
-            * IRQ8 and IRQ2.
-            */
+         * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
+         * IRQ8 and IRQ2.
+         */
         uint8_t compat = object_property_get_uint(OBJECT(hpet),
                 HPET_INTCAP, NULL);
         if (!compat) {
-- 
MST


