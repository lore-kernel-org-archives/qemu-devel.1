Received: from eggs.gnu.org ([209.51.188.92]:60734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBDxF-0007qA-DV
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBDxE-0004E0-Dl
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:35:33 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBDxD-0004DD-TU
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:35:32 -0400
Received: by mail-ot1-x344.google.com with SMTP id t8so11109859otp.7
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 00:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
	<1554099897-28606-2-git-send-email-tjin@wavecomp.com>
	<CAFEAcA8eVfmLdPQs0YKsAUYP5LzsFrcF96xknjfKtzbzY97BNw@mail.gmail.com>
	<CAL1e-=jj4y=_ViZPepZ15VQnQQ++tbD2FYcmNST88O59GcjXfA@mail.gmail.com>
	<MWHPR2201MB11199232622EFEFBF361C3A9B8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
	<CAFEAcA9NDmKV0EdrEM6BGWqLwXpqbdBLXz-YHcWhxEgBSQttQw@mail.gmail.com>
	<MWHPR2201MB11190F1FFDE9CD41E3674DDFB8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
In-Reply-To: <MWHPR2201MB11190F1FFDE9CD41E3674DDFB8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 07:35:19 +0000
Message-ID: <CAFEAcA9ooDF8O+LexHnnmVAFsikdo1nhjYafJDYWopN3fva87g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard for
 mips boston board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tommy Jin <tjin@wavecomp.com>
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pburton.wavecomp.com@gmail.com" <pburton.wavecomp.com@gmail.com>

On Tue, 2 Apr 2019 at 14:24, Tommy Jin <tjin@wavecomp.com> wrote:
> For the option2, I think specify the network model in command line is
> not enough, per my understanding, we still need to create the device
> using API like pci_create && qdev_set_nic_properties && qdev_init_nofail,
> otherwise we'll get error prompts like "requested NIC (anonymous, model
> virtio) was not created (not supported by this machine?)", currently I
> just add these pieces of code in /hw/mips/boston.c, Do you call these
> pieces of code board code and what's your suggestion?

If the boston board has PCI support and it is implemented correctly
then you should be able to create a virtio network setup with
command line options like
 -netdev user,id=mynet -device virtio-net-pci,netdev=mynet

(or any other netdev backend, eg tun/tap).

I don't have a boston image/command line to test that with,
but it works for arm boards and should be the same for any
pci capable board model.

thanks
-- PMM
