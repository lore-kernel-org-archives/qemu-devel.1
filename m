Received: from eggs.gnu.org ([209.51.188.92]:50544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxeuT-0000GZ-HH
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxeuS-0007li-Bs
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:32:37 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-8-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ede85a6-a7e1-a231-db9d-44294ebc36a7@redhat.com>
Date: Sat, 23 Feb 2019 15:32:23 -0600
MIME-Version: 1.0
In-Reply-To: <20190223000614.13894-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/10] block/dirty-bitmaps: unify
 qmp_locked and user_locked calls
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
> These mean the same thing now. Unify them and rename the merged call
> bdrv_dirty_bitmap_busy to indicate semantically what we are describing,
> as well as help disambiguate from the various _locked and _unlocked
> versions of bitmap helpers that refer to mutex locks.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
