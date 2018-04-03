Received: from eggs.gnu.org ([2001:4830:134:3::10]:53241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f3OjA-0001ep-0S
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f3Oj9-0006Vz-3E
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:24:08 -0400
References: <20180330161040.350271-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b6a499bc-b5c6-7c35-e916-d63861f0c0c5@redhat.com>
Date: Tue, 3 Apr 2018 18:23:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180330161040.350271-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

On 2018-03-30 18:10, Vladimir Sementsov-Ogievskiy wrote:
> Use MIGRATION events instead of RESUME. Also, make a TODO: enable
> dirty-bitmaps capability for offline case.
> 
> This (likely) fixes racy faults at least of the following types:
> 
>     - timeout on waiting for RESUME event
>     - sha256 mismatch on 136 (138 after this patch)
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> This patch is a true change for the test anyway. But I don't understand,
> why (and do really) it fixes the things. And I'm not sure about do we
> really have a bug in bitmap migration or persistence. So, it's up to you,
> take it into 2.12... 
> 
> It was already discussed, that "STOP" event is bad for tests. What about
> "RESUME"? How can we miss it? And sha256 mismatch is really something
> strange.
> 
> Max, please check, do it fix 169 for you.
> 
>  tests/qemu-iotests/169 | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

This makes the test pass (thanks!), but it still leaves behind five cats...

Max
