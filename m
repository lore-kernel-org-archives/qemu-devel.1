Received: from eggs.gnu.org ([2001:4830:134:3::10]:37116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flYh3-0007ow-Hj
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flYgz-0004k1-Mx
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:56:29 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180730122828.GD3775@localhost.localdomain>
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180729212744.23709-5-lbloch@janustech.com>
	<20180730094320.GB3775@localhost.localdomain>
	<8d1a2a16-6fa6-1318-d278-ff0c8b45a6f5@janustech.com>
	<20180730122828.GD3775@localhost.localdomain>
Date: Fri, 03 Aug 2018 13:56:18 +0200
Message-ID: <w51d0uzll3x.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/6] qcow2: Update
 total_sectors when resizing the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Leonid Bloch <lbloch@janustech.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon 30 Jul 2018 02:28:28 PM CEST, Kevin Wolf wrote:
>> > Also, 512 should be BDRV_SECTOR_SIZE.
>> 
>> I was surprised that it's not, but it's 512 also in two other places,
>> including in qcow2_co_truncate itself. So I decided to keep
>> that. Probably would be better if I'd repair it in the other places
>> instead. :)
>
> Yeah, or at least not introduce new places with a literal 512.

I have a few patches already in my queue to replace these literals with
BDRV_SECTOR_SIZE, so no need to spend time with the existing cases, I
can take care of that.

For new cases I agree with Kevin that you should always use
BDRV_SECTOR_SIZE.

Berto
