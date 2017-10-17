Received: from eggs.gnu.org ([2001:4830:134:3::10]:60000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4LqP-0002jm-Tu
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4LqM-0002oR-Rm
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:59:18 -0400
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-3-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <50725210-1e77-a987-b9fc-6185597b5c57@redhat.com>
Date: Tue, 17 Oct 2017 08:59:08 +0200
MIME-Version: 1.0
In-Reply-To: <20171017001209.32276-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/39] MAINTAINERS: add entries for
 dma/i82374
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 17.10.2017 02:11, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f56c1349b..cfd9010e27 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -713,6 +713,7 @@ F: hw/ppc/prep_systemio.c
>  F: hw/ppc/rs6000_mc.c
>  F: hw/pci-host/prep.[hc]
>  F: hw/isa/pc87312.[hc]
> +F: hw/dma/i82374.c
>  F: pc-bios/ppc_rom.bin
> =20
>  sPAPR
> @@ -854,6 +855,7 @@ F: hw/misc/pc-testdev.c
>  F: hw/timer/hpet*
>  F: hw/timer/i8254*
>  F: hw/timer/mc146818rtc*
> +F: include/hw/dma/i8257_dma.h

Does not match $subject. And the file does not exist yet (you just
create it in patch 39). And I think you should CC: the corresponding
maintainers so that they have a chance to say yes or no.

 Thomas
