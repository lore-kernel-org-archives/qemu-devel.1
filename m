Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48444C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D37B2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D37B2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoTFu-0000SR-6x
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41769)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hoTFf-0008UW-JI
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hoTFc-0006iB-DG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:48:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hoTFc-0006hV-2U
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:48:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so32305972wrf.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 06:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=GE5vRZPS0+hEW+bLdvnJHdRYEnnkqB4hVVipvEhzx+M=;
 b=T30GH8IT46wXAn5gvDdYEBAuvsjvKoYEqOU/2MxNe14Yy2zR2BHea+Dj83sCJP5rjn
 52LkfyF1GbBKZ1OA+SLaDojDWOxK0AvKe8+ICc7p75kYtZ1+QQnYf41rFtn0GZRwaD9z
 MA83UTYPtlDmVnrdbXSmrmyv7lWA6LuNmEdX7LG/0FDmvA295dKSu3tuo7A1WGo/P8im
 dHCZcgWn7B+hWImmhCVRoFtMxUYQqV1cnWE0AS50Rgoo9QYWAOFhXiI+InHwVCzGttef
 aSFdjRSrrusu1NjrljITZlDZElXfh+0ENBabKuplLyK/AxOzKitrov2DADGNevJhlXUM
 Xwhw==
X-Gm-Message-State: APjAAAVf3Wkp6P9OWHWbBZnr4YiDl7ljeiJTS/Fq5iF3w/KB+ksxDmt5
 8p9fgUkCaMfDXOz4xPnOwdjbGfGO6/s=
X-Google-Smtp-Source: APXvYqxrXscASSoVbGy9cryzINjSjKpjsH2JxHkqpVmXcoRxXakrite83h2Ri3zeosWvl/LvpevqZQ==
X-Received: by 2002:adf:b612:: with SMTP id f18mr45424038wre.97.1563544122461; 
 Fri, 19 Jul 2019 06:48:42 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id w7sm37863977wrn.11.2019.07.19.06.48.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:48:41 -0700 (PDT)
References: <20190702121106.28374-1-slp@redhat.com>
 <20190703095825.GE11844@stefanha-x1.localdomain> <87d0i7tlkl.fsf@redhat.com>
 <20190719102915.GG18585@stefanha-x1.localdomain>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
In-reply-to: <20190719102915.GG18585@stefanha-x1.localdomain>
Date: Fri, 19 Jul 2019 15:48:39 +0200
Message-ID: <8736j2p22w.fsf@redhat.com>
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

> On Thu, Jul 18, 2019 at 05:21:46PM +0200, Sergio Lopez wrote:
>>=20
>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>>=20
>> > On Tue, Jul 02, 2019 at 02:11:02PM +0200, Sergio Lopez wrote:
>> >> Microvm is a machine type inspired by both NEMU and Firecracker, and
>> >> constructed after the machine model implemented by the latter.
>> >>=20
>> >> It's main purpose is providing users a KVM-only machine type with fast
>> >> boot times, minimal attack surface (measured as the number of IO ports
>> >> and MMIO regions exposed to the Guest) and small footprint (specially
>> >> when combined with the ongoing QEMU modularization effort).
>> >>=20
>> >> Normally, other than the device support provided by KVM itself,
>> >> microvm only supports virtio-mmio devices. Microvm also includes a
>> >> legacy mode, which adds an ISA bus with a 16550A serial port, useful
>> >> for being able to see the early boot kernel messages.
>> >>=20
>> >> Microvm only supports booting PVH-enabled Linux ELF images. Booting
>> >> other PVH-enabled kernels may be possible, but due to the lack of ACPI
>> >> and firmware, we're relying on the command line for specifying the
>> >> location of the virtio-mmio transports. If there's an interest on
>> >> using this machine type with other kernels, we'll try to find some
>> >> kind of middle ground solution.
>> >>=20
>> >> This is the list of the exposed IO ports and MMIO regions when running
>> >> in non-legacy mode:
>> >>=20
>> >> address-space: memory
>> >>     00000000d0000000-00000000d00001ff (prio 0, i/o): virtio-mmio
>> >>     00000000d0000200-00000000d00003ff (prio 0, i/o): virtio-mmio
>> >>     00000000d0000400-00000000d00005ff (prio 0, i/o): virtio-mmio
>> >>     00000000d0000600-00000000d00007ff (prio 0, i/o): virtio-mmio
>> >>     00000000d0000800-00000000d00009ff (prio 0, i/o): virtio-mmio
>> >>     00000000d0000a00-00000000d0000bff (prio 0, i/o): virtio-mmio
>> >>     00000000d0000c00-00000000d0000dff (prio 0, i/o): virtio-mmio
>> >>     00000000d0000e00-00000000d0000fff (prio 0, i/o): virtio-mmio
>> >>     00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>> >>=20
>> >> address-space: I/O
>> >>   0000000000000000-000000000000ffff (prio 0, i/o): io
>> >>     0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
>> >>     0000000000000040-0000000000000043 (prio 0, i/o): kvm-pit
>> >>     000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
>> >>     00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
>> >>     00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
>> >>     00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
>> >>=20
>> >> A QEMU instance with the microvm machine type can be invoked this way:
>> >>=20
>> >>  - Normal mode:
>> >>=20
>> >> qemu-system-x86_64 -M microvm -m 512m -smp 2 \
>> >>  -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
>> >>  -nodefaults -no-user-config \
>> >>  -chardev pty,id=3Dvirtiocon0,server \
>> >>  -device virtio-serial-device \
>> >>  -device virtconsole,chardev=3Dvirtiocon0 \
>> >>  -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>> >>  -device virtio-blk-device,drive=3Dtest \
>> >>  -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
>> >>  -device virtio-net-device,netdev=3Dtap0
>> >>=20
>> >>  - Legacy mode:
>> >>=20
>> >> qemu-system-x86_64 -M microvm,legacy -m 512m -smp 2 \
>> >>  -kernel vmlinux -append "console=3DttyS0 root=3D/dev/vda" \
>> >>  -nodefaults -no-user-config \
>> >>  -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>> >>  -device virtio-blk-device,drive=3Dtest \
>> >>  -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
>> >>  -device virtio-net-device,netdev=3Dtap0 \
>> >>  -serial stdio
>> >
>> > Please post metrics that compare this against a minimal Q35.
>> >
>> > With qboot it was later found that SeaBIOS can achieve comparable boot
>> > times, so it wasn't worth maintaining qboot.
>> >
>> > Data is needed to show that microvm is really a significant improvement
>> > over a minimal Q35.
>>=20
>> I've just ran some numbers using Stefano Garzarella's qemu-boot-time
>> scripts [1] on a server with 2xIntel Xeon Silver 4114 2.20GHz, using the
>> upstream QEMU (474f3938d79ab36b9231c9ad3b5a9314c2aeacde) built with
>> minimal features [2]. The VM boots a minimal kernel [3] without initrd,
>> using a kata container image as root via virtio-blk (though this isn't
>> really relevant, as we're just taking measurements until the kernel is
>> about to exec init).
>>=20
>> To try to make the comparison as fair as possible, I've used a minimal
>> q35 machine with as few devices as possible. Disabling HPET and PIT at
>> the same time caused the kernel to get stuck on boot, so I ran two
>> iterations, one without HPET and the other without PIT:
>>=20
>>=20
>> -----------------
>>  | Q35 with HPET |
>>  -----------------
>>=20
>> Command line:
>>=20
>> ./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M q35,smbus=3Do=
ff,nvdimm=3Doff,pit=3Doff,vmport=3Doff,sata=3Doff,usb=3Doff,graphics=3Doff =
-kernel /root/src/images/vmlinux-5.2 -append "console=3Dhvc0 reboot=3Dk pan=
ic=3D1 root=3D/dev/vda quiet" -smp 1 -nodefaults -no-user-config -chardev p=
ty,id=3Dvirtiocon0,server -device virtio-serial -device virtconsole,chardev=
=3Dvirtiocon0 -drive id=3Dtest,file=3D/root/src/images/hello-rootfs.ext4,fo=
rmat=3Draw,if=3Dnone -device virtio-blk,drive=3Dtest
>>=20
>> Average boot times after 10 consecutive runs:
>>=20
>>  qemu_init_end: 77.637936
>>  linux_start_kernel: 117.082526 (+39.44459)
>>  linux_start_user: 364.629972 (+247.547446)
>>=20
>> Memory tree:
>>=20
>>  address-space: memory
>>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>     0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g =
@pc.ram 0000000000000000-000000001fffffff
>>     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>       00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>>       00000000000e0000-00000000000fffff (prio 1, i/o): alias isa-bios @p=
c.bios 0000000000020000-000000000003ffff
>>       00000000febf4000-00000000febf7fff (prio 1, i/o): virtio-pci
>>         00000000febf4000-00000000febf4fff (prio 0, i/o): virtio-pci-comm=
on
>>         00000000febf5000-00000000febf5fff (prio 0, i/o): virtio-pci-isr
>>         00000000febf6000-00000000febf6fff (prio 0, i/o): virtio-pci-devi=
ce
>>         00000000febf7000-00000000febf7fff (prio 0, i/o): virtio-pci-noti=
fy
>>       00000000febf8000-00000000febfbfff (prio 1, i/o): virtio-pci
>>         00000000febf8000-00000000febf8fff (prio 0, i/o): virtio-pci-comm=
on
>>         00000000febf9000-00000000febf9fff (prio 0, i/o): virtio-pci-isr
>>         00000000febfa000-00000000febfafff (prio 0, i/o): virtio-pci-devi=
ce
>>         00000000febfb000-00000000febfbfff (prio 0, i/o): virtio-pci-noti=
fy
>>       00000000febfe000-00000000febfefff (prio 1, i/o): virtio-serial-pci=
-msix
>>         00000000febfe000-00000000febfe01f (prio 0, i/o): msix-table
>>         00000000febfe800-00000000febfe807 (prio 0, i/o): msix-pba
>>       00000000febff000-00000000febfffff (prio 1, i/o): virtio-blk-pci-ms=
ix
>>         00000000febff000-00000000febff01f (prio 0, i/o): msix-table
>>         00000000febff800-00000000febff807 (prio 0, i/o): msix-pba
>>       00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>     00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region =
@pci 00000000000a0000-00000000000bffff
>>     00000000000c0000-00000000000c2fff (prio 1000, i/o): alias kvmvapic-r=
om @pc.ram 00000000000c0000-00000000000c2fff
>>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000c0000-00000000000c3fff [disabled]
>>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000c0000-00000000000c3fff [disabled]
>>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000c0000-00000000000c3fff
>>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci =
00000000000c0000-00000000000c3fff [disabled]
>>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000c4000-00000000000c7fff [disabled]
>>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000c4000-00000000000c7fff [disabled]
>>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000c4000-00000000000c7fff
>>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci =
00000000000c4000-00000000000c7fff [disabled]
>>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000c8000-00000000000cbfff [disabled]
>>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000c8000-00000000000cbfff [disabled]
>>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000c8000-00000000000cbfff
>>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci =
00000000000c8000-00000000000cbfff [disabled]
>>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000cc000-00000000000cffff [disabled]
>>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000cc000-00000000000cffff [disabled]
>>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000cc000-00000000000cffff
>>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci =
00000000000cc000-00000000000cffff [disabled]
>>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000d0000-00000000000d3fff [disabled]
>>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000d0000-00000000000d3fff [disabled]
>>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000d0000-00000000000d3fff
>>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci =
00000000000d0000-00000000000d3fff [disabled]
>>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000d4000-00000000000d7fff [disabled]
>>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000d4000-00000000000d7fff [disabled]
>>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000d4000-00000000000d7fff
>>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci =
00000000000d4000-00000000000d7fff [disabled]
>>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000d8000-00000000000dbfff [disabled]
>>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000d8000-00000000000dbfff [disabled]
>>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000d8000-00000000000dbfff
>>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci =
00000000000d8000-00000000000dbfff [disabled]
>>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000dc000-00000000000dffff [disabled]
>>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000dc000-00000000000dffff [disabled]
>>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000dc000-00000000000dffff
>>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci =
00000000000dc000-00000000000dffff [disabled]
>>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000e0000-00000000000e3fff [disabled]
>>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000e0000-00000000000e3fff [disabled]
>>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000e0000-00000000000e3fff
>>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci =
00000000000e0000-00000000000e3fff [disabled]
>>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000e4000-00000000000e7fff [disabled]
>>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000e4000-00000000000e7fff [disabled]
>>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000e4000-00000000000e7fff
>>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci =
00000000000e4000-00000000000e7fff [disabled]
>>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000e8000-00000000000ebfff
>>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000e8000-00000000000ebfff [disabled]
>>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000e8000-00000000000ebfff [disabled]
>>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci =
00000000000e8000-00000000000ebfff [disabled]
>>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000ec000-00000000000effff
>>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000ec000-00000000000effff [disabled]
>>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000ec000-00000000000effff [disabled]
>>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci =
00000000000ec000-00000000000effff [disabled]
>>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000f0000-00000000000fffff [disabled]
>>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000f0000-00000000000fffff [disabled]
>>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000f0000-00000000000fffff
>>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci =
00000000000f0000-00000000000fffff [disabled]
>>     0000000020000000-0000000020000000 (prio 1, i/o): tseg-blackhole [dis=
abled]
>>     00000000b0000000-00000000bfffffff (prio 0, i/o): pcie-mmcfg-mmio
>>     00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>>     00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>>     00000000fed1c000-00000000fed1ffff (prio 1, i/o): lpc-rcrb-mmio
>>     00000000feda0000-00000000fedbffff (prio 1, i/o): alias smram-open-hi=
gh @pc.ram 00000000000a0000-00000000000bffff [disabled]
>>     00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>>=20
>>  address-space: I/O
>>   0000000000000000-000000000000ffff (prio 0, i/o): io
>>     0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
>>     0000000000000008-000000000000000f (prio 0, i/o): dma-cont
>>     0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
>>     0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
>>     0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
>>     0000000000000070-0000000000000071 (prio 0, i/o): rtc
>>       0000000000000070-0000000000000070 (prio 0, i/o): rtc-index
>>     000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
>>     0000000000000080-0000000000000080 (prio 0, i/o): ioport80
>>     0000000000000081-0000000000000083 (prio 0, i/o): dma-page
>>     0000000000000087-0000000000000087 (prio 0, i/o): dma-page
>>     0000000000000089-000000000000008b (prio 0, i/o): dma-page
>>     000000000000008f-000000000000008f (prio 0, i/o): dma-page
>>     0000000000000092-0000000000000092 (prio 0, i/o): port92
>>     00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
>>     00000000000000b2-00000000000000b3 (prio 0, i/o): apm-io
>>     00000000000000c0-00000000000000cf (prio 0, i/o): dma-chan
>>     00000000000000d0-00000000000000df (prio 0, i/o): dma-cont
>>     00000000000000f0-00000000000000f0 (prio 0, i/o): ioportF0
>>     00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
>>     00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
>>     0000000000000510-0000000000000511 (prio 0, i/o): fwcfg
>>     0000000000000514-000000000000051b (prio 0, i/o): fwcfg.dma
>>     0000000000000600-000000000000067f (prio 0, i/o): ich9-pm
>>       0000000000000600-0000000000000603 (prio 0, i/o): acpi-evt
>>       0000000000000604-0000000000000605 (prio 0, i/o): acpi-cnt
>>       0000000000000608-000000000000060b (prio 0, i/o): acpi-tmr
>>       0000000000000620-000000000000062f (prio 0, i/o): acpi-gpe0
>>       0000000000000630-0000000000000637 (prio 0, i/o): acpi-smi
>>       0000000000000660-000000000000067f (prio 0, i/o): sm-tco
>>     0000000000000cd8-0000000000000ce3 (prio 0, i/o): acpi-mem-hotplug
>>     0000000000000cf8-0000000000000cfb (prio 0, i/o): pci-conf-idx
>>     0000000000000cf9-0000000000000cf9 (prio 1, i/o): lpc-reset-control
>>     0000000000000cfc-0000000000000cff (prio 0, i/o): pci-conf-data
>>     000000000000c000-000000000000c07f (prio 1, i/o): virtio-pci
>>     000000000000c080-000000000000c0bf (prio 1, i/o): virtio-pci
>>=20
>>=20
>>  ----------------
>>  | Q35 with PIT |
>>  ----------------
>>=20
>> Command line:
>>=20
>> ./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M q35,smbus=3Do=
ff,nvdimm=3Doff,pit=3Don,vmport=3Doff,sata=3Doff,usb=3Doff,graphics=3Doff -=
no-hpet -kernel /root/src/images/vmlinux-5.2 -append "console=3Dhvc0 reboot=
=3Dk panic=3D1 root=3D/dev/vda quiet" -smp 1 -nodefaults -no-user-config -c=
hardev pty,id=3Dvirtiocon0,server -device virtio-serial -device virtconsole=
,chardev=3Dvirtiocon0 -drive id=3Dtest,file=3D/root/src/images/hello-rootfs=
.ext4,format=3Draw,if=3Dnone -device virtio-blk,drive=3Dtest
>>=20
>> Average boot times after 10 consecutive runs:
>>=20
>>  qemu_init_end: 77.467852
>>  linux_start_kernel: 116.688472 (+39.22062)
>>  linux_start_user: 363.033365 (+246.344893)
>>=20
>> Memory tree:
>>=20
>> address-space: memory
>>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>     0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g =
@pc.ram 0000000000000000-000000001fffffff
>>     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>       00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>>       00000000000e0000-00000000000fffff (prio 1, i/o): alias isa-bios @p=
c.bios 0000000000020000-000000000003ffff
>>       00000000febf4000-00000000febf7fff (prio 1, i/o): virtio-pci
>>         00000000febf4000-00000000febf4fff (prio 0, i/o): virtio-pci-comm=
on
>>         00000000febf5000-00000000febf5fff (prio 0, i/o): virtio-pci-isr
>>         00000000febf6000-00000000febf6fff (prio 0, i/o): virtio-pci-devi=
ce
>>         00000000febf7000-00000000febf7fff (prio 0, i/o): virtio-pci-noti=
fy
>>       00000000febf8000-00000000febfbfff (prio 1, i/o): virtio-pci
>>         00000000febf8000-00000000febf8fff (prio 0, i/o): virtio-pci-comm=
on
>>         00000000febf9000-00000000febf9fff (prio 0, i/o): virtio-pci-isr
>>         00000000febfa000-00000000febfafff (prio 0, i/o): virtio-pci-devi=
ce
>>         00000000febfb000-00000000febfbfff (prio 0, i/o): virtio-pci-noti=
fy
>>       00000000febfe000-00000000febfefff (prio 1, i/o): virtio-serial-pci=
-msix
>>         00000000febfe000-00000000febfe01f (prio 0, i/o): msix-table
>>         00000000febfe800-00000000febfe807 (prio 0, i/o): msix-pba
>>       00000000febff000-00000000febfffff (prio 1, i/o): virtio-blk-pci-ms=
ix
>>         00000000febff000-00000000febff01f (prio 0, i/o): msix-table
>>         00000000febff800-00000000febff807 (prio 0, i/o): msix-pba
>>       00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>     00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region =
@pci 00000000000a0000-00000000000bffff
>>     00000000000c0000-00000000000c2fff (prio 1000, i/o): alias kvmvapic-r=
om @pc.ram 00000000000c0000-00000000000c2fff
>>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000c0000-00000000000c3fff [disabled]
>>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000c0000-00000000000c3fff [disabled]
>>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000c0000-00000000000c3fff
>>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci =
00000000000c0000-00000000000c3fff [disabled]
>>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000c4000-00000000000c7fff [disabled]
>>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000c4000-00000000000c7fff [disabled]
>>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000c4000-00000000000c7fff
>>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci =
00000000000c4000-00000000000c7fff [disabled]
>>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000c8000-00000000000cbfff [disabled]
>>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000c8000-00000000000cbfff [disabled]
>>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000c8000-00000000000cbfff
>>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci =
00000000000c8000-00000000000cbfff [disabled]
>>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000cc000-00000000000cffff [disabled]
>>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000cc000-00000000000cffff [disabled]
>>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000cc000-00000000000cffff
>>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci =
00000000000cc000-00000000000cffff [disabled]
>>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000d0000-00000000000d3fff [disabled]
>>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000d0000-00000000000d3fff [disabled]
>>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000d0000-00000000000d3fff
>>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci =
00000000000d0000-00000000000d3fff [disabled]
>>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000d4000-00000000000d7fff [disabled]
>>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000d4000-00000000000d7fff [disabled]
>>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000d4000-00000000000d7fff
>>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci =
00000000000d4000-00000000000d7fff [disabled]
>>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000d8000-00000000000dbfff [disabled]
>>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000d8000-00000000000dbfff [disabled]
>>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000d8000-00000000000dbfff
>>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci =
00000000000d8000-00000000000dbfff [disabled]
>>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000dc000-00000000000dffff [disabled]
>>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000dc000-00000000000dffff [disabled]
>>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000dc000-00000000000dffff
>>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci =
00000000000dc000-00000000000dffff [disabled]
>>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000e0000-00000000000e3fff [disabled]
>>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000e0000-00000000000e3fff [disabled]
>>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000e0000-00000000000e3fff
>>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci =
00000000000e0000-00000000000e3fff [disabled]
>>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000e4000-00000000000e7fff [disabled]
>>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000e4000-00000000000e7fff [disabled]
>>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000e4000-00000000000e7fff
>>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci =
00000000000e4000-00000000000e7fff [disabled]
>>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000e8000-00000000000ebfff
>>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000e8000-00000000000ebfff [disabled]
>>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000e8000-00000000000ebfff [disabled]
>>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci =
00000000000e8000-00000000000ebfff [disabled]
>>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000ec000-00000000000effff
>>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000ec000-00000000000effff [disabled]
>>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000ec000-00000000000effff [disabled]
>>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci =
00000000000ec000-00000000000effff [disabled]
>>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-ram @pc.r=
am 00000000000f0000-00000000000fffff [disabled]
>>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pc.r=
am 00000000000f0000-00000000000fffff [disabled]
>>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-rom @pc.r=
am 00000000000f0000-00000000000fffff
>>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci =
00000000000f0000-00000000000fffff [disabled]
>>     0000000020000000-0000000020000000 (prio 1, i/o): tseg-blackhole [dis=
abled]
>>     00000000b0000000-00000000bfffffff (prio 0, i/o): pcie-mmcfg-mmio
>>     00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>>     00000000fed1c000-00000000fed1ffff (prio 1, i/o): lpc-rcrb-mmio
>>     00000000feda0000-00000000fedbffff (prio 1, i/o): alias smram-open-hi=
gh @pc.ram 00000000000a0000-00000000000bffff [disabled]
>>     00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>>=20
>> address-space: I/O
>>   0000000000000000-000000000000ffff (prio 0, i/o): io
>>     0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
>>     0000000000000008-000000000000000f (prio 0, i/o): dma-cont
>>     0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
>>     0000000000000040-0000000000000043 (prio 0, i/o): kvm-pit
>>     0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
>>     0000000000000061-0000000000000061 (prio 0, i/o): pcspk
>>     0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
>>     0000000000000070-0000000000000071 (prio 0, i/o): rtc
>>       0000000000000070-0000000000000070 (prio 0, i/o): rtc-index
>>     000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
>>     0000000000000080-0000000000000080 (prio 0, i/o): ioport80
>>     0000000000000081-0000000000000083 (prio 0, i/o): dma-page
>>     0000000000000087-0000000000000087 (prio 0, i/o): dma-page
>>     0000000000000089-000000000000008b (prio 0, i/o): dma-page
>>     000000000000008f-000000000000008f (prio 0, i/o): dma-page
>>     0000000000000092-0000000000000092 (prio 0, i/o): port92
>>     00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
>>     00000000000000b2-00000000000000b3 (prio 0, i/o): apm-io
>>     00000000000000c0-00000000000000cf (prio 0, i/o): dma-chan
>>     00000000000000d0-00000000000000df (prio 0, i/o): dma-cont
>>     00000000000000f0-00000000000000f0 (prio 0, i/o): ioportF0
>>     00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
>>     00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
>>     0000000000000510-0000000000000511 (prio 0, i/o): fwcfg
>>     0000000000000514-000000000000051b (prio 0, i/o): fwcfg.dma
>>     0000000000000600-000000000000067f (prio 0, i/o): ich9-pm
>>       0000000000000600-0000000000000603 (prio 0, i/o): acpi-evt
>>       0000000000000604-0000000000000605 (prio 0, i/o): acpi-cnt
>>       0000000000000608-000000000000060b (prio 0, i/o): acpi-tmr
>>       0000000000000620-000000000000062f (prio 0, i/o): acpi-gpe0
>>       0000000000000630-0000000000000637 (prio 0, i/o): acpi-smi
>>       0000000000000660-000000000000067f (prio 0, i/o): sm-tco
>>     0000000000000cd8-0000000000000ce3 (prio 0, i/o): acpi-mem-hotplug
>>     0000000000000cf8-0000000000000cfb (prio 0, i/o): pci-conf-idx
>>     0000000000000cf9-0000000000000cf9 (prio 1, i/o): lpc-reset-control
>>     0000000000000cfc-0000000000000cff (prio 0, i/o): pci-conf-data
>>     000000000000c000-000000000000c07f (prio 1, i/o): virtio-pci
>>     000000000000c080-000000000000c0bf (prio 1, i/o): virtio-pci
>>=20
>>=20
>>  -----------
>>  | microvm |
>>  -----------
>>=20
>> Command line:
>>=20
>> ./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M microvm -kern=
el /root/src/images/vmlinux-5.2 -append "console=3Dhvc0 reboot=3Dk panic=3D=
1 root=3D/dev/vda quiet" -smp 1 -nodefaults -no-user-config -chardev pty,id=
=3Dvirtiocon0,server -device virtio-serial-device -device virtconsole,chard=
ev=3Dvirtiocon0 -drive id=3Dtest,file=3D/root/src/images/hello-rootfs.ext4,=
format=3Draw,if=3Dnone -device virtio-blk-device,drive=3Dtest
>>=20
>> Average boot times after 10 consecutive runs:
>>=20
>>  qemu_init_end: 64.043264
>>  linux_start_kernel: 65.481782 (+1.438518)
>>  linux_start_user: 114.938353 (+49.456571)
>>=20
>> Memory tree:
>>=20
>>  address-space: memory
>>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>     0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g =
@microvm.ram 0000000000000000-000000001fffffff
>>     00000000d0000000-00000000d00001ff (prio 0, i/o): virtio-mmio
>>     00000000d0000200-00000000d00003ff (prio 0, i/o): virtio-mmio
>>     00000000d0000400-00000000d00005ff (prio 0, i/o): virtio-mmio
>>     00000000d0000600-00000000d00007ff (prio 0, i/o): virtio-mmio
>>     00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>>     00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>>=20
>>  address-space: I/O
>>   0000000000000000-000000000000ffff (prio 0, i/o): io
>>     000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
>>=20
>>=20
>>  --------------
>>  | Conclusion |
>>  --------------
>>=20
>> The average boot time of microvm is a third of Q35's (115ms vs. 363ms),
>> and is smaller on all sections (QEMU initialization, firmware overhead
>> and kernel start-to-user).
>>=20
>> Microvm's memory tree is also visibly simpler, significantly reducing
>> the exposed surface to the guest.
>>=20
>> While we can certainly work on making Q35 smaller, I definitely think
>> it's better (and way safer!) having a specialized machine type for a
>> specific use case, than a minimal Q35 whose behavior significantly
>> diverges from a conventional Q35.
>
> Interesting, so not a 10x difference!  This might be amenable to
> optimization.
>
> My concern with microvm is that it's so limited that few users will be
> able to benefit from the reduced attack surface and faster startup time.
> I think it's worth investigating slimming down Q35 further first.
>
> In terms of startup time the first step would be profiling Q35 kernel
> startup to find out what's taking so long (firmware initialization, PCI
> probing, etc)?

Some findings:

 1. Exposing the TSC_DEADLINE CPU flag (i.e. using "-cpu host") saves a
    whooping 120ms by avoiding the APIC timer calibration at
    arch/x86/kernel/apic/apic.c:calibrate_APIC_clock

Average boot time with "-cpu host"
 qemu_init_end: 76.408950
 linux_start_kernel: 116.166142 (+39.757192)
 linux_start_user: 242.954347 (+126.788205)

Average boot time with default "cpu"
 qemu_init_end: 77.467852
 linux_start_kernel: 116.688472 (+39.22062)
 linux_start_user: 363.033365 (+246.344893)

 2. The other 130ms are a direct result of PCI and ACPI presence (tested
    with a kernel without support for those elements). I'll publish some
    detailed numbers next week.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0xyjcACgkQ9GknjS8M
AjXIQA//fnuHeJZ1yQAVxKPBLbhrRFoW1FbCqVUWzbJa/F7WVltJF+/7KdgMTgni
De4QvvovsfAc5k9mqeew6ifSL48H4LRQc/xhHgzBucMazynnqY3SqWUkCUwWOTXZ
2VnI6rRJ16kqTLvDn5HeQNwIQOCbVVrRIluh7Sr7YnWNmH249L0HrQZnpM86nprX
oMWTePAYoeGnry+iuhVK6dDCfivGmZq8cET7lNYlBYkG5+oR/JF9dnHrQohnxrbc
7b5yyf7Fx7/PXqFZoogAwLQuZWubZEa1E9ohP3ZEpSG6xIcHsCix3DXavYQcDaml
/0RIJuqZDv3VhewZXm/rkBSDi21Rqnt45e9cZAXArqZsdc91bI5YMZ5g8TRDeCgt
MXgmDPWw3r16W6zQWzof6wjsueskwW7JGsl9mX61f08Lf+d0Nb5xF1oCsvfFqpmh
YeH7Tj3V1VkeNRdxJ9BkGv6Lq93ZGzMnmSKRJ5S6cbPZEU/JA1wNemA0fGHgB1B6
MopPvNYOE5khkZFPC08DSZ16kpaMbnchcqB9qPvXWr3N0AKUlm0cOFHWb9+ndMIx
n7bL+sw/WBr4r/5NznCh0zml14m4/ADuLYIvF8+g9KREF8JQimpsK9Lf6BhyYVmE
ycEzamQCE7MWNuuP/6u+aqym9/PaZXEhZ0f6jFU6F4WLq2JMNNI=
=0Sq4
-----END PGP SIGNATURE-----
--=-=-=--

