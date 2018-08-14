Received: from eggs.gnu.org ([2001:4830:134:3::10]:47230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpYtP-0004CK-3S
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpYtO-0003f8-4e
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:57:47 -0400
References: <20180814095847.23778-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd0e7f07-d920-17d8-d0a0-b125c46e56fe@redhat.com>
Date: Tue, 14 Aug 2018 07:57:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180814095847.23778-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] mirror: Fail gracefully for source ==
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On 08/14/2018 04:58 AM, Kevin Wolf wrote:
> blockdev-mirror with the same node for source and target segfaults
> today: A node is in its own backing chain, so mirror_start_job() decides
> that this is an active commit. When adding the intermediate nodes with
> block_job_add_bdrv(), it starts the iteration through the subchain with
> the backing file of source, though, so it never reaches target and
> instead runs into NULL at the base.
> 
> While we could fix that by starting with source itself, there is no
> point in allowing mirroring a node into itself and I wouldn't be
> surprised if this caused more problems later.
> 
> So just check for this scenario and error out.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/mirror.c             | 5 +++++
>   tests/qemu-iotests/041     | 6 ++++++
>   tests/qemu-iotests/041.out | 4 ++--
>   3 files changed, 13 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
