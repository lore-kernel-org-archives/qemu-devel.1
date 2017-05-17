Received: from eggs.gnu.org ([2001:4830:134:3::10]:56413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB1ri-0000Y2-Il
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB1re-0000jM-NG
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:31:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dB1re-0000jB-Gh
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:31:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51B5F80F90
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:31:53 +0000 (UTC)
Date: Wed, 17 May 2017 17:31:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170517163146.GD2444@work-vm>
References: <1494562661-9063-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494562661-9063-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/3] ramblock: add hmp command "info
 ramblock"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> v8:

Queued for HMP


> - patch 1: add r-b for Dave
> - patch 2: use "uint64_t" for size_to_str() parameter, remove assert()
>   since it's useless now [Dave]
> - drop patch 4
> 
> v7:
> - patch 1: removed Dave's r-b since the patch conflicted during rebase
> - patch 2: add r-b for Markus, with the nice function comment that
>   provided [Markus]
> - patch 3: add r-b for Dave
> - patch 4 (new): added new patch to remove assert in size_to_str(),
>   assuming that would be better.
> 
> v6
> - patch 2: instead of create a new size_to_str(), abstract the logic
>   out from print_type_size(), refactor it, to make sure
>   print_type_size() dumps exactly the same thing as before. (a simple
>   test with info qtree is done)
> - let suffixes be an array of strings [Markus]
> 
> v5
> - add r-b for Dave on first patch (which I forgot in v4, so I got it
>   again)
> - add one more patch to introduce size_to_str() as patch 2 [Dave]
> - let the last patch use the new interface
> 
> v4:
> - move page_size_to_str() into util/cutil.c [Dave]
> 
> v3:
> - cast the three PRIx64 addresses using (uint64_t) [Fam]
> - add more comment in patch 2 to emphasize that this command is only
>   suitable for HMP, not QMP [Markus]
> 
> v2:
> - replace "lx" with "PRIx64" in three places
> 
> Sometimes I would like to know ramblock info for a VM. This command
> would help. It provides a way to dump ramblock info. Currently the
> list is by default sorted by size, though I think it's good enough.
> 
> Please review, thanks.
> 
> Peter Xu (3):
>   ramblock: add RAMBLOCK_FOREACH()
>   utils: provide size_to_str()
>   ramblock: add new hmp command "info ramblock"
> 
>  exec.c                       | 44 +++++++++++++++++++++++++++++++++-----------
>  hmp-commands-info.hx         | 14 ++++++++++++++
>  hmp.c                        |  6 ++++++
>  hmp.h                        |  1 +
>  include/exec/ramlist.h       |  6 ++++++
>  include/qemu-common.h        |  1 +
>  migration/ram.c              | 13 +++++++------
>  qapi/string-output-visitor.c | 22 ++++++----------------
>  util/cutils.c                | 25 +++++++++++++++++++++++++
>  9 files changed, 99 insertions(+), 33 deletions(-)
> 
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
