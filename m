Received: from eggs.gnu.org ([2001:4830:134:3::10]:60304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYYQU-0003On-IX
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYYQR-0002MU-Df
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:24:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cYYQR-0002ML-7O
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:24:47 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F4023D945
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 13:24:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170106182823.1960-15-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 6 Jan 2017 18:28:22 +0000")
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-15-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 31 Jan 2017 14:24:42 +0100
Message-ID: <87d1f3s6p1.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/15] postcopy: Check for
 userfault+hugepage feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> We need extra Linux kernel support (~4.9) to support userfaults
> on hugetlbfs; check for them.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


>  migration/postcopy-ram.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 6b30b43..d12dd7f 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -81,6 +81,17 @@ static bool ufd_version_check(int ufd)
>          return false;
>      }
>  
> +    if (getpagesize() != ram_pagesize_summary()) {

I am pretty sure that I don't like ram_pagesize_summary() name.  I have
already forgot what I mean O:-)
