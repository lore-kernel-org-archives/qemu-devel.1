Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6C7C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 14:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2433720873
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 14:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2433720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho7Ur-0003Sf-8C
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 10:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1ho7Uf-0002ug-Pm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ho7Ue-0005Yb-5u
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:34:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ho7Ud-0005Xe-Ua
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:34:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so21839781wme.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 07:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=VVww2PUhz0TYhbHq0wbDlRnenW+BPclid6VB0pJ2fsg=;
 b=BcC4/xj4u3DTUgT1hk7E0U0v4P6xvughN0pkI+ix/9B3Q/3NO/Uz6yzer4cO+PWa5r
 b8z860FZjHHA1+F5u8qpANGLUgqtcU+mOhoOV19MsJqUS7ihborvYgKG8oCV9A1z9AFQ
 y8WOmdLs/O7e3yEimN+KPcN+CA1eicO15KpTlcJZjFat0WjDlKLKZDz1bAnXSKBb51M8
 KAu6HbyL0z+TSDCBSnp9XMATwO56pxyP/QH7VETdvPx4lJzQ6u6mABhciQNKBBXk7tyF
 Ph59+f9FUTT88hUtxlk5U70TjuN5I4LmEzjuOOQ+/cpemUKUdCe1lQiU35db/KaZiMiM
 oN8Q==
X-Gm-Message-State: APjAAAUEiudTZNEY0NuKxYrpWclIVGHLUFpdFchRl8JMSch2b7M1DYqm
 fHZ4HymNZxvfXRz54XCSd6B12/xFHX4=
X-Google-Smtp-Source: APXvYqyovrJVstxOsGsXmGvYGcMpXlS9+VDR0y5kr1dvDPeyxgTxVCbumVcMKoDrJOxQCE5kqwaXBg==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr43036206wme.29.1563460485326; 
 Thu, 18 Jul 2019 07:34:45 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id f204sm36914386wme.18.2019.07.18.07.34.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 07:34:44 -0700 (PDT)
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
 <878stgygiu.fsf@redhat.com>
 <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
 <875zokyahg.fsf@redhat.com> <8c3b4619-f779-fb0c-7a53-b67150036a07@redhat.com>
 <8736joxzv4.fsf@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <8736joxzv4.fsf@redhat.com>
Date: Thu, 18 Jul 2019 16:34:42 +0200
Message-ID: <87ef2ntnr1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Sergio Lopez <slp@redhat.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 02/07/19 12:52, Sergio Lopez wrote:
>>> As I said, I'm also in favor of microvm supporting booting from
>>> firmware in the future, as long we keep the simple mode too.
>>
>> The simple mode adds code to QEMU's x86 target that only exists to
>> support microvm.  It should be motivated by a clear win in boot times.
>
> OK. When I'm back from my PTO, I'll work on adding the firmware
> support to microvm. I'll run and share some numbers to see whether the
> simple mode makes sense or we can just rely on qboot for lower boot
> times plus SeaBIOS for compatibility.

I've just added support for starting the machine from SeaBIOS (Stefan
Hajnoczi pointed in another thread that it can be as fast as qboot, and
given that the latter doesn't support mptables, I just tested this
one). I tried to keep it as minimalistic as possible, but it still
required an RTC (mc146818), which dragged in an ISA BUS, and this one a
KVM PIT.

I ran some numbers using Stefano Garzarella's qemu-boot-time scripts
[1] on a server with 2xIntel Xeon Silver 4114 2.20GHz, using the
upstream QEMU (474f3938d79ab36b9231c9ad3b5a9314c2aeacde) built with
minimal features [2]. The VM boots a minimal kernel [3] without initrd,
using a kata container image as root via virtio-blk (though this isn't
really relevant, as we're just taking measurements until the kernel is
about to exec init).

 ---------------------
 | QEMU with SeaBIOS |
 ---------------------

Command line:

./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M microvm,legacy -kernel /root/src/images/vmlinux-5.2 -append "console=hvc0 reboot=k panic=1 root=/dev/vda quiet virtio_mmio.device=512@0xd0000600:15 virtio_mmio.device=512@0xd0000400:14" -smp 1 -nodefaults -no-user-config -chardev pty,id=virtiocon0,server -device virtio-serial-device -device virtconsole,chardev=virtiocon0 -drive id=test,file=/usr/share/kata-containers/kata-containers.img,format=raw,if=none -device virtio-blk-device,drive=test -monitor stdio

Average boot times after 10 consecutive runs:

 qemu_init_end: 65.958714
 linux_start_kernel: 77.735803 (+11.777089)
 linux_start_user: 127.360739 (+49.624936)

Exposed I/O ports and MMIOs:

 address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g @microvm.ram 0000000000000000-000000001fffffff
    00000000000e0000-00000000000fffff (prio 1, i/o): alias isa-bios @pc.bios 0000000000000000-000000000001ffff
    00000000d0000000-00000000d00001ff (prio 0, i/o): virtio-mmio
    00000000d0000200-00000000d00003ff (prio 0, i/o): virtio-mmio
    00000000d0000400-00000000d00005ff (prio 0, i/o): virtio-mmio
    00000000d0000600-00000000d00007ff (prio 0, i/o): virtio-mmio
    00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
    00000000fffe0000-00000000ffffffff (prio 0, ram): pc.bios

 address-space: I/O
  0000000000000000-000000000000ffff (prio 0, i/o): io
    0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
    0000000000000040-0000000000000043 (prio 0, i/o): kvm-pit
    0000000000000070-0000000000000071 (prio 0, i/o): rtc
      0000000000000070-0000000000000070 (prio 0, i/o): rtc-index
    000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
    00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
    00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
    00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
    0000000000000510-0000000000000511 (prio 0, i/o): fwcfg
    0000000000000514-000000000000051b (prio 0, i/o): fwcfg.dma


 -------------------
 | QEMU direct PVH |
 -------------------

Command line:

 ./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M microvm -kernel /root/src/images/vmlinux-5.2 -append "console=hvc0 reboot=k panic=1 root=/dev/vda quiet" -smp 1 -nodefaults -no-user-config -chardev pty,id=virtiocon0,server -device virtio-serial-device -device virtconsole,chardev=virtiocon0 -drive id=test,file=/usr/share/kata-containers/kata-containers.img,format=raw,if=none -device virtio-blk-device,drive=test -monitor stdio

Average boot times after 10 consecutive runs:

 qemu_init_end: 64.043264
 linux_start_kernel: 65.481782 (+1.438518)
 linux_start_user: 114.938353 (+49.456571)

Exposed I/O ports and MMIOs:

 address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g @microvm.ram 0000000000000000-000000001fffffff
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
 | Comparison |
 --------------

Average boot time:

 * Relying on SeaBIOS, when compared with direct PVH boot, as a total
   average overhead of ~12ms. The cost of initializing QEMU increases in
   ~2ms (probably due to need to instantiate more devices), while the
   other ~10ms is the SeaBIOS overhead.

Exposed I/O ports and MMIOs:

 * The following 8 I/O ports are only present in the version relying on SeaBIOS:

    0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
    0000000000000040-0000000000000043 (prio 0, i/o): kvm-pit
    0000000000000070-0000000000000071 (prio 0, i/o): rtc
      0000000000000070-0000000000000070 (prio 0, i/o): rtc-index
    00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
    00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
    00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
    0000000000000510-0000000000000511 (prio 0, i/o): fwcfg
    0000000000000514-000000000000051b (prio 0, i/o): fwcfg.dma

 * The following MMIO region is only present in the direct boot version:

    00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic


 ---------------
 | Conclusions |
 ---------------

Objectively, the version that boots directly the kernel using PVH is 10%
faster and has a slightly larger exposed surface. Whether this is enough
to justify its existence is quite subjective.

In my opinion, not only I think it makes sense to have it, but I also
think there's little reason to have the firmware reliant version, given
the nature and purpose of microvm.

Sergio.

[1] https://github.com/stefano-garzarella/qemu-boot-time
[2] https://paste.fedoraproject.org/paste/YZ9Ok-dJtQrc0xxctFm-nw
[3] https://paste.fedoraproject.org/paste/sck0jfioAJdMq51HH6wkmA

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0wg4IACgkQ9GknjS8M
AjXTBhAAjE9PxMC0LIX5WIF0KPCrsPn7+hi+/I+xjESU9WfjSII9unntynxSvyz2
DyghYU+TFYiqlNGVN1jYM6Rn2YL1uy3MVN6xS3dSByab+9RilsocTKUCMkKMmJwI
NmjyVByKAwBpL5FhmKs9jECc6on+6Tj3nF3ynKSBAUZMOICaAOxYL4c4UxUsYkP+
YEn+bpE1fmRjtr8TkCaB+OTwPuuhrutur8UD/vJIupj7tYntKYSoPGaY4HlUCyKG
KkMQP8Ukmm1a90gLgQvmIj6hdJbV90y2e9W8sbFA1uwTdXwoAW/+VnGSE+G+roU/
+U8bn0ykieloZ55AUmXgC3/zqMo52BWA5fQGqYy5jYho0Mb0fz4QvO4K6k4YA1Fw
uLy+0cs9ja5m02+tX8whPKWUAhRixRg9Egfen2pd76EOLhnLn1qlfLgtNlpDZ738
5cfQz+/FmLgVp6dgQvPBVNY2JcS8Ksedyj9A8Hpi7SjgynzFJzLA6aE9XXxbzD1Z
B4MgoY+kreXtkG9JGMnZa1PpVI3o/2tmdWjh4zsdukGdMVt363aHNt11R4bOjI0E
ho8SAbUfUlI4fCJY4UPgIQmp319hCYIJ4PzobGRGMqIOYSO4VhspQxyNUdQvQvEc
Yb2Ahm1F5nwKAkPbelh+LTMB0QbXqgEod0J3a+TyRw/Fkx62iVg=
=DMRo
-----END PGP SIGNATURE-----
--=-=-=--

