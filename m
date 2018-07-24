Received: from eggs.gnu.org ([2001:4830:134:3::10]:57609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhycy-0002AN-QT
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhycy-000392-1W
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:49:28 -0400
References: <20180724121753.5753-1-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0f7f0f9-93da-6e97-e87b-886f9a77f324@redhat.com>
Date: Tue, 24 Jul 2018 09:49:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180724121753.5753-1-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] Introduction of l2-cache-full option
 for qcow2 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

On 07/24/2018 07:17 AM, Leonid Bloch wrote:
> This series introduces an option to calculate and allocate
> automatically enough qcow2 L2 cache to cover the entire image.
> Using cache that covers the entire image can benefit performance,
> while having only a small memory overhead (just 1 MB for every 8 GB
> of virtual image size with the default cluster size).

Is this still needed after Berto's work on commit 603790e and related, 
that maximizes the l2 cache by minimizing the refcount cache?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
