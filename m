Received: from eggs.gnu.org ([209.51.188.92]:46034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxea9-0003lc-GN
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxea8-0003Cs-Nj
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:11:37 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a6899dfd-84b1-5ae9-0741-0edf971d75e9@redhat.com>
Date: Sat, 23 Feb 2019 15:11:15 -0600
MIME-Version: 1.0
In-Reply-To: <20190223000614.13894-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] block/dirty-bitmap: remove
 set/reset assertions against enabled bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

On 2/22/19 6:06 PM, John Snow wrote:
> bdrv_set_dirty_bitmap and bdrv_reset_dirty_bitmap are only used as an
> internal API by the mirror and migration areas of our code. These
> calls modify the bitmap, but do so at the behest of QEMU and not the
> guest.
> 
> Presently, these bitmaps are always "enabled" anyway, but there's no
> reason they have to be.
> 
> Modify these internal APIs to drop this assertion.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
