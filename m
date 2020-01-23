Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DE6C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29762467F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYZWtBa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29762467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWes-0007K3-EB
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWd4-0005bT-Us
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWd3-0007ht-O1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48721
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWd3-0007hH-Jt
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9IIC4wVjNKVjTHjucAzf+tF4nSod1bvNr15UBYf1emI=;
 b=eYZWtBa5DcPOdJYb9yOYblrAO/4iEbTGekwJRzrXsa2Q88pxhX5H9L4w1NuRCm3N+m3n06
 XjXt3hte9zQd7A/U1/vb7i2MbUpNL4+N9SjMiFA+7NS93ybL2bnyZIdAiMdit4p2rBkxAO
 bF8xu1S5uvSv/DFzkzysyVdb9jlx9bo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-PleXpVlaMWGlD_4f5yLcKg-1; Thu, 23 Jan 2020 02:10:09 -0500
Received: by mail-wm1-f71.google.com with SMTP id f25so612842wmb.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=VN9P7gCxUNBVVBSUEw9Py9AJCZADZGzdaJB77zpbOSo=;
 b=kiD2iRQM7SFohi6Qp9f3WtWGtTK6NG2pSBNkTx5G3a3wE3Y6us4E3DprtNMsSAXY5G
 CP+TEamuJNxpMjkf0ZmJYn0bWYat+yAIbzin1choNagGKf7fvJxdW/0HB1A2O3KSM6Gq
 K5ADZ+SNYKQuffRQw/7e+lVF87XKj878jQ63v+b9dkKUszhPh1H3PgJA7Cq/3Atg55D8
 75NuIuqm6xpnHZP2X0ZUKH9+AbNsvJ9u/wprgORdg4pm6ScbeYHbISkb/0keMwC7WglN
 KDki/xCN2hxDXPUi/GIFxyiMnOGdd5sYeRplstPL4aXVO2NimYH6DWB1nyvpnXgovTbw
 /ehA==
X-Gm-Message-State: APjAAAXNY7jx0aWepkSFSORMgrNsTFNZmjxhBxzm80JupHJDSPLiV7z+
 BIgQRhtNznrN/Ax7z5CI//ex0+6lHPVP6TrzdiauT5BCPo0iji1yAtuVOWj0YFqnS3KQk3YnL61
 DuZ1BkAqMRnjqIgY=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr15426723wrp.17.1579763407891; 
 Wed, 22 Jan 2020 23:10:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFRzyEEMgmbSLKhPkl9LfkOCI+01CazcILAOc257FjlFOtrQTlyRWHe3ZiX2oNdiDVS0FxnA==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr15426700wrp.17.1579763407643; 
 Wed, 22 Jan 2020 23:10:07 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 e8sm1841587wrt.7.2020.01.22.23.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:06 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/18] virtio, pc: fixes, features
Message-ID: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: PleXpVlaMWGlD_4f5yLcKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes from v2:
    - add a coding style fix
Changes from v1:
    - add a missing expected file


The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40=
:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-202001=
21' into staging (2020-01-21 15:29:25 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 8347505640238d3b80f9bb7510fdc1bb574bad19:

  vhost: coding style fix (2020-01-23 02:08:15 -0500)

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

Michael S. Tsirkin (2):
      bios-tables-test: document expected file update
      vhost: coding style fix

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


