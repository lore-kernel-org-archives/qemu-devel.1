Received: from eggs.gnu.org ([2001:4830:134:3::10]:33005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gOJg7-0002LC-P5
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 04:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gOJam-0002OV-P1
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 04:42:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gOJal-0002NJ-Gu
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 04:42:12 -0500
Date: Sun, 18 Nov 2018 11:42:01 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181118094201.GF3638@lap1>
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
	<20181113071336.6242-23-yuval.shaia@oracle.com>
	<c061e6b3-2485-652a-b7da-8d5c5f3a739f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c061e6b3-2485-652a-b7da-8d5c5f3a739f@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 22/23] hw/rdma: Do not call
 rdma_backend_del_gid on an empty gid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com, yuval.shaia@oracle.com

On Sat, Nov 17, 2018 at 02:25:55PM +0200, Marcel Apfelbaum wrote:
> 
> 
> On 11/13/18 9:13 AM, Yuval Shaia wrote:
> > When device goes down the function fini_ports loops over all entries in
> > gid table regardless of the fact whether entry is valid or not. In case
> > that entry is not valid we'd like to skip from any further processing in
> > backend device.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/rdma_rm.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> > index 35a96d9a64..e3f6b2f6ea 100644
> > --- a/hw/rdma/rdma_rm.c
> > +++ b/hw/rdma/rdma_rm.c
> > @@ -555,6 +555,10 @@ int rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
> >   {
> >       int rc;
> > +    if (!dev_res->port.gid_tbl[gid_idx].gid.global.interface_id) {
> > +        return 0;
> > +    }
> > +
> >       rc = rdma_backend_del_gid(backend_dev, ifname,
> >                                 &dev_res->port.gid_tbl[gid_idx].gid);
> >       if (rc < 0) {
> 
> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

There seems to be a missing space separator between "Apfelbaum" and "<". Is
that ok?

> 
> Thanks,
> Marcel
> 
