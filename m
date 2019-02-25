Received: from eggs.gnu.org ([209.51.188.92]:45432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyGgz-0000gV-22
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyGgy-0002xL-As
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:53:13 -0500
References: <20190223002209.23084-1-jsnow@redhat.com>
	<20190223002209.23084-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <456759d8-7685-8213-addd-437ed7ec99d9@redhat.com>
Date: Mon, 25 Feb 2019 07:47:03 -0600
MIME-Version: 1.0
In-Reply-To: <20190223002209.23084-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block/dirty-bitmaps: add
 inconsistent bit
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
> Add an inconsistent bit to dirty-bitmaps that allows us to report a bitmap as
> persistent but potentially inconsistent, i.e. if we find bitmaps on a qcow2
> that have been marked as "in use".
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c         | 19 +++++++++++++++++++
>  include/block/dirty-bitmap.h |  2 ++
>  qapi/block-core.json         |  8 ++++++--
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
