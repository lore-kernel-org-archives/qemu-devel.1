Received: from eggs.gnu.org ([2001:4830:134:3::10]:38016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1Uk6-0004qQ-65
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1Uk3-0002P2-2p
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:20:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1Uk2-0002Ot-Sy
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:20:39 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170412135312.1686-3-lvivier@redhat.com> (Laurent Vivier's
	message of "Wed, 12 Apr 2017 15:53:12 +0200")
References: <20170412135312.1686-1-lvivier@redhat.com>
	<20170412135312.1686-3-lvivier@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 21 Apr 2017 11:20:32 +0200
Message-ID: <87pog6dsm7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-rng: stop virtqueue while
 the CPU is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Laurent Vivier <lvivier@redhat.com> wrote:
> If we modify the virtio-rng virqueue while the
> vmstate is already migrated we can have some
> inconsistencies between the virtqueue state and
> the memory content.
>
> To avoid this, stop the virtqueue while the CPU
> is stopped.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Reviewed-by: Juan Quintela <quintela@redhat.com>
