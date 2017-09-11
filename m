Received: from eggs.gnu.org ([2001:4830:134:3::10]:49949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drLKj-0000Br-5w
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drLKf-0006Ww-W8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1drLKf-0006Wa-Pr
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:48:45 -0400
Date: Mon, 11 Sep 2017 11:48:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170911114841.408b5988.cohuck@redhat.com>
In-Reply-To: <20170908152446.14606-4-pasic@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
	<20170908152446.14606-4-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] s390x/css: remove dubious error
 handling branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Fri,  8 Sep 2017 17:24:45 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

s/dubious/unused/

> The case in question actually never happens. Let us get rid of the dead
> code.

I had tried to be complete in my initial implementation. With the
current implementation, it can never happen, yes. We can easily
resurrect it from git history should we need it in the future.

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index a44d87ab3e..a9cdd54efc 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -980,13 +980,6 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
>                      SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
>              s->cpa = sch->channel_prog + 8;
>              break;
> -        case -EBUSY:
> -            /* subchannel busy, generate deferred cc 1 */
> -            s->flags &= ~SCSW_FLAGS_MASK_CC;
> -            s->flags |= (1 << 8);
> -            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
> -            s->ctrl |= SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
> -            break;
>          case -EINPROGRESS:
>              /* channel program has been suspended */
>              s->ctrl &= ~SCSW_ACTL_START_PEND;

Thanks, queued.
