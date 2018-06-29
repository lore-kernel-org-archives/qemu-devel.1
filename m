Received: from eggs.gnu.org ([2001:4830:134:3::10]:52805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fZ07F-0001Ec-0X
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fZ07E-0007S1-1R
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:35:37 -0400
Date: Fri, 29 Jun 2018 22:35:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629203528.GM15588@localhost.localdomain>
References: <CAFLvi203QwYCdfdhq6pb855xOZbt-bOiMsYU3cDSx6itHeu2=w@mail.gmail.com>
	<ceff4595-026d-ae13-5628-042cf043d0ac@redhat.com>
	<007fb94d-5a04-0ee1-5d1b-6fd41e67c9a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007fb94d-5a04-0ee1-5d1b-6fd41e67c9a4@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [BUG] qed_aio_write_alloc: Assertion
 `s->allocating_acb == NULL' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Quytelda Kahja <quytelda@tamalin.org>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

Am 29.06.2018 um 22:16 hat Eric Blake geschrieben:
> On 06/29/2018 03:07 PM, John Snow wrote:
> > CC Qemu Block; looks like QED is a bit busted.
> > 
> > On 06/27/2018 10:25 AM, Quytelda Kahja wrote:
> > > Hello all,
> > > I wanted to submit a bug report in the tracker, but it seem to require
> > > an Ubuntu One account, which I'm having trouble with, so I'll just
> > > give it here and hopefully somebody can make use of it.  The issue
> > > seems to be in an experimental format, so it's likely not very
> > > consequential anyway.
> 
> Analysis in another thread may be relevant:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08963.html

The assertion there was:

qemu-system-x86_64: block.c:3434: bdrv_replace_node: Assertion `!atomic_read(&to->in_flight)' failed.

Which quite clearly pointed to a drain bug. This one, however, doesn't
seem to be related to drain, so I think it's probably a different bug.

Kevin
