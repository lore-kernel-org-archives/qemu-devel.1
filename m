Received: from eggs.gnu.org ([2001:4830:134:3::10]:50781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em4Lh-0008WB-CD
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em4Lg-0000Hd-IM
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:12:17 -0500
References: <20180214204915.7980-1-mreitz@redhat.com>
	<20180214204915.7980-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f446d3c-0df1-d979-337d-f6b7ca0974d3@redhat.com>
Date: Wed, 14 Feb 2018 15:12:11 -0600
MIME-Version: 1.0
In-Reply-To: <20180214204915.7980-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] block/ssh: Add basic .bdrv_truncate()
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
> libssh2 does not seem to offer real truncation support, so we can only
> grow files -- but that is better than nothing.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/ssh.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
