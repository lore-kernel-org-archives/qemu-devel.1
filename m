Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CC3C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCE520706
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFuwLkT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCE520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnvf-0003ux-9R
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifnfk-0001IJ-RP
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifnfj-0002mS-LH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41406
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifnfj-0002li-Ge
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576254007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8wBTE5cUDwAyuXnH+hRuodn6C9SR01WXRNOHU/iiao=;
 b=AFuwLkT0ZNJDIhprUk3hV1TfkoUmjtCFcuEeoNp0dCdcdFi1gvqgsh8LyCr2YXSCG/PywM
 06/0i01doxDKuOTBgPLZePM6I4oAOcU6B7rwyWVtVJM4u1Is44Mc9spgGTpGoIPLSY4rpN
 KKfW3bFc6WA2YjDcYhFp778ptkgvna4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-HUXIkw6eNy6QdyW3JyJ81A-1; Fri, 13 Dec 2019 11:20:05 -0500
X-MC-Unique: HUXIkw6eNy6QdyW3JyJ81A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13E62593A1;
 Fri, 13 Dec 2019 16:20:04 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79E2A19C4F;
 Fri, 13 Dec 2019 16:19:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/12] hw/intc/ioapic: Make ioapic_print_redtbl() static
Date: Fri, 13 Dec 2019 17:17:50 +0100
Message-Id: <20191213161753.8051-10-philmd@redhat.com>
In-Reply-To: <20191213161753.8051-1-philmd@redhat.com>
References: <20191213161753.8051-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Since commit 0c8465440 the ioapic_print_redtbl() function is not
used outside of ioapic_common.c, make it static, and remove its
prototype declaration in "ioapic_internal.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i386/ioapic_internal.h | 1 -
 hw/intc/ioapic_common.c           | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_i=
nternal.h
index d46c87c510..8b743aeed0 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -118,7 +118,6 @@ struct IOAPICCommonState {
=20
 void ioapic_reset_common(DeviceState *dev);
=20
-void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s);
 void ioapic_stat_update_irq(IOAPICCommonState *s, int irq, int level);
=20
 #endif /* QEMU_IOAPIC_INTERNAL_H */
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index 5538b5b86e..72ea945377 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -76,7 +76,7 @@ static void ioapic_irr_dump(Monitor *mon, const char *n=
ame, uint32_t bitmap)
     monitor_printf(mon, "\n");
 }
=20
-void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s)
+static void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s)
 {
     static const char *delm_str[] =3D {
         "fixed", "lowest", "SMI", "...", "NMI", "INIT", "...", "extINT"}=
;
--=20
2.21.0


