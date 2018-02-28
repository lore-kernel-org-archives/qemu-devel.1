Received: from eggs.gnu.org ([2001:4830:134:3::10]:60929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er2d2-0002H8-2X
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er2d1-0000u6-91
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:22:44 -0500
References: <20180228131315.30194-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5b4f75c-6dbf-c5cc-8463-f28bb48d3956@redhat.com>
Date: Wed, 28 Feb 2018 08:22:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180228131315.30194-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] block/file-posix: Fix fully
 preallocated truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org

On 02/28/2018 07:13 AM, Max Reitz wrote:
> Fully preallocated truncation has a 50 % chance of working on images
> files over file-posix.  It works if $SIZE % 4G < 2G, and it fails
> otherwise.  To make things even more interesting, often you would not
> even notice because qemu reported success even though it did nothing
> (because after the successful lseek(), errno was still 0, so when the
> file-posix driver tried to return a negative error code, it actually
> reported success).
> 
> This issue is fixed by patch 1 in this series.  Thanks to Daniel for
> reporting!
> 
> 
> Max Reitz (2):
>    block/file-posix: Fix fully preallocated truncate
>    iotests: Test preallocated truncate of 2G image

Good catch.  Series:
Reviewed-by: Eric Blake <eblake@redhat.com>

gluster.c has similar code, but it assigns glfs_lseek() to an int64_t, 
so it does not have the bug.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
