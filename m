Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCFFC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B899B2224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dkp19hjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B899B2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFSN-0008QJ-Ie
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 10:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVFQS-0006Vh-HK
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVFQQ-0006mM-P8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603291752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IX/L23/0ddyEviqg3E0NRaP17Cro4aG+y7HvpeqT4Dk=;
 b=Dkp19hjN4GZydEJWKCZt2qlBjfXIrXFanm154+zvMnYgK17WgPKMcQg3AFIy84O5U+aeCI
 WP+hxZ/ToaKD/KWr4Q7oKZJ0/9o2uYDb9l2Zp77qdnRy4WEyr3L6hLaV6EPgfKZy6Z6wYW
 yQ44tZz213mIjGjPfhHz9FXZM8Fej1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-SRbqtG9EN22aYKcm_a7WYQ-1; Wed, 21 Oct 2020 10:49:10 -0400
X-MC-Unique: SRbqtG9EN22aYKcm_a7WYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA92A1007468;
 Wed, 21 Oct 2020 14:48:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 528E16EF50;
 Wed, 21 Oct 2020 14:48:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1C167A1EE; Wed, 21 Oct 2020 16:48:52 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Microvm 20201021 patches
Date: Wed, 21 Oct 2020 16:48:35 +0200
Message-Id: <20201021144852.16665-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89=
:=0D
=0D
  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' int=
o staging (2020-10-20 11:20:36 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/microvm-20201021-pull-request=0D
=0D
for you to fetch changes up to 66907f3d3b8bfc2de77b82d89253b7b3a8b728ec:=0D
=0D
  tests/acpi: update expected data files (2020-10-21 11:36:19 +0200)=0D
=0D
----------------------------------------------------------------=0D
microvm: fix PCIe IRQs in APIC table.=0D
microvm: add usb support.=0D
=0D
----------------------------------------------------------------=0D
=0D
Gerd Hoffmann (17):=0D
  tests/acpi: allow changes for microvm/APIC.pcie=0D
  tests/acpi: add empty microvm/APIC.pcie=0D
  x86: make pci irqs runtime configurable=0D
  microvm: set pci_irq_mask=0D
  apci: drop has_pci arg for acpi_build_madt=0D
  tests/acpi: update expected data files=0D
  tests/acpi: disallow changes for microvm/APIC.pcie=0D
  acpi: add aml builder stubs=0D
  usb/xhci: add include/hw/usb/xhci.h header file=0D
  usb/xhci: add xhci_sysbus_build_aml() helper=0D
  usb/xhci: fixup xhci kconfig deps=0D
  microvm: add usb support=0D
  tests/acpi: allow updates for expected data files=0D
  tests/acpi: add empty tests/data/acpi/microvm/DSDT.{usb, rtc} files=0D
  tests/acpi: add microvm usb test=0D
  tests/acpi: add microvm rtc test=0D
  tests/acpi: update expected data files=0D
=0D
 hw/i386/acpi-common.h             |   3 +--=0D
 hw/usb/hcd-xhci-sysbus.h          |   1 -=0D
 hw/usb/hcd-xhci.h                 |  22 ++++++-------------=0D
 include/hw/i386/microvm.h         |   5 ++++-=0D
 include/hw/i386/x86.h             |   2 ++=0D
 include/hw/usb/xhci.h             |  21 ++++++++++++++++++=0D
 hw/acpi/aml-build-stub.c          |  14 ++++++++++++=0D
 hw/i386/acpi-build.c              |   2 +-=0D
 hw/i386/acpi-common.c             |  26 ++++++++++-------------=0D
 hw/i386/acpi-microvm.c            |  11 +++++++++-=0D
 hw/i386/microvm.c                 |  19 +++++++++++++++++=0D
 hw/i386/x86.c                     |   1 +=0D
 hw/usb/hcd-xhci-nec.c             |   4 ++--=0D
 hw/usb/hcd-xhci-pci.c             |   4 ++--=0D
 hw/usb/hcd-xhci-sysbus.c          |  19 +++++++++++++++--=0D
 hw/usb/hcd-xhci.c                 |  34 ++++++++++++++----------------=0D
 tests/qtest/bios-tables-test.c    |  24 +++++++++++++++++++++=0D
 hw/i386/Kconfig                   |   1 +=0D
 hw/usb/Kconfig                    |   6 ++----=0D
 tests/data/acpi/microvm/APIC.pcie | Bin 0 -> 110 bytes=0D
 tests/data/acpi/microvm/DSDT.rtc  | Bin 0 -> 404 bytes=0D
 tests/data/acpi/microvm/DSDT.usb  | Bin 0 -> 414 bytes=0D
 22 files changed, 154 insertions(+), 65 deletions(-)=0D
 create mode 100644 include/hw/usb/xhci.h=0D
 create mode 100644 tests/data/acpi/microvm/APIC.pcie=0D
 create mode 100644 tests/data/acpi/microvm/DSDT.rtc=0D
 create mode 100644 tests/data/acpi/microvm/DSDT.usb=0D
=0D
--=20=0D
2.27.0=0D
=0D


