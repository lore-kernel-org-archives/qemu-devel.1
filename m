Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9D3C2BB86
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAA120656
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3o93U/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAA120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlfG-0003kN-40
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 19:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlM8-00070R-Rq
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlLy-0007Ot-Oi
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:45:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlLy-0007OI-Hz; Sun, 12 Apr 2020 18:45:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id v5so8517772wrp.12;
 Sun, 12 Apr 2020 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=paXowiFLspJCJ+CxZTq0gQWD9VWSRURwdUHQAdRuXpU=;
 b=a3o93U/zHKzjtmWo/h4HlyWVvYhpJwHL2cZ2tOlElCFEjVvrKgS8PemHiYUQIiU+Ia
 Vjz4zUIuffSPe3f+RoEXjK9iLX9NVuciP8qF9yj93cDygWgh8bnAVnhHDulxUWAKPM2u
 O8oVjVinRP8otLOmF9REGmgBCJubcc5Kct7KN4JrVV5fQ+30QD9FMzvDP9tL681NJ4Xp
 ZXys733MPAO3DRTfpNdpF4PIf4+Qxz8AXt9hok2D8YwKyyIBMiVg8A7P+crQ67bO6kOk
 D6UsKb/Ccv4z0XFbnvNAJ6CgFGIhM8Z93Fj8WPW0BoWTGQrS0oz+oAmzyMBPb6oRa2g0
 p/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=paXowiFLspJCJ+CxZTq0gQWD9VWSRURwdUHQAdRuXpU=;
 b=Ky+Loys3286sMwrfM38RdQFoM3e7tzC3ln2cv27v+8ciOMEBLFEVFvBM/81+gLD1HI
 7AjJyoPfj1GdfaRLaHpFRzBFyHYW+EoP/67zjqeh1JPbSTYuAwdfsYwdzxR+9aCmQ60o
 0ifok47JZ7mj91PuFa/OcsPmaAKgzAur8NdNhJf14c4TTFaP8OBfM69bVZQy5tJC7Rha
 yPTYRviZNr8r81BMgjrZkfSpl1VEzoUps+Scem66zhv0eDYvWE3A2YSSKrpCjBQ6NJFD
 MscSNTXRWMp+G1zmGIp1Xqs/ZOjXQJzcP1F6ZJNZaBhZsH3IhF5xDMT4B3urJD3xnHbT
 Bvkg==
X-Gm-Message-State: AGi0PubHRR+OtuyQ+0ZeBYvCRcT1mvI6PLyHvaZwcjnbznLC5rcuzNZM
 OYNMISTdMx5J6Qw6N6OX7M7fa7ep0C51ug==
X-Google-Smtp-Source: APiQypLTyuwiHqEGMcLZIGWjPH6RdHo9ZCnbXR4GgGGa0GkJX1c3soDYoy4J18s1xpE4CkcyItSo8Q==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr15721541wrp.230.1586731523938; 
 Sun, 12 Apr 2020 15:45:23 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a1sm3509742wrn.80.2020.04.12.15.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:45:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 0/7] various: Fix error-propagation with Coccinelle
 scripts (part 3)
Date: Mon, 13 Apr 2020 00:45:10 +0200
Message-Id: <20200412224517.12869-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-riscv@nongnu.org, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is inspired of Peter Maydell fix [1]:
"hw/arm/xlnx-zynqmp.c: fix some error-handling code",
but grew after v1 [2] review :/

Markus: I added the cocci patches to your Error section, I hope
that's fine :)

Part 3: Use &error_abort/&error_fatal in instance_init().

Regards,

Phil.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg691636.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg692155.html
Based-on: <20200412224144.12205-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (7):
  scripts/coccinelle: Use &error_abort in TypeInfo::instance_init()
  various: Use &error_abort in instance_init()
  scripts/coccinelle: Find eventually missing error_propagate() calls
  migration/colo: Add missing error-propagation code
  hw/mips/boston: Add missing error-propagation code
  hw/mips/mips_malta: Use &error_abort in MachineClass::init ->
    create_cps
  qga/commands-win32: Add missing error-propagation code

 .../find-missing-error_propagate.cocci        | 53 +++++++++++++++++++
 .../use-error_abort-in-instance_init.cocci    | 45 ++++++++++++++++
 backends/cryptodev-vhost-user.c               |  2 +-
 backends/rng-egd.c                            |  2 +-
 backends/rng-random.c                         |  2 +-
 backends/vhost-user.c                         |  3 +-
 hw/arm/bcm2835_peripherals.c                  |  6 ++-
 hw/arm/vexpress.c                             |  8 +--
 hw/arm/xlnx-zcu102.c                          |  8 +--
 hw/block/fdc.c                                |  4 +-
 hw/block/vhost-user-blk.c                     |  2 +-
 hw/block/virtio-blk.c                         |  2 +-
 hw/core/machine.c                             |  6 +--
 hw/cpu/core.c                                 |  4 +-
 hw/display/vga-pci.c                          |  7 ++-
 hw/display/xlnx_dp.c                          |  4 +-
 hw/dma/sparc32_dma.c                          |  2 +-
 hw/gpio/aspeed_gpio.c                         |  2 +-
 hw/ide/macio.c                                |  4 +-
 hw/ide/qdev.c                                 |  4 +-
 hw/intc/apic_common.c                         |  2 +-
 hw/mem/nvdimm.c                               |  4 +-
 hw/mips/boston.c                              | 17 +++---
 hw/mips/mips_malta.c                          | 15 ++----
 hw/misc/aspeed_sdmc.c                         |  2 +-
 hw/misc/edu.c                                 |  3 +-
 hw/misc/macio/macio.c                         |  4 +-
 hw/misc/macio/pmu.c                           |  3 +-
 hw/misc/pca9552.c                             |  2 +-
 hw/misc/tmp105.c                              |  2 +-
 hw/misc/tmp421.c                              |  8 +--
 hw/net/e1000.c                                |  3 +-
 hw/net/lance.c                                |  3 +-
 hw/net/lasi_i82596.c                          |  3 +-
 hw/net/ne2000-isa.c                           |  4 +-
 hw/net/spapr_llan.c                           |  3 +-
 hw/net/virtio-net.c                           |  2 +-
 hw/pci-host/grackle.c                         |  2 +-
 hw/pci-host/i440fx.c                          |  8 +--
 hw/pci-host/prep.c                            |  2 +-
 hw/pci-host/q35.c                             | 23 ++++----
 hw/pci-host/sabre.c                           |  3 +-
 hw/pci-host/uninorth.c                        |  9 ++--
 hw/pcmcia/pxa2xx.c                            |  3 +-
 hw/ppc/spapr_drc.c                            |  6 +--
 hw/ppc/spapr_rng.c                            |  2 +-
 hw/riscv/sifive_u.c                           |  4 +-
 hw/s390x/event-facility.c                     |  6 +--
 hw/s390x/s390-ccw.c                           |  2 +-
 hw/s390x/s390-skeys.c                         |  4 +-
 hw/s390x/s390-stattrib.c                      |  4 +-
 hw/s390x/sclp.c                               |  2 +-
 hw/scsi/scsi-bus.c                            |  2 +-
 hw/ssi/xilinx_spips.c                         |  2 +-
 hw/usb/bus.c                                  |  4 +-
 hw/usb/dev-network.c                          |  2 +-
 hw/usb/dev-storage.c                          |  4 +-
 hw/usb/host-libusb.c                          |  2 +-
 hw/usb/redirect.c                             |  2 +-
 hw/virtio/virtio-balloon.c                    |  4 +-
 migration/colo.c                              |  3 ++
 net/dump.c                                    |  4 +-
 net/filter-buffer.c                           |  2 +-
 net/filter-mirror.c                           | 10 ++--
 net/filter-rewriter.c                         |  3 +-
 qga/commands-win32.c                          | 26 ++++++---
 target/arm/cpu64.c                            |  4 +-
 target/i386/cpu.c                             | 23 ++++----
 target/s390x/cpu.c                            |  3 +-
 tests/check-qom-proplist.c                    |  7 +--
 tests/test-qdev-global-props.c                |  5 +-
 MAINTAINERS                                   |  2 +
 72 files changed, 289 insertions(+), 155 deletions(-)
 create mode 100644 scripts/coccinelle/find-missing-error_propagate.cocci
 create mode 100644 scripts/coccinelle/use-error_abort-in-instance_init.cocci

-- 
2.21.1


