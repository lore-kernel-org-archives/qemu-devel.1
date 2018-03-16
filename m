Received: from eggs.gnu.org ([2001:4830:134:3::10]:57486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ewxjP-0006Tz-9Y
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 18:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ewxjO-0003eb-He
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 18:21:47 -0400
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e7053aee-e4d2-50ea-0387-03b11931f7b6@redhat.com>
Date: Fri, 16 Mar 2018 18:21:24 -0400
MIME-Version: 1.0
In-Reply-To: <20171130164750.47320-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12 0/2] qcow2: add
 overlap check for bitmap directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com



On 11/30/2017 11:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add simple constant overlap check.
> 
> Vladimir Sementsov-Ogievskiy (2):
>   qcow2: add overlap check for bitmap directory
>   qcow2: fix indentation after previous patch
> 
>  block/qcow2.h          | 45 ++++++++++++++++++++++++---------------------
>  block/qcow2-refcount.c | 12 ++++++++++++
>  block/qcow2.c          | 22 ++++++++++++++--------
>  3 files changed, 50 insertions(+), 29 deletions(-)
> 

Vladimir, do we need this for 2.12 still?
How about "fix bitmaps migration through shared storage"?
