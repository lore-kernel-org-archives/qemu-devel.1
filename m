Received: from eggs.gnu.org ([2001:4830:134:3::10]:59790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgBQg-0004cH-VS
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgBQc-0000vV-Ti
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:28:34 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170221115512.21918-18-berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-18-berrange@redhat.com>
Date: Tue, 21 Feb 2017 15:28:25 +0100
Message-ID: <w51bmtvboty.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 17/18] block: remove all encryption
 handling APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue 21 Feb 2017 12:55:11 PM CET, Daniel P. Berrange wrote:
> @@ -2244,24 +2240,8 @@ void qmp_block_passwd(bool has_device, const char *device,
>                        bool has_node_name, const char *node_name,
>                        const char *password, Error **errp)
>  {
> -    Error *local_err = NULL;
> -    BlockDriverState *bs;
> -    AioContext *aio_context;
> -
> -    bs = bdrv_lookup_bs(has_device ? device : NULL,
> -                        has_node_name ? node_name : NULL,
> -                        &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    aio_context = bdrv_get_aio_context(bs);
> -    aio_context_acquire(aio_context);
> -
> -    bdrv_add_key(bs, password, errp);
> -
> -    aio_context_release(aio_context);
> +    error_setg(errp,
> +               "Setting block passwords directly is no longer supported");
>  }

Shouldn't you also update the command description in block-core.json and
hmp-commands.hx ?

Berto
