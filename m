Received: from eggs.gnu.org ([2001:4830:134:3::10]:33984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evVyf-0001fd-DM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evVye-00028K-K2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:31:33 -0400
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4884a25-9713-0c5f-8cb1-a46827143554@redhat.com>
Date: Mon, 12 Mar 2018 17:31:23 -0500
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
> 

Thanks; queued to my NBD tree, with tweaks made per discussion on the 
various patches.

Pull request should make soft freeze for 2.12.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
