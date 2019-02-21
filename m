Received: from eggs.gnu.org ([209.51.188.92]:33501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gwkGz-0001jp-MN
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gwkGy-000691-UK
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:04:05 -0500
Date: Thu, 21 Feb 2019 10:03:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190221090355.GA901@linux.fritz.box>
References: <20190220174843.8847-1-kwolf@redhat.com>
	<20190220174843.8847-6-kwolf@redhat.com>
	<bf7d55dc-e914-ad14-d542-175255dd0d1b@redhat.com>
	<20190220180724.GE6281@localhost.localdomain>
	<46a57a6b-d4d6-62d1-20aa-64c9b5b9f91e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a57a6b-d4d6-62d1-20aa-64c9b5b9f91e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/13] io: Remove redundant
 read/write_coroutine assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Am 20.02.2019 um 19:22 hat Paolo Bonzini geschrieben:
> On 20/02/19 19:07, Kevin Wolf wrote:
> > Am 20.02.2019 um 19:01 hat Paolo Bonzini geschrieben:
> >> aio_co_wake was also acquiring/releasing the AioContext, so
> >> that needs to stay for now.
> > 
> > True. Maybe I should leave the aio_co_wake call alone() and just add the
> > assertion to avoid complicating the code rather than simplifying it...
> 
> Yes, I agree.

Okay, I made this change locally. I'm not sending a v3 for this, but
will just directly merge it if no other comments come up.

> ps: where is alone() defined? :)

#define aio_co_wake aio_co_wake()
#define alone() alone

Here. :-)

Kevin
