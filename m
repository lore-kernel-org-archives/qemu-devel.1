Received: from eggs.gnu.org ([2001:4830:134:3::10]:52734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evmHd-000807-IT
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evmHc-00010J-Ox
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:56:13 -0400
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ed5cfa6-4869-45aa-6a34-7167f2f5afa6@redhat.com>
Date: Tue, 13 Mar 2018 10:55:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180312152126.286890-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/8] nbd block status base:allocation
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

On 03/12/2018 10:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
> 
> Here is minimal realization of base:allocation context of NBD
> block-status extension, which allows to get block status through
> NBD.
> 
> v2 changes are in each patch after "---" line.
> 
> Vladimir Sementsov-Ogievskiy (8):
>    nbd/server: add nbd_opt_invalid helper
>    nbd/server: add nbd_read_opt_name helper
>    nbd: BLOCK_STATUS for standard get_block_status function: server part
>    block/nbd-client: save first fatal error in nbd_iter_error
>    nbd: BLOCK_STATUS for standard get_block_status function: client part
>    iotests.py: tiny refactor: move system imports up
>    iotests: add file_path helper
>    iotests: new test 209 for NBD BLOCK_STATUS

I've staged this on my NBD queue, pull request to come later today 
(still this morning for me) so that it makes 2.12 softfreeze.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
