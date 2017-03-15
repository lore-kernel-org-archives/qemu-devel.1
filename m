Received: from eggs.gnu.org ([2001:4830:134:3::10]:37925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cnzPu-0002bT-Rh
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cnzPq-0000zF-Aa
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cnzPq-0000yn-0S
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:15:58 -0400
Date: Wed, 15 Mar 2017 11:15:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170315031550.GG12964@pxdev.xzpeter.org>
References: <1489496187-624-1-git-send-email-peterx@redhat.com>
	<20170315032001-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315032001-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] memory: info mtree check mr range overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, mark.cave-ayland@ilande.co.uk, Peter Maydell <peter.maydell@linaro.org>

On Wed, Mar 15, 2017 at 03:24:04AM +0200, Michael S. Tsirkin wrote:
> On Tue, Mar 14, 2017 at 08:56:27PM +0800, Peter Xu wrote:
> > The address of memory regions might overflow when something wrong
> > happened, like reported in:
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg02043.html
> > 
> > For easier debugging, let's try to detect it.
> > 
> > Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> 
> After a chat with Paolo, I think the following is a more general fix
> 
> - fix info mtree to do 128 bit math and display more than
>   16 digits if necessary

Could you help elaborate in what case will we really need that 128 bit
address?

Btw, thanks for pointing out in the other thread that your patch
wasn't printing 128 bits but 64 bits, actually I didn't notice that
before... but even with that, I would still slightly prefer this one
though considering readability and simplicity.

> - add info about region visibility
>   how much info is appropriate is arguable - after all we already have info mtree -f
>   we probably should report if region is not visible at all,
>   how about partially occluded ones? listing all windows is probably not
>   needed - we have the -f flag for that.

For me, "info mtree" and its "-f" form work good enough. So I'll leave
the discussion on this one to people who know better than me...

Thanks,

-- peterx
