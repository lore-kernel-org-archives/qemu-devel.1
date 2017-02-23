Received: from eggs.gnu.org ([2001:4830:134:3::10]:37173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgsSu-0002lO-Tn
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgsSt-0004lr-Up
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:25:44 -0500
Date: Thu, 23 Feb 2017 13:25:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170223122535.GC6931@noname.redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-11-git-send-email-kwolf@redhat.com>
	<20170223114956.GE14175@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170223114956.GE14175@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH 10/54] vvfat: Use opened node as backing
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Am 23.02.2017 um 12:49 hat Fam Zheng geschrieben:
> On Tue, 02/21 15:58, Kevin Wolf wrote:
> > -    backing = bdrv_new();
> > +    backing = bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O_ALLOW_RDWR,
> > +                                   &error_abort);
> > +    *(void**) backing->opaque = s;
> 
> Could be simply "backing->opaque = s".

That's not semantically the same.

Or if you just mean that vvfat shouldn't be using an implicit
BdrvVVFATState with just one pointer element rather than just directly
assigning the pointer to bs->opaque, that might have been an option, but
vvfat isn't written that way and I don't intend to change it at least in
this specific patch. (If I were to change it, I would probably just use
an explicit BdrvVVFATState, though.)

Kevin
