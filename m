Received: from eggs.gnu.org ([2001:4830:134:3::10]:39653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDGGE-0001xy-Kk
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 17:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDGGD-00019J-OT
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 17:23:02 -0400
References: <20180413181401.46318-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a18337d-1745-aca8-8d64-ccce22d4cefa@redhat.com>
Date: Mon, 30 Apr 2018 16:22:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180413181401.46318-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] NBD export bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com, armbru@redhat.com, jsnow@redhat.com

On 04/13/2018 01:13 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
> 
> This is a proposal and realization of new NBD meta context:
> qemu. (I hope to send corresponding proposal to NBD protocol soon)
> 
> New possible queries will look like:
> qemu:dirty-bitmap:<export-bitmap-name>
> 

> 
>   qapi/block.json     |  23 +++++
>   include/block/nbd.h |   6 ++
>   blockdev-nbd.c      |  23 +++++
>   nbd/server.c        | 274 ++++++++++++++++++++++++++++++++++++++++++++++------
>   4 files changed, 297 insertions(+), 29 deletions(-)

We need something in docs/interop/ that documents the qemu: namespace 
within NBD, so that the upstream NBD spec can point to our document as a 
reference for other clients to be aware of what semantics we are exporting.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
