Received: from eggs.gnu.org ([2001:4830:134:3::10]:46765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6IxR-000412-A9
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6IxQ-0003Ep-9y
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:50:53 -0400
References: <20180411122606.367301-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4aa0f5d3-8d32-3b44-3997-f8ba91625772@redhat.com>
Date: Wed, 11 Apr 2018 18:50:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180411122606.367301-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] bitmaps persistent and migration
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com

On 2018-04-11 14:26, Vladimir Sementsov-Ogievskiy wrote:
> v2:
> 
> 01: new, proposed by Max
> 02: fix leaving cat processes
> 
> Vladimir Sementsov-Ogievskiy (2):
>   qcow2: try load bitmaps only once
>   iotests: fix 169
> 
>  block/qcow2.h          |  1 +
>  block/qcow2.c          | 16 ++++++++--------
>  tests/qemu-iotests/169 | 48 +++++++++++++++++++++++++++---------------------
>  3 files changed, 36 insertions(+), 29 deletions(-)

Thanks, changed the comment wording in patch 1 according to Eric's
suggestion and applied to my block branch:

https://github.com/XanClic/qemu/commits/block

I left the commit wording unchanged because as you said there might be
more cases where we have bitmaps at the node although we haven't yet
loaded any from the file.  I certainly don't want to have to think too
much about those cases and that to me is the main use of patch 1.

If there is going to be an rc4 (it appears there is), I will send a pull
request with these patches for it.  If not, I probably won't.  Then I'll
just add a qemu-stable CC and get them into 2.13 -- unless you disagree
and you think that this series should indeed be in 2.12.

Max
