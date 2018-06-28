Received: from eggs.gnu.org ([2001:4830:134:3::10]:37563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYf2b-000869-Sn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYf2a-0002YR-Or
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:05:25 -0400
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-18-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ca6cea6-e02e-fba9-c87a-3710610cc648@redhat.com>
Date: Thu, 28 Jun 2018 17:05:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180628000745.4477-18-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 17/31] block/nbd: Make bdrv_dirname()
 return NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 06/27/2018 07:07 PM, Max Reitz wrote:
> The generic bdrv_dirname() implementation would be able to generate some
> form of directory name for many NBD nodes, but it would be always wrong.
> Therefore, we have to explicitly make it an error (until NBD has some
> form of specification for export paths, if it ever will).

So far, no one has proposed it, so I don't imagine it being requested 
any time soon.

> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/nbd.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
