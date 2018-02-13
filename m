Received: from eggs.gnu.org ([2001:4830:134:3::10]:37601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbwP-0000Uo-7Q
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbwO-00042M-Fj
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:52:17 -0500
References: <cover.1517840876.git.berto@igalia.com>
	<1fd7d272b5e7b66254a090b74cf2bed1cc334c0e.1517840877.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c619966e-56e9-d5d1-04eb-c2cbb03ae3e3@redhat.com>
Date: Tue, 13 Feb 2018 08:52:09 -0600
MIME-Version: 1.0
In-Reply-To: <1fd7d272b5e7b66254a090b74cf2bed1cc334c0e.1517840877.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 31/39] qcow2: Update qcow2_truncate() to
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
> The qcow2_truncate() code is mostly independent from whether
> we're using L2 slices or full L2 tables, but in full and
> falloc preallocation modes new L2 tables are allocated using
> qcow2_alloc_cluster_link_l2().  Therefore the code needs to be
> modified to ensure that all nb_clusters that are processed in each
> call can be allocated with just one L2 slice.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
