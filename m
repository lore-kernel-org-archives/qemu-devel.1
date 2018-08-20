Received: from eggs.gnu.org ([2001:4830:134:3::10]:50165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1frtwx-0005nv-Pq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 19:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1frtwi-0000YA-Mq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 19:50:53 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1frtwi-0000VW-ED
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 19:50:52 -0400
Received: by mail-lj1-x242.google.com with SMTP id 203-v6so12900244ljj.13
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 16:50:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180817063619.pi7bhuwgjj7asodc@sirius.home.kraxel.org>
References: <cover.1534435831.git.alistair.francis@wdc.com>
	<b54c28929f201751c4f41e5cb7170e5b9a774432.1534435831.git.alistair.francis@wdc.com>
	<20180817063619.pi7bhuwgjj7asodc@sirius.home.kraxel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Aug 2018 16:50:20 -0700
Message-ID: <CAKmqyKMdST9OaHF6jJJSgnvAWOOOtw+vc+rVxoBnJnukVnTAzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/6] hw/riscv/virt: Connect a VGA PCIe
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>

On Thu, Aug 16, 2018 at 11:36 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> +    pci_bus = PCI_HOST_BRIDGE(dev)->bus;
>> +
>> +    pci_vga_init(pci_bus);
>
> I'd suggest to use "-device bochs-display" instead, unless you need all
> the legacy vga cruft (text mode, ...).  The bochs-drm kms driver can
> handle this one just fine too, it is much smaller (in terms of code
> lines and attack surface), and it has pcie support.

I gave this a quick try and the kernel didn't see the device with the
bochs-drm driver enabled.

I'll dig in a little more.

Alistair

>
> cheers,
>   Gerd
>
