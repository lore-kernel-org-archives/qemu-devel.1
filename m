Received: from eggs.gnu.org ([2001:4830:134:3::10]:48103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKM90-0005DW-V6
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKM8x-0003o4-T3
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:00:23 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:34123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dKM8x-0003nN-Fz
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:00:19 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170508141536.20690-8-stefanha@redhat.com>
References: <20170508141536.20690-1-stefanha@redhat.com>
	<20170508141536.20690-8-stefanha@redhat.com>
Date: Mon, 12 Jun 2017 12:00:14 +0200
Message-ID: <w51ziddplu9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 7/9] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Mon 08 May 2017 04:15:34 PM CEST, Stefan Hajnoczi wrote:
> The measure subcommand calculates the size required by a new image file.
> This can be used by users or management tools that need to allocate
> space on an LVM volume, SAN LUN, etc before creating or converting an
> image file.
>
> Suggested-by: Maor Lipchuk <mlipchuk@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v5:
>  * Use UINT64_MAX instead of ~0ULL [Berto]
>  * Document qemu-img measure ofmt, fmt, output_fmt, and snapshot_param
>    [Berto]
> ---

I had left some comments to v5 of this patch, I'm not sure if you saw
that e-mail:

https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01717.html

Berto
