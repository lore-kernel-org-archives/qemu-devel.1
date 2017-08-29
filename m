Received: from eggs.gnu.org ([2001:4830:134:3::10]:43184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmkki-00019l-JK
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmkkh-000090-Sq
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:56:40 -0400
MIME-Version: 1.0
In-Reply-To: <20170829173226.7625-1-bobby.prani@gmail.com>
References: <20170829173226.7625-1-bobby.prani@gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 29 Aug 2017 13:56:06 -0400
Message-ID: <CAJhHMCAEGv6k3WNHGhm=1c9XLJKdApw3JDD3dVJ5TrZ2AQBmiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] arm_gicv3_kvm: Fix compile warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "open list:ARM cores" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

I should have worded the subject better. The warning is pointing to an
actual bug.

On Tue, Aug 29, 2017 at 1:32 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Fix the following warning:
>
> /home/pranith/qemu/hw/intc/arm_gicv3_kvm.c:296:17: warning: logical not is only applied to the left hand side of this bitwise operator [-Wlogical-not-parentheses]
>             if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
>                 ^             ~
> /home/pranith/qemu/hw/intc/arm_gicv3_kvm.c:296:17: note: add parentheses after the '!' to evaluate the bitwise operator first
>             if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
>                 ^
> /home/pranith/qemu/hw/intc/arm_gicv3_kvm.c:296:17: note: add parentheses around left hand side expression to silence this warning
>             if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
>                 ^
>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 6051c77705..481fe5405a 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -293,7 +293,7 @@ static void kvm_arm_gicv3_put(GICv3State *s)
>              kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, true);
>
>              reg64 = c->gicr_pendbaser;
> -            if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
> +            if (!(c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS)) {
>                  /* Setting PTZ is advised if LPIs are disabled, to reduce
>                   * GIC initialization time.
>                   */
> --
> 2.11.0
>



-- 
Pranith
