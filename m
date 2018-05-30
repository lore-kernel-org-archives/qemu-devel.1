Received: from eggs.gnu.org ([2001:4830:134:3::10]:45001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO0qD-0003Py-GQ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO0qC-0003h7-82
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:08:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44866 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fO0qC-0003bw-3F
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:08:36 -0400
References: <20180530090121.28154-1-chen_han_xiao@126.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1533da5-308d-59c7-a0a4-863fb02d771b@redhat.com>
Date: Wed, 30 May 2018 08:08:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180530090121.28154-1-chen_han_xiao@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qga: add mountpoint usage to
 GuestFilesystemInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/30/2018 04:01 AM, Chen Hanxiao wrote:
> From: Chen Hanxiao <chenhanxiao@gmail.com>
> 
> This patch adds support for getting the usage of mounted
> filesystem.
> It's very useful when we try to monitor guest's filesystem.
> 
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> ---
> v2:
>     add description in qapi-schema and version numbers

> +# @usage: file system usage, integer between 0 and 100 (since 3.0)

I still find this as being too imprecise.  Don't throw away data learned 
from the guest that the client might like to know.  Either provide a 
floating point between 0 and 1, or provide the two actual statvfs() 
numbers (used and total) directly and let the client perform the 
division to learn the ratio.

>   # @disk: an array of disk hardware information that the volume lies on,
>   #        which may be empty if the disk type is not supported
>   #
>   # Since: 2.2
>   ##
>   { 'struct': 'GuestFilesystemInfo',
> -  'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
> +  'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str', 'usage': 'int',
>              'disk': ['GuestDiskAddress']} }
>   
>   ##
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
