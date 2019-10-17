Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA6CECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556022082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556022082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL3Yt-0005ak-8e
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 07:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iL3Wr-0004nJ-Jh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iL3Wm-0004Kl-6o
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iL3Wl-0004KP-Uf
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:01:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21A0D7FDC9;
 Thu, 17 Oct 2019 11:01:07 +0000 (UTC)
Received: from redhat.com (ovpn-112-36.ams2.redhat.com [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 668881001E75;
 Thu, 17 Oct 2019 11:00:53 +0000 (UTC)
Date: Thu, 17 Oct 2019 12:00:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v10 13/15] docs/microvm.rst: document the new microvm
 machine type
Message-ID: <20191017110051.GH31072@redhat.com>
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-14-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016101241.24405-14-slp@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 17 Oct 2019 11:01:07 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: ehabkost@redhat.com, mst@redhat.com, philmd@redhat.com, groug@kaod.org,
 qemu-devel@nongnu.org, kraxel@redhat.com, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 12:12:40PM +0200, Sergio Lopez wrote:
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
> index 0000000000..0aab55576c
> --- /dev/null
> +++ b/docs/microvm.rst
> @@ -0,0 +1,98 @@
> +====================
> +microvm Machine Type
> +====================
> +
> +``microvm`` is a machine type inspired by ``Firecracker`` and
> +constructed after its machine model.
> +
> +It's a minimalist machine type without ``PCI`` nor ``ACPI`` support,
> +designed for short-lived guests. microvm also establishes a baseline
> +for benchmarking and optimizing both QEMU and guest operating systems,
> +since it is optimized for both boot time and footprint.

I'm wondering about live migration support across QEMU versions.

IIUC, this is not intended to be a versioned machined type, so
live migration won't be supportable across QEMU versions.

Given that its for short lived guests, this shouldn't be an
issue, but it might be worth saying something explicit here
about migration to avoid any risk of misunderstanding.

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
> -- 
> 2.21.0
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

