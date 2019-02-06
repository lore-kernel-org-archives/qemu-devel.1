Received: from eggs.gnu.org ([209.51.188.92]:51241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1grOj1-0001fE-6T
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1grOiy-0002Az-Un
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:02:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1grOiu-00026R-Dg
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:02:49 -0500
Date: Wed, 6 Feb 2019 17:02:27 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190206150226.GC4282@lap1>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
	<20190131130850.6850-4-yuval.shaia@oracle.com>
	<3dc624dc-7940-f3cc-6d22-bfe0b9d6bc14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc624dc-7940-f3cc-6d22-bfe0b9d6bc14@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] hw/rdma: Warn when too many
 consecutive poll CQ triggered on an empty CQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dgilbert@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

> > @@ -60,6 +60,8 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
> >           return -EINVAL;
> >       }
> > +    atomic_dec(&cq->missing_cqe);
> > +
> 
> We should set it to 0 here? (If we are counting cq-empty hits)

No, this counter just count the number of missing CQEs. It is increased on
every WQE we are posting and decreased on every CQE we receive. What is
remain is the missing CQEs.

> 
> >       ring = (PvrdmaRing *)cq->opaque;
> >       /* Step #1: Put CQE on CQ ring */
