Received: from eggs.gnu.org ([2001:4830:134:3::10]:48205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fBwri-00022C-ET
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fBwrh-0004NJ-NZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:28:18 -0400
Date: Fri, 27 Apr 2018 14:28:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180427062805.GG4217@lemon.usersys.redhat.com>
References: <20180418030424.28980-1-famz@redhat.com>
	<20180418030424.28980-4-famz@redhat.com>
	<20180426153416.GI30991@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426153416.GI30991@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH v2 3/7] qcow2: Implement
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 04/26 16:34, Stefan Hajnoczi wrote:
> On Wed, Apr 18, 2018 at 11:04:20AM +0800, Fam Zheng wrote:
> > +static int qcow2_co_copy_range_to(BlockDriverState *bs,
> > +                                  BdrvChild *src, uint64_t src_offset,
> > +                                  BdrvChild *dst, uint64_t dst_offset,
> > +                                  uint64_t bytes, BdrvRequestFlags flags)
> > +{
> 
> In theory this could increment the refcount if src == dst.  It's not
> necessary to go down to leaf nodes if the sharing can be handled at the
> qcow2 L2 table level.

Yes, this is a good optimization to have.

Fam
