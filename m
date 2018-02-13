Received: from eggs.gnu.org ([2001:4830:134:3::10]:34545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbl8-0007uV-DM
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbl7-0004Nr-He
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:40:38 -0500
References: <cover.1517840876.git.berto@igalia.com>
	<ebc16e7e79fa6969d8975ef487d679794de4fbcc.1517840877.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <882995e5-c409-a9b5-2b21-cbb7ca9db17b@redhat.com>
Date: Tue, 13 Feb 2018 08:40:30 -0600
MIME-Version: 1.0
In-Reply-To: <ebc16e7e79fa6969d8975ef487d679794de4fbcc.1517840877.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 25/39] qcow2: Update zero_single_l2() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On 02/05/2018 08:33 AM, Alberto Garcia wrote:
> zero_single_l2() limits the number of clusters to be zeroed to the
> amount that fits inside an L2 table. Since we'll be loading L2 slices
> instead of full tables we need to update that limit. The function is
> renamed to zero_in_l2_slice() for clarity.
> 
> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-cluster.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
