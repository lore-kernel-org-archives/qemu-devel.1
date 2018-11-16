Received: from eggs.gnu.org ([2001:4830:134:3::10]:47483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNhS9-0006yD-4q
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNhS3-0005MN-Lw
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:58:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNhS3-0005A4-Fz
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:58:39 -0500
References: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
	<20181024094051.4470-4-maozhongyi@cmss.chinamobile.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89541229-6e18-a07d-d7d0-475a18702926@redhat.com>
Date: Fri, 16 Nov 2018 10:58:31 -0600
MIME-Version: 1.0
In-Reply-To: <20181024094051.4470-4-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-iotests: Modern shell
 scripting (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com

On 10/24/18 4:40 AM, Mao Zhongyi wrote:
> Various shell files contain a mix between obsolete ``
> and modern $(); It would be nice to convert to using
> $() everywhere.
> 
> Cc: kwolf@redhat.com
> Cc: mreitz@redhat.com
> Cc: eblake@redhat.com
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>   tests/qemu-iotests/check         | 60 ++++++++++++++++----------------
>   tests/qemu-iotests/common.config |  4 +--
>   2 files changed, 32 insertions(+), 32 deletions(-)

Only affects tests/ so safe for 3.1.  I'm happy to take this through my 
NBD queue, since Dan's test addition will also be impacted by this change.

> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index b37713277d..89ed275988 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -590,7 +590,7 @@ fi
>   export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
>   
>   if [ -z "$QEMU_VXHS_PROG" ]; then
> -  export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
> +    export QEMU_VXHS_PROG="$(set_prog_path qnio_server)"
>   fi

Interesting indentation change while at it.  But 4 spaces does seem to 
be more consistent.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
