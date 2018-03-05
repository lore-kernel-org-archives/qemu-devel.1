Received: from eggs.gnu.org ([2001:4830:134:3::10]:54793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1esn11-0004a1-1E
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1esn0x-0003rA-RZ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:06:43 -0500
Date: Mon, 5 Mar 2018 11:06:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180305110613.2c62b2ab.cohuck@redhat.com>
In-Reply-To: <20180215042900.16078-12-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-12-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/30] hw/s390x: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open
	list:S390" <qemu-s390x@nongnu.org>

On Thu, 15 Feb 2018 01:28:41 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> It ease code review, unit is explicit.

s/ease/eases/

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/s390x/sclp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 276972b59f..8537aa2688 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -526,8 +526,8 @@ static void sclp_realize(DeviceState *dev, Error **er=
rp)
> =20
>      ret =3D s390_set_memory_limit(machine->maxram_size, &hw_limit);
>      if (ret =3D=3D -E2BIG) {
> -        error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
> -                   hw_limit >> 30);
> +        error_setg(&err, "host supports a maximum of %llu GB",
> +                   hw_limit / G_BYTE);
>      } else if (ret) {
>          error_setg(&err, "setting the guest size failed");
>      }

Acked-by: Cornelia Huck <cohuck@redhat.com>
