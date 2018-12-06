Received: from eggs.gnu.org ([2001:4830:134:3::10]:44047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gV0Qh-0001Rz-32
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gV0Qg-0005ZK-Am
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:39:27 -0500
References: <20181206192544.3987-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <739827ab-a936-8969-3170-746d439372aa@redhat.com>
Date: Thu, 6 Dec 2018 15:39:18 -0500
MIME-Version: 1.0
In-Reply-To: <20181206192544.3987-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] bitmaps: remove x- prefix from QMP api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



On 12/6/18 2:25 PM, John Snow wrote:
> Touch up a few last things and remove the x- prefix.
> 
> Test on the way, thoughts?
> 
> John Snow (3):
>   blockdev: abort transactions in reverse order
>   blockdev: n-ary bitmap merge
>   block: remove 'x' prefix from experimental bitmap APIs
> 
>  blockdev.c             | 96 +++++++++++++++++++++++++-----------------
>  qapi/block-core.json   | 56 ++++++++++++------------
>  qapi/transaction.json  | 12 +++---
>  tests/qemu-iotests/223 |  4 +-
>  4 files changed, 94 insertions(+), 74 deletions(-)
> 

Sorry, at some point I bookmarked a typo for Vladimir's email :(

Correcting his address here in the cover letter.
