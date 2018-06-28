Received: from eggs.gnu.org ([2001:4830:134:3::10]:44683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fYUSf-0005Dl-GC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fYUSe-00088I-89
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:47:37 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:38952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fYUSe-00086q-3M
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:47:36 -0400
Received: by mail-it0-x244.google.com with SMTP id p185-v6so11837561itp.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 03:47:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180628102216.GC3513@redhat.com>
References: <1530094388-607-1-git-send-email-hongbo.zhang@linaro.org>
	<20180627123116.GB2424@work-vm> <20180628102216.GC3513@redhat.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 28 Jun 2018 18:47:34 +0800
Message-ID: <CAHmQWvA7_sv53xtgSQ6bb9G+bkYtakqvTHk38xaDhPyJuCe-vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Add SBSA machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 28 June 2018 at 18:22, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> On Wed, Jun 27, 2018 at 01:31:17PM +0100, Dr. David Alan Gilbert wrote:
>> * Hongbo Zhang (hongbo.zhang@linaro.org) wrote:
>> > This patch introduces a new Arm machine type 'SBSA' with features:
>> >  - Based on legacy 'virt' machine type.
>
> The 'virt' machine type is absolutely *not* legacy. It is the preferred
> modern, legacy-free machine type when running virtual machines. Since
> aarch64 is greenfield, there is no compelling reason to emulate a
> specific physical machine for VMs, hence the 'virt' machine type.
>
>> >  - Newly designed memory map.
>> >  - EL2 and EL3 are enabled by default.
>> >  - AHCI controller attached to system bus, and then CDROM and hard dis=
c
>> >    can be added to it.
>> >  - EHCI controller attached to system bus, with USB mouse and key boar=
d
>> >    installed by default.
>> >  - E1000 ethernet card on PCIE bus.
>
>> >  - VGA display adaptor on PCIE bus.
>> >  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
>> >  - No virtio functions enabled, since this is to emulate real hardware=
.
>>
>> I'm a bit confused; do you have real modern ARM hardware that has an
>> e1000 on it?  If I understand correctly, e1000 is the old PCI version
>> and the e1000e is at least the more modern PCIe version which makes
>> more sense if you're building on PCIe.
>
> Indeed, it makes little sense to default to e1000 if the goal is to make
> it legacy-free
>
>> However, if you:
>>   a) Don't have real hardware with the e1000 on
>>   b) Do have PCIe
>>
>> then to my mind it makes sense to use virtio-net-pci rather than
>> an e1000e.
>
> If it does down the virtio-* route though, I fail to see any point in
> adding the new machine type at all -  'virt' machine type is intended
> to be used for guests where everything is paravirtualized, ignoring
> physical hardware constraints.
>
Your comment comes earlier than I replied to Laszlo Ersek:

I said "yes yes yes" to him due to he describes the purpose so well,
even better than me.

And the I had some misunderstanding of term 'legacy' too, as I
explained in that reply.

> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
