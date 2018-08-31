Received: from eggs.gnu.org ([2001:4830:134:3::10]:57351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fvfsG-0003aL-Vo
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fvfsC-000696-0y
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:37:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fvfsB-00068O-SP
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:37:47 -0400
Date: Fri, 31 Aug 2018 10:37:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180831093742.GA2376@work-vm>
References: <20180830173657.22939-1-dgilbert@redhat.com>
	<f5585867-f669-c58a-5f76-4b01ce9fb1e9@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f5585867-f669-c58a-5f76-4b01ce9fb1e9@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: Fix uninitialised
 rdma_return_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, cohuck@redhat.com, jemmy858585@gmail.com

* Philippe Mathieu-Daud=E9 (f4bug@amsat.org) wrote:
> On 8/30/18 2:36 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Clang correctly errors out moaning that rdma_return_path
> > is used uninitialised in the earlier error paths.
> > Make it NULL so that the error path ignores it.
> >=20
> > Fixes: 55cc1b5937a8e709e4c102e74b206281073aab82
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reprorted by: Cornelia Huck <cohuck@redhat.com>
>=20
> "Reported-by"

Oops

> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Thanks,

Dave

>=20
> > ---
> >  migration/rdma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index ae07515e83..9b2e7e10aa 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -4012,7 +4012,7 @@ static void rdma_accept_incoming_migration(void=
 *opaque)
> >  void rdma_start_incoming_migration(const char *host_port, Error **er=
rp)
> >  {
> >      int ret;
> > -    RDMAContext *rdma, *rdma_return_path;
> > +    RDMAContext *rdma, *rdma_return_path =3D NULL;
> >      Error *local_err =3D NULL;
> > =20
> >      trace_rdma_start_incoming_migration();
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
