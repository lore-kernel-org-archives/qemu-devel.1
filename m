Received: from eggs.gnu.org ([2001:4830:134:3::10]:49078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNJP0-0004GX-Oj
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNJOx-0003VK-EQ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:54 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181113230319.1008531-2-eblake@redhat.com>
References: <20181113230319.1008531-1-eblake@redhat.com>
	<20181113230319.1008531-2-eblake@redhat.com>
Date: Thu, 15 Nov 2018 16:17:47 +0100
Message-ID: <w51bm6qgyjo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qcow2: Document some maximum size
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Wed 14 Nov 2018 12:03:17 AM CET, Eric Blake wrote:
> @@ -427,7 +451,9 @@ Standard Cluster Descriptor:
>  Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>
>      Bit  0 - x-1:   Host cluster offset. This is usually _not_ aligned to a
> -                    cluster or sector boundary!
> +                    cluster or sector boundary!  If cluster_bits is
> +                    small enough that this field includes bits beyond
> +                    55, those upper bits must be set to 0.

While I think that it's good to have a 56 bits upper limit for both
compressed and uncompressed clusters, I'm wondering: is it theoretically
possible to have data clusters above 64PB if they're all compressed?

Berto
