Received: from eggs.gnu.org ([2001:4830:134:3::10]:60298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d0Z1F-00042q-0t
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d0Z1E-0008Os-53
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:42:33 -0400
Date: Tue, 18 Apr 2017 15:42:23 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170418194223.GK5704@localhost.localdomain>
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
	<e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
	<20170418193129.GJ5704@localhost.localdomain>
	<c0a0816b-9ff9-a285-dbe1-c5b4f78e6ee4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0a0816b-9ff9-a285-dbe1-c5b4f78e6ee4@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Tue, Apr 18, 2017 at 02:39:12PM -0500, Eric Blake wrote:
> On 04/18/2017 02:31 PM, Jeff Cody wrote:
> > On Tue, Apr 18, 2017 at 01:44:43PM -0500, Eric Blake wrote:
> >> On 04/18/2017 12:45 PM, Jeff Cody wrote:
> >>> For the tests that use the common.qemu functions for running a QEMU
> >>> process, _cleanup_qemu must be called in the exit function.
> >>>
> >>> If it is not, if the qemu process aborts, then not all of the droppings
> >>> are cleaned up (e.g. pidfile, fifos).
> >>>
> 
> >>
> >> Looks like you missed (at least?) 063
> >>
> > 
> > I did miss 156.  But unless I am missing something, 063 does not use
> > common.qemu...
> 
> Good point. 063 does litter, even on success, however:
> 
> $ rm -rf scratch/
> $ ./check -raw 063
> ...
> $ ls scratch/
> t.raw.raw1
> 
> One idea presented in an earlier thread was that common.rc should create
> a subdirectory per test (rather than all tests sharing scratch/), and
> then common.rc itself install the cleanup hook that wipes out the entire
> subdirectory (or maybe even add a command-line option to ./check to
> suppress wiping when it is desirable to debug a test failure by seeing
> the droppings left behind).
>

Yep, good ideas.  I'll leave that for another series though; there are a few
other changes based on some suggestions from Daniel that I'd like to
implement as well, and I can fold your suggestions above into a new series
(unless someone else does it first).


-Jeff
