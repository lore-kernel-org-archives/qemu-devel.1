Received: from eggs.gnu.org ([2001:4830:134:3::10]:59076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbJZ-0001Ay-FT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbJY-0002Na-Nc
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:55:53 -0400
Date: Mon, 23 Jul 2018 15:55:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180723135538.GG8817@localhost.localdomain>
References: <20180713194100.7511-1-mreitz@redhat.com>
	<4347078d-5854-ac6e-f0cd-7512cbd9f419@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4347078d-5854-ac6e-f0cd-7512cbd9f419@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotest: Fix filtering order in 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 13.07.2018 um 22:14 hat John Snow geschrieben:
> 
> 
> On 07/13/2018 03:41 PM, Max Reitz wrote:
> > The test directory should be filtered before the image format, otherwise
> > the test will fail if the image format is part of the test directory,
> > like so:
> > 
> > [...]
> > -can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
> > +can't open: Could not open '/tmp/test-IMGFMT/t.IMGFMT': Is a directory
> > [...]
> > 
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> 
> Too many gotchas in our test suite.
> 
> Thanks :(

Maybe we should start writing tests for our tests? ;-)

Thanks, applied to the block branch.

Kevin
