Received: from eggs.gnu.org ([2001:4830:134:3::10]:56162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEQdk-0004to-KU
	for qemu-devel@nongnu.org; Thu, 03 May 2018 22:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEQdh-0004pl-HH
	for qemu-devel@nongnu.org; Thu, 03 May 2018 22:40:08 -0400
Date: Fri, 4 May 2018 05:39:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180504053740-mutt-send-email-mst@kernel.org>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-35-git-send-email-mst@redhat.com>
	<20180504001556.GK13229@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504001556.GK13229@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 34/67] hw/ppc: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Fri, May 04, 2018 at 10:15:56AM +1000, David Gibson wrote:
> On Thu, May 03, 2018 at 10:51:12PM +0300, Michael S. Tsirkin wrote:
> > This way they are easier to find using standard rules.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I don't really understand what this is accomplishing.

Pls see the cover letter.

The specific headers are used outside their directory so ideally long
term either they should move to include or split or callers refactored.

It's up to maintainers to decide what to do, I do not want to make this
decision.

> > ---
> >  include/hw/ppc/e500-ccsr.h | 1 +
> >  include/hw/ppc/mac.h       | 1 +
> >  2 files changed, 2 insertions(+)
> >  create mode 100644 include/hw/ppc/e500-ccsr.h
> >  create mode 100644 include/hw/ppc/mac.h
> > 
> > diff --git a/include/hw/ppc/e500-ccsr.h b/include/hw/ppc/e500-ccsr.h
> > new file mode 100644
> > index 0000000..08e4ba2
> > --- /dev/null
> > +++ b/include/hw/ppc/e500-ccsr.h
> > @@ -0,0 +1 @@
> > +#include_next "../hw/ppc/e500-ccsr.h"
> > diff --git a/include/hw/ppc/mac.h b/include/hw/ppc/mac.h
> > new file mode 100644
> > index 0000000..e0f0b67
> > --- /dev/null
> > +++ b/include/hw/ppc/mac.h
> > @@ -0,0 +1 @@
> > +#include_next "../hw/ppc/mac.h"
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
