Received: from eggs.gnu.org ([2001:4830:134:3::10]:54174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gLFcx-0003sR-Qq
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gLFcw-0007Og-OO
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:51:47 -0500
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5daca84-4e1d-c2a4-d59d-b61bfbe8d88e@redhat.com>
Date: Fri, 9 Nov 2018 16:51:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180809223117.7846-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/11] blockdev: Check @replaces in
 blockdev_mirror_common
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

On 8/9/18 5:31 PM, Max Reitz wrote:
> There is no reason why the constraints we put on @replaces should be
> limited to drive-mirror.  Therefore, move the sanity checks from
> qmp_drive_mirror() to blockdev_mirror_common() so they apply to
> blockdev-mirror as well.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   blockdev.c | 55 ++++++++++++++++++++++++++++++++----------------------
>   1 file changed, 33 insertions(+), 22 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
