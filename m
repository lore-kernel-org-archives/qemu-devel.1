Received: from eggs.gnu.org ([2001:4830:134:3::10]:44313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPq4j-00082h-JG
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPq4d-0005Ht-N4
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:03:09 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPq4d-0005HV-Ic
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:03:03 -0400
Received: by mail-qt0-x243.google.com with SMTP id y31-v6so10474049qty.9
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 07:03:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180604110358.2821-1-peter.maydell@linaro.org>
	<20180604110358.2821-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2921042b-a6a5-30d0-6541-014b3e39411f@amsat.org>
Date: Mon, 4 Jun 2018 11:02:59 -0300
MIME-Version: 1.0
In-Reply-To: <20180604110358.2821-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Juan Quintela <quintela@redhat.com>, patches@linaro.org, dgilbert@redhat.com, Paul Burton <paul.burton@mips.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 06/04/2018 08:03 AM, Peter Maydell wrote:
> Currently we use memory_region_init_rom_nomigrate() to create
> the "bios.1fc" memory region, and we don't manually register
> it with vmstate_register_ram(). This currently means that its
> contents are migrated but as a ram block whose name is the empty
> string; in future it may mean they are not migrated at all. Use
> memory_region_init_ram() instead.
> 
> Note that this is a a cross-version migration compatibility break
> for the "malta" machine.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/mips/mips_malta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index af70ecffc0..927944899b 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1153,7 +1153,7 @@ void mips_malta_init(MachineState *machine)
>       * handled by an overlapping region as the resulting ROM code subpage
>       * regions are not executable.
>       */
> -    memory_region_init_ram_nomigrate(bios_copy, NULL, "bios.1fc", BIOS_SIZE,
> +    memory_region_init_ram(bios_copy, NULL, "bios.1fc", BIOS_SIZE,
>                             &error_fatal);
>      if (!rom_copy(memory_region_get_ram_ptr(bios_copy),
>                    FLASH_ADDRESS, BIOS_SIZE)) {
> 
