Received: from eggs.gnu.org ([2001:4830:134:3::10]:34901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fPpQE-0005Ae-Et
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fPpQA-0002tZ-9R
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:21:18 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:57369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fPpQA-0002sz-3L
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:21:14 -0400
Received: from player793.ha.ovh.net (unknown [10.109.105.46])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 94756DCF97
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 15:21:12 +0200 (CEST)
References: <20180604110358.2821-1-peter.maydell@linaro.org>
	<20180604110358.2821-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f339f5b5-5bc1-164b-02ee-39a53519d344@kaod.org>
Date: Mon, 4 Jun 2018 15:21:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180604110358.2821-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/mips/mips_malta: don't make bios
 region 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com

On 06/04/2018 01:03 PM, Peter Maydell wrote:
> Currently we use memory_region_init_rom_nomigrate() to create
> the "bios.1fc" memory region, and we don't manually register
> it with vmstate_register_ram(). This currently means that its
> contents are migrated but as a ram block whose name is the empty
> string; in future it may mean they are not migrated at all. Use
> memory_region_init_ram() instead.
>=20
> Note that this is a a cross-version migration compatibility break
> for the "malta" machine.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/mips/mips_malta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index af70ecffc0..927944899b 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1153,7 +1153,7 @@ void mips_malta_init(MachineState *machine)
>       * handled by an overlapping region as the resulting ROM code subp=
age
>       * regions are not executable.
>       */
> -    memory_region_init_ram_nomigrate(bios_copy, NULL, "bios.1fc", BIOS=
_SIZE,
> +    memory_region_init_ram(bios_copy, NULL, "bios.1fc", BIOS_SIZE,
>                             &error_fatal);
>      if (!rom_copy(memory_region_get_ram_ptr(bios_copy),
>                    FLASH_ADDRESS, BIOS_SIZE)) {
>=20
