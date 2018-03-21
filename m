Received: from eggs.gnu.org ([2001:4830:134:3::10]:57497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhVj-0001Xt-J0
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhVi-0005Rg-MV
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:26:51 -0400
Date: Wed, 21 Mar 2018 18:26:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180321172627.GH3898@localhost.localdomain>
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-13-kwolf@redhat.com>
	<e457c30d-2276-ff0d-5211-a98d25ea49ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e457c30d-2276-ff0d-5211-a98d25ea49ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 12/12] qemu-iotests: Test vhdx
 image creation with QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Am 20.03.2018 um 19:53 hat Eric Blake geschrieben:
> On 03/20/2018 12:36 PM, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/qemu-iotests/213     | 349 +++++++++++++++++++++++++++++++++++++++++++++
> >   tests/qemu-iotests/213.out | 121 ++++++++++++++++
> >   tests/qemu-iotests/group   |   1 +
> >   3 files changed, 471 insertions(+)
> >   create mode 100755 tests/qemu-iotests/213
> >   create mode 100644 tests/qemu-iotests/213.out
> > 
> 
> > +
> > +echo
> > +echo "=== Invalid sizes ==="
> > +echo
> > +
> > +# TODO Negative image sizes aren't handled correctly, but this is a problem
> > +# with QAPI's implementation of the 'size' type and affects other commands as
> > +# well. Once this is fixed, we may want to add a test case here.
> > +
> > +# 1. 2^64 - 512
> > +# 2. 2^63 = 8 EB (qemu-img enforces image sizes less than this)
> > +# 3. 2^63 - 512 (generally valid, but with the crypto header the file will
> > +#                exceed 63 bits)
> 
> Same comments as before on whether this comment is slightly stale after
> copy-and-paste.

Will do the same thing as there ("image header").

> > +# 4. 2^46 + 1 (512 bytes more than maximum image size)
> 
> Does this image format require 512-byte alignment?  If so, are you missing a
> test of unaligned sizes?  If not, why not just 1 byte more than the maximum?

The comment is wrong, the code already does just 1 byte more.

Kevin
