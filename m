Received: from eggs.gnu.org ([208.118.235.92]:53970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf3Ju-0004DJ-5A
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf3Jq-000406-2Q
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:45:58 -0500
Received: from m12-17.163.com ([220.181.12.17]:38387)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf3Jp-0003wg-1P
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:45:54 -0500
MIME-Version: 1.0
From: Li Qiang <liq3ea@163.com>
Date: Thu, 3 Jan 2019 21:45:17 +0800
In-Reply-To: <0cecbd74-2fe7-6bda-d92e-f7ba8e912800@redhat.com>
References: <20190103132605.49476-1-liq3ea@163.com>
	<0cecbd74-2fe7-6bda-d92e-f7ba8e912800@redhat.com>
Message-Id: <5C2E11EF.D7E244.23880@m12-17.163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiAgW1BBVENIXSB1c2I6IGRldi1tdHA6?=
 =?utf-8?q?_fix_memory_leak_in_error_path?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "kraxel@redhat.com" <kraxel@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Oh, sorry, I always forget to add this =E2=80=9CFixs: xxx=E2=80=9D for thes=
e small issues.

Thanks,
Li Qiang


=E5=8F=91=E4=BB=B6=E4=BA=BA: Philippe Mathieu-Daud=C3=A9
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2019=E5=B9=B41=E6=9C=883=E6=97=A5 21:=
38
=E6=94=B6=E4=BB=B6=E4=BA=BA: Li Qiang; kraxel@redhat.com
=E6=8A=84=E9=80=81: peter.maydell@linaro.org; qemu-devel@nongnu.org
=E4=B8=BB=E9=A2=98: Re: [Qemu-devel] [PATCH] usb: dev-mtp: fix memory leak =
in error path

On 1/3/19 2:26 PM, Li Qiang wrote:
> Spotted by Coverity: CID 1397074
>=20

Gerd, if you take this, can you add:

Fixes: c52d46e041b
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  hw/usb/dev-mtp.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 6098005cd4..b19b576278 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1729,6 +1729,7 @@ static void usb_mtp_write_metadata(MTPState *s, uin=
t64_t dlen)
>      if (strchr(filename, '/')) {
>          usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
>                               0, 0, 0, 0);
> +        g_free(filename);
>          return;
>      }
> =20
>=20
