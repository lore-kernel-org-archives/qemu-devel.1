Received: from eggs.gnu.org ([2001:4830:134:3::10]:39345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkQB-0000fI-8Y
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 13:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkQ6-0005SM-Cj
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 13:43:35 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkQ6-0005Q0-6x
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 13:43:30 -0400
Received: by mail-qt0-x242.google.com with SMTP id w1so20001259qtg.0
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 10:43:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-7-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48f1c503-f31d-9f65-7a5f-2bf8dee92313@amsat.org>
Date: Sat, 10 Jun 2017 14:43:22 -0300
MIME-Version: 1.0
In-Reply-To: <1497097821-32754-7-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/6] fw_cfg: move QOM type defines into
 fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

On 06/10/2017 09:30 AM, Mark Cave-Ayland wrote:
> This allows the device to be instantiated externally.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/nvram/fw_cfg.c         |    8 --------
>  include/hw/nvram/fw_cfg.h |    8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 4159316..b77de00 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -40,14 +40,6 @@
>  #define FW_CFG_NAME "fw_cfg"
>  #define FW_CFG_PATH "/machine/" FW_CFG_NAME
>
> -#define TYPE_FW_CFG     "fw_cfg"
> -#define TYPE_FW_CFG_IO  "fw_cfg_io"
> -#define TYPE_FW_CFG_MEM "fw_cfg_mem"
> -
> -#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
> -#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
> -#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
> -
>  /* FW_CFG_VERSION bits */
>  #define FW_CFG_VERSION      0x01
>  #define FW_CFG_VERSION_DMA  0x02
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index b980cba..e515698 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -4,6 +4,14 @@
>  #include "exec/hwaddr.h"
>  #include "hw/nvram/fw_cfg_keys.h"
>
> +#define TYPE_FW_CFG     "fw_cfg"
> +#define TYPE_FW_CFG_IO  "fw_cfg_io"
> +#define TYPE_FW_CFG_MEM "fw_cfg_mem"
> +
> +#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
> +#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
> +#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
> +
>  typedef struct FWCfgFile {
>      uint32_t  size;        /* file size */
>      uint16_t  select;      /* write this to 0x510 to read it */
>
