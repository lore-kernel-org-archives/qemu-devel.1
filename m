Received: from eggs.gnu.org ([2001:4830:134:3::10]:39591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fENu4-0006J9-3X
	for qemu-devel@nongnu.org; Thu, 03 May 2018 19:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fENu2-0001ij-UF
	for qemu-devel@nongnu.org; Thu, 03 May 2018 19:44:48 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.41798.1525379108.27994.qemu-ppc@nongnu.org>
Date: Thu, 3 May 2018 19:44:37 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5AEF48F-E82A-4053-945A-E5D92BF60DEF@gmail.com>
References: <mailman.41798.1525379108.27994.qemu-ppc@nongnu.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/3] uninorth: create new
 uninorth device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>


> Commit 4e46dcdbd3 "PPC: Newworld: Add uninorth token register" added a =
TODO
> which was to convert the uninorth registers hack to a proper device. =
Move
> these registers to a new uninorth device, removing the old hacks from
> mac_newworld.c.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daud? <f4bug@amsat.org>

<snip>

> +
> +static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    uint32_t value;
> +
> +    value =3D 0;
> +    switch (addr) {
> +    case 0:
> +        value =3D *(int *)opaque;
> +    }

This code caught my attention. Is it possible that values other than =
zero could be passed as the address?

If keeping the switch statement is a must, perhaps a default case should =
be added that alerts the user an unprogrammed response was detected.

Also I think "case 0" might not be descriptive enough. Could the zero be =
replaced with a macro that describes what this case is?

> +
> +    trace_unin_read(addr, value);
> +
> +    return value;
> +}
> +
>=20
