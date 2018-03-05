Received: from eggs.gnu.org ([2001:4830:134:3::10]:34273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esni8-0005Dd-5H
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esni7-0005rc-Ca
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:51:16 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-3-f4bug@amsat.org>
	<8fd4272f-8c40-3804-8449-752aea88a7cc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5036928a-f7dd-ae77-9ca4-0aaa9d5b8673@amsat.org>
Date: Mon, 5 Mar 2018 07:50:50 -0300
MIME-Version: 1.0
In-Reply-To: <8fd4272f-8c40-3804-8449-752aea88a7cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/30] hw: include "qemu/cunits.h" and
 clean unused "qemu/cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Marek Vasut <marex@denx.de>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Chris Wulff <crwulff@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Paul Burton <paul.burton@mips.com>, qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

Hi Thomas,

On 02/15/2018 03:10 AM, Thomas Huth wrote:
> On 15.02.2018 05:28, Philippe Mathieu-Daudé wrote:
>> These files were including "qemu/cutils.h" to use the byte-based size
>> definitions, now available in "qemu/cunits.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/hw.h       | 1 +
>>  hw/arm/msf2-soc.c     | 1 -
>>  hw/arm/msf2-som.c     | 1 -
>>  hw/core/loader-fit.c  | 1 -
>>  hw/core/loader.c      | 1 -
>>  hw/core/machine.c     | 1 -
>>  hw/cris/boot.c        | 1 -
>>  hw/display/sm501.c    | 1 -
>>  hw/hppa/machine.c     | 1 -
>>  hw/lm32/milkymist.c   | 1 -
>>  hw/microblaze/boot.c  | 1 -
>>  hw/mips/boston.c      | 1 -
>>  hw/misc/mos6522.c     | 1 -
>>  hw/nios2/boot.c       | 1 -
>>  hw/ppc/mac_newworld.c | 1 -
>>  hw/ppc/mac_oldworld.c | 1 -
>>  hw/ppc/pnv.c          | 1 -
>>  hw/ppc/prep.c         | 1 -
>>  hw/ppc/spapr_rtas.c   | 1 -
>>  hw/sd/sdhci.c         | 1 -
>>  hw/sparc/sun4m.c      | 1 -
>>  hw/sparc64/sun4u.c    | 1 -
>>  hw/usb/dev-serial.c   | 1 -
>>  hw/usb/dev-storage.c  | 1 -
>>  24 files changed, 1 insertion(+), 23 deletions(-)
>>
>> diff --git a/include/hw/hw.h b/include/hw/hw.h
>> index ab4950c312..8249448cac 100644
>> --- a/include/hw/hw.h
>> +++ b/include/hw/hw.h
>> @@ -14,6 +14,7 @@
>>  #include "migration/qemu-file-types.h"
>>  #include "qemu/module.h"
>>  #include "sysemu/reset.h"
>> +#include "qemu/cunits.h"
> 
> Instead of adding this to a header and creating yet another possible
> recompile-the-world dependency this way, wouldn't it be better to
> include the cunits.h only from the .c files that need the definitions?

I was waiting for other opinions but I can change if you prefer;
meanwhile I'll respin this patch as RFC.

Regards,

Phil.
