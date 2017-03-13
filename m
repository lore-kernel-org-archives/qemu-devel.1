Received: from eggs.gnu.org ([2001:4830:134:3::10]:43944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnUPT-0006nz-PL
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnUPQ-0004Dm-Kp
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:09:31 -0400
Date: Mon, 13 Mar 2017 15:08:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170313180807.GK4694@thinpad.lan.raisama.net>
References: <20170310200550.13313-1-krzk@kernel.org>
	<20170310200550.13313-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170310200550.13313-3-krzk@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qdev: Constify local variable
 returned by blk_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org

On Fri, Mar 10, 2017 at 10:05:50PM +0200, Krzysztof Kozlowski wrote:
> Inside qdev_prop_set_drive() the value returned by blk_bs() is passed
> only as pointer to const to bdrv_get_node_name() and pointed values is
> not modified in other places so this can be made const for code
> safeness.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Unless another maintainer wants to take this, I am queueing it
for 2.10 on my machine-next branch.

> ---
>  hw/core/qdev-properties-system.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index c34be1c1bace..0d40ce682d05 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -405,7 +405,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
>      if (value) {
>          ref = blk_name(value);
>          if (!*ref) {
> -            BlockDriverState *bs = blk_bs(value);
> +            const BlockDriverState *bs = blk_bs(value);
>              if (bs) {
>                  ref = bdrv_get_node_name(bs);
>              }
> -- 
> 2.9.3
> 

-- 
Eduardo
