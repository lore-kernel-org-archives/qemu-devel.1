Received: from eggs.gnu.org ([2001:4830:134:3::10]:39949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1e99A0-0003Zu-Al
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1e999w-0004Ho-F7
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:27:20 -0400
Received: from smtp8.web4u.cz ([81.91.87.88]:48173 helo=mx-8.mail.web4u.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pisa@cmp.felk.cvut.cz>)
	id 1e999v-0004H0-WF
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:27:16 -0400
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Mon, 30 Oct 2017 13:27:12 +0100
References: <cover.1508885974.git.pisa@cmp.felk.cvut.cz>
	<1d51d638-6046-2f7a-890d-a9d1fd0889a7@denx.de>
	<f453335b-6a6b-ae22-eecd-cec048db14e3@adacore.com>
In-Reply-To: <f453335b-6a6b-ae22-eecd-cec048db14e3@adacore.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201710301327.12315.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH 1/6] CAN bus simple SJA1000 PCI card
 emulation for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>

Hello Marek and Konrad,

On Monday 30 of October 2017 12:38:12 KONRAD Frederic wrote:
> On 10/30/2017 11:51 AM, Marek Vasut wrote:
> > On 10/30/2017 10:19 AM, KONRAD Frederic wrote:
> >
> > [...]
> >
> >>> CAN bus MIOe-3680 PCI (dual SJA1000 channel) emulation added.
> >>>     hw/can/can_mioe3680_pci.c
> >>>
> >>> If you think that this is more logical even that the first
> >>> commits introduce something which cannot be tested/compiles
> >>> only into library, then I rearrange patchyes this way.
> >>
> >> I don't know all those PCI cards. But if the simple SJA1000
> >> doesn't exist in real life maybe better dropping it?
> >
> > SJA1000 is the only sensible card to emulate IMO, at least initially,
> > it's the de-facto standard for CAN devices.
> >
> > [...]
>
> I was talking of "CAN bus simple SJA1000 memory mapped PCI card
> example" which according to Pavel is an example device with
> custom vendor/device ids?

That is right, SJA1000 chip was and is the goal for now.
But on PCI addnon cards, it is usually accessed through some
PCI<->local bridge chip. Sometimes a little obscure intended
for ISDN communication for example etc. And bridges needs
to be emulated for real hardware to gate interrupts, provide
identifications etc. To make simple start for a student during
original GSoC, I have defined as the first target the "board"
where SJA1000 is connected directly to one and only one PCI BAR
and IRQ is routed directly to INTA. As a VID is used RedHat or similar
VID used for virtual QEMU devices and device ID is some arbitrarily
chosen number. So if this card should stay then we should try to
really reserve the Device ID.

But we have three QEMU device models implementing real boards
using SJA1000 chips now. I have contributed Kvaser which we
use in many application at university and another two boards
are contributed by Deniz Eren

CAN bus Kvaser PCI CAN-S (single SJA1000 channel) emulation added.
CAN bus PCM-3680I PCI (dual SJA1000 channel) emulation added.
CAN bus MIOe-3680 PCI (dual SJA1000 channel) emulation added.

The simple SJA1000 PCI board is friendly for initial diver
implementation for some other OS, because you deal only with
single memory mapped BAR. But it is necessary to adapt such
driver for some real hardware anyway, because I am not aware
of any so straightforward board model. So drop of this example is not
big lost and MIOe-3680 is memory mapped as well so it is enough
for mamory-mapped SJA1000 driver testing. Kvaser an PCM-3680I
are IO mapped.

Best wishes,

Pavel
