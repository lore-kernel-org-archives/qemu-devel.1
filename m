Received: from eggs.gnu.org ([209.51.188.92]:52029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hJhHv-0004Sl-1V
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hJhHu-000788-6x
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:31:55 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190417153005.30096-1-mreitz@redhat.com>
References: <20190417153005.30096-1-mreitz@redhat.com>
Date: Thu, 25 Apr 2019 18:31:25 +0200
Message-ID: <w51ef5q11ya.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] iotests: Make 182 do without device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed 17 Apr 2019 05:30:05 PM CEST, Max Reitz wrote:
> 182 fails if qemu has no support for hotplugging of a virtio-blk device.
> Using an NBD server instead works just as well for the test, even on
> qemus without hotplugging support.
>
> Fixes: 6d0a4a0fb5c8f10c8eb68b52cfda0082b00ae963
> Reported-by: Danilo C. L. de Paula <ddepaula@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Acked-by: Alberto Garcia <berto@igalia.com>

Berto
