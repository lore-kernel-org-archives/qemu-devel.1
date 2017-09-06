Received: from eggs.gnu.org ([2001:4830:134:3::10]:46169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dpbqk-0008RX-NE
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dpbqg-00019Y-1d
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:02:42 -0400
Date: Wed, 6 Sep 2017 12:02:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170906150221.GB7570@localhost.localdomain>
References: <cover.1504112256.git.jcody@redhat.com>
	<fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
	<20170906130041.GI3753@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906130041.GI3753@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/3] block-jobs: Optionally
 unregister live block operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, peterx@redhat.com, mrezanin@redhat.com

On Wed, Sep 06, 2017 at 03:00:41PM +0200, Kevin Wolf wrote:
> Am 30.08.2017 um 19:01 hat Jeff Cody geschrieben:
> > From: Jeffrey Cody <jcody@redhat.com>
> > 
> > If configured without live block operations enabled, unregister the
> > live block operation commands.
> > 
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> 
> How sure are we that libvirt will like a qemu that advertises these
> commands in the schema, but doesn't actually provide them?

If libvirt wants to know if a command is available, it uses
'query-commands', not 'query-qmp-schema'.

The only query-qmp-schema elements used by latest libvirt are
gluster-related blockdev-add options (see
libvirt/src/qemu/qemu_capabilities.c:virQEMUCapsQMPSchemaQueries]]).

-- 
Eduardo
