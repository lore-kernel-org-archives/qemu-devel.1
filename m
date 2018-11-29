Received: from eggs.gnu.org ([2001:4830:134:3::10]:59294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSP3F-0003pf-Sc
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSP38-0005KG-6R
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:20:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSP36-0005Ja-MU
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:20:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BC3830BA374
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:20:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181129090120.28828-1-pbonzini@redhat.com>
	<20181129090120.28828-2-pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 17:20:17 +0100
In-Reply-To: <20181129090120.28828-2-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Thu, 29 Nov 2018 10:01:17 +0100")
Message-ID: <87d0qn7t4u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/4] checkpatch: fix premature exit
 when no input or --mailback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> In some cases, checkpatch's process subroutine is exiting the
> whole process.  This is wrong, just return from the subroutine
> instead.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/checkpatch.pl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index eccd656c41..d58fcb1efd 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2869,19 +2869,19 @@ sub process {
>  	# If we have no input at all, then there is nothing to report on
>  	# so just keep quiet.
>  	if ($#rawlines == -1) {
> -		exit(0);
> +		return 1;
>  	}
>  
>  	# In mailback mode only produce a report in the negative, for
>  	# things that appear to be patches.
>  	if ($mailback && ($clean == 1 || !$is_patch)) {
> -		exit(0);
> +		return 1;
>  	}
>  
>  	# This is not a patch, and we are are in 'no-patch' mode so
>  	# just keep quiet.
>  	if (!$chk_patch && !$is_patch) {
> -		exit(0);
> +		return 1;
>  	}
>  
>  	if (!$is_patch) {

Would this make sense for Linux's checkpatch.pl, too?
