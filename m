Received: from eggs.gnu.org ([2001:4830:134:3::10]:51327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs04A-00080K-Ez
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs043-0004qk-3W
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:22:58 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:40489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs042-0004pX-Al
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:22:50 -0400
Received: by mail-qt0-x231.google.com with SMTP id h4-v6so18970347qtj.7
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 23:22:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
	<1534796770-10295-2-git-send-email-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2e4c8ae9-a2ef-6286-a85e-ad65c7df265f@amsat.org>
Date: Tue, 21 Aug 2018 03:22:41 -0300
MIME-Version: 1.0
In-Reply-To: <1534796770-10295-2-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/10] i2c:pm_smbus: Clean up some style
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S . Tsirkin" <mst@redhat.com>

Hi Corey,

On 08/20/2018 05:26 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Fix some spacing issues, remove extraneous comments, add some
> defines instead of hard-coding numbers.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i2c/pm_smbus.c | 58 ++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index 0d26e0f..83c2377 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -22,8 +22,6 @@
>  #include "hw/i2c/pm_smbus.h"
>  #include "hw/i2c/smbus.h"
>  
> -/* no save/load? */
> -
>  #define SMBHSTSTS       0x00
>  #define SMBHSTCNT       0x02
>  #define SMBHSTCMD       0x03
> @@ -32,19 +30,34 @@
>  #define SMBHSTDAT1      0x06
>  #define SMBBLKDAT       0x07
>  
> -#define STS_HOST_BUSY   (1)
> -#define STS_INTR        (1<<1)
> -#define STS_DEV_ERR     (1<<2)
> -#define STS_BUS_ERR     (1<<3)
> -#define STS_FAILED      (1<<4)
> -#define STS_SMBALERT    (1<<5)
> -#define STS_INUSE_STS   (1<<6)
> -#define STS_BYTE_DONE   (1<<7)
> +#define STS_HOST_BUSY   (1 << 0)
> +#define STS_INTR        (1 << 1)
> +#define STS_DEV_ERR     (1 << 2)
> +#define STS_BUS_ERR     (1 << 3)
> +#define STS_FAILED      (1 << 4)
> +#define STS_SMBALERT    (1 << 5)
> +#define STS_INUSE_STS   (1 << 6)
> +#define STS_BYTE_DONE   (1 << 7)
>  /* Signs of successfully transaction end :
>  *  ByteDoneStatus = 1 (STS_BYTE_DONE) and INTR = 1 (STS_INTR )
>  */
>  
> -//#define DEBUG
> +#define CTL_INTREN      (1 << 0)
> +#define CTL_KILL        (1 << 1)
> +#define CTL_LAST_BYTE   (1 << 5)
> +#define CTL_START       (1 << 6)
> +#define CTL_PEC_EN      (1 << 7)
> +#define CTL_RETURN_MASK 0x1f
> +

What about using an enum { ...

> +#define PROT_QUICK          0
> +#define PROT_BYTE           1
> +#define PROT_BYTE_DATA      2
> +#define PROT_WORD_DATA      3
> +#define PROT_PROC_CALL      4
> +#define PROT_BLOCK_DATA     5
> +#define PROT_I2C_BLOCK_DATA 6

}; ?

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
> +/*#define DEBUG*/
>  
>  #ifdef DEBUG
>  # define SMBUS_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
> @@ -70,11 +83,12 @@ static void smb_transaction(PMSMBus *s)
>      if ((s->smb_stat & STS_DEV_ERR) != 0)  {
>          goto error;
>      }
> +
>      switch(prot) {
> -    case 0x0:
> +    case PROT_QUICK:
>          ret = smbus_quick_command(bus, addr, read);
>          goto done;
> -    case 0x1:
> +    case PROT_BYTE:
>          if (read) {
>              ret = smbus_receive_byte(bus, addr);
>              goto data8;
> @@ -82,7 +96,7 @@ static void smb_transaction(PMSMBus *s)
>              ret = smbus_send_byte(bus, addr, cmd);
>              goto done;
>          }
> -    case 0x2:
> +    case PROT_BYTE_DATA:
>          if (read) {
>              ret = smbus_read_byte(bus, addr, cmd);
>              goto data8;
> @@ -91,16 +105,17 @@ static void smb_transaction(PMSMBus *s)
>              goto done;
>          }
>          break;
> -    case 0x3:
> +    case PROT_WORD_DATA:
>          if (read) {
>              ret = smbus_read_word(bus, addr, cmd);
>              goto data16;
>          } else {
> -            ret = smbus_write_word(bus, addr, cmd, (s->smb_data1 << 8) | s->smb_data0);
> +            ret = smbus_write_word(bus, addr, cmd,
> +                                   (s->smb_data1 << 8) | s->smb_data0);
>              goto done;
>          }
>          break;
> -    case 0x5:
> +    case PROT_I2C_BLOCK_DATA:
>          if (read) {
>              ret = smbus_read_block(bus, addr, cmd, s->smb_data);
>              goto data8;
> @@ -158,8 +173,9 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
>          break;
>      case SMBHSTCNT:
>          s->smb_ctl = val;
> -        if (val & 0x40)
> +        if (s->smb_ctl & CTL_START) {
>              smb_transaction_start(s);
> +        }
>          break;
>      case SMBHSTCMD:
>          s->smb_cmd = val;
> @@ -198,7 +214,7 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
>          break;
>      case SMBHSTCNT:
>          s->smb_index = 0;
> -        val = s->smb_ctl & 0x1f;
> +        val = s->smb_ctl & CTL_RETURN_MASK;
>          break;
>      case SMBHSTCMD:
>          val = s->smb_cmd;
> @@ -221,7 +237,9 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
>          val = 0;
>          break;
>      }
> -    SMBUS_DPRINTF("SMB readb port=0x%04" HWADDR_PRIx " val=0x%02x\n", addr, val);
> +    SMBUS_DPRINTF("SMB readb port=0x%04" HWADDR_PRIx " val=0x%02x\n",
> +                  addr, val);
> +
>      return val;
>  }
>  
> 
