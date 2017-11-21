Received: from eggs.gnu.org ([2001:4830:134:3::10]:39556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHCbe-0004ka-P7
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHCba-0006I9-TN
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:45:10 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHCba-0006Hv-Os
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:45:06 -0500
Received: by mail-oi0-x242.google.com with SMTP id d93so1392572oic.4
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 09:45:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106154813.19936-10-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-10-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 17:44:45 +0000
Message-ID: <CAFEAcA-pwZBVgGHHFttjST=0VvCasEx-eZccBG=3VfLKzerxHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/30] imx_fec: Fix a typo in
 imx_enet_receive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wrot=
e:
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/net/imx_fec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index eefb3b2c62..48d012cad6 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -1121,7 +1121,7 @@ static ssize_t imx_enet_receive(NetClientState *nc,=
 const uint8_t *buf,
>          size +=3D 2;
>      }
>
> -    /* Huge frames are truncted.  */
> +    /* Huge frames are truncated. */
>      if (size > s->regs[ENET_FTRL]) {
>          size =3D s->regs[ENET_FTRL];
>          flags |=3D ENET_BD_TR | ENET_BD_LG;
> --
> 2.13.6
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
