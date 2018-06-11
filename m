Received: from eggs.gnu.org ([2001:4830:134:3::10]:39521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSVpC-0000L9-0P
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 19:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSVpB-0002oF-82
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 19:02:10 -0400
References: <20180611224338.9743-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5b955356-810f-b3e3-27c5-d999c90306d7@redhat.com>
Date: Mon, 11 Jun 2018 19:02:02 -0400
MIME-Version: 1.0
In-Reply-To: <20180611224338.9743-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/1] blockdev: implement n-ary bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

I mis-typed Vladimir's email, I have corrected it here.

On 06/11/2018 06:43 PM, John Snow wrote:
> requires: 20180606182449.1607-1-jsnow@redhat.com
> 
> See patch for details; this is somewhat an RFC that I suspect
> will be useful for libvirt in some situations, but maybe it's
> actually overkill.
> 
> John Snow (1):
>   blockdev: n-ary bitmap merge
> 
>  blockdev.c           | 40 ++++++++++++++++++++++++++++++----------
>  qapi/block-core.json | 10 +++++-----
>  2 files changed, 35 insertions(+), 15 deletions(-)
> 
