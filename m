Received: from eggs.gnu.org ([2001:4830:134:3::10]:34575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emDc1-0001Gs-TB
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 02:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emDc1-00060e-49
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 02:05:45 -0500
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-12-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ad3f0eda-f60f-1aa6-b587-87798970da59@redhat.com>
Date: Thu, 15 Feb 2018 08:05:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 11/30] hw/s390x: use the
 BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:S390" <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 15.02.2018 05:28, Philippe Mathieu-Daud=C3=A9 wrote:
> It ease code review, unit is explicit.
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
> @@ -526,8 +526,8 @@ static void sclp_realize(DeviceState *dev, Error **=
errp)
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
