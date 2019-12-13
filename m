Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D6CC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8798B24125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7FtgtZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8798B24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifng2-00013v-0m
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifne2-0007nD-9n
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifndz-00083x-Ff
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:18:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27929
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifndz-00082N-BH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576253898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eictPqqvfDWdLCnWulB6nvsiJMgILd7otDTiwQaZME4=;
 b=W7FtgtZy02cgeowTjxtRgkyZ4xFT2qSVGM77Q+xQmb5rJO9AOgBIT2ez5KWeNhvYZQ0aZq
 we01nH6WoRkLxRGiSg3khpteMc7lhCzlZolJJkWc1gcfDC76VlR8wDehbqlrGVloctr7pt
 KAUKgVhiPknzDQ6XqFhbXdrD55H72cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-termAq3FMgGFGnyF0OlLXA-1; Fri, 13 Dec 2019 11:18:14 -0500
X-MC-Unique: termAq3FMgGFGnyF0OlLXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E942800D41;
 Fri, 13 Dec 2019 16:18:12 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F91219C4F;
 Fri, 13 Dec 2019 16:17:57 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] hw/i386/pc: Move PC-machine specific declarations to
 'pc_internal.h'
Date: Fri, 13 Dec 2019 17:17:41 +0100
Message-Id: <20191213161753.8051-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Hi Paolo,

Since you posted your "x86: allow building without PC machine
types" series [1], I looked at my past work on this topic
(restrict "hw/i386/pc.h" to the X86 architecture).
I'm glad to see in [2] you remove most (all) of the last uses.
Since I haven't looked at this for some time, my WiP branch was
quite diverged from QEMU master. I guess I could salvage most of
the easy patches. The rest is QOMification of GSI/IOAPIC which
require various changes with the i8259, so I'll keep that for
later.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg664760.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg664765.html

Philippe Mathieu-Daud=C3=A9 (12):
  hw/i386/pc: Convert DPRINTF() to trace events
  hw/i386/pc: Move kvm_i8259_init() declaration to sysemu/kvm.h
  hw/i386/pc: Remove obsolete pc_pci_device_init() declaration
  hw/i386/pc: Remove obsolete cpu_set_smm_t typedef
  hw/i386/ich9: Remove unused include
  hw/i386/ich9: Move unnecessary "pci_bridge.h" include
  hw/ide/piix: Remove superfluous DEVICE() cast
  hw/ide/piix: Use ARRAY_SIZE() instead of magic numbers
  hw/intc/ioapic: Make ioapic_print_redtbl() static
  hw/i386/pc: Rename allocate_cpu_irq from 'pc' to 'x86_machine'
  hw/i386/pc: Move x86_machine_allocate_cpu_irq() to 'hw/i386/x86.c'
  hw/i386/pc: Move PC-machine specific declarations to 'pc_internal.h'

 hw/i386/pc_internal.h             | 144 ++++++++++++++++++++++++++++++
 include/hw/i386/ich9.h            |   2 -
 include/hw/i386/ioapic_internal.h |   1 -
 include/hw/i386/pc.h              | 133 ---------------------------
 include/hw/i386/x86.h             |   2 +
 include/sysemu/kvm.h              |   1 +
 hw/i386/acpi-build.c              |   2 +
 hw/i386/microvm.c                 |   2 +-
 hw/i386/pc.c                      |  47 ++--------
 hw/i386/pc_piix.c                 |   1 +
 hw/i386/pc_q35.c                  |   1 +
 hw/i386/pc_sysfw.c                |   1 +
 hw/i386/x86.c                     |  30 +++++++
 hw/i386/xen/xen-hvm.c             |   1 +
 hw/ide/piix.c                     |  29 +++---
 hw/intc/ioapic_common.c           |   2 +-
 hw/pci-bridge/i82801b11.c         |   1 +
 hw/i386/trace-events              |   6 ++
 18 files changed, 211 insertions(+), 195 deletions(-)
 create mode 100644 hw/i386/pc_internal.h

--=20
2.21.0


