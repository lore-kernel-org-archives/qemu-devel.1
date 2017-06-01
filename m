Received: from eggs.gnu.org ([2001:4830:134:3::10]:43278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGOQE-0005pA-Ns
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGOQD-0000wj-EL
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:37:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dGOQD-0000vd-99
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:37:45 -0400
Date: Thu, 1 Jun 2017 12:37:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170601113740.GH2083@work-vm>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113132eucas1p19143aceccbb30a0051635cddcf376bb6@eucas1p1.samsung.com>
	<1495539071-12995-11-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495539071-12995-11-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH V6 10/10] migration: postcopy_blocktime
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  docs/migration.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/docs/migration.txt b/docs/migration.txt
> index 1b940a8..2207c6d 100644
> --- a/docs/migration.txt
> +++ b/docs/migration.txt
> @@ -402,6 +402,16 @@ will now cause the transition from precopy to postcopy.
>  It can be issued immediately after migration is started or any
>  time later on.  Issuing it after the end of a migration is harmless.
>  
> +Blocktime is a postcopy live migration metric, intended to show
> +how long the source vCPU was in state of interruptable sleep due to pagefault.

                ^^^^^^
I think it's just 'how long the vCPU' - I don't think 'source' adds
anything.

> +This value is calculated on destination side.
> +To enable postcopy blocktime calculation, enter following command on destination
> +monitor:
> +
> +migrate_set_capability postcopy-blocktime on
> +
> +Postcopy blocktime can be retrieved by query-migrate qmp command.
> +

I think other than that it's OK.



Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  Note: During the postcopy phase, the bandwidth limits set using
>  migrate_set_speed is ignored (to avoid delaying requested pages that
>  the destination is waiting for).
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
