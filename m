Received: from eggs.gnu.org ([2001:4830:134:3::10]:37758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpZvh-00025f-W0
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpZvh-0001qX-1q
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:04:13 -0400
Date: Tue, 14 Aug 2018 16:04:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180814140403.GN5025@dhcp-200-186.str.redhat.com>
References: <cover.1530270904.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1530270904.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Some bs->options fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 29.06.2018 um 13:36 hat Alberto Garcia geschrieben:
> Hi everyone,
> 
> this is part of the blockdev-reopen work that I'm doing, but since
> I'll be away during most of July I thought that I could send already a
> couple of patches that I think are ready and don't need anything else
> from the rest of the series.
> 
> There's two main fixes here:
> 
>   1) bs->options are not kept up to date after an image is reopened
>      and no longer reflect its state.
> 
>   2) bs->options and bs->explicit_options also contain the options of
>      a BDS's children, so there's data that is duplicated and will be
>      inconsistent as soon as you change the children's options
>      directly.
> 
> The fix for (2) involves removing all children options from both
> QDicts. In the cases of node name references ("backing": "node-name")
> those remain in the QDict (they're technically parent options). I
> think we don't really need them and it should be possible to get rid
> of them, but it's a little more complicated (we need them during
> bdrv_reopen() to ensure that the user didn't try to change any of
> them).

Thanks, applied to the block branch.

Kevin
