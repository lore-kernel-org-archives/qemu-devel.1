Received: from eggs.gnu.org ([2001:4830:134:3::10]:41643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIaRd-00030W-1f
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIaRY-0004a4-CU
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:52:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIaRY-0004Zo-6B
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:52:12 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496828798-27548-12-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Wed, 07 Jun 2017 12:46:38 +0300")
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094732eucas1p199fb11b4189929a105515f6079415ebe@eucas1p1.samsung.com>
	<1496828798-27548-12-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 14:52:07 +0200
Message-ID: <87mv9kez9k.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 11/11] migration: postcopy_blocktime
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
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  docs/migration.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/docs/migration.txt b/docs/migration.txt
> index 1b940a8..4b625ca 100644
> --- a/docs/migration.txt
> +++ b/docs/migration.txt
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

Reviewed-by: Juan Quintela <quintela@redhat.com>

If you have to respin, I think that put the units would be a good idea.
Even you can put the units in the patch where you define the value.
