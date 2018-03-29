Received: from eggs.gnu.org ([2001:4830:134:3::10]:53723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1Yfy-0005fq-0m
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 10:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1Yfx-0001UQ-4c
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 10:37:14 -0400
References: <20180329120745.11154-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4589769-90ac-dbe7-7f54-84700793a77e@redhat.com>
Date: Thu, 29 Mar 2018 09:37:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180329120745.11154-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 v5] iotests: Test abnormally large
 size in compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 03/29/2018 07:07 AM, Alberto Garcia wrote:
> L2 entries for compressed clusters have a field that indicates the
> number of sectors used to store the data in the image.
> 
> That's however not the size of the compressed data itself, just the
> number of sectors where that data is located. The actual data size is
> usually not a multiple of the sector size, and therefore cannot be
> represented with this field.
> 

> One possible task for the future is to make 'qemu-img check' verify
> the sizes of the compressed clusters, by trying to decompress the data
> and checking that the size stored in the L2 entry is correct.

Is it still worth trying to add such a check in 2.12?  (Probably not - 
the bug has been there "since the beginning", so it's not a regression 
and thus not a showstopper if it stays there for another release)

> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
> v5: Use 'write -c' instead of 'write' followed by 'convert' [Max]
>      Add TODO comment explaining that the size of compressed clusters
>      should also be corrected when it's too large in order to avoid
>      referencing other unrelated clusters.

Thanks, those changes look good.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
