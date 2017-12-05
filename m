Received: from eggs.gnu.org ([2001:4830:134:3::10]:41682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMD2U-00019B-Rg
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMD2T-0007T2-Rt
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:13:34 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-20-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-20-mreitz@redhat.com>
Date: Tue, 05 Dec 2017 14:13:27 +0100
Message-ID: <w511sk971xk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 19/25] block: Add
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

On Mon 20 Nov 2017 09:09:58 PM CET, Max Reitz wrote:
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
> implementation and the ones that we actually (currently) want to use
> differ. See quorum_gather_child_options() for more information.
>
> Note that both of these are cases which are not ideal: In case of VMDK
> it would probably be nice to be able to specify options for all extents.
> In case of quorum, the current runtime option structure is simply broken
> and needs to be fixed (but that is left for another patch).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
