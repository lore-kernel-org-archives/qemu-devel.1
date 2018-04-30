Received: from eggs.gnu.org ([2001:4830:134:3::10]:43619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDB90-0005TK-7M
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDB8z-0008W1-BA
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:55:14 -0400
References: <20180428163442.6238-1-mreitz@redhat.com>
	<20180428163442.6238-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8b67db9-edc7-a045-9a40-1b7caded8dc1@redhat.com>
Date: Mon, 30 Apr 2018 10:55:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180428163442.6238-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: Repair OFLAG_COPIED when fixing
 leaks
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

On 04/28/2018 11:34 AM, Max Reitz wrote:
> Repairing OFLAG_COPIED is usually safe because it is done after the
> refcounts have been repaired.  Therefore, it we did not find anyone else
> referencing a data or L2 cluster, it makes no sense to not set
> OFLAG_COPIED -- and the other direction (clearing OFLAG_COPIED) is
> always safe, anyway, it may just induce leaks.
> 
> Furthermore, if OFLAG_COPIED is actually consistent with a wrong (leaky)
> refcount, we will decrement the refcount with -r leaks, but OFLAG_COPIED
> will then be wrong.  qemu-img check should not produce images that are
> more corrupted afterwards then they were before.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1527085
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2-refcount.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
