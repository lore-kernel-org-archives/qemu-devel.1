Received: from eggs.gnu.org ([2001:4830:134:3::10]:47769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejnuL-0005Hr-UF
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejnuG-0001tn-TJ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:14:41 -0500
Date: Thu, 8 Feb 2018 16:14:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180208161414.073ac2c2.cohuck@redhat.com>
In-Reply-To: <20180207155531.28446-1-cohuck@redhat.com>
References: <20180207155531.28446-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] s390x: maintainership reorg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, thuth@redhat.com

On Wed,  7 Feb 2018 16:55:28 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Hi,
> 
> s390x maintainership is currently a bit like a huge pile of stuff routed
> through one person who is not even listed as the maintainer for some
> of the areas. Let's try to clean this up a bit.
> 
> Patch 1 is basically making official what I actually have been doing in
> the last months; that is, acting as the overall s390x maintainer. There
> does not seem to be the concept of "overall arch maintainer" in MAINTAINERS
> so far, so I added it.
> 
> Where I want to go is basically a submaintainership model for s390x,
> i.e. that I integrate the work in various areas and send it on. Patch 2
> serves as a step in that direction, as Thomas has volunteered to look
> after the s390-ccw bios (thanks!)
> 
> If that works out well, I plan to split out other parts as well. That
> would make a lot of sense for those parts which I lack documentation
> for, and also for parts where other folks could do a good job as well.
> 
> Speaking of other people: Patch 3 adds David as an additional maintainer
> for tcg (thanks!).
> 
> Cornelia Huck (3):
>   MAINTAINERS: add myself as overall s390x maintainer
>   MAINTAINERS: reorganize s390-ccw bios maintainership
>   MAINTAINERS: add David as additional tcg/s390 maintainer
> 
>  MAINTAINERS | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 

Queued to s390-next.
