Received: from eggs.gnu.org ([2001:4830:134:3::10]:47266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ey5PR-0000Yf-8Z
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ey5PM-0002H0-Br
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:45:49 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ey5PM-0002FD-55
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:45:44 -0400
Received: by mail-wr0-x243.google.com with SMTP id f14so20400271wre.8
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 17:45:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180319213101.6100-1-wsa+renesas@sang-engineering.com>
	<20180319213101.6100-3-wsa+renesas@sang-engineering.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e1c19d1a-0d1b-f4b6-e255-649ab0349e2d@amsat.org>
Date: Tue, 20 Mar 2018 01:45:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180319213101.6100-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] nvram: at24c: use a sane default
 for "rom-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-devel@nongnu.org
Cc: linux-renesas-soc@vger.kernel.org

On 03/19/2018 10:31 PM, Wolfram Sang wrote:
> 0 as "rom-size" will lead to an error message. Let's use the size of a
> small 24c01 which has 128 byte.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/nvram/eeprom_at24c.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index ccf78b25e4..ab1ef686e2 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -28,6 +28,9 @@
>  #define TYPE_AT24C_EE "at24c-eeprom"
>  #define AT24C_EE(obj) OBJECT_CHECK(EEPROMState, (obj), TYPE_AT24C_EE)
>  
> +/* default is the size of a 24c01 EEPROM */
> +#define AT24C_ROMSIZE_DEFAULT 128
> +
>  typedef struct EEPROMState {
>      I2CSlave parent_obj;
>  
> @@ -171,7 +174,7 @@ void at24c_eeprom_reset(DeviceState *state)
>  }
>  
>  static Property at24c_eeprom_props[] = {
> -    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 0),
> +    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, AT24C_ROMSIZE_DEFAULT),
>      DEFINE_PROP_BOOL("writable", EEPROMState, writable, true),
>      DEFINE_PROP_DRIVE("drive", EEPROMState, blk),
>      DEFINE_PROP_END_OF_LIST()
> 
