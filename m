Received: from eggs.gnu.org ([2001:4830:134:3::10]:33581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCU06-0002t6-Ll
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCU05-0002JO-Qp
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:18:54 -0500
Date: Wed, 8 Nov 2017 18:18:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171108171843.GI30890@localhost.localdomain>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-20-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170929165347.29658-20-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 19/25] block: Add
 BlockDriver.bdrv_gather_child_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Am 29.09.2017 um 18:53 hat Max Reitz geschrieben:
> Some follow-up patches will rework the way bs->full_open_options is
> refreshed in bdrv_refresh_filename(). The new implementation will remove
> the need for the block drivers' bdrv_refresh_filename() implementations
> to set bs->full_open_options; instead, it will be generic and use static
> information from each block driver.
> 
> However, by implementing bdrv_gather_child_options(), block drivers will
> still be able to override the way the full_open_options of their
> children are incorporated into their own.
> 
> We need to implement this function for VMDK because we have to prevent
> the generic implementation from gathering the options of all children:
> It is not possible to specify options for the extents through the
> runtime options.

Sounds more like a bug than a feature.

> For quorum, the child names that would be used by the generic
> implementation and the ones that we actually want to use differ. See
> quorum_gather_child_options() for more information.

:-/

What was the conclusion of our discussion at KVM Forum again? I just
remember that this caused problems in other contexts like dynamic
reconfiguration, too.

> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block_int.h | 13 +++++++++++++
>  block/quorum.c            | 30 ++++++++++++++++++++++++++++++
>  block/vmdk.c              | 13 +++++++++++++
>  3 files changed, 56 insertions(+)

Kevin
