Received: from eggs.gnu.org ([2001:4830:134:3::10]:49596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRzbZ-0000RC-CM
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRzbT-0002yi-Ul
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:10:13 -0500
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:37131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gRzbT-0002yK-Os
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:10:07 -0500
Received: from player774.ha.ovh.net (unknown [10.109.159.157])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 4519BE48FE
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 14:10:05 +0100 (CET)
References: <1543397736-8198-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <27825a78-913d-3136-de1f-6cd289539b3f@kaod.org>
Date: Wed, 28 Nov 2018 14:09:57 +0100
MIME-Version: 1.0
In-Reply-To: <1543397736-8198-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1?] hw/arm/aspeed: Fix build issue
 with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org

Hello Thomas,

On 11/28/18 10:35 AM, Thomas Huth wrote:
> When using clang 3.4.2, compilation of QEMU fails like this:
>=20
>   CC      aarch64-softmmu/hw/arm/aspeed.o
> hw/arm/aspeed.c:36:3: error: redefinition of typedef 'AspeedBoardState'=
 is a C11
>       feature [-Werror,-Wtypedef-redefinition]
> } AspeedBoardState;
>   ^
> include/hw/arm/aspeed.h:14:33: note: previous definition is here
> typedef struct AspeedBoardState AspeedBoardState;
>                                 ^
> 1 error generated.
> make[1]: *** [hw/arm/aspeed.o] Error 1
> make: *** [subdir-aarch64-softmmu] Error 2
>=20
> Remove the duplicated typedef to fix this issue.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

yes. May be for 3.1.=20

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>  hw/arm/aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 6b33ecd..5158985 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -29,11 +29,11 @@ static struct arm_boot_info aspeed_board_binfo =3D =
{
>      .nb_cpus =3D 1,
>  };
> =20
> -typedef struct AspeedBoardState {
> +struct AspeedBoardState {
>      AspeedSoCState soc;
>      MemoryRegion ram;
>      MemoryRegion max_ram;
> -} AspeedBoardState;
> +};
> =20
>  /* Palmetto hardware value: 0x120CE416 */
>  #define PALMETTO_BMC_HW_STRAP1 (                                      =
  \
>=20
