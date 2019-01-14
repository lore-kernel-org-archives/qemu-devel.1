Received: from eggs.gnu.org ([209.51.188.92]:45659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj0mL-0003z9-A6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj0mK-0002cu-FX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:51:41 -0500
References: <20181213162727.17438-1-lvivier@redhat.com>
	<20181213162727.17438-5-lvivier@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a6c3699-b2f7-fb55-00e0-653cdec416b2@redhat.com>
Date: Mon, 14 Jan 2019 12:51:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181213162727.17438-5-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] block/sheepdog: Convert from
 DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org, Liu Yuan <namei.unix@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>

On 13.12.18 17:27, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>=20
> Notes:
>     v2: replace "sd_" prefix by "sheepdog_"
>         remove the dot at the end of the text strings
>=20
>  block/sheepdog.c   | 47 +++++++++++++++++-----------------------------
>  block/trace-events | 14 ++++++++++++++
>  2 files changed, 31 insertions(+), 30 deletions(-)
>=20
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 0125df9d49..8b95cde01a 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c

[...]

> diff --git a/block/trace-events b/block/trace-events
> index 06dbe65080..358c0e3c11 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -189,3 +189,17 @@ file_xfs_discard(const char* error) "cannot punch =
hole (%s)"

[...]

> +sheepdog_snapshot_create_inode(const char *name, uint32_t snap, uint32=
_t vdi) "s->inode: name %s snap_id 0x%x vdi 0x%x"

Good point in giving @snap and @vdi the correct types, but then the
format string should follow suit. :-)

Max
