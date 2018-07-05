Received: from eggs.gnu.org ([2001:4830:134:3::10]:36624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fawzO-0000JQ-Ue
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fawzJ-0001TW-UD
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fawzJ-0001S3-PW
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-8-f4bug@amsat.org>
Date: Thu, 05 Jul 2018 07:39:24 +0200
In-Reply-To: <20180704153919.12432-8-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Jul 2018 12:39:18
	-0300")
Message-ID: <87lgaqckc3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/8] hw/pci-host: Remove useless
 parenthesis around DIV_ROUND_UP macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Patch created mechanically by rerunning:
>
>   $  spatch --sp-file scripts/coccinelle/round.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/pci-host/piix.c | 2 +-
>  hw/pci-host/q35.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 0e608347c1..317c0feca6 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -144,7 +144,7 @@ static void i440fx_update_memory_mappings(PCII440FXSt=
ate *d)
>      memory_region_transaction_begin();
>      for (i =3D 0; i < 13; i++) {
>          pam_update(&d->pam_regions[i], i,
> -                   pd->config[I440FX_PAM + (DIV_ROUND_UP(i, 2))]);
> +                   pd->config[I440FX_PAM + DIV_ROUND_UP(i, 2)]);
>      }
>      memory_region_set_enabled(&d->smram_region,
>                                !(pd->config[I440FX_SMRAM] & SMRAM_D_OPEN)=
);
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 02f9576588..b3a5b3036d 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -352,7 +352,7 @@ static void mch_update_pam(MCHPCIState *mch)
>      memory_region_transaction_begin();
>      for (i =3D 0; i < 13; i++) {
>          pam_update(&mch->pam_regions[i], i,
> -                   pd->config[MCH_HOST_BRIDGE_PAM0 + (DIV_ROUND_UP(i, 2)=
)]);
> +                   pd->config[MCH_HOST_BRIDGE_PAM0 + DIV_ROUND_UP(i, 2)]=
);
>      }
>      memory_region_transaction_commit();
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
