Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6137CC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D74224655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6CIOJ4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D74224655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9rV-0005oo-SJ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9pu-00049e-Om
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9pr-0007iF-WF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:49:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43132
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9pr-0007hd-PW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5qYfA5cgudD+2cRo66zaD/Cz752AR9k6ffKvTJerkYk=;
 b=D6CIOJ4xHr+If5GFa1TzI227G8LNycjsix17dXt1tHMqTaErvM0zCtdrc5q31DgSo1M66N
 joGPN8LwHkM+b2n6SZD1yOVFFx3X0g441VW+TRgbE6sWxG8xv8c3tOdjF3LuIkuMhrXYPk
 RbtoaSwpXm3h6Nuz5VbgK8fwV/ZenE0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-lxMCOUk5OM6_e1WmDytIbw-1; Wed, 22 Jan 2020 01:49:52 -0500
Received: by mail-wr1-f70.google.com with SMTP id z15so2624005wrw.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=bPUWeY+Nnc2V8JdGNO0Z1xkiSCws7fpytYoYmHj0eic=;
 b=bqyWT+s01mi3gGmwQk3mMU6hVBwsn0WUQiv69C+649DbCE9U14xkgqckwC+DBJzkqU
 zUYa26izN30Zj9xf+8mr8YEVVwytglRrOOBsuRqrnu6XZJPedmznWLlGUMedFlVfMWBk
 bw86Sur+Aye1yS9iuFRAru39HO4qyn4m0sIG92IYAdk2cCPEpx+6DNQmeZYd8Yxr9w4v
 O8xaxaBkNb7hcp5wjfpfQp2HEGY9UU/iukiBX9QxE0xHQNcq2Pi3kzKgz+Aeni6hnfiI
 WMqU2Ei+07KmTK1+Kq1zNzXsAw4QtL2kZuT1I44AXkwHuCyUL1g1kbn9tI9TqrpiYPcN
 v2PQ==
X-Gm-Message-State: APjAAAWJxSgO5E9tF+jWOfvcJy8ekxukEDukl65NMWewr/68K/9DOb4k
 yUEhvEczzEUNXW+QUhqH4J4UsolkLpKnTG6iCM3DCcOHKAQ9x99E88LivRYVMCZ96SyLVNiRwbH
 vCuofCaNYilgYoGc=
X-Received: by 2002:a5d:5347:: with SMTP id t7mr9224872wrv.401.1579675791248; 
 Tue, 21 Jan 2020 22:49:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqykAqYOV7Vs7+OTu1Y/gnk4TokGf7nnIZsO5lE6BGp7T7ZGsP7wJnGdkVGFainiPBU5gTKQcw==
X-Received: by 2002:a5d:5347:: with SMTP id t7mr9224850wrv.401.1579675790923; 
 Tue, 21 Jan 2020 22:49:50 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 j2sm2656944wmk.23.2020.01.21.22.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:49:50 -0800 (PST)
Date: Wed, 22 Jan 2020 01:49:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/17] virtio, pc: fixes, features
Message-ID: <20200122064907.512501-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: lxMCOUk5OM6_e1WmDytIbw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes from v1:
    - add a missing expected file

The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40=
:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-202001=
21' into staging (2020-01-21 15:29:25 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to aefcaf9d1b3ebb30981627bd08f595211a648a62:

  i386:acpi: Remove _HID from the SMBus ACPI entry (2020-01-22 01:47:55 -05=
00)

----------------------------------------------------------------
virtio, pc: fixes, features

Bugfixes all over the place.
CPU hotplug with secureboot.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Corey Minyard (1):
      i386:acpi: Remove _HID from the SMBus ACPI entry

Dr. David Alan Gilbert (2):
      vhost: Add names to section rounded warning
      vhost: Only align sections for vhost-user

Igor Mammedov (8):
      q35: implement 128K SMRAM at default SMBASE address
      tests: q35: MCH: add default SMBASE SMRAM lock test
      acpi: cpuhp: spec: clarify 'CPU selector' register usage and endianne=
ss
      acpi: cpuhp: spec: fix 'Command data' description
      acpi: cpuhp: spec: clarify store into 'Command data' when 'Command fi=
eld' =3D=3D 0
      acpi: cpuhp: introduce 'Command data 2' field
      acpi: cpuhp: spec: add typical usecases
      acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command

Michael S. Tsirkin (1):
      bios-tables-test: document expected file update

Pan Nengyuan (5):
      virtio-9p-device: fix memleak in virtio_9p_device_unrealize
      virtio-9p-device: convert to new virtio_delete_queue
      virtio-scsi: delete vqs in unrealize to avoid memleaks
      virtio-scsi: convert to new virtio_delete_queue
      vhost-vsock: delete vqs in vhost_vsock_unrealize to avoid memleaks

 docs/specs/acpi_cpu_hotplug.txt   |  89 ++++++++++++++++++++++++++------
 include/hw/pci-host/q35.h         |  10 ++++
 include/hw/virtio/vhost-vsock.h   |   2 +
 hw/9pfs/virtio-9p-device.c        |   1 +
 hw/acpi/cpu.c                     |  18 +++++++
 hw/i386/acpi-build.c              |   1 -
 hw/i386/pc.c                      |   4 +-
 hw/pci-host/q35.c                 |  84 +++++++++++++++++++++++++++---
 hw/scsi/virtio-scsi.c             |   6 +++
 hw/virtio/vhost-vsock.c           |  12 ++++-
 hw/virtio/vhost.c                 |  39 +++++++-------
 tests/qtest/bios-tables-test.c    |  23 +++++++--
 tests/qtest/q35-test.c            | 105 ++++++++++++++++++++++++++++++++++=
++++
 hw/acpi/trace-events              |   1 +
 tests/data/acpi/q35/DSDT          | Bin 7879 -> 7869 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9203 -> 9193 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7896 -> 7886 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8342 -> 8332 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9532 -> 9522 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7954 -> 7944 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9238 -> 9228 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 9009 -> 8999 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7885 -> 7875 bytes
 23 files changed, 344 insertions(+), 51 deletions(-)


