Received: from eggs.gnu.org ([2001:4830:134:3::10]:60338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7g96-0002dR-M5
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7g95-0004E1-OQ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:20:52 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e46561b8-7afc-5f13-0bc1-66c57b585c4f@redhat.com>
Date: Wed, 3 Oct 2018 07:20:26 -0500
MIME-Version: 1.0
In-Reply-To: <20181002230218.13949-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/6] block/dirty-bitmaps: fix merge
 permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 10/2/18 6:02 PM, John Snow wrote:
> In prior commits that made merge transactionable, we removed the
> assertion that merge cannot operate on disabled bitmaps. In addition,
> we want to make sure that we are prohibiting merges to "locked" bitmaps.
> 
> Use the new user_locked function to check.
> 
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   block/dirty-bitmap.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
