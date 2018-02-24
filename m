Received: from eggs.gnu.org ([2001:4830:134:3::10]:43788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eph4C-0000VK-S9
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 16:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eph4B-0002lc-MA
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 16:09:12 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a3875a7f-a3a2-9dca-cbb4-1660cfc3c76b@redhat.com>
Date: Sat, 24 Feb 2018 15:09:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180224154033.29559-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block: Handle null backing link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 02/24/2018 09:40 AM, Max Reitz wrote:
> Instead of converting all "backing": null instances into "backing": "",
> handle a null value directly in bdrv_open_inherit().
> 
> This enables explicitly null backing links for json:{} filenames.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>   block.c                    |  4 +++-
>   blockdev.c                 | 14 --------------
>   tests/qemu-iotests/089     | 20 ++++++++++++++++++++
>   tests/qemu-iotests/089.out |  8 ++++++++
>   4 files changed, 31 insertions(+), 15 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
