Received: from eggs.gnu.org ([2001:4830:134:3::10]:34304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYenI-0000rz-7N
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYenH-0007vU-E0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:49:36 -0400
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <16e42916-2cfe-5852-9940-982a1eae0892@redhat.com>
Date: Thu, 28 Jun 2018 16:49:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180628000745.4477-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 03/31] block: Skip implicit nodes for
 filename info
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

On 06/27/2018 07:07 PM, Max Reitz wrote:
> bdrv_refresh_filename() should simply skip all implicit nodes.  They are
> supposed to be invisible to the user, so they should not appear in
> filename information.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
