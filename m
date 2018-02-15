Received: from eggs.gnu.org ([2001:4830:134:3::10]:49176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emCtO-0002Ie-Mk
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emCtL-0005dR-C7
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:19:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50736 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1emCtL-0005cw-7S
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:19:35 -0500
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-6-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <36b2678c-0e9f-9f92-6832-895d7cb1ee89@redhat.com>
Date: Thu, 15 Feb 2018 07:19:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/30] hw/mips/r4k: constify params_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 15.02.2018 05:28, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/mips_r4k.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 830ee7732c..5a74c44b9a 100644
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
> @@ -144,7 +144,6 @@ static int64_t load_kernel(void)
> =20
>      rom_add_blob_fixed("params", params_buf, params_size,
>                         (16 << 20) - 264);
> -
>      g_free(params_buf);
>      return entry;
>  }

The last hunk is an unnecessary white-space change. Did you maybe rather
wanted to replace the 264 in the preceding line instead?

 Thomas
