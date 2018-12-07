Received: from eggs.gnu.org ([2001:4830:134:3::10]:57741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVC1q-0008OZ-Gf
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVC1n-0005sW-6B
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gVC1m-0005sB-Vf
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A6A5307DAB6
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 09:02:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181206232333.22408-1-pbonzini@redhat.com>
	<20181206232333.22408-7-pbonzini@redhat.com>
Date: Fri, 07 Dec 2018 10:02:28 +0100
In-Reply-To: <20181206232333.22408-7-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Fri, 7 Dec 2018 00:23:33 +0100")
Message-ID: <87d0qd1zh7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] checkpatch: warn about queue/queue.h
 head structs that are not typedef-ed
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

Let's state the rationale for requiring a typedef in the commit
message, or point to a prior commit that has it.

Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/checkpatch.pl | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a8d6e44107..b4b3495044 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2263,6 +2263,11 @@ sub process {
>  			}
>  		}
>  
> +		if ($line =~ /^.\s*(Q(?:S?LIST|SIMPLEQ|TAILQ)_HEAD)\s*\(\s*[^,]/ &&
> +		    $line !~ /^.typedef/) {
> +		    ERROR("named $1 should be typedefed separately\n" . $herecurr);
> +		}
> +
>  # Need a space before open parenthesis after if, while etc
>  		if ($line=~/\b(if|while|for|switch)\(/) {
>  			ERROR("space required before the open parenthesis '('\n" . $herecurr);
