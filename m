Received: from eggs.gnu.org ([2001:4830:134:3::10]:37295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fihTZ-0008KC-0S
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fihTV-0006yI-Vv
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:42:44 -0400
Date: Thu, 26 Jul 2018 16:42:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180726144232.GE4215@localhost.localdomain>
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-4-lbloch@janustech.com>
	<20180725082611.GA4879@localhost.localdomain>
	<32a32b18-0c7c-63cd-3b1d-429717b23a85@redhat.com>
	<499d5d12-cdba-76e4-3b2e-122675ef9eec@janustech.com>
	<20180725133243.GC4879@localhost.localdomain>
	<dd4a32bc-845c-f529-51a8-71c978f93861@janustech.com>
	<20180725155323.GD4879@localhost.localdomain>
	<0638cd7c-23f7-0f99-735b-c3fb3102e254@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0638cd7c-23f7-0f99-735b-c3fb3102e254@janustech.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 26.07.2018 um 14:24 hat Leonid Bloch geschrieben:
> > > You mean with QDict? I'll look into that now. But already sent v5 before
> > > reading this email.
> > 
> > Yes, with reading it from the QDict. (Or whatever the simplest way is
> > that results in the right external interface, but I suppose this is the
> > one.)
> 
> Well, there is a problem with that: I can easily isolate
> l2-cache-size from QDict, check if it is "full", and if it is - do whatever
> is needed, and delete this option before parsing. But what if it is "foo"?
> It will not get deleted, and the regular QEMU_OPT_SIZE parsing error will
> appear, stating that l2-cache-size "expects a non-negative number..." - no
> word about that it can expect "full" as well. Now, one can try to modify
> local_err->msg for this particular option, but this will require substantial
> additional logic. I think considering this, it would be easier to stick with
> a dedicated option, l2-cache-full.
> 
> Do you think there is a smarter way to parse the l2-cache-size option, so it
> would accept both size and "full", while handling errors correctly? It seems
> more elegant to have a single option, but the internal handling will be more
> elegant and simpler with two mutually exclusive options.

I think we can live with the suboptimal error message for a while. Once
qcow2 is QAPIfied, it should become easy to improve it. Let's not choose
a worse design (that stays forever) for a temporarily better error
message.

> By the way, the L2 cache resizes now on image resize. Will send the changes
> in v6. Thanks for the suggestion!

Sounds good!

Kevin
