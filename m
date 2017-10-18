Received: from eggs.gnu.org ([2001:4830:134:3::10]:38078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4r4M-0000Vd-VV
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4r4M-0006du-3y
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:19:46 -0400
Date: Wed, 18 Oct 2017 12:19:35 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171018161935.GH17962@localhost.localdomain>
References: <cover.1508257445.git.jcody@redhat.com>
	<503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
	<2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
	<20171018150352.GE17962@localhost.localdomain>
	<d3682b70-64c6-1284-77c4-8df561a61098@redhat.com>
	<20171018153416.GF17962@localhost.localdomain>
	<07a69c86-aae3-9174-b646-dee04bf191de@redhat.com>
	<20171018155038.GG17962@localhost.localdomain>
	<f5da8290-096d-36b5-28c5-ecfeb66199af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5da8290-096d-36b5-28c5-ecfeb66199af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 03/10] qemu-iotests: automatically clean
 up bash protocol servers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

On Wed, Oct 18, 2017 at 05:51:53PM +0200, Paolo Bonzini wrote:
> On 18/10/2017 17:50, Jeff Cody wrote:
> > Here is what we need from common.rc for this series:
> > 
> > _rm_test_img
> > _cleanup_nbd
> > _cleanup_vxhs
> > _cleanup_rbd
> > _cleanup_sheepdog
> > _cleanup_protocols
> > _cleanup_test_img
> > 
> > 
> > They all have a common theme (cleanup), so I could move them all to a
> > common.cleanup (naming suggestion?) file (which would need to be included by
> > common.rc, as well).
> > 
> > Would this be a strong enough delineation to overcome your concerns?
> 
> A great start.  Which of these are actually needed by the tests (and
> hence by common.rc) and why?
> 

 Some tests are written such that they do intermediate cleanups between
 multiple internal sub-tests for varying reasons, and so use those cleanup
 functions as part of their testing.  The function _cleanup_test_img
 effectively calls all the other functions I listed, so they are really all
 required for the tests, if they choose to call _cleanup_test_img.

And for 'check' to tear everything down to a clean state, it also needs to
use the cleanup functions for everything that is not just a file/directory.

-Jeff
