Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70758C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E57D2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E57D2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKLNj-0000AA-EN
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 07:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iKLMA-0007D8-97
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iKLM7-0000QH-3L
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:51:13 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:39153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iKLM6-0000L9-HH
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:51:10 -0400
Received: from player799.ha.ovh.net (unknown [10.109.143.136])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 04A6C7C2EE
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 13:51:07 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 63EF1AF1C93D;
 Tue, 15 Oct 2019 11:50:54 +0000 (UTC)
Date: Tue, 15 Oct 2019 13:50:53 +0200
From: Greg Kurz <groug@kaod.org>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v9 13/15] docs/microvm.rst: document the new microvm
 machine type
Message-ID: <20191015135053.569f1614@bahia.lan>
In-Reply-To: <20191015112346.45554-14-slp@redhat.com>
References: <20191015112346.45554-1-slp@redhat.com>
 <20191015112346.45554-14-slp@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12874383960360917396
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeefgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.49.171
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
Cc: ehabkost@redhat.com, mst@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 13:23:44 +0200
Sergio Lopez <slp@redhat.com> wrote:

> Document the new microvm machine type.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  docs/microvm.rst | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 docs/microvm.rst
> 
> diff --git a/docs/microvm.rst b/docs/microvm.rst
> new file mode 100644
> index 0000000000..dc36ecf7c3
> --- /dev/null
> +++ b/docs/microvm.rst
> @@ -0,0 +1,98 @@
> +====================
> +Microvm Machine Type
> +====================
> +
> +Microvm is a machine type inspired by ``Firecracker`` and constructed
> +after the its machine model.
> +

Same typo as in the cover.

s/the //

> +It's a minimalist machine type without ``PCI`` nor ``ACPI`` support,
> +designed for short-lived guests. Microvm also establishes a baseline
> +for benchmarking and optimizing both QEMU and guest operating systems,
> +since it is optimized for both boot time and footprint.
> +
> +
> +Supported devices
> +-----------------
> +
> +The microvm machine type supports the following devices:
> +
> +- ISA bus
> +- i8259 PIC (optional)
> +- i8254 PIT (optional)
> +- MC146818 RTC (optional)
> +- One ISA serial port (optional)
> +- LAPIC
> +- IOAPIC (with kernel-irqchip=split by default)
> +- kvmclock (if using KVM)
> +- fw_cfg
> +- Up to eight virtio-mmio devices (configured by the user)
> +
> +
> +Using the microvm machine type
> +------------------------------
> +
> +Machine-specific options
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It supports the following machine-specific options:
> +
> +- microvm.x-option-roms=bool (Set off to disable loading option ROMs)
> +- microvm.pit=OnOffAuto (Enable i8254 PIT)
> +- microvm.isa-serial=bool (Set off to disable the instantiation an ISA serial port)
> +- microvm.pic=OnOffAuto (Enable i8259 PIC)
> +- microvm.rtc=OnOffAuto (Enable MC146818 RTC)
> +- microvm.auto-kernel-cmdline=bool (Set off to disable adding virtio-mmio devices to the kernel cmdline)
> +
> +
> +Boot options
> +~~~~~~~~~~~~
> +
> +By default, microvm uses ``qboot`` as its BIOS, to obtain better boot
> +times, but it's also compatible with ``SeaBIOS``.
> +
> +As no current FW is able to boot from a block device using
> +``virtio-mmio`` as its transport, a microvm-based VM needs to be run
> +using a host-side kernel and, optionally, an initrd image.
> +
> +
> +Running a microvm-based VM
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +By default, microvm aims for maximum compatibility, enabling both
> +legacy and non-legacy devices. In this example, a VM is created
> +without passing any additional machine-specific option, using the
> +legacy ``ISA serial`` device as console::
> +
> +  $ qemu-system-x86_64 -M microvm \
> +     -enable-kvm -cpu host -m 512m -smp 2 \
> +     -kernel vmlinux -append "earlyprintk=ttyS0 console=ttyS0 root=/dev/vda" \
> +     -nodefaults -no-user-config -nographic \
> +     -serial stdio \
> +     -drive id=test,file=test.img,format=raw,if=none \
> +     -device virtio-blk-device,drive=test \
> +     -netdev tap,id=tap0,script=no,downscript=no \
> +     -device virtio-net-device,netdev=tap0
> +
> +While the example above works, you might be interested in reducing the
> +footprint further by disabling some legacy devices. If you're using
> +``KVM``, you can disable the ``RTC``, making the Guest rely on
> +``kvmclock`` exclusively. Additionally, if your host's CPUs have the
> +``TSC_DEADLINE`` feature, you can also disable both the i8259 PIC and
> +the i8254 PIT (make sure you're also emulating a CPU with such feature
> +in the guest).
> +
> +This is an example of a VM with all optional legacy features
> +disabled::
> +
> +  $ qemu-system-x86_64 \
> +     -M microvm,x-option-roms=off,pit=off,pic=off,isa-serial=off,rtc=off \
> +     -enable-kvm -cpu host -m 512m -smp 2 \
> +     -kernel vmlinux -append "console=hvc0 root=/dev/vda" \
> +     -nodefaults -no-user-config -nographic \
> +     -chardev stdio,id=virtiocon0,server \
> +     -device virtio-serial-device \
> +     -device virtconsole,chardev=virtiocon0 \
> +     -drive id=test,file=test.img,format=raw,if=none \
> +     -device virtio-blk-device,drive=test \
> +     -netdev tap,id=tap0,script=no,downscript=no \
> +     -device virtio-net-device,netdev=tap0


