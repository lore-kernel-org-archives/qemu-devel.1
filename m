Received: from eggs.gnu.org ([2001:4830:134:3::10]:32830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxab2-0003wK-AH
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 11:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxaay-0008Sd-4U
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 11:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxaax-0008SJ-Tp
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 11:19:24 -0400
Date: Thu, 28 Sep 2017 17:19:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170928171919.0a71784c.cohuck@redhat.com>
In-Reply-To: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
References: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] 3270 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 20 Sep 2017 19:23:12 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Jason found some problems with 3270 which he traced down to insufficient
> output buffer size. I've looked into the underlying issue (and the
> relevant code) and I saw strange things. Among others an unreasonable
> assert requiring the payload of a ccw being less than some more or
> less arbitrary limit (dictated by the size of the output buffer).
> 
> Because we were already considering converting 3270 to CcwDataStream I've
> decided to try do get rid of this strange limitation on the length of the
> writes too. 
> 
> This series depends on my IDA work, which can be found here:
> https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg03434.html.
> 
> Halil Pasic (2):
>   s390x/3270: IDA support for 3270 via CcwDataStream
>   s390x/3270: handle writes of arbitrary length
> 
>  hw/char/terminal3270.c      | 46 +++++++++++++++++++++++++++------------------
>  hw/s390x/3270-ccw.c         |  4 ++--
>  include/hw/s390x/3270-ccw.h |  5 ++---
>  3 files changed, 32 insertions(+), 23 deletions(-)
> 

Thanks, applied.
