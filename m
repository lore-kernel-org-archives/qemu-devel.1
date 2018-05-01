Received: from eggs.gnu.org ([2001:4830:134:3::10]:46908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcdG-0000XU-12
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcdF-0002gE-3a
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:16:18 -0400
References: <20180208132336.6519-1-edgar.kaziakhmedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf137287-88fd-a599-c935-313042631dc5@redhat.com>
Date: Tue, 1 May 2018 16:16:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180208132336.6519-1-edgar.kaziakhmedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: increase maximum size of the
 PWRITE_ZERO request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On 02/08/2018 07:23 AM, Edgar Kaziakhmedov wrote:
> Upstream NBD protocol implementation supports an efficient zero out
> mechanism over the wire, along with the ability to check whether a
> client allows using a hole.
> 
> Accordingly, since PWRITE_ZERO doesn't involve any payload on the wire,
> increase a maximum size of the PWRITE_ZERO request up to 1Gb (aligned).
> Moreover, such change will decrease the number of PWRITE_ZERO NBD commands
> in comparison with the current 32M limit. The benefits of
> the larger constraint can be examined in a block mirroring over NBD.
> 
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> ---
>   block/nbd.c         | 2 +-
>   include/block/nbd.h | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)

I've posted a counter-proposal series that should accomplish the same 
effect, but in a way (soon to be) sanctioned by the NBD spec:

https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg00135.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
