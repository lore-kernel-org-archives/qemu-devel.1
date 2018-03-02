Received: from eggs.gnu.org ([2001:4830:134:3::10]:60758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZcj-0003QD-Aa
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZci-0007g7-Fc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:36:37 -0500
References: <cover.1519921268.git.berto@igalia.com>
	<e0230b79625ea4f0a73e6c1cc43710a2e1a1aa21.1519921268.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0511b0bf-aab9-42c5-797d-3844f72d044e@redhat.com>
Date: Thu, 1 Mar 2018 19:36:14 -0600
MIME-Version: 1.0
In-Reply-To: <e0230b79625ea4f0a73e6c1cc43710a2e1a1aa21.1519921268.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] qcow2: Check snapshot L1 table in
 qcow2_snapshot_delete()
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
> This function deletes a snapshot from disk, removing its entry from
> the snapshot table, freeing its L1 table and decreasing the refcounts
> of all clusters.
> 
> The L1 table offset and size are however not validated. If we use
> invalid values in this function we'll probably corrupt the image even
> more, so we should return an error instead.
> 
> We now have a function to take care of this, so let's use it.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-snapshot.c     | 7 +++++++
>   tests/qemu-iotests/080     | 2 ++
>   tests/qemu-iotests/080.out | 2 ++
>   3 files changed, 11 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
