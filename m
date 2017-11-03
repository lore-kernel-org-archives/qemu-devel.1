Received: from eggs.gnu.org ([2001:4830:134:3::10]:48210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eAbFJ-00015B-6o
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eAbFE-00030k-3k
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:38:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1eAbFD-0002zD-Tw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:38:44 -0400
Date: Fri, 3 Nov 2017 08:38:40 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171103123840.GA5399@localhost.localdomain>
References: <f512ef4b-11ac-0cd2-0037-4608f2059669@ozlabs.ru>
	<d80a7e33-f055-d59e-8aff-2ed1f9a79c83@ozlabs.ru>
	<20171027071241.GA30326@localhost.localdomain>
	<12b21c38-3d03-929b-aea0-7de5efe55d56@ozlabs.ru>
	<9ac46d04-9a6a-67a5-73b3-fa2208c03e35@redhat.com>
	<0c64b45d-3f42-7866-ffa8-b2d0a32dddb0@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c64b45d-3f42-7866-ffa8-b2d0a32dddb0@ozlabs.ru>
Subject: Re: [Qemu-devel] iotest 194 fails on vhdx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Nov 02, 2017 at 12:19:00PM +1100, Alexey Kardashevskiy wrote:
> On 28/10/17 19:25, Paolo Bonzini wrote:
> > On 28/10/2017 08:57, Alexey Kardashevskiy wrote:
> >> On 27/10/17 18:12, Jeff Cody wrote:
> >>> VHDX does not support migration (VMDK fails the same way). 
> >>
> >> Probably a very ignorant question but how can an image format not support
> >> migration at all? Is not it simple writing blocks, one-by-one? Thanks.
> > 
> > VHDX does not implement bdrv_invalidate_cache.  If you add that
> > callback, it can support migration.
> 
> 
> I could give it a try but is there a demand for it really?
> 

I don't think there is much demand for it, which is why we use the
migration-blocker for it still.  VHDX is a compatibility format, and as such
I don't imagine many people using it as a primary format during runtime.
