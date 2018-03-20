Received: from eggs.gnu.org ([2001:4830:134:3::10]:49354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyL3t-0003Vx-OW
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyL3s-0001pF-CB
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:28:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49312 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyL3s-0001ov-80
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:28:36 -0400
Date: Tue, 20 Mar 2018 19:28:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320192314-mutt-send-email-mst@kernel.org>
References: <1521566230-111929-1-git-send-email-mst@redhat.com>
	<1521566230-111929-4-git-send-email-mst@redhat.com>
	<CAFEAcA97jt9rcAC4HROcxQgWhi-FxC3UOKhyrTuUioSFd=6KyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA97jt9rcAC4HROcxQgWhi-FxC3UOKhyrTuUioSFd=6KyA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] postcopy: drop unnecessary
 conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Tue, Mar 20, 2018 at 05:20:04PM +0000, Peter Maydell wrote:
> On 20 March 2018 at 17:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> > We have our own copy of unistd so there is no
> > need to check for symbols present there.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I just sent a mail in the other thread about this, but we
> only have our own copy of unistd if the host architecture
> supports KVM. If it doesn't then we're going to be using
> the system's copy of the includes...
> 
> thanks
> -- PMM

Hmm good point.

I guess I should leave postcopy alone then, and just update
the headers?

That can go through my tree ...

-- 
MST
