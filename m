Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB085C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D99217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D99217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho8EV-0007Y2-Ru
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 11:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46043)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1ho8EG-0006r1-Lj
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ho8ED-0008F1-Dz
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:21:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ho8ED-0008EB-2R
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:21:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so29117396wru.10
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 08:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=1n3klYO5/fLdUunu1OTfh7HtFGlP960jHSZvkJVjMHQ=;
 b=W6GvQsqiVEYVnwj2MYd1f2FQKL87LVkYfP8vUn7KU/iQ8ySlXClVway9ycYN77cRf8
 I6JO7mrd4LFhf4JGx0MySQgWOGOzlS4Ay5jD62yanG2sk7kmh/HJ6JAdrajX6o2U3fn1
 XovhMzYmvz6T8WD65ty80rkzt9rB2dAs+5D8eCtM6nASnd7GmVjTddf0GmqkWD00lL14
 3eAMCS8jDvdGjHGgHvm5MyfmuDdCxl00SfhPzaLagCtFTNCLpWpY5FzAosbqqB1ezhgs
 99t3DGnPWohn8jCkgVM82jH2jJ8X/BPmYVwva/iqshayMKDIHS+xd+Kga8lY9wgku12m
 G0ZA==
X-Gm-Message-State: APjAAAX1WfxMGV7vcCkL4CJxHpblf6xQYjstnrkE8TTft9dGxiwIU0sx
 rT5vupITcqJvMM7Nq1+L81ABjCYbwas=
X-Google-Smtp-Source: APXvYqwaaaZpFKPbEks5SVDejMB4JwVbgyg5gjSO3DVfkwe6KsyUmqNpD0SLzBi8MXw28QYIJaMVkQ==
X-Received: by 2002:a05:6000:11c6:: with SMTP id
 i6mr44679579wrx.193.1563463310887; 
 Thu, 18 Jul 2019 08:21:50 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id v5sm28912156wre.50.2019.07.18.08.21.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 08:21:48 -0700 (PDT)
References: <20190702121106.28374-1-slp@redhat.com>
 <20190703095825.GE11844@stefanha-x1.localdomain>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
In-reply-to: <20190703095825.GE11844@stefanha-x1.localdomain>
Date: Thu, 18 Jul 2019 17:21:46 +0200
Message-ID: <87d0i7tlkl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 sgarzare@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Jul 02, 2019 at 02:11:02PM +0200, Sergio Lopez wrote:
>> Microvm is a machine type inspired by both NEMU and Firecracker, and
>> constructed after the machine model implemented by the latter.
>>=20
>> It's main purpose is providing users a KVM-only machine type with fast
>> boot times, minimal attack surface (measured as the number of IO ports
>> and MMIO regions exposed to the Guest) and small footprint (specially
>> when combined with the ongoing QEMU modularization effort).
>>=20
>> Normally, other than the device support provided by KVM itself,
>> microvm only supports virtio-mmio devices. Microvm also includes a
>> legacy mode, which adds an ISA bus with a 16550A serial port, useful
>> for being able to see the early boot kernel messages.
>>=20
>> Microvm only supports booting PVH-enabled Linux ELF images. Booting
>> other PVH-enabled kernels may be possible, but due to the lack of ACPI
>> and firmware, we're relying on the command line for specifying the
>> location of the virtio-mmio transports. If there's an interest on
>> using this machine type with other kernels, we'll try to find some
>> kind of middle ground solution.
>>=20
>> This is the list of the exposed IO ports and MMIO regions when running
>> in non-legacy mode:
>>=20
>> address-space: memory
>>     00000000d0000000-00000000d00001ff (prio 0, i/o): virtio-mmio
>>     00000000d0000200-00000000d00003ff (prio 0, i/o): virtio-mmio
>>     00000000d0000400-00000000d00005ff (prio 0, i/o): virtio-mmio
>>     00000000d0000600-00000000d00007ff (prio 0, i/o): virtio-mmio
>>     00000000d0000800-00000000d00009ff (prio 0, i/o): virtio-mmio
>>     00000000d0000a00-00000000d0000bff (prio 0, i/o): virtio-mmio
>>     00000000d0000c00-00000000d0000dff (prio 0, i/o): virtio-mmio
>>     00000000d0000e00-00000000d0000fff (prio 0, i/o): virtio-mmio
>>     00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>>=20
>> address-space: I/O
>>   0000000000000000-000000000000ffff (prio 0, i/o): io
>>     0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
>>     0000000000000040-0000000000000043 (prio 0, i/o): kvm-pit
>>     000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
>>     00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
>>     00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
>>     00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
>>=20
>> A QEMU instance with the microvm machine type can be invoked this way:
>>=20
>>  - Normal mode:
>>=20
>> qemu-system-x86_64 -M microvm -m 512m -smp 2 \
>>  -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
>>  -nodefaults -no-user-config \
>>  -chardev pty,id=3Dvirtiocon0,server \
>>  -device virtio-serial-device \
>>  -device virtconsole,chardev=3Dvirtiocon0 \
>>  -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>>  -device virtio-blk-device,drive=3Dtest \
>>  -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
>>  -device virtio-net-device,netdev=3Dtap0
>>=20
>>  - Legacy mode:
>>=20
>> qemu-system-x86_64 -M microvm,legacy -m 512m -smp 2 \
>>  -kernel vmlinux -append "console=3DttyS0 root=3D/dev/vda" \
>>  -nodefaults -no-user-config \
>>  -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>>  -device virtio-blk-device,drive=3Dtest \
>>  -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
>>  -device virtio-net-device,netdev=3Dtap0 \
>>  -serial stdio
>
> Please post metrics that compare this against a minimal Q35.
>
> With qboot it was later found that SeaBIOS can achieve comparable boot
> times, so it wasn't worth maintaining qboot.
>
> Data is needed to show that microvm is really a significant improvement
> over a minimal Q35.

I've just ran some numbers using Stefano Garzarella's qemu-boot-time
scripts [1] on a server with 2xIntel Xeon Silver 4114 2.20GHz, using the
upstream QEMU (474f3938d79ab36b9231c9ad3b5a9314c2aeacde) built with
minimal features [2]. The VM boots a minimal kernel [3] without initrd,
using a kata container image as root via virtio-blk (though this isn't
really relevant, as we're just taking measurements until the kernel is
about to exec init).

To try to make the comparison as fair as possible, I've used a minimal
q35 machine with as few devices as possible. Disabling HPET and PIT at
the same time caused the kernel to get stuck on boot, so I ran two
iterations, one without HPET and the other without PIT:


=2D----------------
 | Q35 with HPET |
 -----------------

Command line:

./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M q35,smbus=3Doff,=
nvdimm=3Doff,pit=3Doff,vmport=3Doff,sata=3Doff,usb=3Doff,graphics=3Doff -ke=
rnel /root/src/images/vmlinux-5.2 -append "console=3Dhvc0 reboot=3Dk panic=
=3D1 root=3D/dev/vda quiet" -smp 1 -nodefaults -no-user-config -chardev pty=
,id=3Dvirtiocon0,server -device virtio-serial -device virtconsole,chardev=
=3Dvirtiocon0 -drive id=3Dtest,file=3D/root/src/images/hello-rootfs.ext4,fo=
rmat=3Draw,if=3Dnone -device virtio-blk,drive=3Dtest

Average boot times after 10 consecutive runs:

 qemu_init_end: 77.637936
 linux_start_kernel: 117.082526 (+39.44459)
 linux_start_user: 364.629972 (+247.547446)

Memory tree:

 address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g @pc=
.ram 0000000000000000-000000001fffffff
    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
      00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
      00000000000e0000-00000000000fffff (prio 1, i/o): alias isa-bios @pc.b=
ios 0000000000020000-000000000003ffff
      00000000febf4000-00000000febf7fff (prio 1, i/o): virtio-pci
        00000000febf4000-00000000febf4fff (prio 0, i/o): virtio-pci-common
        00000000febf5000-00000000febf5fff (prio 0, i/o): virtio-pci-isr
        00000000febf6000-00000000febf6fff (prio 0, i/o): virtio-pci-device
        00000000febf7000-00000000febf7fff (prio 0, i/o): virtio-pci-notify
      00000000febf8000-00000000febfbfff (prio 1, i/o): virtio-pci
        00000000febf8000-00000000febf8fff (prio 0, i/o): virtio-pci-common
        00000000febf9000-00000000febf9fff (prio 0, i/o): virtio-pci-isr
        00000000febfa000-00000000febfafff (prio 0, i/o): virtio-pci-device
        00000000febfb000-00000000febfbfff (prio 0, i/o): virtio-pci-notify
      00000000febfe000-00000000febfefff (prio 1, i/o): virtio-serial-pci-ms=
ix
        00000000febfe000-00000000febfe01f (prio 0, i/o): msix-table
        00000000febfe800-00000000febfe807 (prio 0, i/o): msix-pba
      00000000febff000-00000000febfffff (prio 1, i/o): virtio-blk-pci-msix
        00000000febff000-00000000febff01f (prio 0, i/o): msix-table
        00000000febff800-00000000febff807 (prio 0, i/o): msix-pba
      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
    00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pc=
i 00000000000a0000-00000000000bffff
    00000000000c0000-00000000000c2fff (prio 1000, i/o): alias kvmvapic-rom =
@pc.ram 00000000000c0000-00000000000c2fff
    00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000c0000-00000000000c3fff [disabled]
    00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000c0000-00000000000c3fff [disabled]
    00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000c0000-00000000000c3fff
    00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 000=
00000000c0000-00000000000c3fff [disabled]
    00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000c4000-00000000000c7fff [disabled]
    00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000c4000-00000000000c7fff [disabled]
    00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000c4000-00000000000c7fff
    00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 000=
00000000c4000-00000000000c7fff [disabled]
    00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000c8000-00000000000cbfff [disabled]
    00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000c8000-00000000000cbfff [disabled]
    00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000c8000-00000000000cbfff
    00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci 000=
00000000c8000-00000000000cbfff [disabled]
    00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000cc000-00000000000cffff [disabled]
    00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000cc000-00000000000cffff [disabled]
    00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000cc000-00000000000cffff
    00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci 000=
00000000cc000-00000000000cffff [disabled]
    00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000d0000-00000000000d3fff [disabled]
    00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000d0000-00000000000d3fff [disabled]
    00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000d0000-00000000000d3fff
    00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci 000=
00000000d0000-00000000000d3fff [disabled]
    00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000d4000-00000000000d7fff [disabled]
    00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000d4000-00000000000d7fff [disabled]
    00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000d4000-00000000000d7fff
    00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci 000=
00000000d4000-00000000000d7fff [disabled]
    00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000d8000-00000000000dbfff [disabled]
    00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000d8000-00000000000dbfff [disabled]
    00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000d8000-00000000000dbfff
    00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci 000=
00000000d8000-00000000000dbfff [disabled]
    00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000dc000-00000000000dffff [disabled]
    00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000dc000-00000000000dffff [disabled]
    00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000dc000-00000000000dffff
    00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci 000=
00000000dc000-00000000000dffff [disabled]
    00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000e0000-00000000000e3fff [disabled]
    00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000e0000-00000000000e3fff [disabled]
    00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000e0000-00000000000e3fff
    00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci 000=
00000000e0000-00000000000e3fff [disabled]
    00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000e4000-00000000000e7fff [disabled]
    00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000e4000-00000000000e7fff [disabled]
    00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000e4000-00000000000e7fff
    00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci 000=
00000000e4000-00000000000e7fff [disabled]
    00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000e8000-00000000000ebfff
    00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000e8000-00000000000ebfff [disabled]
    00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000e8000-00000000000ebfff [disabled]
    00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci 000=
00000000e8000-00000000000ebfff [disabled]
    00000000000ec000-00000000000effff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000ec000-00000000000effff
    00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000ec000-00000000000effff [disabled]
    00000000000ec000-00000000000effff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000ec000-00000000000effff [disabled]
    00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci 000=
00000000ec000-00000000000effff [disabled]
    00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000f0000-00000000000fffff [disabled]
    00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000f0000-00000000000fffff [disabled]
    00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000f0000-00000000000fffff
    00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci 000=
00000000f0000-00000000000fffff [disabled]
    0000000020000000-0000000020000000 (prio 1, i/o): tseg-blackhole [disabl=
ed]
    00000000b0000000-00000000bfffffff (prio 0, i/o): pcie-mmcfg-mmio
    00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
    00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
    00000000fed1c000-00000000fed1ffff (prio 1, i/o): lpc-rcrb-mmio
    00000000feda0000-00000000fedbffff (prio 1, i/o): alias smram-open-high =
@pc.ram 00000000000a0000-00000000000bffff [disabled]
    00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi

 address-space: I/O
  0000000000000000-000000000000ffff (prio 0, i/o): io
    0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
    0000000000000008-000000000000000f (prio 0, i/o): dma-cont
    0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
    0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
    0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
    0000000000000070-0000000000000071 (prio 0, i/o): rtc
      0000000000000070-0000000000000070 (prio 0, i/o): rtc-index
    000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
    0000000000000080-0000000000000080 (prio 0, i/o): ioport80
    0000000000000081-0000000000000083 (prio 0, i/o): dma-page
    0000000000000087-0000000000000087 (prio 0, i/o): dma-page
    0000000000000089-000000000000008b (prio 0, i/o): dma-page
    000000000000008f-000000000000008f (prio 0, i/o): dma-page
    0000000000000092-0000000000000092 (prio 0, i/o): port92
    00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
    00000000000000b2-00000000000000b3 (prio 0, i/o): apm-io
    00000000000000c0-00000000000000cf (prio 0, i/o): dma-chan
    00000000000000d0-00000000000000df (prio 0, i/o): dma-cont
    00000000000000f0-00000000000000f0 (prio 0, i/o): ioportF0
    00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
    00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
    0000000000000510-0000000000000511 (prio 0, i/o): fwcfg
    0000000000000514-000000000000051b (prio 0, i/o): fwcfg.dma
    0000000000000600-000000000000067f (prio 0, i/o): ich9-pm
      0000000000000600-0000000000000603 (prio 0, i/o): acpi-evt
      0000000000000604-0000000000000605 (prio 0, i/o): acpi-cnt
      0000000000000608-000000000000060b (prio 0, i/o): acpi-tmr
      0000000000000620-000000000000062f (prio 0, i/o): acpi-gpe0
      0000000000000630-0000000000000637 (prio 0, i/o): acpi-smi
      0000000000000660-000000000000067f (prio 0, i/o): sm-tco
    0000000000000cd8-0000000000000ce3 (prio 0, i/o): acpi-mem-hotplug
    0000000000000cf8-0000000000000cfb (prio 0, i/o): pci-conf-idx
    0000000000000cf9-0000000000000cf9 (prio 1, i/o): lpc-reset-control
    0000000000000cfc-0000000000000cff (prio 0, i/o): pci-conf-data
    000000000000c000-000000000000c07f (prio 1, i/o): virtio-pci
    000000000000c080-000000000000c0bf (prio 1, i/o): virtio-pci


 ----------------
 | Q35 with PIT |
 ----------------

Command line:

./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M q35,smbus=3Doff,=
nvdimm=3Doff,pit=3Don,vmport=3Doff,sata=3Doff,usb=3Doff,graphics=3Doff -no-=
hpet -kernel /root/src/images/vmlinux-5.2 -append "console=3Dhvc0 reboot=3D=
k panic=3D1 root=3D/dev/vda quiet" -smp 1 -nodefaults -no-user-config -char=
dev pty,id=3Dvirtiocon0,server -device virtio-serial -device virtconsole,ch=
ardev=3Dvirtiocon0 -drive id=3Dtest,file=3D/root/src/images/hello-rootfs.ex=
t4,format=3Draw,if=3Dnone -device virtio-blk,drive=3Dtest

Average boot times after 10 consecutive runs:

 qemu_init_end: 77.467852
 linux_start_kernel: 116.688472 (+39.22062)
 linux_start_user: 363.033365 (+246.344893)

Memory tree:

address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g @pc=
.ram 0000000000000000-000000001fffffff
    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
      00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
      00000000000e0000-00000000000fffff (prio 1, i/o): alias isa-bios @pc.b=
ios 0000000000020000-000000000003ffff
      00000000febf4000-00000000febf7fff (prio 1, i/o): virtio-pci
        00000000febf4000-00000000febf4fff (prio 0, i/o): virtio-pci-common
        00000000febf5000-00000000febf5fff (prio 0, i/o): virtio-pci-isr
        00000000febf6000-00000000febf6fff (prio 0, i/o): virtio-pci-device
        00000000febf7000-00000000febf7fff (prio 0, i/o): virtio-pci-notify
      00000000febf8000-00000000febfbfff (prio 1, i/o): virtio-pci
        00000000febf8000-00000000febf8fff (prio 0, i/o): virtio-pci-common
        00000000febf9000-00000000febf9fff (prio 0, i/o): virtio-pci-isr
        00000000febfa000-00000000febfafff (prio 0, i/o): virtio-pci-device
        00000000febfb000-00000000febfbfff (prio 0, i/o): virtio-pci-notify
      00000000febfe000-00000000febfefff (prio 1, i/o): virtio-serial-pci-ms=
ix
        00000000febfe000-00000000febfe01f (prio 0, i/o): msix-table
        00000000febfe800-00000000febfe807 (prio 0, i/o): msix-pba
      00000000febff000-00000000febfffff (prio 1, i/o): virtio-blk-pci-msix
        00000000febff000-00000000febff01f (prio 0, i/o): msix-table
        00000000febff800-00000000febff807 (prio 0, i/o): msix-pba
      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
    00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pc=
i 00000000000a0000-00000000000bffff
    00000000000c0000-00000000000c2fff (prio 1000, i/o): alias kvmvapic-rom =
@pc.ram 00000000000c0000-00000000000c2fff
    00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000c0000-00000000000c3fff [disabled]
    00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000c0000-00000000000c3fff [disabled]
    00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000c0000-00000000000c3fff
    00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 000=
00000000c0000-00000000000c3fff [disabled]
    00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000c4000-00000000000c7fff [disabled]
    00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000c4000-00000000000c7fff [disabled]
    00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000c4000-00000000000c7fff
    00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 000=
00000000c4000-00000000000c7fff [disabled]
    00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000c8000-00000000000cbfff [disabled]
    00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000c8000-00000000000cbfff [disabled]
    00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000c8000-00000000000cbfff
    00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci 000=
00000000c8000-00000000000cbfff [disabled]
    00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000cc000-00000000000cffff [disabled]
    00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000cc000-00000000000cffff [disabled]
    00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000cc000-00000000000cffff
    00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci 000=
00000000cc000-00000000000cffff [disabled]
    00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000d0000-00000000000d3fff [disabled]
    00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000d0000-00000000000d3fff [disabled]
    00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000d0000-00000000000d3fff
    00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci 000=
00000000d0000-00000000000d3fff [disabled]
    00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000d4000-00000000000d7fff [disabled]
    00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000d4000-00000000000d7fff [disabled]
    00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000d4000-00000000000d7fff
    00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci 000=
00000000d4000-00000000000d7fff [disabled]
    00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000d8000-00000000000dbfff [disabled]
    00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000d8000-00000000000dbfff [disabled]
    00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000d8000-00000000000dbfff
    00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci 000=
00000000d8000-00000000000dbfff [disabled]
    00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000dc000-00000000000dffff [disabled]
    00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000dc000-00000000000dffff [disabled]
    00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000dc000-00000000000dffff
    00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci 000=
00000000dc000-00000000000dffff [disabled]
    00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000e0000-00000000000e3fff [disabled]
    00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000e0000-00000000000e3fff [disabled]
    00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000e0000-00000000000e3fff
    00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci 000=
00000000e0000-00000000000e3fff [disabled]
    00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000e4000-00000000000e7fff [disabled]
    00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000e4000-00000000000e7fff [disabled]
    00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000e4000-00000000000e7fff
    00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci 000=
00000000e4000-00000000000e7fff [disabled]
    00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000e8000-00000000000ebfff
    00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000e8000-00000000000ebfff [disabled]
    00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000e8000-00000000000ebfff [disabled]
    00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci 000=
00000000e8000-00000000000ebfff [disabled]
    00000000000ec000-00000000000effff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000ec000-00000000000effff
    00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000ec000-00000000000effff [disabled]
    00000000000ec000-00000000000effff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000ec000-00000000000effff [disabled]
    00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci 000=
00000000ec000-00000000000effff [disabled]
    00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-ram @pc.ram =
00000000000f0000-00000000000fffff [disabled]
    00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pc.ram =
00000000000f0000-00000000000fffff [disabled]
    00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-rom @pc.ram =
00000000000f0000-00000000000fffff
    00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci 000=
00000000f0000-00000000000fffff [disabled]
    0000000020000000-0000000020000000 (prio 1, i/o): tseg-blackhole [disabl=
ed]
    00000000b0000000-00000000bfffffff (prio 0, i/o): pcie-mmcfg-mmio
    00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
    00000000fed1c000-00000000fed1ffff (prio 1, i/o): lpc-rcrb-mmio
    00000000feda0000-00000000fedbffff (prio 1, i/o): alias smram-open-high =
@pc.ram 00000000000a0000-00000000000bffff [disabled]
    00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi

address-space: I/O
  0000000000000000-000000000000ffff (prio 0, i/o): io
    0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
    0000000000000008-000000000000000f (prio 0, i/o): dma-cont
    0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
    0000000000000040-0000000000000043 (prio 0, i/o): kvm-pit
    0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
    0000000000000061-0000000000000061 (prio 0, i/o): pcspk
    0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
    0000000000000070-0000000000000071 (prio 0, i/o): rtc
      0000000000000070-0000000000000070 (prio 0, i/o): rtc-index
    000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
    0000000000000080-0000000000000080 (prio 0, i/o): ioport80
    0000000000000081-0000000000000083 (prio 0, i/o): dma-page
    0000000000000087-0000000000000087 (prio 0, i/o): dma-page
    0000000000000089-000000000000008b (prio 0, i/o): dma-page
    000000000000008f-000000000000008f (prio 0, i/o): dma-page
    0000000000000092-0000000000000092 (prio 0, i/o): port92
    00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
    00000000000000b2-00000000000000b3 (prio 0, i/o): apm-io
    00000000000000c0-00000000000000cf (prio 0, i/o): dma-chan
    00000000000000d0-00000000000000df (prio 0, i/o): dma-cont
    00000000000000f0-00000000000000f0 (prio 0, i/o): ioportF0
    00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
    00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
    0000000000000510-0000000000000511 (prio 0, i/o): fwcfg
    0000000000000514-000000000000051b (prio 0, i/o): fwcfg.dma
    0000000000000600-000000000000067f (prio 0, i/o): ich9-pm
      0000000000000600-0000000000000603 (prio 0, i/o): acpi-evt
      0000000000000604-0000000000000605 (prio 0, i/o): acpi-cnt
      0000000000000608-000000000000060b (prio 0, i/o): acpi-tmr
      0000000000000620-000000000000062f (prio 0, i/o): acpi-gpe0
      0000000000000630-0000000000000637 (prio 0, i/o): acpi-smi
      0000000000000660-000000000000067f (prio 0, i/o): sm-tco
    0000000000000cd8-0000000000000ce3 (prio 0, i/o): acpi-mem-hotplug
    0000000000000cf8-0000000000000cfb (prio 0, i/o): pci-conf-idx
    0000000000000cf9-0000000000000cf9 (prio 1, i/o): lpc-reset-control
    0000000000000cfc-0000000000000cff (prio 0, i/o): pci-conf-data
    000000000000c000-000000000000c07f (prio 1, i/o): virtio-pci
    000000000000c080-000000000000c0bf (prio 1, i/o): virtio-pci


 -----------
 | microvm |
 -----------

Command line:

./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M microvm -kernel =
/root/src/images/vmlinux-5.2 -append "console=3Dhvc0 reboot=3Dk panic=3D1 r=
oot=3D/dev/vda quiet" -smp 1 -nodefaults -no-user-config -chardev pty,id=3D=
virtiocon0,server -device virtio-serial-device -device virtconsole,chardev=
=3Dvirtiocon0 -drive id=3Dtest,file=3D/root/src/images/hello-rootfs.ext4,fo=
rmat=3Draw,if=3Dnone -device virtio-blk-device,drive=3Dtest

Average boot times after 10 consecutive runs:

 qemu_init_end: 64.043264
 linux_start_kernel: 65.481782 (+1.438518)
 linux_start_user: 114.938353 (+49.456571)

Memory tree:

 address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g @mi=
crovm.ram 0000000000000000-000000001fffffff
    00000000d0000000-00000000d00001ff (prio 0, i/o): virtio-mmio
    00000000d0000200-00000000d00003ff (prio 0, i/o): virtio-mmio
    00000000d0000400-00000000d00005ff (prio 0, i/o): virtio-mmio
    00000000d0000600-00000000d00007ff (prio 0, i/o): virtio-mmio
    00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
    00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi

 address-space: I/O
  0000000000000000-000000000000ffff (prio 0, i/o): io
    000000000000007e-000000000000007f (prio 0, i/o): kvmvapic


 --------------
 | Conclusion |
 --------------

The average boot time of microvm is a third of Q35's (115ms vs. 363ms),
and is smaller on all sections (QEMU initialization, firmware overhead
and kernel start-to-user).

Microvm's memory tree is also visibly simpler, significantly reducing
the exposed surface to the guest.

While we can certainly work on making Q35 smaller, I definitely think
it's better (and way safer!) having a specialized machine type for a
specific use case, than a minimal Q35 whose behavior significantly
diverges from a conventional Q35.

Sergio.

[1] https://github.com/stefano-garzarella/qemu-boot-time
[2] https://paste.fedoraproject.org/paste/YZ9Ok-dJtQrc0xxctFm-nw
[3] https://paste.fedoraproject.org/paste/sck0jfioAJdMq51HH6wkmA

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0wjooACgkQ9GknjS8M
AjWuJhAAns1QQuLoyofvS8SuwZZeLlIuPrRgiG/EAobqJ/BEXuxAV9kRMN8kTgn7
V+YQE12UojWcAM98UlviC8E/gvEDl8lrWxiu9aN3VIc9g++CvIbxUFNF+LUL7Xo6
mkFTPf2Tv1M3KxkvBFCsfXDreJv/wNLbGsOtqTyI0mJ3nQHXs3SN4vdC4RU2M175
xUzD96MMJwSL8Yu+ybMp6sGUdTQtJAkGvZcNA2di9EIa47Q3pr/tmCi6DBw3cbS6
Nswv4xqHSGb1rF2fzWyjQublyR4QGSIWUmh+OiyfpdaAhTQ14c1N5RWwmuuQxdaH
MBl+McgUESPpK01vTDnyNG8HuMdeDiOa2hiYxChNhHZuX52g6cfvNuv3vsDErgpi
bwdhrhZwV0FTqUeZJJgguBSZvbCZQqFMTyIbqMTiJlcz1n5irEqQMCYnPdfTZxKl
QwO3xc4JRMKbcoLsf/M+zLEulQjrKe9NBmZdLLP3HgcWQs/B3O99JLVNY0kITg/k
FB4RTOcdmVuGmNNQCm0scEMG9wKR7CJuRRANl9yUPnHf8bDdTaDI//APMsPPZtXW
CXmDP8/6OYed19LtPvQMBMayomZlGzwoqDW7WS9Fo71xnNYpELrw0YqyztMD3dso
splR8RPqhU1K3b8GKuuCq8aA9DMSb3XMHwLADYMkknV6phKUlbE=
=su64
-----END PGP SIGNATURE-----
--=-=-=--

