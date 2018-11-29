Received: from eggs.gnu.org ([2001:4830:134:3::10]:59608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSP4H-0004da-IC
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSP4E-0005pV-Dc
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:21:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSP4E-0005ox-4Z
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:21:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CAAD5AFF5
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:21:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181129090120.28828-1-pbonzini@redhat.com>
	<20181129090120.28828-3-pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 17:21:27 +0100
In-Reply-To: <20181129090120.28828-3-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Thu, 29 Nov 2018 10:01:18 +0100")
Message-ID: <878t1b7t2w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/4] checkpatch: check
 Signed-off-by in --mailback mode
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

> Pull the test before the anticipated exits from the process sub.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/checkpatch.pl | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d58fcb1efd..c216c55e01 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2866,6 +2866,10 @@ sub process {
>  		}
>  	}
>  
> +	if ($is_patch && $chk_signoff && $signoff == 0) {
> +		ERROR("Missing Signed-off-by: line(s)\n");
> +	}
> +
>  	# If we have no input at all, then there is nothing to report on
>  	# so just keep quiet.
>  	if ($#rawlines == -1) {
> @@ -2887,9 +2891,6 @@ sub process {
>  	if (!$is_patch) {
>  		ERROR("Does not appear to be a unified-diff format patch\n");
>  	}
> -	if ($is_patch && $chk_signoff && $signoff == 0) {
> -		ERROR("Missing Signed-off-by: line(s)\n");
> -	}
>  
>  	print report_dump();
>  	if ($summary && !($clean == 1 && $quiet == 1)) {

Would this make sense for Linux's checkpatch.pl, too?
