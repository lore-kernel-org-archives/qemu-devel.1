Received: from eggs.gnu.org ([209.51.188.92]:35128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyHvi-00054k-R8
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyHvi-00044B-2Q
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:12:30 -0500
References: <20190223002209.23084-1-jsnow@redhat.com>
	<20190223002209.23084-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24fbb392-d5d5-dba5-f698-638f6297b413@redhat.com>
Date: Mon, 25 Feb 2019 09:12:08 -0600
MIME-Version: 1.0
In-Reply-To: <20190223002209.23084-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] block/dirty-bitmap: add
 inconsistent status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

On 2/22/19 6:22 PM, John Snow wrote:
> Even though the status field is deprecated, we still have to support
> it for a few more releases. Since this is a very new kind of bitmap
> state, it makes sense for it to have its own status field.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c | 7 ++++++-
>  qapi/block-core.json | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
