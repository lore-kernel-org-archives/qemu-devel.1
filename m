Received: from eggs.gnu.org ([2001:4830:134:3::10]:42368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLkW2-0008EK-FT
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 02:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLkVo-0008Le-0j
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 02:50:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gLkVh-0007b5-DV
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 02:50:23 -0500
Date: Sun, 11 Nov 2018 09:50:08 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181111075007.GC2974@lap1>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-11-yuval.shaia@oracle.com>
	<6dbdd27a-1686-c7c0-068a-a1c71adc7c79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dbdd27a-1686-c7c0-068a-a1c71adc7c79@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/22] json: Define new QMP message for
 pvrdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com

On Sat, Nov 10, 2018 at 08:25:46PM +0200, Marcel Apfelbaum wrote:
> 
> > +#
> > +##
> > +{ 'event': 'RDMA_GID_STATUS_CHANGED',
> > +  'data': { 'netdev'        : 'str',
> > +            'gid-status'    : 'bool',
> 
> 'git-status' naming as of indication if we add or remove a gid
> is a little odd, but I can't come up with something better.

How about 'gid-in-use'?

> 
> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
> 
> Thanks,
> Marcel
> 
> > +            'subnet-prefix' : 'uint64',
> > +            'interface-id'  : 'uint64' } }
> 
