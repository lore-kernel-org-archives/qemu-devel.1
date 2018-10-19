Received: from eggs.gnu.org ([2001:4830:134:3::10]:43380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDInV-00058a-VE
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 20:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDInO-0006pa-Pi
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 20:37:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gDInI-0006Ma-Kb
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 20:37:38 -0400
Date: Thu, 18 Oct 2018 21:37:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181019003725.GB31060@habkost.net>
References: <20181018162057.19348-1-wainersm@redhat.com>
	<f53ae31c-a0e6-9370-2b77-26d313380f3a@redhat.com>
	<20181018220922.GA31060@habkost.net>
	<59005eb9-98cd-a614-46fb-d6627056352a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59005eb9-98cd-a614-46fb-d6627056352a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: add Linux initrd
 checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, lizhijian@cn.fujitsu.com, ccarrara@redhat.com, philmd@redhat.com

On Thu, Oct 18, 2018 at 07:52:58PM -0400, Cleber Rosa wrote:
[...]
> >>> +            expected_msg = r'.*initrd is too large.*max: \d+, need \d+.*'
> >>
> >> I'd be a bit more assertive here and do something like:
> >>
> >>       expected_msg = r'.*initrd is too large.*max: \d+, need %d\)' %
> >> max_size
> >>
> >> And if "134053887" (which appears in "max"), is a QEMU constant, that
> >> can be added there as well.
> > 
> > I was going to suggest the opposite: just checking if the error
> > message contains "initrd is too large".  If we ensure the exit
> > status is 1, the exact format of the error message isn't very
> > important.
> > 
> 
> It's certainly a matter of style here, and both are fine to me, but I'd
> rather have someone touching that part of the code to also have to touch
> the test if the message changes.
> 
> Note that I can't predict if this will eventually catch a regression
> that the simpler message you suggest wouldn't, but, I, personally,
> prefer to be safe than sorry.

I see your point, and I would probably prefer your approach if we
already had QEMU developers used to writing and running
acceptance tests once in a while.

Anyway, both approaches would be good enough to me.

-- 
Eduardo
