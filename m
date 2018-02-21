Received: from eggs.gnu.org ([2001:4830:134:3::10]:39874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoXsr-0000ky-Cf
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoXsq-0005qz-Ix
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:45 -0500
Date: Wed, 21 Feb 2018 18:08:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180221170835.GA353@localhost.localdomain>
References: <20180221140849.16068-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221140849.16068-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v3] specs/qcow2: Fix documentation of the
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 21.02.2018 um 15:08 hat Alberto Garcia geschrieben:
> This patch fixes several mistakes in the documentation of the
> compressed cluster descriptor:
> 
> 1) the documentation claims that the cluster descriptor contains the
>    number of sectors used to store the compressed data, but what it
>    actually contains is the number of sectors *minus one* or, in other
>    words, the number of additional sectors after the first one.
> 
> 2) the width of the fields is incorrectly specified. The number of bits
>    used by each field is
> 
>       x = 62 - (cluster_bits - 8)   for the offset field
>       y = (cluster_bits - 8)        for the size field
> 
>    So the offset field's location is [0, x-1], not [0, x] as stated.
> 
> 3) the size field does not contain the size of the compressed data,
>    but rather the number of sectors where that data is stored. The
>    compressed data starts at the exact point specified in the offset
>    field and ends when there's enough data to produce a cluster of
>    decompressed data. Both points can be in the middle of a sector,
>    allowing several compressed clusters to be stored next to one
>    another, sharing sectors if necessary.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
