Received: from eggs.gnu.org ([2001:4830:134:3::10]:45998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB6bt-0006DP-1X
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB6bo-0002Xz-SN
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:35:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dB6bo-0002Xr-Id
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:35:52 -0400
References: <218478942.134698.1495055111655.ref@mail.yahoo.com>
	<218478942.134698.1495055111655@mail.yahoo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f53ede15-95d3-363f-4c44-a6944a11e60c@redhat.com>
Date: Wed, 17 May 2017 16:35:49 -0500
MIME-Version: 1.0
In-Reply-To: <218478942.134698.1495055111655@mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sOeuq6fN5trRG0D4xtBKNXetgtXBbvbdB"
Subject: Re: [Qemu-devel] [PATCH] Add BCM2835 devices to Arm hardware.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Bradley <flypie1@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Geert Martin Ijewski <gm.ijewski@web.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "qemu-website@weilnetz.de" <qemu-website@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sOeuq6fN5trRG0D4xtBKNXetgtXBbvbdB
From: Eric Blake <eblake@redhat.com>
To: John Bradley <flypie1@yahoo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier
 <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Geert Martin Ijewski <gm.ijewski@web.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "qemu-website@weilnetz.de" <qemu-website@weilnetz.de>,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <f53ede15-95d3-363f-4c44-a6944a11e60c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Add BCM2835 devices to Arm hardware.
References: <218478942.134698.1495055111655.ref@mail.yahoo.com>
 <218478942.134698.1495055111655@mail.yahoo.com>
In-Reply-To: <218478942.134698.1495055111655@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 04:05 PM, John Bradley via Qemu-devel wrote:
>>From 0b39a04030d5a2cea4fcd2159d365580ca155b78 Mon Sep 17 00:00:00 2001
> From: John Bradley <flypie@rocketmail.com>
> Date: Wed, 17 May 2017 18:57:21 +0100
> Subject: [PATCH] Add BCM2835 devices to Arm hardware.
>=20

The subject line is not typical; you are missing a 'category: ' prefix,
and most commits don't end in '.'.  I'd suggest:

bcm2835: Add new Arm device

Your commit message is sparse. While the subject does a good one-line
summary of WHAT, the commit body is where you state WHY and/or go into
more details.


> Signed-off-by: John Bradley <flypie@rocketmail.com>
> ---
> hw/arm/bcm2835.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
> 1 file changed, 114 insertions(+)

Adding a new .c file without touching any Makefile snippets is pointless
- your new code does not compile.  Therefore, we cannot validate that it
is useful.  Also, it pays to double-check that MAINTAINERS will cover
the new file (if not, you need to add a section, as we are trying to
avoid adding new files without a listed maintainer).

I'm doing a rough code review (as I can't compile this in isolation, and
don't know what the prerequisites are - but at least this patch is small
enough to be reviewable):

>=20
> diff --git a/hw/arm/bcm2835.c b/hw/arm/bcm2835.c
> new file mode 100644
> index 0000000000..e5744c1620
> --- /dev/null
> +++ b/hw/arm/bcm2835.c
> @@ -0,0 +1,114 @@
> +/*
> + * Raspberry Pi emulation (c) 2012 Gregory Estrade
> + * Upstreaming code cleanup [including bcm2835_*] (c) 2013 Jan Petrous=


Then where is Jan Petrous' Signed-off-by:?

> + *
> + * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microso=
ft
> + * Written by Andrew Baumann

Then where is Andrew Baumann's Signed-off-by:?

> + *
> + * This code is licensed under the GNU GPLv2 and later.

That's not the usual spelling for GPLv2+ as used in other files,
although we haven't been very consistent so it's probably okay.

$ git grep 'or later' | wc
    603    9704   58672
$ git grep 'and later' | wc
     71     734    6032



> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hw/arm/bcm2835.h"
> +#include "hw/arm/raspi_platform.h"
> +#include "hw/sysbus.h"
> +#include "exec/address-spaces.h"
> +
> +
> +/* Peripheral base address seen by the CPU */
> +#define BCM2835_PERI_BASE       0x20000000
> +
> +static void bcm2835_init(Object *obj)
> +{
> +    BCM2835State *s =3D BCM2835(obj);
> +
> +    object_initialize(&s->cpus[0], sizeof(s->cpus[0]), "arm1176-" TYPE=
_ARM_CPU);
> +    object_property_add_child(obj, "cpu", OBJECT(&s->cpus[0]), &error_=
abort);
> +
> +    object_initialize(&s->peripherals, sizeof(s->peripherals),
> +                      TYPE_BCM2835_PERIPHERALS);
> +    object_property_add_child(obj, "peripherals", OBJECT(&s->periphera=
ls),
> +                              &error_abort);

Does this use of error_abort even compile without an #include
"qapi/error.h"?


> +static void bcm2835_realize(DeviceState *dev, Error **errp)
> +{
> +    BCM2835State *s =3D BCM2835(dev);
> +    Object *obj;
> +    Error *err =3D NULL;
> +
> +    /* common peripherals from bcm2835 */
> +    obj =3D object_property_get_link(OBJECT(dev), "ram", &err);
> +    if (obj =3D=3D NULL) {

I personally prefer 'if (!obj)' (less typing), but your use of '(obj =3D=3D=

NULL)' is fine.

> +        error_setg(errp, "%s: required ram link not found: %s",
> +                   __func__, error_get_pretty(err));

error_setg() already includes __func__ as part of its boilerplate; your
explicit use of __func__ is redundant and makes your error look stupid.

It looks like you are trying to add details to an existing error -
rather than calling error_setg(, error_get_pretty(err)), you should
instead use:

obj =3D (, errp);
if (obj =3D=3D NULL) {
    error_prepend(errp, "required ram link not found: ");

> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
> +                            BCM2835_PERI_BASE, 1);
> +
> +    object_property_set_bool(OBJECT(&s->cpus[0]), true, "realized", &e=
rr);
> +    if (err) {
> +        error_report_err(err);
> +        exit(1);

It's weird to mix error_propagate() (return the error to the caller to
deal with) and error_report_err() (report the error to the end user and
exit) in the same function.  You should probably NOT be using
error_report_err() or exit().

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sOeuq6fN5trRG0D4xtBKNXetgtXBbvbdB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHMI1AAoJEKeha0olJ0NqQBwH/jCAs2w5rRUyBhjwVtSy+F46
B7qvkmejU1IG583FAdycW9laIeoVFMqxmCnwuBEtwYGgJ/tYAae1Vuh2Jg0Qd8Rn
RhMQAePz7x053eK/rrE4o5Q4PyuNP70Jr2XJI2J9nyBXxnKY6jldmc47fqSqVZo8
QO01IVapcSJFFBaL6yNNduI535gq7/D0UuN+KJlUteqE93Nm+lxhP0KDi75WrM69
xnKeeTk67v6AZ1MGfBegATgeT8xgz7SfXRs8LoytHYrJFlgvqw+uc47ILcrAIvQ0
AyQwqVf72XqqpPM3feaaxXcnpMsRpza8Kh+wjvb7MYDS7sUo6AbX9qpSaHZ27B0=
=uXgJ
-----END PGP SIGNATURE-----

--sOeuq6fN5trRG0D4xtBKNXetgtXBbvbdB--
