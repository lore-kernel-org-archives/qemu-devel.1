Received: from eggs.gnu.org ([2001:4830:134:3::10]:56520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpbB9-0002Mx-9O
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpbB5-0001Md-6T
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:19:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpbB5-0001MG-09
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:19:39 -0400
Date: Wed, 6 Sep 2017 15:19:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170906141931.GC8457@work-vm>
References: <20170825141940.20740-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825141940.20740-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix double loadvm failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shorne@gmail.com, quintela@redhat.com, mreitz@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> lp: https://bugs.launchpad.net/qemu/+bug/1712564
> 
> Reported-by: Stafford Horne <shorne@gmail.com>
> 
> Dr. David Alan Gilbert (2):
>   migration: Reset rather than destroy main_thread_load_event
>   snapshot/tests: Try loadvm twice
> 
>  migration/migration.c      | 2 +-
>  tests/qemu-iotests/068     | 2 +-
>  tests/qemu-iotests/068.out | 4 ++++
>  3 files changed, 6 insertions(+), 2 deletions(-)

Queued

> -- 
> 2.13.5
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
