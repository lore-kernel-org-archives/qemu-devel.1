Received: from eggs.gnu.org ([2001:4830:134:3::10]:34425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbkL-0007Ey-LA
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbkK-0003yi-Tw
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:39:49 -0500
References: <cover.1517840876.git.berto@igalia.com>
	<1cb44a5b68be5334cb01b97a3db3a3c5a43396e5.1517840877.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c8f18f4-d17e-6bfb-75d2-22a65cdda89a@redhat.com>
Date: Tue, 13 Feb 2018 08:39:25 -0600
MIME-Version: 1.0
In-Reply-To: <1cb44a5b68be5334cb01b97a3db3a3c5a43396e5.1517840877.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 24/39] qcow2: Update discard_single_l2()
 to support L2 slices
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
> discard_single_l2() limits the number of clusters to be discarded
> to the amount that fits inside an L2 table. Since we'll be loading
> L2 slices instead of full tables we need to update that limit. The
> function is renamed to discard_in_l2_slice() for clarity.
> 
> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-cluster.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
