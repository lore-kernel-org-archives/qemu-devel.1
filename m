Received: from eggs.gnu.org ([2001:4830:134:3::10]:54222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ete6i-0000NN-AR
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ete6h-00082I-Cg
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:48:08 -0500
References: <cover.1520352600.git.berto@igalia.com>
	<080ff2e2c66577e8113454dce4974c6a34915d9f.1520352600.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d9268455-ae27-6818-2533-5a25a3a3439d@redhat.com>
Date: Wed, 7 Mar 2018 12:47:41 -0600
MIME-Version: 1.0
In-Reply-To: <080ff2e2c66577e8113454dce4974c6a34915d9f.1520352600.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] qcow2: Check L1 table parameters in
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 03/06/2018 10:14 AM, Alberto Garcia wrote:
> This function iterates over all snapshots of a qcow2 file in order to
> expand all zero clusters, but it does not validate the snapshots' L1
> tables first.
> 
> We now have a function to take care of this, so let's use it.
> 
> We can also take the opportunity to replace the sector-based
> bdrv_read() with bdrv_pread().
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Cc: Eric Blake <eblake@redhat.com>
> ---
>   block/qcow2-cluster.c      | 24 +++++++++++++++++-------
>   tests/qemu-iotests/080     |  2 ++
>   tests/qemu-iotests/080.out |  4 ++++
>   3 files changed, 23 insertions(+), 7 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
