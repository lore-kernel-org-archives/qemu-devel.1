Received: from eggs.gnu.org ([2001:4830:134:3::10]:48162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZplu-0000KW-Dp
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZplt-00035c-LF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:12:46 -0500
Date: Fri, 12 Jan 2018 11:12:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180112031238.GE29151@lemon.usersys.redhat.com>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-10-famz@redhat.com>
	<d425ded3-cfe0-1ae3-7d91-eb9913194f18@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d425ded3-cfe0-1ae3-7d91-eb9913194f18@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 9/9] qapi: Add NVMe driver options to
 the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

On Wed, 01/10 08:41, Eric Blake wrote:
> On 01/10/2018 03:18 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  qapi/block-core.json | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index e94a6881b2..fd6c94454d 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -2237,7 +2237,7 @@
> >    'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
> >              'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
> >              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
> > -            'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
> > +            'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2', 'qed',
> >              'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
> >              'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
> 
> Missing a doc line:
> @nvme: Since 2.12
> 

Will add, thanks!

Fam
