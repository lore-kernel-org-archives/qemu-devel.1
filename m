Received: from eggs.gnu.org ([2001:4830:134:3::10]:35175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dB3qb-0005pL-RX
	for qemu-devel@nongnu.org; Wed, 17 May 2017 14:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dB3qY-0004i8-NG
	for qemu-devel@nongnu.org; Wed, 17 May 2017 14:38:57 -0400
Received: from sonic314-47.consmr.mail.ir2.yahoo.com ([77.238.177.173]:38122)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dB3qY-0004hF-A4
	for qemu-devel@nongnu.org; Wed, 17 May 2017 14:38:54 -0400
Date: Wed, 17 May 2017 18:34:51 +0000 (UTC)
From: John Bradley <flypie1@yahoo.com>
Reply-To: John Bradley <flypie1@yahoo.com>
Message-ID: <107015620.2969780.1495046091978@mail.yahoo.com>
In-Reply-To: <3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
	<684185116.2952708.1495044580181@mail.yahoo.com>
	<3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom
 Perhiperals for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Geert Martin Ijewski <gm.ijewski@web.de>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This is especial true as I meant Andrew Baumann 0xabu (Andrew Baumann)

 =20
| =20
|  =20
|  =20
|   |    |

   |

  |
| =20
|    | =20
0xabu (Andrew Baumann)
 0xabu has 3 repositories available. Follow their code on GitHub.  |   |

  |

  |

=20

=C2=A0John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge H=
ill Liverpool L7 7AF=20

    On Wednesday, 17 May 2017, 19:27, Eric Blake <eblake@redhat.com> wrote:
=20

 On 05/17/2017 01:09 PM, John Bradley via Qemu-devel wrote:
> Also available at=20
>=20
> https://www.dropbox.com/s/gwuquw0kirstw7a/0001-Add-Markus-Armbrusters-cod=
e-for-Broadcom-Perhiperals.patch?dl=3D0

This content belongs...

>=20
> Following suggestions split my original patch up. This the largest monoli=
thic chunk is=20
> additional BCM device support from Markus Armbruster.
>=20
>=20
>>From 0b39a04030d5a2cea4fcd2159d365580ca155b78 Mon Sep 17 00:00:00 2001
> From: John Bradley <flypie@rocketmail.com>
> Date: Wed, 17 May 2017 18:57:21 +0100
> Subject: [PATCH] Add Markus Armbrusters code for Broadcom Perhiperals for=
 ARM.
>=20
> Signed-off-by: John Bradley <flypie@rocketmail.com>

I would expect that if some of this code was written by Markus, then it
would carry his Signed-off-by.=C2=A0 Or, maybe you just mean that you are
splitting your patch according to the device Markus gave (in which case,
a Suggested-by: tag may be appropriate).=C2=A0 Either way, I don't see why
Markus' name has to be in the subject line (the patch subject should be
WHAT changed, not WHO suggested the change).

> ---

...here, after the --- separator.=C2=A0 It is useful to reviewers, but shou=
ld
not end up as part of the actual commit message.

> hw/arm/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 2 +-
> hw/arm/bcm2835.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 114 ++++
> hw/arm/bcm2835_peripherals.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 104 ++++
> hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 2 +
> hw/misc/bcm2835_mphi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 163 ++++++
> hw/misc/bcm2835_power.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 106 ++++
> hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 2 +
> hw/timer/bcm2835_st.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 202 +++++++
> hw/timer/bcm2835_timer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 224 +++++++
> hw/usb/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 4 +-
> hw/usb/bcm2835_usb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 604 +++++++++++++++++++
> hw/usb/bcm2835_usb_regs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1061=
 ++++++++++++++++++++++++++++++++++

That's still rather large to review in one chunk, especially while
touching other files.=C2=A0 It can probably still be split up further.

> include/hw/arm/bcm2835.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 37 ++
> include/hw/arm/bcm2835_peripherals.h |=C2=A0 10 +
> include/hw/intc/bcm2835_control.h=C2=A0 =C2=A0 |=C2=A0 53 ++
> include/hw/misc/bcm2835_mphi.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 28 +
> include/hw/misc/bcm2835_power.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 22 +
> include/hw/timer/bcm2835_st.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 25 +
> include/hw/timer/bcm2835_timer.h=C2=A0 =C2=A0 |=C2=A0 32 +
> include/hw/usb/bcm2835_usb.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 78 +++
> 20 files changed, 2871 insertions(+), 2 deletions(-)
> create mode 100644 hw/arm/bcm2835.c
> create mode 100644 hw/misc/bcm2835_mphi.c
> create mode 100644 hw/misc/bcm2835_power.c
> create mode 100644 hw/timer/bcm2835_st.c
> create mode 100644 hw/timer/bcm2835_timer.c
> create mode 100644 hw/usb/bcm2835_usb.c
> create mode 100644 hw/usb/bcm2835_usb_regs.h
> create mode 100644 include/hw/arm/bcm2835.h
> create mode 100644 include/hw/intc/bcm2835_control.h
> create mode 100644 include/hw/misc/bcm2835_mphi.h
> create mode 100644 include/hw/misc/bcm2835_power.h
> create mode 100644 include/hw/timer/bcm2835_st.h
> create mode 100644 include/hw/timer/bcm2835_timer.h
> create mode 100644 include/hw/usb/bcm2835_usb.h
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +1-919-301-3266
Virtualization:=C2=A0 qemu.org | libvirt.org


  =20
