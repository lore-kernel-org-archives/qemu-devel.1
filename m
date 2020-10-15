Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E5DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F34822255
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJ9UnK2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F34822255
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6SN-0008Ln-4l
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6Ne-0004OM-Mc
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6NR-0000XE-TT
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCDuD6H6MJD1t3wMyUJdOcMIiE41OOWS2VG/S+mOCY4=;
 b=fJ9UnK2naFxZ1EdACrB6T/G0/A2RrT1b31ZaGYt+3N17P7m1zqceKI8UdtVcPHtuWHcVlZ
 w8lg1wZYoiah/ABR336eT2XKRSFHKMDPIliACcmHuF71V3GYEFarykhZJJAxNGIfL/ObsB
 KpPg7tmzNphQ+/vUz54QonTs2v1Bmyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-i6B9MYqHPxGBbOjANKJu9g-1; Thu, 15 Oct 2020 12:45:13 -0400
X-MC-Unique: i6B9MYqHPxGBbOjANKJu9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8335356B56;
 Thu, 15 Oct 2020 16:45:12 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4442C5C1BD;
 Thu, 15 Oct 2020 16:45:12 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 7/9] kvm: Correct documentation of kvm_irqchip_*()
Date: Thu, 15 Oct 2020 12:44:59 -0400
Message-Id: <20201015164501.462775-8-ehabkost@redhat.com>
In-Reply-To: <20201015164501.462775-1-ehabkost@redhat.com>
References: <20201015164501.462775-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When split irqchip support was introduced, the meaning of
kvm_irqchip_in_kernel() changed: now it only means the LAPIC is
in kernel.  The PIC, IOAPIC, and PIT might be in userspace if
irqchip=split was set.  Update the doc comment to reflect that.

While at it, remove the "the user asked us" part in
kvm_irqchip_is_split() doc comment.  That macro has nothing to do
with existence of explicit user-provided options.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200922203612.2178370-1-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/kvm.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index fe7dab1466..bb5d5cf497 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -51,23 +51,22 @@ extern bool kvm_msi_use_devid;
 /**
  * kvm_irqchip_in_kernel:
  *
- * Returns: true if the user asked us to create an in-kernel
- * irqchip via the "kernel_irqchip=on" machine option.
+ * Returns: true if an in-kernel irqchip was created.
  * What this actually means is architecture and machine model
- * specific: on PC, for instance, it means that the LAPIC,
- * IOAPIC and PIT are all in kernel. This function should never
- * be used from generic target-independent code: use one of the
- * following functions or some other specific check instead.
+ * specific: on PC, for instance, it means that the LAPIC
+ * is in kernel.  This function should never be used from generic
+ * target-independent code: use one of the following functions or
+ * some other specific check instead.
  */
 #define kvm_irqchip_in_kernel() (kvm_kernel_irqchip)
 
 /**
  * kvm_irqchip_is_split:
  *
- * Returns: true if the user asked us to split the irqchip
- * implementation between user and kernel space. The details are
- * architecture and machine specific. On PC, it means that the PIC,
- * IOAPIC, and PIT are in user space while the LAPIC is in the kernel.
+ * Returns: true if the irqchip implementation is split between
+ * user and kernel space.  The details are architecture and
+ * machine specific.  On PC, it means that the PIC, IOAPIC, and
+ * PIT are in user space while the LAPIC is in the kernel.
  */
 #define kvm_irqchip_is_split() (kvm_split_irqchip)
 
-- 
2.28.0


