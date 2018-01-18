Received: from eggs.gnu.org ([2001:4830:134:3::10]:57339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec8tM-0007ai-T3
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec8tM-0006D5-1g
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:02:00 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ec8tL-0006CE-TM
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:01:59 -0500
Received: by mail-ot0-x244.google.com with SMTP id d9so522309oth.6
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 04:01:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180111045937.2119-4-david@gibson.dropbear.id.au>
References: <20180111045937.2119-1-david@gibson.dropbear.id.au>
	<20180111045937.2119-4-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 12:01:38 +0000
Message-ID: <CAFEAcA-8EyPp4AKnnDW647HX3j+a8SfVcr4Y5tiBnzgR+ErUYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 03/11] sm501: Add some more unimplemented
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, surajjs@au1.ibm.com, BALATON Zoltan <balaton@eik.bme.hu>

On 11 January 2018 at 04:59, David Gibson <david@gibson.dropbear.id.au> wrote:
> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> These are not really implemented (just return zero or default values)
> but add these so guests accessing them can run.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/display/sm501.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index b9b611131e..4f7dc59b25 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -795,6 +795,8 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
>      case SM501_ARBTRTN_CONTROL:
>          ret = s->arbitration_control;
>          break;
> +    case SM501_COMMAND_LIST_STATUS:
> +        ret = 0x00180002; /* FIFOs are empty, everything idle */
>      case SM501_IRQ_MASK:
>          ret = s->irq_mask;
>          break;

Is this new case missing a "break;" statement? Coverity points
out that we fall through and overwrite the previous assignment
to 'ret' (CID 1385154).

thanks
-- PMM
