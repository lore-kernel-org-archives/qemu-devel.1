Received: from eggs.gnu.org ([2001:4830:134:3::10]:48835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDvfL-00010D-Ts
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDvfL-0006X9-5z
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:35:43 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7eeedf54-8437-c912-1180-75f9cf4f984b@redhat.com>
Date: Wed, 2 May 2018 12:35:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180421165423.30759-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] qemu-img: Amendment support implies
 create_opts
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

On 04/21/2018 11:54 AM, Max Reitz wrote:
> Instead of checking whether a driver has a non-NULL create_opts we
> should check whether it supports image amendment in the first place.  If
> it does, it must have create_opts.
> 
> On the other hand, if it does not have create_opts (so it does not
> support amendment either), the error message "does not support any
> options" is a bit useless.  Stating clearly that the driver has no
> amendment support whatsoever is probably better.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qemu-img.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
