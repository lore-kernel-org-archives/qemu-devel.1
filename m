Received: from eggs.gnu.org ([2001:4830:134:3::10]:48809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejVMv-0002ur-4I
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejVMs-0004dE-10
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:26:57 -0500
References: <20180207160302.15651-1-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <16675663-c4fc-3d2a-9d90-9731c904e46c@redhat.com>
Date: Wed, 7 Feb 2018 20:26:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180207160302.15651-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Drop unneeded system header includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 07.02.2018 17:03, Eric Blake wrote:
> <memory.h> is a non-standard obsolete header that was long ago
> replaced by <string.h>.
> 
> <malloc.h> is a non-standard header; it is not obsolete (we must
> use it for malloc_trim, for example), but generally should not
> be used in files that just need malloc() and friends, where
> <stdlib.h> is the standard header.
> 
> And since osdep.h already guarantees string.h and stdlib.h, we
> can drop these unusual system header includes as redundant
> rather than replacing them.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> Based-on: <20180207124009.12376-1-armbru@redhat.com>
> ([PULL 00/20] Miscellaneous patches for 2018-02-07)
> 
>  target/i386/hax-windows.h | 2 --
>  target/i386/hvf/x86_mmu.c | 1 -
>  2 files changed, 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
