Received: from eggs.gnu.org ([209.51.188.92]:52283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gznzg-0003oU-2T
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gznzd-0001M6-Tj
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:38:51 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-5-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <47e13575-6bb7-1374-4f7a-7d5029560393@redhat.com>
Date: Fri, 1 Mar 2019 13:38:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190301191545.8728-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block/dirty-bitmaps: prohibit
 readonly bitmaps for backups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

On 3/1/19 1:15 PM, John Snow wrote:
> drive and blockdev backup cannot use readonly bitmaps, because the
> sync=incremental mechanism actually edits the bitmaps on success.
> 
> If you really want to do this operation, use a copied bitmap.

In fact, that's what I ended up doing in my libvirt patches, always
running sync=incremental on a temporary copy.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
