Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DF0C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48FB20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48FB20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClGm-00084H-UI
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iCkCl-0003NT-GY
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iCkCj-0004yd-RY
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:46:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iCkCj-0004yI-IE
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:46:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C26E1307D970;
 Tue, 24 Sep 2019 12:46:04 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94A0160933;
 Tue, 24 Sep 2019 12:45:58 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine type
Date: Tue, 24 Sep 2019 14:44:32 +0200
Message-Id: <20190924124433.96810-8-slp@redhat.com>
In-Reply-To: <20190924124433.96810-1-slp@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 24 Sep 2019 12:46:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Sergio Lopez <slp@redhat.com>, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, lersek@redhat.com, mtosatti@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document the new microvm machine type.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 docs/microvm.txt | 78 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 docs/microvm.txt

diff --git a/docs/microvm.txt b/docs/microvm.txt
new file mode 100644
index 0000000000..0241226b2a
--- /dev/null
+++ b/docs/microvm.txt
@@ -0,0 +1,78 @@
+Microvm is a machine type inspired by both NEMU and Firecracker, and
+constructed after the machine model implemented by the latter.
+
+It's main purpose is providing users a minimalist machine type free
+from the burden of legacy compatibility, serving as a stepping stone
+for future projects aiming at improving boot times, reducing the
+attack surface and slimming down QEMU's footprint.
+
+The microvm machine type supports the following devices:
+
+ - ISA bus
+ - i8259 PIC
+ - LAPIC (implicit if using KVM)
+ - IOAPIC (defaults to kernel_irqchip_split =3D true)
+ - i8254 PIT
+ - MC146818 RTC (optional)
+ - kvmclock (if using KVM)
+ - fw_cfg
+ - One ISA serial port (optional)
+ - Up to eight virtio-mmio devices (configured by the user)
+
+It supports the following machine-specific options:
+
+microvm.option-roms=3Dbool (Set off to disable loading option ROMs)
+microvm.isa-serial=3Dbool (Set off to disable the instantiation an ISA s=
erial port)
+microvm.rtc=3Dbool (Set off to disable the instantiation of an MC146818 =
RTC)
+microvm.kernel-cmdline=3Dbool (Set off to disable adding virtio-mmio dev=
ices to the kernel cmdline)
+
+By default, microvm uses qboot as its BIOS, to obtain better boot
+times, but it's also compatible with SeaBIOS.
+
+As no current FW is able to boot from a block device using virtio-mmio
+as its transport, a microvm-based VM needs to be run using a host-side
+kernel and, optionally, an initrd image.
+
+This is an example of instantiating a microvm VM with a virtio-mmio
+based console:
+
+qemu-system-x86_64 -M microvm
+ -enable-kvm -cpu host -m 512m -smp 2 \
+ -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
+ -nodefaults -no-user-config -nographic \
+ -chardev stdio,id=3Dvirtiocon0,server \
+ -device virtio-serial-device \
+ -device virtconsole,chardev=3Dvirtiocon0 \
+ -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
+ -device virtio-blk-device,drive=3Dtest \
+ -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
+ -device virtio-net-device,netdev=3Dtap0
+
+This is another example, this time using an ISA serial port, useful
+for debugging purposes:
+
+qemu-system-x86_64 -M microvm \
+ -enable-kvm -cpu host -m 512m -smp 2 \
+ -kernel vmlinux -append "earlyprintk=3DttyS0 console=3DttyS0 root=3D/de=
v/vda" \
+ -nodefaults -no-user-config -nographic \
+ -serial stdio \
+ -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
+ -device virtio-blk-device,drive=3Dtest \
+ -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
+ -device virtio-net-device,netdev=3Dtap0
+
+Finally, in this example a microvm VM is instantiated without RTC,
+without an ISA serial port and without loading the option ROMs,
+obtaining the smallest configuration:
+
+qemu-system-x86_64 -M microvm,rtc=3Doff,isa-serial=3Doff,option-roms=3Do=
ff \
+ -enable-kvm -cpu host -m 512m -smp 2 \
+ -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
+ -nodefaults -no-user-config -nographic \
+ -chardev stdio,id=3Dvirtiocon0,server \
+ -device virtio-serial-device \
+ -device virtconsole,chardev=3Dvirtiocon0 \
+ -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
+ -device virtio-blk-device,drive=3Dtest \
+ -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
+ -device virtio-net-device,netdev=3Dtap0
--=20
2.21.0


