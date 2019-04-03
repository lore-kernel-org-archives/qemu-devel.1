Received: from eggs.gnu.org ([209.51.188.92]:33248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBY3W-0001rW-PD
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 01:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBY3V-0000q4-PR
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 01:03:22 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBY3V-0000oP-HN
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 01:03:21 -0400
Received: by mail-ot1-x344.google.com with SMTP id j10so14340551otq.0
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 22:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
	<1554099897-28606-2-git-send-email-tjin@wavecomp.com>
	<CAFEAcA8eVfmLdPQs0YKsAUYP5LzsFrcF96xknjfKtzbzY97BNw@mail.gmail.com>
	<CAL1e-=jj4y=_ViZPepZ15VQnQQ++tbD2FYcmNST88O59GcjXfA@mail.gmail.com>
	<MWHPR2201MB11199232622EFEFBF361C3A9B8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
	<CAFEAcA9NDmKV0EdrEM6BGWqLwXpqbdBLXz-YHcWhxEgBSQttQw@mail.gmail.com>
	<MWHPR2201MB11190F1FFDE9CD41E3674DDFB8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
	<CAFEAcA9ooDF8O+LexHnnmVAFsikdo1nhjYafJDYWopN3fva87g@mail.gmail.com>
	<MWHPR2201MB11197A7C98CD47E491559F61B8570@MWHPR2201MB1119.namprd22.prod.outlook.com>
In-Reply-To: <MWHPR2201MB11197A7C98CD47E491559F61B8570@MWHPR2201MB1119.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Apr 2019 12:03:08 +0700
Message-ID: <CAFEAcA81xjt7Hy9XqR76G4jKkcC4B=Zwr1g8=bu98tdKLUEdmQ@mail.gmail.com>
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

On Wed, 3 Apr 2019 at 11:52, Tommy Jin <tjin@wavecomp.com> wrote:
> That command line option doesn't work for boston, although I didn't get any obvious error, no Ethernet card appears either.

Does the guest kernel find the PCI device (eg appears in kernel bootup
messages, appears in 'lspci' output)? It's worth double-checking that
your guest kernel's config has enabled support for PCI, for the PCI
controller used by the boston board, for virtio-net, etc.

> Where can I get that arm image/command which can work well for you with " -netdev user,id=mynet -device virtio-net-pci,netdev=mynet" ?

https://translatedcode.wordpress.com/2017/07/24/installing-debian-on-qemus-64-bit-arm-virt-board/
has instructions for booting Debian which use that command line.

thanks
-- PMM
