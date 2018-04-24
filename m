Received: from eggs.gnu.org ([2001:4830:134:3::10]:51961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fAu1K-0002t0-O3
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 05:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fAu1G-0003Xv-Ew
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 05:13:54 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180423223337.82366-3-eblake@redhat.com>
References: <20180423223337.82366-1-eblake@redhat.com>
	<20180423223337.82366-3-eblake@redhat.com>
Date: Tue, 24 Apr 2018 11:13:47 +0200
Message-ID: <w51lgdd55mc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 2/5] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 24 Apr 2018 12:33:34 AM CEST, Eric Blake wrote:
> Although off_t permits up to 63 bits (8EB) of file offsets, in
> practice, we're going to hit other limits first.  Document some
> of those limits in the qcow2 spec, and how choice of cluster size
> can influence some of the limits.
>
> While at it, notice that since we cannot map any virtual cluster
> to any address higher than 64 PB (56 bits) (due to the current L1/L2
> field encoding stopping at bit 55), it makes little sense to require
> the refcount table to access host offsets beyond that point.  Mark
> the upper bits of the refcount table entries as reserved to match
> the L1/L2 table, with no ill effects, since it is unlikely that there
> are any existing images larger than 64PB in the first place, and thus
> all existing images already have those bits as 0.  If 64PB proves to
> be too small in the future, we could enlarge all three uses of bit
> 55 into the reserved bits at that time.  (For reference, ext4 with
> 4k blocks caps files at 16PB.)
>
> However, there is one limit that reserved bits don't help with: for
> compressed clusters, the L2 layout requires an ever-smaller maximum
> host offset as cluster size gets larger, down to a 512 TB maximum
> with 2M clusters.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
