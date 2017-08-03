Received: from eggs.gnu.org ([2001:4830:134:3::10]:45227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddBRl-0005kp-Vj
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 04:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddBRg-0007al-Uv
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 04:25:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddBRg-0007Zi-Nx
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 04:25:28 -0400
Date: Thu, 3 Aug 2017 10:25:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170803102522.4758f156@gondolin>
In-Reply-To: <20170803003527.86979-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170803003527.86979-1-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] ERC cleanup and CRW bugfix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

On Thu,  3 Aug 2017 02:35:25 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> This series is trying to:
> 1. clear up ERC related code
> 2. bugfix for channel path related CRW generation
> 
> Change log
> ----------
> v2->v3:
> Added Halil's R-B on both patches.
> Patch #1:
>   Added ERC "installed parameters restored".
> 
> v1->v2:
> Patch #1:
>   Add all ERCs.
>   Commit message update.
> Patch #2:
>   Rename the new added parameter to more speaking name -- solicited.
> 
> Dong Jia Shi (2):
>   s390x/css: use macro for event-information pending error recover code
>   s390x/css: generate solicited crw for rchp completion signaling
> 
>  hw/s390x/css.c            | 16 ++++++++++------
>  include/hw/s390x/css.h    |  3 ++-
>  include/hw/s390x/ioinst.h | 12 ++++++++++--
>  3 files changed, 22 insertions(+), 9 deletions(-)
> 

Thanks, applied.
