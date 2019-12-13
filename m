Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D941C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CE92465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7MyBPgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CE92465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnir-0004ih-7x
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifnei-0008MY-5k
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifnef-0000iI-NG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48735
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifnef-0000h7-Im
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576253941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGwuqBufIRpm7r+bogG1ik6zWSyuu3LLE1OLY6amY0k=;
 b=P7MyBPgKAUZjxvHJQE396s4OjOb6JuXXiy/zJ2zlASw+Z2BKN/ulVA7Xp5utDnzAcBLuAz
 4B7GdkYi//xEf9DqTl7SmAwKt38abOYosyzmirVeV3x1rN0TnyPtw+QjSJUuvWovk6m6hY
 HwEauLQsWrJW2lFmjP9Rn21ZELGB4v0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-tC9omY2INnyb3aoLSRkHSQ-1; Fri, 13 Dec 2019 11:18:59 -0500
X-MC-Unique: tC9omY2INnyb3aoLSRkHSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF5A48024CF;
 Fri, 13 Dec 2019 16:18:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62BEC19C4F;
 Fri, 13 Dec 2019 16:18:43 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/12] hw/i386/pc: Remove obsolete cpu_set_smm_t typedef
Date: Fri, 13 Dec 2019 17:17:45 +0100
Message-Id: <20191213161753.8051-5-philmd@redhat.com>
In-Reply-To: <20191213161753.8051-1-philmd@redhat.com>
References: <20191213161753.8051-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit f809c6051 we replaced the use of cpu_set_smm_t callbacks
by using a Notifier to modify the MemoryRegion. This prototype is
now not used anymore, we can safely remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i386/pc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bc7d855aaa..743141e107 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -212,8 +212,6 @@ void pc_cmos_init(PCMachineState *pcms,
                   ISADevice *s);
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)=
;
=20
-typedef void (*cpu_set_smm_t)(int smm, void *arg);
-
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
=20
--=20
2.21.0


