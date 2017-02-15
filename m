Received: from eggs.gnu.org ([2001:4830:134:3::10]:45130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2tW-0001At-C1
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2tV-0001gV-NT
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:57:30 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-16-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd7747fa-088b-4042-3840-c53e3a2757b3@redhat.com>
Date: Wed, 15 Feb 2017 17:57:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-16-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/18] qmp: add block-dirty-bitmap-load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com



On 03/02/2017 16:47, Vladimir Sementsov-Ogievskiy wrote:
>  ##
> +# @block-dirty-bitmap-load:
> +#
> +# Load a dirty bitmap from the storage (qcow2 file or nbd export)

NBD export only in upstream QEMU?

Paolo

> +# Returns: nothing on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found, GenericError with an explanation
> +#
