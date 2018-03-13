Received: from eggs.gnu.org ([2001:4830:134:3::10]:32788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evhZE-0006hW-4g
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evhZ9-0003ra-72
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:54:04 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evhZ8-0003qQ-WD
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:53:59 -0400
Received: by mail-wr0-x244.google.com with SMTP id m12so21239896wrm.13
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 03:53:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180312214230.17561-1-wsa+renesas@sang-engineering.com>
	<20180312214230.17561-4-wsa+renesas@sang-engineering.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5108cc9b-9fb9-d202-d4bc-a5c1dd4d4f76@amsat.org>
Date: Tue, 13 Mar 2018 11:53:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180312214230.17561-4-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] nvram: at24c: use a sane default for
 "rom-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-devel@nongnu.org
Cc: linux-renesas-soc@vger.kernel.org, Michael Davidsaver <mdavidsaver@gmail.com>

Hi Wolfram,

On 03/12/2018 10:42 PM, Wolfram Sang wrote:
> 0 as "rom-size" doesn't make much sense, let's use the smallest 24cXX
> which has 128 byte.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  hw/nvram/eeprom_at24c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index d82710e1df..de988f8d07 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -168,7 +168,7 @@ void at24c_eeprom_reset(DeviceState *state)
>  }
>  
>  static Property at24c_eeprom_props[] = {
> -    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 0),
> +    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 128),

This patch should goes before your 2/3 in your series.

Can you add a #define for this value? Such AT24C_ROMSIZE_MIN.

With a #define you can add:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      DEFINE_PROP_BOOL("writable", EEPROMState, writable, true),
>      DEFINE_PROP_DRIVE("drive", EEPROMState, blk),
>      DEFINE_PROP_END_OF_LIST()
> 
