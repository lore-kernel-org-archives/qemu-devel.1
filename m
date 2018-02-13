Received: from eggs.gnu.org ([2001:4830:134:3::10]:36931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbv9-0007ob-30
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbv8-0003PI-5Z
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:50:59 -0500
References: <cover.1517840876.git.berto@igalia.com>
	<5f4db199b9637f4833b58487135124d70add8cf0.1517840877.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1e6a974-986e-45a5-9c34-58b5897181ff@redhat.com>
Date: Tue, 13 Feb 2018 08:50:35 -0600
MIME-Version: 1.0
In-Reply-To: <5f4db199b9637f4833b58487135124d70add8cf0.1517840877.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 27/39] qcow2: Update
 qcow2_update_snapshot_refcount() to support L2 slices
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
> qcow2_update_snapshot_refcount() increases the refcount of all
> clusters of a given snapshot. In order to do that it needs to load all
> its L2 tables and iterate over their entries. Since we'll be loading
> L2 slices instead of full tables we need to add an extra loop that
> iterates over all slices of each L2 table.
> 
> This function doesn't need any additional changes so apart from that
> this patch simply updates the variable name from l2_table to l2_slice.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-refcount.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
