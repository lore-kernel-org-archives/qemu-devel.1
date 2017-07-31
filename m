Received: from eggs.gnu.org ([2001:4830:134:3::10]:55631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dc9hX-0000lt-4f
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dc9hW-0002mo-By
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:21:35 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dc9hW-0002mE-4t
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:21:34 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t201so47692610wmt.0
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 05:21:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170729234930.725-1-f4bug@amsat.org>
References: <20170729234930.725-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 13:13:05 +0100
Message-ID: <CAFEAcA96EWJqRpmcdr_zD+KyLfnn50zzfui+sNewb4AwWthVHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10] hw/mps2_scc: fix incorrect
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 30 July 2017 at 00:49, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> sorry, I missed them in my review :(
>
>  hw/misc/mps2-scc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
> index cc58d26f29..32be2a9df1 100644
> --- a/hw/misc/mps2-scc.c
> +++ b/hw/misc/mps2-scc.c
> @@ -270,9 +270,9 @@ static Property mps2_scc_properties[] =3D {
>      /* Values for various read-only ID registers (which are specific
>       * to the board model or FPGA image)
>       */
> -    DEFINE_PROP_UINT32("scc-cfg4", MPS2SCC, aid, 0),
> +    DEFINE_PROP_UINT32("scc-cfg4", MPS2SCC, cfg4, 0),
>      DEFINE_PROP_UINT32("scc-aid", MPS2SCC, aid, 0),
> -    DEFINE_PROP_UINT32("scc-id", MPS2SCC, aid, 0),
> +    DEFINE_PROP_UINT32("scc-id", MPS2SCC, id, 0),
>      /* These are the initial settings for the source clocks on the board=
.
>       * In hardware they can be configured via a config file read by the
>       * motherboard configuration controller to suit the FPGA image.
> --
> 2.13.3

Oops, nice catch. Applied to target-arm.next for 2.10.

thanks
-- PMM
