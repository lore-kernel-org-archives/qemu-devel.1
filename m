Received: from eggs.gnu.org ([2001:4830:134:3::10]:50118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHYS-0007V5-Ft
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHYR-0005G3-PO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:36:28 -0400
References: <20180621180224.8312-1-f4bug@amsat.org>
	<20180621180224.8312-10-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9eba4426-6870-29a4-cb4b-63af49350fe9@redhat.com>
Date: Fri, 22 Jun 2018 10:36:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180621180224.8312-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/11] hw/arm/stellaris: Use
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
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 21.06.2018 20:02, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/stellaris.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index a8f1f6a912..d06e366402 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -560,7 +560,7 @@ static void ssys_write(void *opaque, hwaddr offset,
>      case 0x040: /* SRCR0 */
>      case 0x044: /* SRCR1 */
>      case 0x048: /* SRCR2 */
> -        fprintf(stderr, "Peripheral reset not implemented\n");
> +        qemu_log_mask(LOG_UNIMP, "Peripheral reset not implemented\n")=
;
>          break;
>      case 0x054: /* IMC */
>          s->int_mask =3D value & 0x7f;
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
