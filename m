Received: from eggs.gnu.org ([2001:4830:134:3::10]:43287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvicz-0005Dw-Ki
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvicv-0001SH-GJ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:57:29 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvicv-0001SB-C0
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:57:25 -0400
Received: by mail-qt0-x244.google.com with SMTP id r5so1076711qtb.2
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 03:57:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<07368f466735c951eaf53605582085cc7c5feb9b.1491349058.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <17bb7de2-a945-5202-1d1b-759adce5bd87@amsat.org>
Date: Wed, 5 Apr 2017 07:57:20 -0300
MIME-Version: 1.0
In-Reply-To: <07368f466735c951eaf53605582085cc7c5feb9b.1491349058.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 4/5] cadence_gem: Make the revision a
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair23@gmail.com

On 04/04/2017 08:40 PM, Alistair Francis wrote:
> Expose the Cadence GEM revision as a property.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>
>  hw/net/cadence_gem.c         | 6 +++++-
>  include/hw/net/cadence_gem.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index b9eaed4..7047e02 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -300,6 +300,8 @@
>  #define DESC_1_RX_SOF 0x00004000
>  #define DESC_1_RX_EOF 0x00008000
>
> +#define GEM_MODID_VALUE 0x00020118
> +
>  static inline unsigned tx_desc_get_buffer(unsigned *desc)
>  {
>      return desc[0];
> @@ -1213,7 +1215,7 @@ static void gem_reset(DeviceState *d)
>      s->regs[GEM_TXPAUSE] = 0x0000ffff;
>      s->regs[GEM_TXPARTIALSF] = 0x000003ff;
>      s->regs[GEM_RXPARTIALSF] = 0x000003ff;
> -    s->regs[GEM_MODID] = 0x00020118;
> +    s->regs[GEM_MODID] = s->revision;
>      s->regs[GEM_DESCONF] = 0x02500111;
>      s->regs[GEM_DESCONF2] = 0x2ab13fff;
>      s->regs[GEM_DESCONF5] = 0x002f2145;
> @@ -1512,6 +1514,8 @@ static const VMStateDescription vmstate_cadence_gem = {
>
>  static Property gem_properties[] = {
>      DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
> +    DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
> +                       GEM_MODID_VALUE),
>      DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
>                        num_priority_queues, 1),
>      DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
> diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
> index c469ffe..35de622 100644
> --- a/include/hw/net/cadence_gem.h
> +++ b/include/hw/net/cadence_gem.h
> @@ -50,6 +50,7 @@ typedef struct CadenceGEMState {
>      uint8_t num_priority_queues;
>      uint8_t num_type1_screeners;
>      uint8_t num_type2_screeners;
> +    uint32_t revision;
>
>      /* GEM registers backing store */
>      uint32_t regs[CADENCE_GEM_MAXREG];
>
