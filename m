Received: from eggs.gnu.org ([2001:4830:134:3::10]:57496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezQJc-000790-AM
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezQJZ-0003cE-JQ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:17:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34846 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ezQJZ-0003bG-FS
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:17:17 -0400
Date: Fri, 23 Mar 2018 17:17:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180323171703.GD3186@work-vm>
References: <1521568357-114127-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521568357-114127-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] linux-headers: unistd.h fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> It turns out that we have unistd.h for some architectures but not
> others.  We are thus unable to use e.g. usefaultfd on these systems.
> 
> Fix up update-linux-headers.sh to make sure we
> get it for all architectures which have linux-headers/
> (unfortunately this still does not mean "all linux systems").
> 
> Tested on x86 only.
> 
> Pls consider merging this through the migration tree.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued for migration;  I'll test build Power and aarch64 as well.

Dave

> Michael S. Tsirkin (2):
>   update-linux-headers.sh: add unistd.h
>   linux-headers: add asm-generic/unistd.h
> 
>  linux-headers/asm-arm/bitsperlong.h     |   1 +
>  linux-headers/asm-arm64/bitsperlong.h   |  24 +
>  linux-headers/asm-generic/bitsperlong.h |  16 +
>  linux-headers/asm-generic/unistd.h      | 944 ++++++++++++++++++++++++++++++++
>  linux-headers/asm-mips/bitsperlong.h    |   9 +
>  linux-headers/asm-mips/unistd.h         |  44 +-
>  linux-headers/asm-powerpc/bitsperlong.h |  13 +
>  linux-headers/asm-s390/bitsperlong.h    |  14 +
>  linux-headers/asm-x86/bitsperlong.h     |  14 +
>  scripts/update-linux-headers.sh         |  20 +-
>  10 files changed, 1086 insertions(+), 13 deletions(-)
>  create mode 100644 linux-headers/asm-arm/bitsperlong.h
>  create mode 100644 linux-headers/asm-arm64/bitsperlong.h
>  create mode 100644 linux-headers/asm-generic/bitsperlong.h
>  create mode 100644 linux-headers/asm-generic/unistd.h
>  create mode 100644 linux-headers/asm-mips/bitsperlong.h
>  create mode 100644 linux-headers/asm-powerpc/bitsperlong.h
>  create mode 100644 linux-headers/asm-s390/bitsperlong.h
>  create mode 100644 linux-headers/asm-x86/bitsperlong.h
> 
> -- 
> MST
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
