Received: from eggs.gnu.org ([2001:4830:134:3::10]:38005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv27f-0000Dv-3V
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv27b-0000DN-1I
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:34:19 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv27a-0000DI-Sw
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:34:14 -0400
Received: by mail-qk0-x243.google.com with SMTP id r140so8055002qke.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 06:34:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490978921-3782-1-git-send-email-gsomlo@gmail.com>
	<1490978921-3782-2-git-send-email-gsomlo@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bef9b06c-c29e-4259-96c1-88c0c5950c41@amsat.org>
Date: Mon, 3 Apr 2017 10:34:09 -0300
MIME-Version: 1.0
In-Reply-To: <1490978921-3782-2-git-send-email-gsomlo@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/3] applesmc: cosmetic whitespace and
 indentation cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gabriel L. Somlo" <gsomlo@gmail.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, eshelton@pobox.com

Hi Gabriel,

On 03/31/2017 01:48 PM, Gabriel L. Somlo wrote:
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  hw/misc/applesmc.c | 100 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 51 insertions(+), 49 deletions(-)
>
> diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
> index 77fab5b..986f2ac 100644
> --- a/hw/misc/applesmc.c
> +++ b/hw/misc/applesmc.c
> @@ -39,24 +39,27 @@
>  /* #define DEBUG_SMC */
>
>  #define APPLESMC_DEFAULT_IOBASE        0x300
> -/* data port used by Apple SMC */
> -#define APPLESMC_DATA_PORT             0x0
> -/* command/status port used by Apple SMC */
> -#define APPLESMC_CMD_PORT              0x4
> -#define APPLESMC_NR_PORTS              32
>
> -#define APPLESMC_READ_CMD              0x10
> -#define APPLESMC_WRITE_CMD             0x11
> -#define APPLESMC_GET_KEY_BY_INDEX_CMD  0x12
> -#define APPLESMC_GET_KEY_TYPE_CMD      0x13
> +enum {
> +    APPLESMC_DATA_PORT               = 0x00,
> +    APPLESMC_CMD_PORT                = 0x04,
> +    APPLESMC_NUM_PORTS               = 0x20,
> +};
> +
> +enum {
> +    APPLESMC_READ_CMD                = 0x10,
> +    APPLESMC_WRITE_CMD               = 0x11,
> +    APPLESMC_GET_KEY_BY_INDEX_CMD    = 0x12,
> +    APPLESMC_GET_KEY_TYPE_CMD        = 0x13,
> +};
>
>  #ifdef DEBUG_SMC
>  #define smc_debug(...) fprintf(stderr, "AppleSMC: " __VA_ARGS__)
>  #else
> -#define smc_debug(...) do { } while(0)
> +#define smc_debug(...) do { } while (0)
>  #endif
>
> -static char default_osk[64] = "This is a dummy key. Enter the real key "
> +static char default_osk[65] = "This is a dummy key. Enter the real key "

Here is more than a cosmetic change.

Since this array is initialized you can declare it without specify the size:
static char default_osk[] = ...

OSK0 + OSK1 is 64, why need an extra byte?

Can yoy add some self-explanatory #define and use them later in this file:

     applesmc_add_key(s, "OSK0", 32, s->osk);
     applesmc_add_key(s, "OSK1", 32, s->osk + 32);

and

     if (!s->osk || (strlen(s->osk) != 64)) {
         fprintf(stderr, "WARNING: Using AppleSMC with invalid key\n");


>                                "using the -osk parameter";
>
>  struct AppleSMCData {
> @@ -77,12 +80,11 @@ struct AppleSMCState {
>      uint32_t iobase;
>      uint8_t cmd;
>      uint8_t status;
> -    uint8_t key[4];
> +    char key[4];
>      uint8_t read_pos;
>      uint8_t data_len;
>      uint8_t data_pos;
>      uint8_t data[255];
> -    uint8_t charactic[4];
>      char *osk;
>      QLIST_HEAD(, AppleSMCData) data_def;
>  };
> @@ -93,10 +95,10 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
>      AppleSMCState *s = opaque;
>
>      smc_debug("CMD Write B: %#x = %#x\n", addr, val);
> -    switch(val) {
> -        case APPLESMC_READ_CMD:
> -            s->status = 0x0c;
> -            break;
> +    switch (val) {
> +    case APPLESMC_READ_CMD:
> +        s->status = 0x0c;
> +        break;
>      }
>      s->cmd = val;
>      s->read_pos = 0;
> @@ -123,54 +125,54 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
>      AppleSMCState *s = opaque;
>
>      smc_debug("DATA Write B: %#x = %#x\n", addr, val);
> -    switch(s->cmd) {
> -        case APPLESMC_READ_CMD:
> -            if(s->read_pos < 4) {
> -                s->key[s->read_pos] = val;
> -                s->status = 0x04;
> -            } else if(s->read_pos == 4) {
> -                s->data_len = val;
> -                s->status = 0x05;
> -                s->data_pos = 0;
> -                smc_debug("Key = %c%c%c%c Len = %d\n", s->key[0],
> -                          s->key[1], s->key[2], s->key[3], val);
> -                applesmc_fill_data(s);
> -            }
> -            s->read_pos++;
> -            break;
> +    switch (s->cmd) {
> +    case APPLESMC_READ_CMD:
> +        if (s->read_pos < 4) {
> +            s->key[s->read_pos] = val;
> +            s->status = 0x04;
> +        } else if (s->read_pos == 4) {
> +            s->data_len = val;
> +            s->status = 0x05;
> +            s->data_pos = 0;
> +            smc_debug("Key = %c%c%c%c Len = %d\n", s->key[0],
> +                      s->key[1], s->key[2], s->key[3], val);
> +            applesmc_fill_data(s);
> +        }
> +        s->read_pos++;
> +        break;
>      }
>  }
>
> -static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr1,
> -                                      unsigned size)
> +static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      AppleSMCState *s = opaque;
>      uint8_t retval = 0;
>
> -    switch(s->cmd) {
> -        case APPLESMC_READ_CMD:
> -            if(s->data_pos < s->data_len) {
> -                retval = s->data[s->data_pos];
> -                smc_debug("READ_DATA[%d] = %#hhx\n", s->data_pos,
> -                          retval);
> -                s->data_pos++;
> -                if(s->data_pos == s->data_len) {
> -                    s->status = 0x00;
> -                    smc_debug("EOF\n");
> -                } else
> -                    s->status = 0x05;
> +    switch (s->cmd) {
> +    case APPLESMC_READ_CMD:
> +        if (s->data_pos < s->data_len) {
> +            retval = s->data[s->data_pos];
> +            smc_debug("READ_DATA[%d] = %#hhx\n", s->data_pos,
> +                      retval);
> +            s->data_pos++;
> +            if (s->data_pos == s->data_len) {
> +                s->status = 0x00;
> +                smc_debug("EOF\n");
> +            } else {
> +                s->status = 0x05;
>              }
> +        }
>      }
> -    smc_debug("DATA Read b: %#x = %#x\n", addr1, retval);
> +    smc_debug("DATA Read b: %#x = %#x\n", addr, retval);
>
>      return retval;
>  }
>
> -static uint64_t applesmc_io_cmd_read(void *opaque, hwaddr addr1, unsigned size)
> +static uint64_t applesmc_io_cmd_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      AppleSMCState *s = opaque;
>
> -    smc_debug("CMD Read B: %#x\n", addr1);
> +    smc_debug("CMD Read B: %#x\n", addr);
>      return s->status;
>  }
>
>
