Received: from eggs.gnu.org ([2001:4830:134:3::10]:60731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eotea-0004rh-MA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoteX-0005Un-GB
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:23:28 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180222155922.9833-5-eblake@redhat.com>
References: <20180222155922.9833-1-eblake@redhat.com>
	<20180222155922.9833-5-eblake@redhat.com>
Date: Thu, 22 Feb 2018 17:23:23 +0100
Message-ID: <w51371t56ys.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/4] qcow2: Avoid memory over-allocation
 on compressed images
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

On Thu 22 Feb 2018 04:59:22 PM CET, Eric Blake wrote:
>          sector_offset = coffset & 511;
>          csize = nb_csectors * 512 - sector_offset;
           [...]
> +        assert(csize < 2 * s->cluster_size);

I think it should be <=

If sector_offset is 0 and nb_csector is the maximum allowed value then
csize is exactly 2 * s->cluster_size bytes.

Berto
