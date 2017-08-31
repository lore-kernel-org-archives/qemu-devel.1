Received: from eggs.gnu.org ([2001:4830:134:3::10]:34102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnMKc-0001fZ-N9
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnMKZ-0000ZO-JD
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:04:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnMKZ-0000Z7-E3
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:04:11 -0400
Date: Thu, 31 Aug 2017 12:04:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170831120407.447b0206.cohuck@redhat.com>
In-Reply-To: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/9]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 30 Aug 2017 18:36:00 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> This series has a character of a refactoring, as the initial motivation
> was improving readability and reducing complexity.

But you reduced the cover letter subject too much ;)

> 
> Despite of the original intent the tree first patches buxfixes, and
> according to Dong Jia the patch-set also has a functional value: for ccw
> pass-through, he is planing to pass-through the instruction completion
> information (cc or interruption condition) from the kernel, and this
> patch set can pretty much be seen as a preparation for that.

I think the first one (with the precedence fixed as well) is pretty
uncontroversial, and I'd be happy to queue an updated version.

> 
> The basic idea is: tell how to handle an unusual conditon where it's
> identified, instead of mapping it to an errno (more or less arbitrarily),
> then possibly mapping these errnos around, to finally (mentally) map the
> errno back to the condition and take appropriate action. 
> 
> At the end of the series we also have 125 lines of code less to maintain,
> and the executable got a bit smaller too.

I agree with the basic direction, but I think this needs more hashing
out.

> 
> Halil Pasic (9):
>   s390x/css: fix cc handling for XSCH
>   s390x: fix invalid use of cc 1 for SSCH
>   s390x/css: be more consistent if broken beyond repair
>   s390x: refactor error handling for SSCH and RSCH
>   s390x: refactor error handling for XSCH handler
>   s390x: refactor error handling for CSCH handler
>   s390x: refactor error handling for HSCH handler
>   s390x: refactor error handling for MSCH handler
>   s390x: factor out common ioinst handler logic
> 
>  hw/s390x/css.c              | 158 ++++++++++++--------------------------
>  hw/s390x/s390-ccw.c         |   8 +-
>  hw/vfio/ccw.c               |  32 ++++++--
>  include/hw/s390x/css.h      |  38 +++++++---
>  include/hw/s390x/s390-ccw.h |   2 +-
>  target/s390x/ioinst.c       | 181 ++++++++++----------------------------------
>  6 files changed, 147 insertions(+), 272 deletions(-)
> 
