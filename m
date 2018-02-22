Received: from eggs.gnu.org ([2001:4830:134:3::10]:58557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ep0Ap-0000aH-8a
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ep0AG-0004NB-95
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:21:11 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-15-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba331d4f-39fa-b198-4231-086702417253@redhat.com>
Date: Thu, 22 Feb 2018 17:19:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-15-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/36] block: x-blockdev-create QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> This adds a synchronous x-blockdev-create QMP command that can create
> qcow2 images on a given node name.
> 
> We don't want to block while creating an image, so this is not the final
> interface in all aspects, but BlockdevCreateOptionsQcow2 and
> .bdrv_co_create() are what they actually might look like in the end. In
> any case, this should be good enough to test whether we interpret
> BlockdevCreateOptions as we should.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json      | 12 ++++++++
>   include/block/block_int.h |  2 ++
>   block/create.c            | 76 +++++++++++++++++++++++++++++++++++++++++++++++
>   block/qcow2.c             |  3 +-
>   block/Makefile.objs       |  2 +-
>   5 files changed, 93 insertions(+), 2 deletions(-)
>   create mode 100644 block/create.c
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
