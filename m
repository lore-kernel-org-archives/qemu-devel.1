Received: from eggs.gnu.org ([2001:4830:134:3::10]:49790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em4Ih-00069A-72
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em4Id-00070o-ME
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:09:11 -0500
References: <20180214204915.7980-1-mreitz@redhat.com>
	<20180214204915.7980-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <626a7ee0-faef-863f-4dcf-384e9a18ba81@redhat.com>
Date: Wed, 14 Feb 2018 15:08:19 -0600
MIME-Version: 1.0
In-Reply-To: <20180214204915.7980-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] block/ssh: Pull ssh_grow_file() from
 ssh_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org

On 02/14/2018 02:49 PM, Max Reitz wrote:
> If we ever want to offer even rudimentary truncation functionality for
> ssh, we should put the respective code into a reusable function.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/ssh.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 

> +++ b/block/ssh.c
> @@ -803,6 +803,26 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
>       return ret;
>   }
>   
> +static int ssh_grow_file(BDRVSSHState *s, int64_t offset, Error **errp)
> +{
> +    ssize_t ret;
> +    char c[1] = { '\0' };

Could spell this 'char c[1] = "";', but you just did code motion.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
