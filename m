Received: from eggs.gnu.org ([2001:4830:134:3::10]:35446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fYAof-0001U6-M4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fYAoa-000211-RY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:49:01 -0400
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-30-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8ced7c8b-94f4-6378-0b2d-39158726e2ee@redhat.com>
Date: Wed, 27 Jun 2018 15:48:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-30-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 29/46] hw/mips/r4k: Constify params_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-trivial@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 25.06.2018 14:42, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/mips_r4k.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index e5cf8ed1a3..fc38b4bf99 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -79,8 +79,9 @@ typedef struct ResetData {
> =20
>  static int64_t load_kernel(void)
>  {
> +    const size_t params_size =3D 264;
>      int64_t entry, kernel_high;
> -    long kernel_size, initrd_size, params_size;
> +    long kernel_size, initrd_size;
>      ram_addr_t initrd_offset;
>      uint32_t *params_buf;
>      int big_endian;
> @@ -128,7 +129,6 @@ static int64_t load_kernel(void)
>      }
> =20
>      /* Store command line.  */
> -    params_size =3D 264;
>      params_buf =3D g_malloc(params_size);
> =20
>      params_buf[0] =3D tswap32(ram_size);
> @@ -143,7 +143,7 @@ static int64_t load_kernel(void)
>      }
> =20
>      rom_add_blob_fixed("params", params_buf, params_size,
> -                       (16 << 20) - 264);
> +                       (16 << 20) - params_size);
> =20
>      g_free(params_buf);
>      return entry;

Reviewed-by: Thomas Huth <thuth@redhat.com>
