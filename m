Received: from eggs.gnu.org ([2001:4830:134:3::10]:57384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duxi1-0004ex-GG
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duxhy-0003LO-Be
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:23:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duxhy-0003KJ-4b
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:23:46 -0400
Date: Thu, 21 Sep 2017 11:23:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170921112341.59175a29.cohuck@redhat.com>
In-Reply-To: <20170920172314.102710-3-pasic@linux.vnet.ibm.com>
References: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
	<20170920172314.102710-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/3270: handle writes of arbitrary
 length
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

On Wed, 20 Sep 2017 19:23:14 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The problem is, that the current implementation places unrealistic and
> arbitrary constraints on the length of writes to the device (that is the
> outbound requests), by asserting ccw.count being such that that even the
> worst case escaped payload will fit an  more or less arbitrary sized
> buffer. Actually on protocol level there is nothing to justify such
> a limitation.
> 
> Another strange thing is the return value which more or less reflects
> the size (written) after escaping instead of before escaping. This
> is strange, because this return value is used to calculate SCSW.count.

Didn't the Linux driver care about the count?

> 
> Let us teach 3270 how to deal with arbitrary long writes.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Reported-by: Jason J . Herne <jjherne@linux.vnet.ibm.com>
> Tested-by: Jason J . Herne <jjherne@linux.vnet.ibm.com>
> ---
>  hw/char/terminal3270.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Looks good.
