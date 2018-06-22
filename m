Received: from eggs.gnu.org ([2001:4830:134:3::10]:48197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWS7z-0005Lo-U6
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWS7z-00050H-3D
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:53:52 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-14-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a3f1d1f7-3435-3056-1c19-76c706098f3f@redhat.com>
Date: Fri, 22 Jun 2018 21:53:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180622134036.23182-14-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/14] hw/net/smc91c111: Use
 qemu_log_mask(UNIMP) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>

On 22.06.2018 15:40, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/net/smc91c111.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
> index 9094c0b47c..d2fd2040e8 100644
> --- a/hw/net/smc91c111.c
> +++ b/hw/net/smc91c111.c
> @@ -362,10 +362,14 @@ static void smc91c111_writeb(void *opaque, hwaddr=
 offset,
>              SET_HIGH(gpr, value);
>              return;
>          case 12: /* Control */
> -            if (value & 1)
> -                fprintf(stderr, "smc91c111:EEPROM store not implemente=
d\n");
> -            if (value & 2)
> -                fprintf(stderr, "smc91c111:EEPROM reload not implement=
ed\n");
> +            if (value & 1) {
> +                qemu_log_mask(LOG_UNIMP,
> +                              "smc91c111: EEPROM store not implemented=
\n");
> +            }
> +            if (value & 2) {
> +                qemu_log_mask(LOG_UNIMP,
> +                              "smc91c111: EEPROM reload not implemente=
d\n");
> +            }
>              value &=3D ~3;
>              SET_LOW(ctr, value);
>              return;

Reviewed-by: Thomas Huth <thuth@redhat.com>
