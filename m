Received: from eggs.gnu.org ([2001:4830:134:3::10]:58932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ1wv-0007bd-Ly
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ1wr-0007oo-Of
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:00:49 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180108154303.6522-27-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
	<20180108154303.6522-27-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 9 Jan 2018 14:00:14 -0800
Message-ID: <CAKmqyKOUogkrdonCZmVEg_i70Vf=xrs+5BWTaRH+4KJTsuVsmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 26/31] sdhci: remove the deprecated
 'capareg' property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Gr=C3=A9gory_Estrade?= <gregory.estrade@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Jan 8, 2018 at 7:42 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> All SDHCI consumers have been upgraded to set correct properties.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 34bda73b66..ae914a6ef9 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1194,9 +1194,7 @@ static void sdhci_init_readonly_registers(SDHCIStat=
e *s, Error **errp)
>      }
>      s->version =3D (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
>
> -    if (s->capareg =3D=3D UINT64_MAX) {
> -        sdhci_init_capareg(s, errp);
> -    }
> +    sdhci_init_capareg(s, errp);
>  }
>
>  static void sdhci_initfn(SDHCIState *s)
> @@ -1345,9 +1343,6 @@ static Property sdhci_properties[] =3D {
>      DEFINE_PROP_UINT8("bus-speed", SDHCIState, cap.sdr, 0),
>      DEFINE_PROP_UINT8("driver-strength", SDHCIState, cap.strength, 0),
>
> -    /* capareg: deprecated */
> -    DEFINE_PROP_UINT64("capareg", SDHCIState, capareg, UINT64_MAX),
> -
>      DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
>      DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_=
quirk,
>                       false),
> --
> 2.15.1
>
>
