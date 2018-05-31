Received: from eggs.gnu.org ([2001:4830:134:3::10]:60155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOTCD-00066E-Nh
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOTCA-0001hT-G5
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:25:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOTCA-0001fz-Bn
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:25:10 -0400
Date: Thu, 31 May 2018 22:25:09 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180531215947-mutt-send-email-mst@kernel.org>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-24-git-send-email-mst@redhat.com>
	<20180531185032.2rr6u4pfja2twew5@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531185032.2rr6u4pfja2twew5@var.youpi.perso.aquilenet.fr>
Subject: Re: [Qemu-devel] [PATCH 23/67] slirp: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org

On Thu, May 31, 2018 at 08:50:32PM +0200, Samuel Thibault wrote:
> Hello,
> 
> Michael S. Tsirkin, le jeu. 03 mai 2018 22:51:01 +0300, a ecrit:
> > +#include_next "../slirp/ip6.h"
> 
> Mmm, this is the first time #include_next would be used in qemu, and I
> don't think this is a standard thing...
> 
> Samuel

Well we don't support arbitrary compilers, and
gcc and clang both have it.
It's also a temporary thing, then intent is for maintainers
to drop these after deciding on either code refactoring
or just moving header to include.

-- 
MST
