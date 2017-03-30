Received: from eggs.gnu.org ([2001:4830:134:3::10]:34561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ctcgR-0000YL-L7
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ctcgQ-0007Qu-IU
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:12:23 -0400
Reply-To: minyard@acm.org
References: <20170330232236.8272-1-emaste@freebsd.org>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <3ba002c2-9a57-05fe-c93c-62f279a2381c@gmail.com>
Date: Thu, 30 Mar 2017 11:12:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170330232236.8272-1-emaste@freebsd.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ipmi: use parens to avoid unexpected macro
 var evaluation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This isn't quite right, a lot of these need parenthesis around the whole
thing, and some of the macros are unused and need to be removed.
I had submitted something for this a while ago, but it hadn't been
taken.  I will re-submit.

-corey

On 03/30/2017 06:22 PM, Ed Maste wrote:
> Found via Clang warning: logical not is only applied to the left hand
> side of this bitwise operator [-Wlogical-not-parentheses]
>
>                                !IPMI_BT_GET_HBUSY(ib->control_reg));
>                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> expanded from macro 'IPMI_BT_SET_HBUSY'
>                                         (((v & 1) << IPMI_BT_HBUSY_BIT)))
>                                            ^ ~
>
> Signed-off-by: Ed Maste <emaste@freebsd.org>
> ---
>   hw/ipmi/isa_ipmi_bt.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index 1c69cb33f8..c1dea503a2 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -40,37 +40,37 @@
>   #define IPMI_BT_CLR_WR_MASK        (1 << IPMI_BT_CLR_WR_BIT)
>   #define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)
>   #define IPMI_BT_SET_CLR_WR(d, v)   (d) = (((d) & ~IPMI_BT_CLR_WR_MASK) | \
> -                                       (((v & 1) << IPMI_BT_CLR_WR_BIT)))
> +                                       ((((v) & 1) << IPMI_BT_CLR_WR_BIT)))
>   
>   #define IPMI_BT_CLR_RD_MASK        (1 << IPMI_BT_CLR_RD_BIT)
>   #define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)
>   #define IPMI_BT_SET_CLR_RD(d, v)   (d) = (((d) & ~IPMI_BT_CLR_RD_MASK) | \
> -                                       (((v & 1) << IPMI_BT_CLR_RD_BIT)))
> +                                       ((((v) & 1) << IPMI_BT_CLR_RD_BIT)))
>   
>   #define IPMI_BT_H2B_ATN_MASK       (1 << IPMI_BT_H2B_ATN_BIT)
>   #define IPMI_BT_GET_H2B_ATN(d)     (((d) >> IPMI_BT_H2B_ATN_BIT) & 0x1)
>   #define IPMI_BT_SET_H2B_ATN(d, v)  (d) = (((d) & ~IPMI_BT_H2B_ATN_MASK) | \
> -                                        (((v & 1) << IPMI_BT_H2B_ATN_BIT)))
> +                                        ((((v) & 1) << IPMI_BT_H2B_ATN_BIT)))
>   
>   #define IPMI_BT_B2H_ATN_MASK       (1 << IPMI_BT_B2H_ATN_BIT)
>   #define IPMI_BT_GET_B2H_ATN(d)     (((d) >> IPMI_BT_B2H_ATN_BIT) & 0x1)
>   #define IPMI_BT_SET_B2H_ATN(d, v)  (d) = (((d) & ~IPMI_BT_B2H_ATN_MASK) | \
> -                                        (((v & 1) << IPMI_BT_B2H_ATN_BIT)))
> +                                        ((((v) & 1) << IPMI_BT_B2H_ATN_BIT)))
>   
>   #define IPMI_BT_SMS_ATN_MASK       (1 << IPMI_BT_SMS_ATN_BIT)
>   #define IPMI_BT_GET_SMS_ATN(d)     (((d) >> IPMI_BT_SMS_ATN_BIT) & 0x1)
>   #define IPMI_BT_SET_SMS_ATN(d, v)  (d) = (((d) & ~IPMI_BT_SMS_ATN_MASK) | \
> -                                        (((v & 1) << IPMI_BT_SMS_ATN_BIT)))
> +                                        ((((v) & 1) << IPMI_BT_SMS_ATN_BIT)))
>   
>   #define IPMI_BT_HBUSY_MASK         (1 << IPMI_BT_HBUSY_BIT)
>   #define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
>   #define IPMI_BT_SET_HBUSY(d, v)    (d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
> -                                       (((v & 1) << IPMI_BT_HBUSY_BIT)))
> +                                       ((((v) & 1) << IPMI_BT_HBUSY_BIT)))
>   
>   #define IPMI_BT_BBUSY_MASK         (1 << IPMI_BT_BBUSY_BIT)
>   #define IPMI_BT_GET_BBUSY(d)       (((d) >> IPMI_BT_BBUSY_BIT) & 0x1)
>   #define IPMI_BT_SET_BBUSY(d, v)    (d) = (((d) & ~IPMI_BT_BBUSY_MASK) | \
> -                                       (((v & 1) << IPMI_BT_BBUSY_BIT)))
> +                                       ((((v) & 1) << IPMI_BT_BBUSY_BIT)))
>   
>   
>   /* Mask register */
> @@ -80,12 +80,12 @@
>   #define IPMI_BT_B2H_IRQ_EN_MASK      (1 << IPMI_BT_B2H_IRQ_EN_BIT)
>   #define IPMI_BT_GET_B2H_IRQ_EN(d)    (((d) >> IPMI_BT_B2H_IRQ_EN_BIT) & 0x1)
>   #define IPMI_BT_SET_B2H_IRQ_EN(d, v) (d) = (((d) & ~IPMI_BT_B2H_IRQ_EN_MASK) | \
> -                                        (((v & 1) << IPMI_BT_B2H_IRQ_EN_BIT)))
> +                                        ((((v) & 1) << IPMI_BT_B2H_IRQ_EN_BIT)))
>   
>   #define IPMI_BT_B2H_IRQ_MASK         (1 << IPMI_BT_B2H_IRQ_BIT)
>   #define IPMI_BT_GET_B2H_IRQ(d)       (((d) >> IPMI_BT_B2H_IRQ_BIT) & 0x1)
>   #define IPMI_BT_SET_B2H_IRQ(d, v)    (d) = (((d) & ~IPMI_BT_B2H_IRQ_MASK) | \
> -                                        (((v & 1) << IPMI_BT_B2H_IRQ_BIT)))
> +                                        ((((v) & 1) << IPMI_BT_B2H_IRQ_BIT)))
>   
>   typedef struct IPMIBT {
>       IPMIBmc *bmc;
