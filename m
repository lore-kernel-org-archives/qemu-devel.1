Received: from eggs.gnu.org ([2001:4830:134:3::10]:45130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv0fi-0005aR-7z
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv0ff-0001sC-2O
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:33:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dv0fe-0001rY-Sh
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:33:35 -0400
Date: Thu, 21 Sep 2017 13:33:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170921123326.GD2717@work-vm>
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164825eucas1p21fd133a55091e4a09fdeee05d130260d@eucas1p2.samsung.com>
	<1505839684-10046-9-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505839684-10046-9-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v10 08/10] migration: postcopy_blocktime
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
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, quintela@redhat.com, heetae82.ahn@samsung.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Although it does have my R-b it might be worth adding some clarification
that it's a measure of when *all* cpus are blocked and so isn't a 
total measure of impact of postcopy (when blocking some of them).

Dave

> ---
>  docs/devel/migration.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/docs/devel/migration.txt b/docs/devel/migration.txt
> index 1b940a8..4b625ca 100644
> --- a/docs/devel/migration.txt
> +++ b/docs/devel/migration.txt
> @@ -402,6 +402,16 @@ will now cause the transition from precopy to postcopy.
>  It can be issued immediately after migration is started or any
>  time later on.  Issuing it after the end of a migration is harmless.
>  
> +Blocktime is a postcopy live migration metric, intended to show
> +how long the vCPU was in state of interruptable sleep due to pagefault.
> +This value is calculated on destination side.
> +To enable postcopy blocktime calculation, enter following command on destination
> +monitor:
> +
> +migrate_set_capability postcopy-blocktime on
> +
> +Postcopy blocktime can be retrieved by query-migrate qmp command.
> +
>  Note: During the postcopy phase, the bandwidth limits set using
>  migrate_set_speed is ignored (to avoid delaying requested pages that
>  the destination is waiting for).
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
