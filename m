Received: from eggs.gnu.org ([2001:4830:134:3::10]:50283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cejVc-0005OP-RW
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cejVb-0000xt-VX
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:27:40 -0500
Date: Fri, 17 Feb 2017 15:27:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170217142727.GK5338@noname.redhat.com>
References: <20170217005127.21010-1-nirsof@gmail.com>
	<20170217005127.21010-2-nirsof@gmail.com>
	<20170217091435.GB5338@noname.redhat.com>
	<CAMr-obu0RPWyTcJHGA5b_Hs3L3usOvFNJ0N+runD4ZyMMvgWFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMr-obu0RPWyTcJHGA5b_Hs3L3usOvFNJ0N+runD4ZyMMvgWFg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-img: Add tests for raw image
 preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 17.02.2017 um 15:20 hat Nir Soffer geschrieben:
> On Fri, Feb 17, 2017 at 11:14 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 17.02.2017 um 01:51 hat Nir Soffer geschrieben:
> >> Add tests for creating raw image with and without the preallocation
> >> option.
> >>
> >> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> >
> > Looks good, but 175 is already (multiply) taken. Not making this a
> > blocker, but I just want to remind everyone to check the mailing list
> > for pending patches which add new tests before using a new number in
> > order to avoid unnecessary rebases for everyone. In general, it's as
> > easy as searching for the string "175.out" in the mailbox.
> >
> > The next free one seems to be 177 currently.
> 
> Thanks, will change to 177 in the next version.

If there needs to be a next version for other reasons. Otherwise it's
not important enough to respin, it just means that someone else will
have to rebase.

> For next patches, what do you mean by "pending"? patches sent
> to the block mailing list?

Yes, that's what I'm looking for when I add a new test case myself. It's
just an easy way to avoid stepping on each others toes.

Kevin
