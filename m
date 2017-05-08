Received: from eggs.gnu.org ([2001:4830:134:3::10]:48737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d7png-0001gA-51
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d7pnb-0003ru-9i
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:02:36 -0400
References: <20170504105444.8940-1-daniel.kucera@gmail.com>
	<20170508203556.GA22634@stefanha-x1.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <c51044c8-edf6-c0a2-e543-0d9be1a61b29@openvz.org>
Date: Mon, 8 May 2017 23:02:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170508203556.GA22634@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] mirror: add sync mode incremental to
 drive-mirror and blockdev-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Daniel Kucera <daniel.kucera@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 05/08/2017 10:35 PM, Stefan Hajnoczi wrote:
> On Thu, May 04, 2017 at 12:54:40PM +0200, Daniel Kucera wrote:
>
> Seems like a logical extension along the same lines as the backup block
> job's dirty bitmap sync mode.
>
>> parameter bitmap chooses existing dirtymap instead of newly created
>> in mirror_start_job
>>
>> Signed-off-by: Daniel Kucera <daniel.kucera@gmail.com>
Can you pls describe the use case pls in a bit more details.

For now this could be a bit strange:
- dirty bitmap, which can be found via bdrv_create_dirty_bitmap
  could be read-only or read-write, i.e. being modified by writes
  or be read-only, which should not be modified. Thus adding
  r/o bitmap to the mirror could result in interesting things.

Minimally we should prohibit usage of r/o bitmaps this way.

So, why to use mirror, not backup for the case?

Den
