Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C0EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D5E21974
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjTLgRws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D5E21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuNY-0001h4-Ki
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuM1-0008Ex-Td
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:53:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27308
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuLz-00082P-5E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600350818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y9WO84tCpuVHwapYFNj9NZlA9ewco3LU+TaOt9K8VpY=;
 b=EjTLgRwsVqf+fSMmN479vpsqqstU0ZgdYLUZ4fcmHz4CdbW6z7NJM/1KmrvFV2chnMExKd
 tI1N8If7eV1kp380W+DhkAjqgTbDesR6D5Y0TcWVwZ5MANP5sog1UOSoVbDdnHH8wn7Yuk
 9UpNzPYUn/3vINQkwldIP9qCbjiYVO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-85UHzPhcOn-i37ApEqYibA-1; Thu, 17 Sep 2020 09:53:36 -0400
X-MC-Unique: 85UHzPhcOn-i37ApEqYibA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F08111074673;
 Thu, 17 Sep 2020 13:53:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2F5419D6C;
 Thu, 17 Sep 2020 13:53:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 89E279D5A; Thu, 17 Sep 2020 15:53:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] Microvm 20200917 patches
Date: Thu, 17 Sep 2020 15:53:02 +0200
Message-Id: <20200917135323.18022-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 09:24:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8ee612722dc08830761516e761dde934c3753a14=
:=0D
=0D
  Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20200915'=
 into staging (2020-09-16 14:47:50 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/microvm-20200917-pull-request=0D
=0D
for you to fetch changes up to 63bcfe7be09787ad6425afcaab5501b53bc26095:=0D
=0D
  microvm: enable ramfb (2020-09-17 14:16:19 +0200)=0D
=0D
----------------------------------------------------------------=0D
microvm: add acpi support=0D
=0D
----------------------------------------------------------------=0D
=0D
Gerd Hoffmann (21):=0D
  microvm: name qboot binary qboot.rom=0D
  seabios: add microvm config, update build rules=0D
  seabios: add bios-microvm.bin binary=0D
  acpi: ged: add control regs=0D
  acpi: ged: add x86 device variant.=0D
  acpi: move acpi_dsdt_add_power_button() to ged=0D
  microvm: make virtio irq base runtime configurable=0D
  microvm/acpi: add minimal acpi support=0D
  microvm/acpi: add acpi_dsdt_add_virtio() for x86=0D
  microvm/acpi: use GSI 16-23 for virtio=0D
  microvm/acpi: use seabios with acpi=3Don=0D
  microvm/acpi: disable virtio-mmio cmdline hack=0D
  x86: constify x86_machine_is_*_enabled=0D
  x86: move acpi_dev from pc/microvm=0D
  x86: move cpu hotplug from pc to x86=0D
  microvm: wire up hotplug=0D
  tests/acpi: allow microvm test data updates.=0D
  tests/acpi: allow override blkdev=0D
  tests/acpi: add microvm test=0D
  tests/acpi: update expected data files for microvm=0D
  microvm: enable ramfb=0D
=0D
 hw/i386/acpi-microvm.h                 |   8 +=0D
 include/hw/acpi/generic_event_device.h |  17 ++=0D
 include/hw/i386/microvm.h              |  10 +-=0D
 include/hw/i386/pc.h                   |   1 -=0D
 include/hw/i386/x86.h                  |  15 +-=0D
 hw/acpi/generic_event_device.c         |  52 +++++=0D
 hw/arm/virt-acpi-build.c               |   8 -=0D
 hw/i386/acpi-build.c                   |   2 +-=0D
 hw/i386/acpi-microvm.c                 | 240 ++++++++++++++++++++=0D
 hw/i386/generic_event_device_x86.c     |  36 +++=0D
 hw/i386/microvm.c                      | 108 ++++++++-=0D
 hw/i386/pc.c                           | 297 ++-----------------------=0D
 hw/i386/pc_piix.c                      |   2 +-=0D
 hw/i386/pc_q35.c                       |   2 +-=0D
 hw/i386/x86.c                          | 275 ++++++++++++++++++++++-=0D
 tests/qtest/bios-tables-test.c         |  21 +-=0D
 hw/i386/Kconfig                        |   1 +=0D
 hw/i386/meson.build                    |   3 +-=0D
 pc-bios/bios-microvm.bin               | Bin 65536 -> 131072 bytes=0D
 pc-bios/meson.build                    |   1 +=0D
 pc-bios/qboot.rom                      | Bin 0 -> 65536 bytes=0D
 roms/Makefile                          |  11 +-=0D
 roms/config.seabios-microvm            |  26 +++=0D
 tests/data/acpi/microvm/APIC           | Bin 0 -> 70 bytes=0D
 tests/data/acpi/microvm/DSDT           | Bin 0 -> 365 bytes=0D
 tests/data/acpi/microvm/FACP           | Bin 0 -> 268 bytes=0D
 26 files changed, 823 insertions(+), 313 deletions(-)=0D
 create mode 100644 hw/i386/acpi-microvm.h=0D
 create mode 100644 hw/i386/acpi-microvm.c=0D
 create mode 100644 hw/i386/generic_event_device_x86.c=0D
 create mode 100644 pc-bios/qboot.rom=0D
 create mode 100644 roms/config.seabios-microvm=0D
 create mode 100644 tests/data/acpi/microvm/APIC=0D
 create mode 100644 tests/data/acpi/microvm/DSDT=0D
 create mode 100644 tests/data/acpi/microvm/FACP=0D
=0D
--=20=0D
2.27.0=0D
=0D


