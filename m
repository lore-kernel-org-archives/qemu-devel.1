Received: from eggs.gnu.org ([2001:4830:134:3::10]:60731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euNNZ-00071T-Ne
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euNNY-0005Zt-Tg
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:08:33 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1fa1dc96-51b7-f756-f86b-54240361c440@redhat.com>
Date: Fri, 9 Mar 2018 13:08:06 -0600
MIME-Version: 1.0
In-Reply-To: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/9] nbd block status base:allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
> 
> Here is minimal realization of base:allocation context of NBD
> block-status extension, which allows to get block status through
> NBD.
> 
> Vladimir Sementsov-Ogievskiy (9):
>    nbd/server: add nbd_opt_invalid helper
>    nbd: change indenting in nbd.h
>    nbd: BLOCK_STATUS for standard get_block_status function: server part
>    block/nbd-client: save first fatal error in nbd_iter_error
>    nbd/client: fix error messages in nbd_handle_reply_err
>    nbd: BLOCK_STATUS for standard get_block_status function: client part
>    iotests.py: tiny refactor: move system imports up
>    iotests: add file_path helper
>    iotests: new test 206 for NBD BLOCK_STATUS

I'd really like to send a PULL request for NBD on Monday, in order to 
make the 2.12 softfreeze deadline (this is a new feature, so if we miss 
Tuesday, we have to wait until 2.13 or whatever the next release is 
called).  Where do you stand on rebasing this, and what help can I 
offer? (I know you have factored out some of the patches in another 
thread that I'm in the middle of reviewing as well; you can submit the 
later patches even before the earlier ones land, and use a 'Based-on:' 
tag in the cover letter to make it obvious the dependencies between series).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
