Received: from eggs.gnu.org ([2001:4830:134:3::10]:56119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d0Yqe-000114-NI
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d0Yqd-0001bU-PC
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:31:36 -0400
Date: Tue, 18 Apr 2017 15:31:29 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170418193129.GJ5704@localhost.localdomain>
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
	<e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
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

On Tue, Apr 18, 2017 at 01:44:43PM -0500, Eric Blake wrote:
> On 04/18/2017 12:45 PM, Jeff Cody wrote:
> > For the tests that use the common.qemu functions for running a QEMU
> > process, _cleanup_qemu must be called in the exit function.
> > 
> > If it is not, if the qemu process aborts, then not all of the droppings
> > are cleaned up (e.g. pidfile, fifos).
> > 
> > This updates those tests that did not have a cleanup in qemu-iotests.
> > 
> > (I swapped spaces for tabs in test 102 as well)
> > 
> > Reported-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> > 
> > v2 fixed typo in test 094, s/cleanup/_cleanup/ for the trap function.
> > 
> >  tests/qemu-iotests/028 |  1 +
> >  tests/qemu-iotests/094 | 11 ++++++++---
> >  tests/qemu-iotests/102 |  5 +++--
> >  tests/qemu-iotests/109 |  1 +
> >  tests/qemu-iotests/117 |  1 +
> >  tests/qemu-iotests/130 |  1 +
> >  tests/qemu-iotests/140 |  1 +
> >  tests/qemu-iotests/141 |  1 +
> >  tests/qemu-iotests/143 |  1 +
> >  9 files changed, 18 insertions(+), 5 deletions(-)
> 
> Looks like you missed (at least?) 063
>

I did miss 156.  But unless I am missing something, 063 does not use
common.qemu...

(I'll send a v3 with 156)

-Jeff
