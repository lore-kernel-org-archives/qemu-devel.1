Received: from eggs.gnu.org ([2001:4830:134:3::10]:55923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erXnS-0000Zg-6J
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 18:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erXnR-0003q7-Ay
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 18:39:34 -0500
References: <cover.1519921268.git.berto@igalia.com>
	<d58bbc353563bb9c83ffe90faaa36fadf683e332.1519921268.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c6863d4-1e0f-bed5-ac3f-8a48606a0a69@redhat.com>
Date: Thu, 1 Mar 2018 17:39:08 -0600
MIME-Version: 1.0
In-Reply-To: <d58bbc353563bb9c83ffe90faaa36fadf683e332.1519921268.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow2: Check L1 table parameters in
 qcow2_expand_zero_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 03/01/2018 10:27 AM, Alberto Garcia wrote:
> This function iterates over all snapshots of a qcow2 file in order to
> expand all zero clusters, but it does not validate the snapshots' L1
> tables first.
> 
> We now have a function to take care of this, so let's use it.
> 
> We can also take the opportunity to replace the sector-based
> bdrv_read() with bdrv_pread().

Doesn't my pending patch do that as well?
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06799.html

I guess it remains to be seen in what order these patches are merged.

> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-cluster.c      | 20 +++++++++++++-------
>   tests/qemu-iotests/080     |  2 ++
>   tests/qemu-iotests/080.out |  2 ++
>   3 files changed, 17 insertions(+), 7 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
