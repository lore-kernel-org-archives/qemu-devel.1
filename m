Received: from eggs.gnu.org ([2001:4830:134:3::10]:39337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1clCPy-0007sv-Dy
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1clCPv-0005Bf-94
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:32:34 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:39724 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1clCPu-0005Bb-TP
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:32:31 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170303135150.12145-3-stefanha@redhat.com>
References: <20170303135150.12145-1-stefanha@redhat.com>
	<20170303135150.12145-3-stefanha@redhat.com>
Date: Tue, 07 Mar 2017 11:32:29 +0100
Message-ID: <w51k2812x8i.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 2/4] raw-format: add bdrv_max_size() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow <jsnow@redhat.com>

On Fri 03 Mar 2017 02:51:48 PM CET, Stefan Hajnoczi wrote:

> +static uint64_t raw_max_size(QemuOpts *opts, BlockDriverState *in_bs,
> +                             Error **errp)
> +{
> +    if (in_bs) {
> +        int64_t size = bdrv_nb_sectors(in_bs);
> +        if (size < 0) {
> +            error_setg_errno(errp, -size, "Unable to get image size");
> +            return 0;
> +        }
> +        return (uint64_t)size * BDRV_SECTOR_SIZE;
> +    }

Why not use bdrv_getlength() directly? It gives you the size in bytes.

Berto
