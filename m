Received: from eggs.gnu.org ([2001:4830:134:3::10]:47406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fLWU1-0002Hh-1o
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fLWU0-0003B2-50
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:19:25 -0400
Date: Wed, 23 May 2018 12:19:17 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180523161917.GI6722@localhost.localdomain>
References: <20180523160721.14018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523160721.14018-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] sheepdog: remove huge BSS object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, May 23, 2018 at 06:07:19PM +0200, Paolo Bonzini wrote:
> block/sheepdog.o has a 4M static variable that is 90% of QEMU's whole .bss
> section.  Since it doesn't really have to be static, we can just use a
> heap allocated block.  We can actually make it smaller too. :)
> 
> Patch 1 is a related cleanup since we're touching that area of the code.
> 
> Paolo
> 
> v1->v2: free the data...
> 
> Paolo Bonzini (2):
>   sheepdog: cleanup repeated expression
>   sheepdog: remove huge BSS object
> 
>  block/sheepdog.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> -- 
> 2.17.0
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
