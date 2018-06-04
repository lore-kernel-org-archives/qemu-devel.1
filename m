Received: from eggs.gnu.org ([2001:4830:134:3::10]:33850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fPuBj-0000bs-TO
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fPuBj-00028h-3h
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:26:39 -0400
MIME-Version: 1.0
In-Reply-To: <20180603000827.30872-6-f4bug@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
	<20180603000827.30872-6-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 Jun 2018 11:26:05 -0700
Message-ID: <CAKmqyKPRbvPF8gSwpZ3e4xzbpvb0sii=HF7Av==F-chDqBojzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/8] hw/sd/ssi-sd: Force cards connected in
 SPI mode to use Spec v1.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Sat, Jun 2, 2018 at 5:08 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Can you add a justification for this in the commit message?

Alistair

> ---
>  hw/sd/ssi-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index ae04b6641b..c62fdc871c 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -253,6 +253,8 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
>      /* FIXME use a qdev drive property instead of drive_get_next() */
>      dinfo =3D drive_get_next(IF_SD);
>      carddev =3D qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
> +    object_property_set_uint(OBJECT(carddev),
> +                             SD_PHY_SPECv1_10_VERS, "spec_version", &err=
);
>      if (dinfo) {
>          qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo)=
, &err);
>      }
> --
> 2.17.1
>
>
