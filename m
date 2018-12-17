Received: from eggs.gnu.org ([2001:4830:134:3::10]:59508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxiF-0001UA-MV
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxiB-0007g9-J8
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:33:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYxiB-0007dB-9O
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:33:51 -0500
Date: Mon, 17 Dec 2018 20:33:38 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181217183338.GB18512@lap1>
References: <20181217081047.2039-1-yuval.shaia@oracle.com>
	<20181217081047.2039-11-yuval.shaia@oracle.com>
	<24444259-238a-5811-a36d-44574d986c52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24444259-238a-5811-a36d-44574d986c52@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 10/23] qapi: Define new QMP message for
 pvrdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com, yuval.shai@oracle.com

On Mon, Dec 17, 2018 at 10:00:32AM -0600, Eric Blake wrote:
> On 12/17/18 2:10 AM, Yuval Shaia wrote:
> > pvrdma requires that the same GID attached to it will be attached to the
> > backend device in the host.
> > 
> > A new QMP messages is defined so pvrdma device can broadcast any change
> > made to its GID table. This event is captured by libvirt which in  turn
> > will update the GID table in the backend device.
> > 
> > Depend on: "qapi: Reduce Makefile boilerplate"
> 
> This line fits better...
> 
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > ---
> 
> ...here, where it is useful to reviewers but stripped by 'git am'. Remember,
> the commit message that lives in qemu.git is what people will care about a
> year from now, and if the dependency was correctly satisfied (which is now
> guaranteed, as commit bf582c34 has now landed), then the fact that this
> commit is in git means its dependencies have already been satisfied. A year
> from now, no one will care about what the dependencies were in developing
> the patch.

Thanks, will delete.

> 
> 
> > +##
> > +# @RDMA_GID_STATUS_CHANGED:
> > +#
> > +# Emitted when guest driver adds/deletes GID to/from device
> > +#
> > +# @netdev: RoCE Network Device name - char *
> > +#
> > +# @gid-status: Add or delete indication - bool
> 
> Listing the type of each member here is redundant...
> 
> > +{ 'event': 'RDMA_GID_STATUS_CHANGED',
> > +  'data': { 'netdev'        : 'str',
> > +            'gid-status'    : 'bool',
> 
> because the docs generator should already be using the type from here to do
> that on your behalf.

Thanks.

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
