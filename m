Received: from eggs.gnu.org ([2001:4830:134:3::10]:58001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7nzp-0000l3-7F
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7nzo-0007Q2-8Q
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:43:49 -0400
References: <20181003175524.597407-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49f570ae-4fe9-6ec9-89c5-67db559bddf1@redhat.com>
Date: Wed, 3 Oct 2018 15:43:37 -0500
MIME-Version: 1.0
In-Reply-To: <20181003175524.597407-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] nbd: Flip qemu-nbd to prefer newstyle;
 add -O for old behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, rjones@redhat.com, "open list:Network Block Dev..." <qemu-block@nongnu.org>

On 10/3/18 12:55 PM, Eric Blake wrote:
> Oldstyle NBD negotiation cannot perform any of the extensions that
> we have recently been relying on.  While you can always pass -x ""
> to get newstyle negotiation, these days, it is better to just default
> to newstyle (with an empty export name) and fall back to oldstyle
> only on an explicit request.
> 
> qemu as client can manage either style since 2.6.0, commit 69b49502d8
> 
> For comparison:
> 
> nbdkit 1.3 switched its default to newstyle (Jan 2018):
> https://github.com/libguestfs/nbdkit/commit/b2a8aecc
> https://github.com/libguestfs/nbdkit/commit/8158e773
> 
> nbd 3.10 dropped oldstyle long ago (Mar 2015):
> https://github.com/NetworkBlockDevice/nbd/commit/36940193
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> v2: improve 'qemu-nbd --help', drop redundant variable 'newproto'
> ---
>   qemu-nbd.c | 37 +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)

But I still forgot to document it in qemu-nbd.texi.

I'm dropping this patch in favor of Vladimir's stronger series, now that 
Rich has agreed with my observation that nbdkit can bridge the needs of 
any non-qemu client that still only talks oldstyle.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
