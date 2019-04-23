Received: from eggs.gnu.org ([209.51.188.92]:48435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hIwba-0007Cc-VR
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hIwbZ-0007uZ-Dr
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:41:06 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:44557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hIwbY-0007r2-DT
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:41:05 -0400
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 23 Apr 2019 16:40:57 +0200
Message-ID: <7519361.8GXJqb1B4Y@silver>
In-Reply-To: <20190423134442.0549f427@bahia.lan>
References: <3205397.r2gctG0f81@silver> <1736754.y8mDa9Bjs0@silver>
	<20190423134442.0549f427@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Qemu-devel] virtfs/9p duplicate inodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>

On Dienstag, 23. April 2019 13:44:42 CEST Greg Kurz wrote:
> Hi Christian,
> 
> Sorry for the late response. I'm quite busy on other topics these days...

Absolutely no problem. We probably all share the same fate of constant work 
load on endless battle fields popping up everywhere. :-)

> > I intended to extend Antonios' patch set regarding 9p QID collisions with
> > the goal to make the ids constant beyond reboots by storing the qpp_table
> > as fs xattr.
> 
> Hmm... why would you do that ? Even if some filesystems do have persistant
> inode numbers, it isn't mandatory AFAIK.

Mja, unfortunately I found that necessary, see my comment in patch 3 for the 
background / reason:

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03755.html

And sorry that my patch set did not go out as one thread today. I vow 
emendation. ;-)

Best regards,
Christian Schoenebeck
