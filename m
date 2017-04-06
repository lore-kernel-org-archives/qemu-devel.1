Received: from eggs.gnu.org ([2001:4830:134:3::10]:37017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw3DC-0001kb-Lh
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw3DB-00023E-RD
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:56:14 -0400
Date: Thu, 6 Apr 2017 10:56:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406085601.GB4341@noname.redhat.com>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-13-eblake@redhat.com>
	<cf7bf2dd-32ee-baf2-b963-177c4aff8c52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7bf2dd-32ee-baf2-b963-177c4aff8c52@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 12/13] fdc-test: Avoid
 deprecated 'change' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>

Am 05.04.2017 um 22:52 hat John Snow geschrieben:
> On 04/05/2017 03:47 PM, Eric Blake wrote:
> > Use the preferred blockdev-change-medium command instead.
> > 
> > Admittedly, use of 'device' is also deprecated over the newer use
> > of 'id', but the test is exploiting that the name 'floppy0' is
> > auto-created by the board, and I could not figure out where the
> > command line lives that would need to be tweaked to provide a
> > non-random 'id' to this device.
> > 
> 
> qtest_start
>   qtest_init
>     qtest_init_without_qmp_handshake
> 
> You can give *extra* args to qtest_start, but depending on the board
> -nodefaults isn't going to get rid of that embedded FDC nor its default
> floppy0 drive, I think.

It does get rid of the default drive.

> You could perhaps add a second floppy drive explicitly with
> -device floppy,id=snafu,bus=floppy-bus.0,unit=1

As soon as you use -device floppy, the default drive goes away, too, so
you don't have to use a secondary floppy drive. It's like the default
CD-ROM that goes away if you use -device ide-cd.

So if you want to give it an ID, the solution is as simple as:

    -device floppy,id=foo

Kevin
