Received: from eggs.gnu.org ([2001:4830:134:3::10]:56180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhQc-0004rY-3u
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhQb-0003Tf-8F
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:21:34 -0400
Date: Wed, 21 Mar 2018 18:21:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180321172115.GF3898@localhost.localdomain>
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-9-kwolf@redhat.com>
	<5609865f-8d08-bf92-23f3-fba625012e1d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5609865f-8d08-bf92-23f3-fba625012e1d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 08/12] qemu-iotests: Test
 parallels image creation with QMP
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

Am 20.03.2018 um 19:42 hat Eric Blake geschrieben:
> On 03/20/2018 12:36 PM, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/qemu-iotests/212     | 326 +++++++++++++++++++++++++++++++++++++++++++++
> >   tests/qemu-iotests/212.out | 111 +++++++++++++++
> >   tests/qemu-iotests/group   |   1 +
> >   3 files changed, 438 insertions(+)
> >   create mode 100755 tests/qemu-iotests/212
> >   create mode 100644 tests/qemu-iotests/212.out
> > 
> 
> > +echo
> > +echo "=== Invalid sizes ==="
> > +echo
> > +
> > +# TODO Negative image sizes aren't handled correctly, but this is a problem
> > +# with QAPI's implementation of the 'size' type and affects other commands as
> > +# well. Once this is fixed, we may want to add a test case here.
> > +
> > +# 1. Misaligned image size
> > +# 2. 2^64 - 512
> > +# 3. 2^63 = 8 EB (qemu-img enforces image sizes less than this)
> > +# 4. 2^63 - 512 (generally valid, but with the crypto header the file will
> > +#                exceed 63 bits)
> 
> Is this part of the comment stale copy-and-paste? There's no crypto header,
> and the real max is much smaller...

Yeah... Not sure if the case is all that useful, but it can't hurt, so
I'll just s/crypto header/image header/ rather than removing it.

Kevin
