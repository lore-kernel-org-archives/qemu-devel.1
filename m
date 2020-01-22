Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FE7C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418B924656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtFvNYi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418B924656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu8ww-0008U1-Qt
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 00:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8vh-0007CG-Fb
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8vg-0004Vf-BT
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:51:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28974
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8vg-0004V9-7y
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579672311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iqdou0zJkfRWru0+TaH+ds3yQysCRWAljy+JrvdS3ko=;
 b=ZtFvNYi6pd+Sh6BkNZ7GAsUEg4790LaHtvx0Au9xIIxieJbCoF5Q6m1lqWv6rKBuZZHfy7
 r/+JvcRYJFokj5WQJBRxBBZApwhAtfDFFcGPyGcUxx+eT0MOWFj5ZBvt85zikFFGutlLX9
 nzMwseFLeq7gerVAU2F1afDNhrki4cQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-3_AUKBp1Nqy4gL2GMszcOg-1; Wed, 22 Jan 2020 00:51:49 -0500
Received: by mail-wr1-f71.google.com with SMTP id w6so2546891wrm.16
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=/6xO29TZkk8la6itErk1eKrVcyTIt+MrtjmHjpHcAxc=;
 b=E6VX3YVRSRt9yubPEbvhbyYp3cgL302TJh5LIMuqGSfGWi8n6LvtTBunq1ry0LVM9y
 QTWPaMnwhFO0ph0vW/YBceqWJBxQiq1zyIPBrsIjQMmodROqF3rXxhXP1rpAtOou3h4p
 frmLcUxe3pjptsDkD359U7N7/K/L0L2eQTSCQcsFdJ+xBuaBWOaAgYHmiAb6Yg8Lq2MZ
 Ggwnt3SzGSJezewR8XQc3Lf+jBSlrqS9qmYPkGeQBQFXPzW1eoaL2mXvdwKxW8RsWk4f
 AbCEyf6wkxXFcHLzfTugIhBwo01RHVBy+f34y2wKfihC4VGibohpV0Ctvp26Xh7v9bE5
 6Ctg==
X-Gm-Message-State: APjAAAXZLuNrhIYUXULDLzlDXShS6L4oLLegfQ5qs5S9UYeFCYOphMDJ
 FjWVnNxA0rKXJOUJwPLlgJa37fznwqG7WSwnf74M0/te6BTprNLXFj99VKMFWGL9lIz7/uoJwFH
 0EkeimMchRikP/O8=
X-Received: by 2002:a1c:9849:: with SMTP id a70mr932644wme.76.1579672307953;
 Tue, 21 Jan 2020 21:51:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoOnqb6Wilsqe6Sgys/utv5Gt44/AWFxJqWOsEPgDH6hm3nADqEnILSgji/FcSQ1Pg6A9sbw==
X-Received: by 2002:a1c:9849:: with SMTP id a70mr932629wme.76.1579672307746;
 Tue, 21 Jan 2020 21:51:47 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 p15sm2303862wma.40.2020.01.21.21.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:51:46 -0800 (PST)
Date: Wed, 22 Jan 2020 00:51:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] virtio, pc: fixes, features
Message-ID: <20200122055115.429945-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 3_AUKBp1Nqy4gL2GMszcOg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40=
:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-202001=
21' into staging (2020-01-21 15:29:25 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to b214ce61b60faa8b7629645824889bc01a07df0e:

  i386:acpi: Remove _HID from the SMBus ACPI entry (2020-01-22 00:50:03 -05=
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

 docs/specs/acpi_cpu_hotplug.txt  |  89 ++++++++++++++++++++++++++-------
 include/hw/pci-host/q35.h        |  10 ++++
 include/hw/virtio/vhost-vsock.h  |   2 +
 hw/9pfs/virtio-9p-device.c       |   1 +
 hw/acpi/cpu.c                    |  18 +++++++
 hw/i386/acpi-build.c             |   1 -
 hw/i386/pc.c                     |   4 +-
 hw/pci-host/q35.c                |  84 ++++++++++++++++++++++++++++---
 hw/scsi/virtio-scsi.c            |   6 +++
 hw/virtio/vhost-vsock.c          |  12 ++++-
 hw/virtio/vhost.c                |  39 ++++++++-------
 tests/qtest/bios-tables-test.c   |  23 +++++++--
 tests/qtest/q35-test.c           | 105 +++++++++++++++++++++++++++++++++++=
++++
 hw/acpi/trace-events             |   1 +
 tests/data/acpi/q35/DSDT         | Bin 7879 -> 7869 bytes
 tests/data/acpi/q35/DSDT.bridge  | Bin 7896 -> 7886 bytes
 tests/data/acpi/q35/DSDT.cphp    | Bin 8342 -> 8332 bytes
 tests/data/acpi/q35/DSDT.dimmpxm | Bin 9532 -> 9522 bytes
 tests/data/acpi/q35/DSDT.ipmibt  | Bin 7954 -> 7944 bytes
 tests/data/acpi/q35/DSDT.memhp   | Bin 9238 -> 9228 bytes
 tests/data/acpi/q35/DSDT.mmio64  | Bin 9009 -> 8999 bytes
 tests/data/acpi/q35/DSDT.numamem | Bin 7885 -> 7875 bytes
 22 files changed, 344 insertions(+), 51 deletions(-)


