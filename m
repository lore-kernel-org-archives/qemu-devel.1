Received: from eggs.gnu.org ([2001:4830:134:3::10]:58759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsI0j-0003uO-FE
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsI0i-0007ao-Ks
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:28:05 -0400
References: <20170912203119.24166-1-eblake@redhat.com>
	<20170912203119.24166-13-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <20064851-72f5-846e-6842-6140ac65d4d7@redhat.com>
Date: Wed, 13 Sep 2017 20:27:52 -0400
MIME-Version: 1.0
In-Reply-To: <20170912203119.24166-13-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 12/20] dirty-bitmap: Change
 bdrv_get_dirty_count() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 09/12/2017 04:31 PM, Eric Blake wrote:
> Thanks to recent cleanups, all callers were scaling a return value
> of sectors into bytes; do the scaling internally instead.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>
