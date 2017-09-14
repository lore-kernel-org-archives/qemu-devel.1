Received: from eggs.gnu.org ([2001:4830:134:3::10]:36017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsQEC-0007tI-GW
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsQE8-0005v8-FN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:14:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dsQE8-0005uT-8u
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:14:28 -0400
Date: Thu, 14 Sep 2017 11:14:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170914111423.008791d0.cohuck@redhat.com>
In-Reply-To: <20170913115029.47626-5-pasic@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-5-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] s390x/css: support ccw IDA
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

On Wed, 13 Sep 2017 13:50:29 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Let's add indirect data addressing support for our virtual channel
> subsystem. This implementation does no bother with any kind of

s/no/not/

> prefetching. We simply step trough the IDAL on demand.

s/trough/through/

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 6b0cd8861b..e34b2af4eb 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -819,6 +819,113 @@ incr:
>      return 0;
>  }
>  
> +/* returns values between 1 and bsz, where bs is a power of 2 */

s/bz/bsz/ (missed the second one)

I can fix the typos while applying.
