Received: from eggs.gnu.org ([2001:4830:134:3::10]:58516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQtBg-0002BB-EC
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQtBd-0007tz-Bq
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:30:08 -0400
References: <149881713243.18888.18140083803237379387.stgit@bahia>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <74e3d68d-d7b0-a3f2-c798-056d6b405740@redhat.com>
Date: Fri, 30 Jun 2017 12:30:00 +0200
MIME-Version: 1.0
In-Reply-To: <149881713243.18888.18140083803237379387.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: refresh
 "platform-specific" hcalls comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 30.06.2017 12:05, Greg Kurz wrote:
> We have more of these since the addition of KVMPPC_H_LOGICAL_MEMOP in 2012.

Right, and we don't need one for virtio :-)

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  include/hw/ppc/spapr.h |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a66bbac35242..1826cc4fd696 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -377,9 +377,8 @@ struct sPAPRMachineState {
>   * as well.
>   *
>   * We also need some hcalls which are specific to qemu / KVM-on-POWER.
> - * So far we just need one for H_RTAS, but in future we'll need more
> - * for extensions like virtio.  We put those into the 0xf000-0xfffc
> - * range which is reserved by PAPR for "platform-specific" hcalls.
> + * We put those into the 0xf000-0xfffc range which is reserved by PAPR
> + * for "platform-specific" hcalls.
>   */
>  #define KVMPPC_HCALL_BASE       0xf000
>  #define KVMPPC_H_RTAS           (KVMPPC_HCALL_BASE + 0x0)

Reviewed-by: Thomas Huth <thuth@redhat.com>
