Received: from eggs.gnu.org ([2001:4830:134:3::10]:40662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gJhaf-0003Ql-Qd
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gJhQk-00045C-0K
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:08:50 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1541004440-182262-2-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1541004440-182262-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1541004440-182262-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Mon, 05 Nov 2018 17:08:41 +0100
Message-ID: <w51k1lrik1i.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] The discard flag for
 block stream operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jcody@redhat.com, armbru@redhat.com, dgilbert@redhat.com, den@openvz.org, mreitz@redhat.com

On Wed 31 Oct 2018 05:47:19 PM CET, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> wrote:
> Adding a parameter to QMP block-stream command to allow discarding
> blocks in the backing chain while blocks are being copied to the
> active layer.
>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

I haven't checked the other patch yet, but if you're going to add new
API (this new 'discard' parameter) I suggest you to do it _after_ the
implementation.

> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2329,6 +2329,9 @@
>  #
>  # @speed:  the maximum speed, in bytes per second
>  #
> +# @discard: true to delete blocks duplicated in old backing files.
> +#           (default: false). Since 3.1.
> +#
>  # @on-error: the action to take on an error (default report).
>  #            'stop' and 'enospc' can only be used if the block device
>  #            supports io-status (see BlockInfo).  Since 1.3.
> @@ -2361,7 +2364,7 @@
>  { 'command': 'block-stream',
>    'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>              '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
> -            '*on-error': 'BlockdevOnError',
> +            '*discard': 'bool', '*on-error': 'BlockdevOnError',
>              '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }

Berto
