Received: from eggs.gnu.org ([2001:4830:134:3::10]:33654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkMuu-0004QU-K7
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 01:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkMut-0002PT-RL
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 01:09:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Jul 2018 07:09:43 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <CAFEAcA-tAewpxZZAh5vmB0ZRYGdoLHrBuZ14aW0Qczsp3gQZ7A@mail.gmail.com>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<CAFEAcA_wxAbODS=voCunFYYMZdSG7jOuu7B-8mRhH15snGp6=A@mail.gmail.com>
	<alpine.BSF.2.21.1807310055170.24147@zero.eik.bme.hu>
	<CAFEAcA-tAewpxZZAh5vmB0ZRYGdoLHrBuZ14aW0Qczsp3gQZ7A@mail.gmail.com>
Message-ID: <01ddb520c0355680399999199f4f0e8d@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

Am 2018-07-31 01:15, schrieb Peter Maydell:
> It would work. But creating an OR gate is half a dozen lines or so of
> code, so it's not much more work than changing the PCI controller.
> So we should prefer whichever is closest to what the real hardware
> does, assuming we can determine that.

The real way is not known. The only source of information is UBoot which 
sets the interrupt line to 32 for all PCI devices. At least AmigaOS 
doesn't overwrite this setting. But UBoot could be wrong of course, as 
the hardware provides only one PCI slot (I think the sm502 is also 
connected to that bus in a direct fashion, but it doesn't have an PCI 
IRQ). Technically, we could also modify UBoot to chose other lines, at 
least AmigaOS would continue to work (if this maps the QEMU wiring) but 
this UBoot would be incompatible to the original hardware.

Bye
Sebastian
