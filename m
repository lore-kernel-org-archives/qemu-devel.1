Received: from eggs.gnu.org ([2001:4830:134:3::10]:34245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX8Hq-0005V7-Fn
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX8Hl-00066Y-Eq
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:27:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gX8Hk-00065N-DA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:27:01 -0500
Date: Wed, 12 Dec 2018 19:26:41 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181212172641.GE5747@lap1>
References: <20181212114726.24060-1-ppandit@redhat.com>
	<20181212114726.24060-7-ppandit@redhat.com>
	<20181212172304.GD5747@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212172304.GD5747@lap1>
Subject: Re: [Qemu-devel] [PATCH v1 6/6] rdma: remove unused
 VENDOR_ERR_NO_SGE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>, yuval.shaia@oracle.com

On Wed, Dec 12, 2018 at 07:23:05PM +0200, Yuval Shaia wrote:
> On Wed, Dec 12, 2018 at 05:17:26PM +0530, P J P wrote:
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> > 
> > Replace VENDOR_ERR_NO_SGE macro with VENDOR_ERR_INV_NUM_SGE
> > to indicate invalid number of scatter/gather elements.
> 
> Suggesting a revised commit message such as:
> With commit xxxx ("pvrdma: check number of pages when creating rings")
> VENDOR_ERR_NO_SGE is no longer in use - delete it.

Correction, commit is ("rdma: check num_sge does not exceed MAX_SGE")

> 
> (kinda ambiguity if subject says "remove" while commit message says
> "replace")
> 
> > 
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > ---
> >  hw/rdma/rdma_backend.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index bd4710d16f..c28bfbd44d 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -37,12 +37,11 @@
> >  #define VENDOR_ERR_TOO_MANY_SGES    0x202
> >  #define VENDOR_ERR_NOMEM            0x203
> >  #define VENDOR_ERR_QP0              0x204
> > -#define VENDOR_ERR_NO_SGE           0x205
> > +#define VENDOR_ERR_INV_NUM_SGE      0x205
> >  #define VENDOR_ERR_MAD_SEND         0x206
> >  #define VENDOR_ERR_INVLKEY          0x207
> >  #define VENDOR_ERR_MR_SMALL         0x208
> >  #define VENDOR_ERR_INV_MAD_BUFF     0x209
> > -#define VENDOR_ERR_INV_NUM_SGE      0x210
> >  
> >  #define THR_NAME_LEN 16
> >  #define THR_POLL_TO  5000
> > -- 
> > 2.19.2
> > 
