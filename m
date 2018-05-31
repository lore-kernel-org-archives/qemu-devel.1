Received: from eggs.gnu.org ([2001:4830:134:3::10]:48583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fOQLd-000728-SF
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fOQLd-0001oA-3R
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:22:45 -0400
Date: Thu, 31 May 2018 12:22:39 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180531162239.GC11303@localhost.localdomain>
References: <20180531004323.4611-1-jsnow@redhat.com>
	<20180531004323.4611-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531004323.4611-4-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] ahci: don't schedule
 unnecessary BH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, May 30, 2018 at 08:43:23PM -0400, John Snow wrote:
> The comment gives us a hint. *Maybe* we still have something to
> process. Well, why not check?

Heh :)

Reviewed-by: Jeff Cody <jcody@redhat.com>

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/ahci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index a9558e45e7..380366b038 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1427,8 +1427,7 @@ static void ahci_cmd_done(IDEDMA *dma)
>      /* update d2h status */
>      ahci_write_fis_d2h(ad);
>  
> -    if (!ad->check_bh) {
> -        /* maybe we still have something to process, check later */
> +    if (ad->port_regs.cmd_issue && !ad->check_bh) {
>          ad->check_bh = qemu_bh_new(ahci_check_cmd_bh, ad);
>          qemu_bh_schedule(ad->check_bh);
>      }
> -- 
> 2.14.3
> 
> 
