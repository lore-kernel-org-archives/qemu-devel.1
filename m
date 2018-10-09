Received: from eggs.gnu.org ([2001:4830:134:3::10]:51438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g9uNr-0000Ml-E0
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g9uNg-00036c-VK
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g9uNg-000314-2E
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:57:08 -0400
Date: Tue, 9 Oct 2018 12:57:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181009155700.GC5738@habkost.net>
References: <20181002212522.23303-1-f4bug@amsat.org>
	<41e8ac78-1a7a-c937-6e66-c84afc89f1d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <41e8ac78-1a7a-c937-6e66-c84afc89f1d7@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/12] another SysBusDevice::init to
 Device::realize cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org

On Tue, Oct 09, 2018 at 05:01:49PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Eduardo,
>=20
> On 02/10/2018 23:25, Philippe Mathieu-Daud=E9 wrote:
> > Peter suggested [1] another crusade for this merge window,
> > then C=E9dric jumped on his horse [2]. My turn on my dromedary.
> >=20
> > since v1:
> > - let the empty_slot
> > - sh4_pci and bonito use DeviceState::realize instead of PCIDevice::r=
ealize
> > - reword niagara-iob commit message
> >=20
> > v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00220.ht=
ml
> > - convert few devices to DeviceState::realize,
> > - kill the empty_slot device,
> > - remove unuseful class_init() code [RFC, do we want to keep this?]
> > - few other minor fixes catched while editing
> >=20
> > Regards,
> >=20
> > Phil.
> >=20
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03605.ht=
ml
> > [2] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00001.ht=
ml
> >=20
> > 001/12:[----] [--] 'trace-events: Fix copy/paste typo'
> > 002/12:[----] [--] 'hw/timer/sun4v-rtc: Convert from DPRINTF() macro =
to trace events'
> > 003/12:[----] [--] 'hw/timer/sun4v-rtc: Use DeviceState::realize rath=
er than SysBusDevice::init'
> > 004/12:[----] [--] 'hw/ssi/xilinx_spi: Use DeviceState::realize rathe=
r than SysBusDevice::init'
> > 005/12:[0006] [FC] 'hw/sh4/sh_pci: Use DeviceState::realize rather th=
an SysBusDevice::init'
> > 006/12:[0006] [FC] 'hw/pci-host/bonito: Use DeviceState::realize rath=
er than SysBusDevice::init'
> > 007/12:[----] [--] 'hw/mips/gt64xxx_pci: Convert gt64120_reset() func=
tion into Device reset method'
> > 008/12:[----] [--] 'hw/mips/gt64xxx_pci: Mark as bridge device'
> > 009/12:[----] [--] 'hw/sparc64/niagara: Model the I/O Bridge with the=
 'unimplemented_device''
> > 010/12:[----] [--] 'hw/alpha/typhoon: Remove unuseful code'
> > 011/12:[----] [--] 'hw/hppa/dino: Remove unuseful code'
> > 012/12:[----] [--] 'hw/mips/malta: Remove unuseful code'
>=20
> Can you take this via your machine-next tree?

I'll do it.  Thanks!

--=20
Eduardo
