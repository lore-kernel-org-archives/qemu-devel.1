Received: from eggs.gnu.org ([2001:4830:134:3::10]:39221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euL4w-0002PV-Iy
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euL4v-0000wY-M1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:41:10 -0500
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ca5bbf03-a506-b10b-2db9-cb6a7aad3075@redhat.com>
Date: Fri, 9 Mar 2018 10:41:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180308184636.178534-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] nbd server fixing and refactoring
 before BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> 01 and 02 are splitted and updated "[PATCH] nbd/server: fix space read",
> others are new.
> 
> Vladimir Sementsov-Ogievskiy (5):
>    nbd/server: move nbd_co_send_structured_error up
>    nbd/server: fix sparse read
>    nbd/server: fix: check client->closing before reply sending
>    nbd/server: refactor nbd_trip: cmd_read and generic reply
>    nbd/server: refactor nbd_trip: split out nbd_handle_request

I had a tough time applying this one:

Applying: nbd/server: move nbd_co_send_structured_error up
Applying: nbd/server: fix: check client->closing before reply sending
Applying: nbd/server: refactor nbd_trip: cmd_read and generic reply
error: sha1 information is lacking or useless (nbd/server.c).
error: could not build fake ancestor
Patch failed at 0004 nbd/server: refactor nbd_trip: cmd_read and generic 
reply
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

I think I've resolved the conflicts correctly, but if I get through 
reviewing this series and posting it to my NBD queue, you may want to 
double-check things.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
