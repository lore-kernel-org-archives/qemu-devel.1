Received: from eggs.gnu.org ([2001:4830:134:3::10]:58635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX4FH-0003lN-NA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX4FE-0002NE-IR
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:31:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dX4FE-0002Mt-C6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:31:20 -0400
Date: Mon, 17 Jul 2017 13:31:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717113115.GE5301@noname.redhat.com>
References: <20170717063521.GA7393@lemon>
	<20170717103937.GD5301@noname.redhat.com>
	<CAFEAcA9zoauJw-CnNxtec48VOr6onXiCZ8BV8JJwk7ZeOLxnUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9zoauJw-CnNxtec48VOr6onXiCZ8BV8JJwk7ZeOLxnUw@mail.gmail.com>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Am 17.07.2017 um 12:49 hat Peter Maydell geschrieben:
> On 17 July 2017 at 11:39, Kevin Wolf <kwolf@redhat.com> wrote:
> > Only today I noticed again that two recently merged pull requests broke
> > qemu-iotests cases, so I must assume that apart from some block
> > maintainers, nobody runs it regularly.
> 
> If "make check" doesn't run it, it doesn't get run :-)
> I actually looked into trying to run qemu-iotests tests
> for the recent patches I sent for vpc and vmdk image format
> handler fixes, but I couldn't get it to do anything sensible
> and I couldn't find any documentation, so I gave up and
> assumed that "make check" plus manual testing was good enough...

I think we had it in 'make check' for a while, but I seem to remember
that people complained about things like the disk space that some of the
tests needed for temporary files, and some exotic systems didn't support
sparse files or something like that.

There is still 'make check-block', but nobody uses that. If you want to
add it back to 'make check', I wouldn't object (but others might).

Kevin
