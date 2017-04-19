Received: from eggs.gnu.org ([2001:4830:134:3::10]:45694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d0or1-0005it-Ac
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d0oqy-0002Py-K6
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:37:01 -0400
Date: Wed, 19 Apr 2017 08:36:47 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170419123647.GL5704@localhost.localdomain>
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
	<e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
	<20170418193129.GJ5704@localhost.localdomain>
	<c0a0816b-9ff9-a285-dbe1-c5b4f78e6ee4@redhat.com>
	<20170418194223.GK5704@localhost.localdomain>
	<20170419103635.GB14508@lemon.lan>
	<63eb8549-dea7-ba35-021c-78697aa5f099@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63eb8549-dea7-ba35-021c-78697aa5f099@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/1] qemu-iotests:
 _cleanup_qemu must be called on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, Apr 19, 2017 at 02:13:35PM +0200, Max Reitz wrote:
> On 19.04.2017 12:36, Fam Zheng wrote:
> > On Tue, 04/18 15:42, Jeff Cody wrote:
> >>> One idea presented in an earlier thread was that common.rc should create
> >>> a subdirectory per test (rather than all tests sharing scratch/), and
> >>> then common.rc itself install the cleanup hook that wipes out the entire
> >>> subdirectory (or maybe even add a command-line option to ./check to
> >>> suppress wiping when it is desirable to debug a test failure by seeing
> >>> the droppings left behind).
> >>>
> >>
> >> Yep, good ideas.  I'll leave that for another series though; there are a few
> >> other changes based on some suggestions from Daniel that I'd like to
> >> implement as well, and I can fold your suggestions above into a new series
> >> (unless someone else does it first).
> > 
> > Sounds good, I was thinking about making ./check run tests in parallel. If each
> > test has its own tmpdir, it will be much easier.
> 

Neat - it'd be cool to be able to use the same options as for 'make', e.g.
./check -j5.


> In case you were not yet aware: you can manually set TEST_DIR, this is
> what I do.
> 
> (I have a script that basically does TEST_DIR=/tmp/test-$1 ./check -$1)
>

Baking it into common without relying on external env variables adds extra
niceties, because as Eric mentioned cleanup is not left up to the script
then, and the subdir can be nuked (or kept, via an option to 'check').

This would make the scripts simpler to read and implement, and less prone to
do Bad Things. (I keep waiting for some iotest script to misquote a var
during cleanup and do an rm -f ~/* or something...  it'd be nice to not have
to worry about that).


-Jeff
