Received: from eggs.gnu.org ([2001:4830:134:3::10]:33866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDqfe-0001Af-C3
	for qemu-devel@nongnu.org; Thu, 25 May 2017 07:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDqfb-0005Zr-6p
	for qemu-devel@nongnu.org; Thu, 25 May 2017 07:11:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dDqfb-0005Zj-0B
	for qemu-devel@nongnu.org; Thu, 25 May 2017 07:11:07 -0400
Date: Thu, 25 May 2017 19:10:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170525111058.GC22816@pxdev.xzpeter.org>
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-3-git-send-email-felipe@nutanix.com>
	<20170525004007.GP3873@pxdev.xzpeter.org>
	<3F052E47-5144-411B-BBEF-03C0E4D872B7@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3F052E47-5144-411B-BBEF-03C0E4D872B7@nutanix.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: set dirty_pages_rate before
 autoconverge logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Juan Quintela <quintela@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, May 25, 2017 at 10:52:32AM +0000, Felipe Franciosi wrote:
> 
> > On 25 May 2017, at 01:40, Peter Xu <peterx@redhat.com> wrote:
> > 
> > On Wed, May 24, 2017 at 05:10:01PM +0100, Felipe Franciosi wrote:
> >> Currently, a "period" in the RAM migration logic is at least a second
> >> long and accounts for what happened since the last period (or the
> >> beginning of the migration). The dirty_pages_rate counter is calculated
> >> at the end this logic.
> >> 
> >> If the auto convergence capability is enabled from the start of the
> >> migration, it won't be able to use this counter the first time around.
> >> This calculates dirty_pages_rate as soon as a period is deemed over,
> >> which allows for it to be used immediately.
> >> 
> >> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> > 
> > You fixed the indents as well, but imho it's okay.
> 
> Yeah a couple of lines were off-by-one space. Fixed it given I was touching the code anyway, hope it's ok with everyone else. Would you normally patch that separately or just mention it in the commit message?

For me normally I don't intentionally touch code up only for
indentation to make sure commit log won't be affected for those lines.
However I'm also okay if we fix some of them, either separately or
squashed into patch like this.

IMHO at last it really depends on the maintainers' flavor on this. :-)

Thanks,

-- 
Peter Xu
