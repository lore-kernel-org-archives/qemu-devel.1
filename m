Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CDFCA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475572064A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475572064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLQ6I-0002Uh-Bb
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 07:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iLPuc-0006Gr-PY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iLPub-0001sa-2c
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:55:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iLPua-0001s1-QU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:55:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C151877AD3;
 Fri, 18 Oct 2019 10:55:12 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD525D713;
 Fri, 18 Oct 2019 10:55:02 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 13/15] docs/microvm.rst: document the new microvm machine
 type
Date: Fri, 18 Oct 2019 12:53:13 +0200
Message-Id: <20191018105315.27511-14-slp@redhat.com>
In-Reply-To: <20191018105315.27511-1-slp@redhat.com>
References: <20191018105315.27511-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 18 Oct 2019 10:55:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: berrange@redhat.com, ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>,
 mst@redhat.com, lersek@redhat.com, groug@kaod.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 marcandre.lureau@gmail.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document the new microvm machine type.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/microvm.rst | 108 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 docs/microvm.rst

diff --git a/docs/microvm.rst b/docs/microvm.rst
new file mode 100644
index 0000000000..aae811a922
--- /dev/null
+++ b/docs/microvm.rst
@@ -0,0 +1,108 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+microvm Machine Type
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+``microvm`` is a machine type inspired by ``Firecracker`` and
+constructed after its machine model.
+
+It's a minimalist machine type without ``PCI`` nor ``ACPI`` support,
+designed for short-lived guests. microvm also establishes a baseline
+for benchmarking and optimizing both QEMU and guest operating systems,
+since it is optimized for both boot time and footprint.
+
+
+Supported devices
+-----------------
+
+The microvm machine type supports the following devices:
+
+- ISA bus
+- i8259 PIC (optional)
+- i8254 PIT (optional)
+- MC146818 RTC (optional)
+- One ISA serial port (optional)
+- LAPIC
+- IOAPIC (with kernel-irqchip=3Dsplit by default)
+- kvmclock (if using KVM)
+- fw_cfg
+- Up to eight virtio-mmio devices (configured by the user)
+
+
+Limitations
+-----------
+
+Currently, microvm does *not* support the following features:
+
+ - PCI-only devices.
+ - Hotplug of any kind.
+ - Live migration across QEMU versions.
+
+
+Using the microvm machine type
+------------------------------
+
+Machine-specific options
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+It supports the following machine-specific options:
+
+- microvm.x-option-roms=3Dbool (Set off to disable loading option ROMs)
+- microvm.pit=3DOnOffAuto (Enable i8254 PIT)
+- microvm.isa-serial=3Dbool (Set off to disable the instantiation an ISA=
 serial port)
+- microvm.pic=3DOnOffAuto (Enable i8259 PIC)
+- microvm.rtc=3DOnOffAuto (Enable MC146818 RTC)
+- microvm.auto-kernel-cmdline=3Dbool (Set off to disable adding virtio-m=
mio devices to the kernel cmdline)
+
+
+Boot options
+~~~~~~~~~~~~
+
+By default, microvm uses ``qboot`` as its BIOS, to obtain better boot
+times, but it's also compatible with ``SeaBIOS``.
+
+As no current FW is able to boot from a block device using
+``virtio-mmio`` as its transport, a microvm-based VM needs to be run
+using a host-side kernel and, optionally, an initrd image.
+
+
+Running a microvm-based VM
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+By default, microvm aims for maximum compatibility, enabling both
+legacy and non-legacy devices. In this example, a VM is created
+without passing any additional machine-specific option, using the
+legacy ``ISA serial`` device as console::
+
+  $ qemu-system-x86_64 -M microvm \
+     -enable-kvm -cpu host -m 512m -smp 2 \
+     -kernel vmlinux -append "earlyprintk=3DttyS0 console=3DttyS0 root=3D=
/dev/vda" \
+     -nodefaults -no-user-config -nographic \
+     -serial stdio \
+     -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
+     -device virtio-blk-device,drive=3Dtest \
+     -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
+     -device virtio-net-device,netdev=3Dtap0
+
+While the example above works, you might be interested in reducing the
+footprint further by disabling some legacy devices. If you're using
+``KVM``, you can disable the ``RTC``, making the Guest rely on
+``kvmclock`` exclusively. Additionally, if your host's CPUs have the
+``TSC_DEADLINE`` feature, you can also disable both the i8259 PIC and
+the i8254 PIT (make sure you're also emulating a CPU with such feature
+in the guest).
+
+This is an example of a VM with all optional legacy features
+disabled::
+
+  $ qemu-system-x86_64 \
+     -M microvm,x-option-roms=3Doff,pit=3Doff,pic=3Doff,isa-serial=3Doff=
,rtc=3Doff \
+     -enable-kvm -cpu host -m 512m -smp 2 \
+     -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
+     -nodefaults -no-user-config -nographic \
+     -chardev stdio,id=3Dvirtiocon0 \
+     -device virtio-serial-device \
+     -device virtconsole,chardev=3Dvirtiocon0 \
+     -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
+     -device virtio-blk-device,drive=3Dtest \
+     -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
+     -device virtio-net-device,netdev=3Dtap0
--=20
2.21.0


