Received: from eggs.gnu.org ([2001:4830:134:3::10]:59455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dOWut-0002FG-9n
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dOWus-0004Di-Em
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:19:03 -0400
References: <20170609150600.4654-1-f4bug@amsat.org>
	<20170609150600.4654-2-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <e8e3e476-6cc3-30b8-b4b1-cc91704293d6@redhat.com>
Date: Fri, 23 Jun 2017 18:18:55 -0400
MIME-Version: 1.0
In-Reply-To: <20170609150600.4654-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] arm/highbank: use defined type
 name instead of hard-coded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org



On 06/09/2017 11:05 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/highbank.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index d209b97dee..dd809b404b 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -31,6 +31,7 @@
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
>  #include "hw/char/pl011.h"
> +#include "hw/ide/ahci.h"
> =20
>  #define SMP_BOOT_ADDR           0x100
>  #define SMP_BOOT_REG            0x40
> @@ -341,7 +342,7 @@ static void calxeda_init(MachineState *machine, enu=
m cxmachines machine_id)
>      sysbus_create_simple("pl031", 0xfff35000, pic[19]);
>      sysbus_create_simple("pl022", 0xfff39000, pic[23]);
> =20
> -    sysbus_create_simple("sysbus-ahci", 0xffe08000, pic[83]);
> +    sysbus_create_simple(TYPE_SYSBUS_AHCI, 0xffe08000, pic[83]);
> =20
>      if (nd_table[0].used) {
>          qemu_check_nic_model(&nd_table[0], "xgmac");
>=20

This patch is fine, I took a stab at fixing the include issues in a
separate series. Try it all out and let me know.

--js
