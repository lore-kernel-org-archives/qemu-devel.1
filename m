Received: from eggs.gnu.org ([2001:4830:134:3::10]:54919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ceqNj-00021J-Pj
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ceqNj-00049k-3D
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:47:59 -0500
Date: Fri, 17 Feb 2017 16:47:52 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170217214752.GL19045@localhost.localdomain>
References: <cover.1485365834.git.jcody@redhat.com>
	<f0449fb39181c0c4c45d3deba6faaea5282161e0.1485365834.git.jcody@redhat.com>
	<36a56ad1-9a1a-9542-1b54-389fddc7081e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a56ad1-9a1a-9542-1b54-389fddc7081e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] iscsi: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

On Fri, Feb 17, 2017 at 03:40:21PM -0600, Eric Blake wrote:
> On 01/25/2017 11:42 AM, Jeff Cody wrote:
> > From: Kevin Wolf <kwolf@redhat.com>
> > 
> > This adds blockdev-add support for iscsi devices.
> > 
> > Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block/iscsi.c        | 14 ++++++----
> >  qapi/block-core.json | 74 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 78 insertions(+), 10 deletions(-)
> 
> > +++ b/qapi/block-core.json
> > @@ -2116,10 +2116,10 @@
> >  { 'enum': 'BlockdevDriver',
> >    'data': [ 'archipelago', 'blkdebug', 'blkverify', 'bochs', 'cloop',
> >              'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
> > -            'host_device', 'http', 'https', 'luks', 'nbd', 'nfs', 'null-aio',
> > -            'null-co', 'parallels', 'qcow', 'qcow2', 'qed', 'quorum', 'raw',
> > -            'replication', 'ssh', 'vdi', 'vhdx', 'vmdk', 'vpc',
> > -            'vvfat' ] }
> > +            'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
> > +            'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
> > +            'quorum', 'raw', 'replication', 'ssh', 'vdi', 'vhdx', 'vmdk',
> > +            'vpc', 'vvfat' ] }
> 
> Are we missing a since 2.9 documentation designation here?
> 

Yes, thanks for catching that.  I've applied it to my branch already, but I
will go ahead and fix this and rebase with the following squashed into the
patch:

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f00fc9d..5f82d35 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2110,6 +2110,7 @@
 # @nfs: Since 2.8
 # @replication: Since 2.8
 # @ssh: Since 2.8
+# @iscsi: Since 2.9
 #
 # Since: 2.0
 ##
