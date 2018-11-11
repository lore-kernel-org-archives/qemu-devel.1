Received: from eggs.gnu.org ([2001:4830:134:3::10]:58312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLlnO-0003gl-52
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 04:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLlnK-0004LL-3H
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 04:12:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gLlnH-00046T-WD
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 04:12:37 -0500
Date: Sun, 11 Nov 2018 11:12:25 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181111091225.GF2974@lap1>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-4-yuval.shaia@oracle.com>
	<ae430ac0-aa00-92b8-1453-d0eb47372d69@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ae430ac0-aa00-92b8-1453-d0eb47372d69@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/22] hw/rdma: Return qpn 1 if ibqp is
 NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, yuval.shaia@oracle.com

On Sat, Nov 10, 2018 at 07:59:00PM +0200, Marcel Apfelbaum wrote:
> Hi Yuval,
>=20
> On 11/8/18 6:07 PM, Yuval Shaia wrote:
> > Device is not supporting QP0, only QP1.
> >=20
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/rdma_backend.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> > index 86e8fe8ab6..3ccc9a2494 100644
> > --- a/hw/rdma/rdma_backend.h
> > +++ b/hw/rdma/rdma_backend.h
> > @@ -33,7 +33,7 @@ static inline union ibv_gid *rdma_backend_gid(RdmaB=
ackendDev *dev)
> >   static inline uint32_t rdma_backend_qpn(const RdmaBackendQP *qp)
> >   {
> > -    return qp->ibqp ? qp->ibqp->qp_num : 0;
> > +    return qp->ibqp ? qp->ibqp->qp_num : 1;
>=20
> Just to be sure, what are the cases we don't get=A0 a qp_num?
> Can we assume all of them are MADs?
>=20
> Thanks,
> Marcel

qp->ibqp is set only in case that QP type is not QP 1 (see
rdma_backend_create_qp()) so we can safely assume that this is QP 1.

>=20
> >   }
> >   static inline uint32_t rdma_backend_mr_lkey(const RdmaBackendMR *mr=
)
>=20
