Received: from eggs.gnu.org ([2001:4830:134:3::10]:56406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdwYD-0003F5-4S
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdwYB-0003rT-QV
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:11:05 -0500
Date: Wed, 15 Feb 2017 11:10:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170215101052.GA4935@noname.redhat.com>
References: <1202180823.778907.1487108292243.JavaMail.zimbra@research.iiit.ac.in>
	<6066bf52-d3d9-07d2-1e0f-118b8c19f3f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6066bf52-d3d9-07d2-1e0f-118b8c19f3f4@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] regarding bug name : -hda FAT:.
 limited to 504MBytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Shubham Kumar <kumar.shubham@research.iiit.ac.in>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 14.02.2017 um 23:24 hat Thomas Huth geschrieben:
> On 14.02.2017 22:38, Shubham Kumar wrote:
> > Since the problem seems like the used FAT-16 file system , 
> > Will it solve the problem if I change the code of  vvfat.c for FAT-32 file system to increase acceptable file size ?
> 
> As far as I know, FAT16 can already support up to 4GB file systems, so
> that limitation to 504 MB must be something different.
> It's maybe best if you put the qemu-block mailing list on CC:, to get
> the attention of the block/disk expert, too. Maybe there's someone
> around who knows the vvfat code and its limitations and can give a good
> answer here...

None of the active developers know, or want to know, the vvfat code.

There is some FAT32 support there, but if you use it:

    fprintf(stderr, "Big fat greek warning: FAT32 has not been tested. "
                    "You are welcome to do so!\n");

So if you just want to play with it, go ahead. But if you care about
your data, maybe vvfat isn't the right tool anyway.

Kevin
