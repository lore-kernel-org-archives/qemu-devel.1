Received: from eggs.gnu.org ([209.51.188.92]:40953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hH4aD-0003oX-2p
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 06:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hH4a9-0003QT-Aa
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 06:47:55 -0400
Date: Thu, 18 Apr 2019 12:47:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190418104737.GC5242@linux.fritz.box>
References: <20190417115343.30527-1-pbonzini@redhat.com>
	<CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
	<cf51d357-d9c0-3a20-1d23-7f6671d7948a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf51d357-d9c0-3a20-1d23-7f6671d7948a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] scsi-generic: prevent guest
 from exceeding SG_IO limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

Am 18.04.2019 um 11:48 hat Paolo Bonzini geschrieben:
> On 17/04/19 14:30, Stefan Hajnoczi wrote:
> > On Wed, Apr 17, 2019 at 12:54 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> Linux places a limit of UIO_MAXIOV pages on SG_IO ioctls (and if the limit
> >> is exceeded, a confusing ENOMEM error is returned[1]).  Prevent the guest
> >> from exceeding these limits, by capping the maximum transfer length to
> >> that value in the block limits VPD page.
> >>
> >> [1] Oh well, at least it was easier to follow the kernel source knowing
> >>     it had to end as ENOMEM...
> >>
> >> Cc: qemu-stable@nongnu.org
> >> Cc: qemu-block@nongnu.org
> >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>  hw/scsi/scsi-generic.c | 17 +++++++++++++----
> >>  1 file changed, 13 insertions(+), 4 deletions(-)
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> 
> This is acually only an issue with kernels prior to 4.5, so it should be
> fixed downstream instead.

I don't think that upstream QEMU has kernels > 4.5 as an official
requirement, though? We try to be compatible with quite old libs, so we
should stay compatible with old kernels, too.

Kevin
