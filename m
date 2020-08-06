Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57909C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5722623131
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5A6ROVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5722623131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3hT6-0000T5-7j
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3hSW-0008NR-V4
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:05:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3hSV-0006a3-75
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596726330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=36NRQBFnKvLOHfTrOUCkCppYTniyv3MNt81GIJOXd7M=;
 b=V5A6ROVNHF23+HzAfsMlk3kThCe0fJkQGSZ/yMRQ5QU0Px3jC8MhamCjiMmOYhse2kS+Xm
 fK6w+gx5wq33YSqbV6FOhwcr/3EEY+zLQVTMA5+iE1LsnooCHrT92mbsqsXq/+Gghm7Bok
 QJX33UiibP+V8MWZxUtAz9Xxn8pYNzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-rIacAZosPb63Ip5arLh3yQ-1; Thu, 06 Aug 2020 11:05:11 -0400
X-MC-Unique: rIacAZosPb63Ip5arLh3yQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B96E19200C2;
 Thu,  6 Aug 2020 15:05:11 +0000 (UTC)
Received: from thuth.com (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6AA16FEDC;
 Thu,  6 Aug 2020 15:05:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
	qemu-s390x@nongnu.org
Subject: [PATCH] docs/system/s390x: Add a chapter about s390x boot devices
Date: Thu,  6 Aug 2020 17:05:07 +0200
Message-Id: <20200806150507.12073-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Booting on s390x is a little bit different compared to other architectures.
Let's add some information for people who are not yet used to this.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/s390x/bootdevices.rst | 82 +++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst      |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 docs/system/s390x/bootdevices.rst

diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
new file mode 100644
index 0000000000..68f0ffd450
--- /dev/null
+++ b/docs/system/s390x/bootdevices.rst
@@ -0,0 +1,82 @@
+Boot devices on s390x
+=====================
+
+Booting with bootindex parameter
+--------------------------------
+
+For classical mainframe guests (i.e. LPAR or z/VM installations), you always
+have to exactly specify the disk where you want to boot from (or "IPL" from,
+in s390x-speak -- IPL means "Initial Program Load"). Especially, there can
+also be only one boot device according to the architecture specification, thus
+specifying multiple boot devices is not possible (yet).
+
+So for booting an s390x guest in QEMU, you should always mark the
+device where you want to boot from with the ``bootindex`` property, for
+example::
+
+ qemu-system-s390x -drive if=none,id=dr1,file=guest.qcow2 \
+                   -device virtio-blk,drive=dr1,bootindex=1
+
+For booting from a CD-ROM ISO image (which needs to include El-Torito boot
+informatin for being bootable), it is recommended to specify a ``scsi-cd``
+device, for example like this::
+
+ qemu-system-s390x -blockdev file,node-name=c1,filename=... \
+                   -device virtio-scsi \
+                   -device scsi-cd,drive=c1,bootindex=1
+
+Note that you really have to use the ``bootindex`` property to select the
+boot device. The old-fashioned ``-boot order=...`` command of QEMU (and
+also ``-boot once=...``) is not supported on s390x.
+
+
+Booting without bootindex parameter
+-----------------------------------
+
+The QEMU guest firmware (the so-called s390-ccw bios) has also some rudimentary
+support for scanning through the available block devices. So in case you did
+not specify a boot device with the ``bootindex`` property, there is still a
+chance that it finds a bootable device on its own and starts a guest operating
+system from it. However, this scanning algorithm is still very rough and may
+be incomplete, so that it might fail to detect a bootable device in many cases.
+It is really recommended to always specify the boot device with the
+``bootindex`` property instead.
+
+This also means that you should avoid the classical short-cut commands like
+``-hda``, ``-cdrom`` or ``-drive if=virtio``, since it is not possible to
+specify the ``bootindex`` with these commands. Note that the convenience
+``-cdrom`` option even does not give you a real (virtio-scsi) CD-ROM device on
+s390x. Due to technical limitations in the QEMU code base, you will get a
+virtio-blk device with this parameter instead, which might not be the right
+device type for installing a Linux distribution via ISO image. It is
+recommended to specify a CD-ROM device via ``-device scsi-cd`` (as mentioned
+above) instead.
+
+
+Booting from a network device
+-----------------------------
+
+Beside the normal guest firmware (which is loaded from the file ``s390-ccw.img``
+in the data directory of QEMU, or via the ``-bios`` option), QEMU ships with
+a small TFTP network bootloader firmware for virtio-net-ccw devices, too. This
+firmware is loaded from a file called ``s390-netboot.img`` in the QEMU data
+directory. In case you want to load it from a different filename instead,
+you can specify it via the ``-global s390-ipl.netboot_fw=filename``
+command line option.
+
+The ``bootindex`` property is especially important for booting via the network.
+If you don't specify the the ``bootindex`` property here, the network bootloader
+firmware code won't get loaded into the guest memory so that the network boot
+will fail. For a successful network boot, try something like this::
+
+ qemu-system-s390x -netdev user,id=n1,tftp=...,bootfile=... \
+                   -device virtio-net-ccw,netdev=n1,bootindex=1
+
+The network bootloader firmware also has basic support for pxelinux.cfg-style
+configuration files. See the `PXELINUX Configuration page
+<https://wiki.syslinux.org/wiki/index.php?title=PXELINUX#Configuration>`__
+for details how to set up the configuration file on your TFTP server.
+The supported configuration file entries are ``DEFAULT``, ``LABEL``,
+``KERNEL``, ``INITRD`` and ``APPEND`` (see the `Syslinux Config file syntax
+<https://wiki.syslinux.org/wiki/index.php?title=Config>`__ for more
+information).
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
index 644e404ef9..c636f64113 100644
--- a/docs/system/target-s390x.rst
+++ b/docs/system/target-s390x.rst
@@ -31,4 +31,5 @@ Architectural features
 ======================
 
 .. toctree::
+   s390x/bootdevices
    s390x/protvirt
-- 
2.18.1


