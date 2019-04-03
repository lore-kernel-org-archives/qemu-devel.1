Received: from eggs.gnu.org ([209.51.188.92]:59570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hBXsu-0006rq-Q9
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 00:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hBXsr-0006lc-8H
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 00:52:23 -0400
Received: from mail-eopbgr740103.outbound.protection.outlook.com
	([40.107.74.103]:9964
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tjin@wavecomp.com>) id 1hBXsn-0006hx-Qr
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 00:52:19 -0400
From: Tommy Jin <tjin@wavecomp.com>
Date: Wed, 3 Apr 2019 04:52:13 +0000
Message-ID: <MWHPR2201MB11197A7C98CD47E491559F61B8570@MWHPR2201MB1119.namprd22.prod.outlook.com>
References: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
	<1554099897-28606-2-git-send-email-tjin@wavecomp.com>
	<CAFEAcA8eVfmLdPQs0YKsAUYP5LzsFrcF96xknjfKtzbzY97BNw@mail.gmail.com>
	<CAL1e-=jj4y=_ViZPepZ15VQnQQ++tbD2FYcmNST88O59GcjXfA@mail.gmail.com>
	<MWHPR2201MB11199232622EFEFBF361C3A9B8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
	<CAFEAcA9NDmKV0EdrEM6BGWqLwXpqbdBLXz-YHcWhxEgBSQttQw@mail.gmail.com>
	<MWHPR2201MB11190F1FFDE9CD41E3674DDFB8560@MWHPR2201MB1119.namprd22.prod.outlook.com>,
	<CAFEAcA9ooDF8O+LexHnnmVAFsikdo1nhjYafJDYWopN3fva87g@mail.gmail.com>
In-Reply-To: <CAFEAcA9ooDF8O+LexHnnmVAFsikdo1nhjYafJDYWopN3fva87g@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pburton.wavecomp.com@gmail.com" <pburton.wavecomp.com@gmail.com>

Hi Peter,


That command line option doesn't work for boston, although I didn't get any=
 obvious error, no Ethernet card appears either.

Where can I get that arm image/command which can work well for you with " -=
netdev user,id=3Dmynet -device virtio-net-pci,netdev=3Dmynet" ?


Anyway, if that command line option works for arm, I'm going to investigate=
 the reason.


Best regards,

Tommy

________________________________
From: Peter Maydell <peter.maydell@linaro.org>
Sent: Tuesday, April 2, 2019 3:35:19 PM
To: Tommy Jin
Cc: Aleksandar Markovic; qemu-devel@nongnu.org; pburton.wavecomp.com@gmail.=
com
Subject: Re: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard fo=
r mips boston board.

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
 -netdev user,id=3Dmynet -device virtio-net-pci,netdev=3Dmynet

(or any other netdev backend, eg tun/tap).

I don't have a boston image/command line to test that with,
but it works for arm boards and should be the same for any
pci capable board model.

thanks
-- PMM
