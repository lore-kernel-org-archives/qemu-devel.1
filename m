Received: from eggs.gnu.org ([2001:4830:134:3::10]:46591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edaOA-0000vo-J9
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edaO6-0007Fy-Ks
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:35:46 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edaO6-0007FX-DZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:35:42 -0500
Received: by mail-qt0-x241.google.com with SMTP id d8so11247518qtm.0
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 03:35:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6408e418-c2b5-61fe-be3d-137ba9fab113@amsat.org>
Date: Mon, 22 Jan 2018 08:35:33 -0300
MIME-Version: 1.0
In-Reply-To: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="ZMcr7rXxdwQhnIi1TjbazVDGXRcRWVBGJ"
Subject: Re: [Qemu-devel] [PATCH V4 0/7] CAN bus support for QEMU (SJA1000
 PCI so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pisa@cmp.felk.cvut.cz, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZMcr7rXxdwQhnIi1TjbazVDGXRcRWVBGJ
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: pisa@cmp.felk.cvut.cz, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6408e418-c2b5-61fe-be3d-137ba9fab113@amsat.org>
Subject: Re: [Qemu-devel] [PATCH V4 0/7] CAN bus support for QEMU (SJA1000 PCI
 so far)
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 01/14/2018 05:14 PM, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>=20
> Basic emulation of CAN bus controller and interconnection for QEMU.
>=20
> Patches version 4:
> Resolve comments longer than 80 characters to suppress
> all warnings reported by scripts/checkpatch.pl.
> Follow all suggestions from Frederic Konrad review.
> Replace all printf and perror calls by QEMU equivalents.
> Include Deniz Eren signed-off confimation.
>=20
> Patches version 3:
> Support to connect to host SocketCAN interface has been
> separated from the core bus implementation. Only simple
> statically initialize pointer to the connection function
> is used, no QOM concept for now.
> SJA1000 message filters redone and code unified where
> possible.
> Basic documentation added.
> QEMU_ALIGNED used in definition of CAN frame structure,
> structure and defines are separated from Linux/SocketCAN
> API defined ones to allow to keep QEMU message format
> independed from host system one. Check for correspondence
> to socketcan defines added.
>=20
> Patches version 2:
> The bus emulation and the SJA1000 chip emulation introduced
> by individual patches as suggested by Frederic Konrad.
> Simple example board to test SJA1000 as single memory-mapped BAR
> has been omitted in a new series because emulation of real
> existing boards can provide same functions now.
> Conditionalized debug printfs changed to be exposed to compiler
> syntax check as suggested in review.
>=20
> The work has been started by Jin Yang in the frame of GSoC 2013 slot
> contributed by RTEMS project which has been looking for environment
> to allow develop and test CAN drivers for multiple CPU architectures.
>=20
> I have menthored the project and then done substantial code cleanup
> and update to QOM. Deniz Eren then used emulation for SJA1000 base card=

> driver development for other operating system and contributed
> PCM-3680I and MIOe-3680 support.
>=20
> Some page about the project
>=20
>   https://gitlab.fel.cvut.cz/canbus/qemu-canbus/wikis/home
>=20
> FEE CTU GitLab repository with can-pci branch for 2.3, 2.4, 2.7, 2.8, 2=
=2E10
> and 2.11 QEMU version is available in the repository
>=20
>   https://gitlab.fel.cvut.cz/canbus/qemu-canbus/tree/can-pci
>=20
> mirror at GitHub
>=20
>   https://github.com/CTU-IIG/qemu
>=20
> There are many areas for improvement and extension of the code still
> (for example freeze and migration is not implemented. CAN controllers
> use proper QOM model but bus/interconnection emulation uses simple broa=
dcast
> connection which is required for CAN, but it is not based on QEMU bus m=
odel).
> I have tried to look into QEMU VLANs implementation but it
> does not map straightforward to CAN and I would need some help/opinion
> from more advanced developers to decide what is their right
> mapping to CAN.

I think your series is quite ready to get accepted, although I'm not
sure through with tree it will goes.

Most of my review comments are not blocking issues and might get
addressed later (like having an abstract sja1000).

The principal issue I'd like to discuss with Paolo/Marc-Andr=C3=A9 is the=

chardev backend, they might say it's OK to accept it in this current
state and refactor the CANBus backend later.

I'd still avoid using directly the socket() syscall and use the QEMU
socket API instead (also suggested by Daniel).

>=20
> CAN-FD support would be interesting requires other developers/
> companies contributions or setup of some project to allow invite
> some students and colleagues from my university into project.
>=20
> But I believe that (even in its actual state) provided solution
> is great help for embedded systems developers when they can connect
> SocketCAN from one or more embedded systems running in virtual
> environment together or with Linux host SocketCAN virtual
> or real bus interfaces.
>=20
> We have even tested our generic CANopen device configured
> for CANopen 401 profile for generic I/O running in the virtual
> system which can control GPIO inputs/outputs through virtual
> industrial I/O card.
>=20
> Generally QEMU can be interesting setup which allows
> to test complete industrial and automotive applications
> in virtual environment even before real hardware is availabe.

I have been thinking a bit about how to test some frame operations
(rather than the PCI devices) and the Linux vcan driver might be a good
option (Virtual Local CAN Interface). This is also useful to test this
series without having CAN hardware. How to use vcan might be worth his
own paragraph in docs/can.txt.

Do you think some of your tests can be added in the QEMU test suite
(qtests)?

Regards,

Phil.

>=20
> Deniz Eren (2):
>   CAN bus PCM-3680I PCI (dual SJA1000 channel) emulation added.
>   CAN bus MIOe-3680 PCI (dual SJA1000 channel) emulation added.
>=20
> Pavel Pisa (5):
>   CAN bus simple messages transport implementation for QEMU
>   CAN bus support to connect bust to Linux host SocketCAN interface.
>   CAN bus SJA1000 chip register level emulation for QEMU
>   CAN bus Kvaser PCI CAN-S (single SJA1000 channel) emulation added.
>   QEMU CAN bus emulation documentation
>=20
>  default-configs/pci.mak   |    3 +
>  docs/can.txt              |   78 ++++
>  hw/Makefile.objs          |    1 +
>  hw/can/Makefile.objs      |   14 +
>  hw/can/can_core.c         |  136 ++++++
>  hw/can/can_host_stub.c    |   36 ++
>  hw/can/can_kvaser_pci.c   |  375 +++++++++++++++++
>  hw/can/can_mioe3680_pci.c |  336 +++++++++++++++
>  hw/can/can_pcm3680_pci.c  |  336 +++++++++++++++
>  hw/can/can_sja1000.c      | 1013 +++++++++++++++++++++++++++++++++++++=
++++++++
>  hw/can/can_sja1000.h      |  167 ++++++++
>  hw/can/can_socketcan.c    |  314 ++++++++++++++
>  include/can/can_emu.h     |  131 ++++++
>  13 files changed, 2940 insertions(+)
>  create mode 100644 docs/can.txt
>  create mode 100644 hw/can/Makefile.objs
>  create mode 100644 hw/can/can_core.c
>  create mode 100644 hw/can/can_host_stub.c
>  create mode 100644 hw/can/can_kvaser_pci.c
>  create mode 100644 hw/can/can_mioe3680_pci.c
>  create mode 100644 hw/can/can_pcm3680_pci.c
>  create mode 100644 hw/can/can_sja1000.c
>  create mode 100644 hw/can/can_sja1000.h
>  create mode 100644 hw/can/can_socketcan.c
>  create mode 100644 include/can/can_emu.h
>=20


--ZMcr7rXxdwQhnIi1TjbazVDGXRcRWVBGJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlplzIUACgkQ4+MsLN6t
wN643xAAiM9+v64xbFZAU0yarMH0Whz4j1TLFzSR7XUHK19EGnTTtX3Ll2trA8xs
MmN3Ox682faJDVPY12AEQ1Ss0bR7Mx9mCCaGBIDgHKr+e52ol6zR1nbwLVSP+L5I
ApTfd+i5Xcqtvqb5l9ZTXkfNnyhWX8y6jegDQmRFp5eCTEAz2ZgEqrlD/oycAA++
PeHXHAEdkYj1YMO/38Vzz8XiFnypXeNwJ4kl8nSxGd/MNIyUXWL0hrCRfUmj82Sk
n2q0A4BRKLg9nCelvVCWvm5THGnhrbLOCZBVmnNPAv/hwdxH5YfjPcEsHkuhaB4+
egY2l5nf7YNslsH17INKCENfvubSLUt9DH0PxBx/nVjOTpuwG7WeRL4iAmvxcyNW
vRZ5Y9zErs1xada/+bBV68jgLpBCvkRvKVhNEjkqiFsQMH0EBphT/vr142XNufEk
mOl/iziNqfzqMDeq2bYQFHEW/C6YTvNOw2nilaB2YUDca3IY6bsLXE5qMmvA0BB+
jvwF8d2uCZ1yZx0DQNsHjTi+Tq1sdc+8oP4bdoMNwdOOF4ikXQ+kBVgQ+cMQ7JRt
O0CMbXqbF51eRnZg8WUb66v8ICk3gre3D1v+xqmNOQUPQvzHwh5WLKFWHcY+htUZ
Lp/g41e2B8uW15rh/jkui/SwVD1rRaMbqourjmMhiQprNk/2xcg=
=WxNU
-----END PGP SIGNATURE-----

--ZMcr7rXxdwQhnIi1TjbazVDGXRcRWVBGJ--
