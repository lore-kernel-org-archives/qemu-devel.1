Received: from eggs.gnu.org ([2001:4830:134:3::10]:59581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCQQk-0003nR-2D
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCQQf-0006As-2g
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:30:10 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170929165347.29658-20-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-20-mreitz@redhat.com>
Date: Wed, 08 Nov 2017 14:29:52 +0100
Message-ID: <w51o9oczynj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Fri 29 Sep 2017 06:53:41 PM CEST, Max Reitz wrote:
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
>
> For quorum, the child names that would be used by the generic
> implementation and the ones that we actually want to use differ. See
> quorum_gather_child_options() for more information.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
