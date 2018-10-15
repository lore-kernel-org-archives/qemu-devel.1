Received: from eggs.gnu.org ([2001:4830:134:3::10]:57907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC7Bb-0002qv-Jx
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC7Ba-000405-Cg
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:01:47 -0400
Date: Mon, 15 Oct 2018 15:01:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181015180130.GO31060@habkost.net>
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<20181015093243.GE6785@redhat.com>
	<CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
	<20181015101309.GD10459@localhost.localdomain>
	<87woqjw4o3.fsf@dusky.pond.sub.org>
	<CAFEAcA_H78rpT-9-M-NhTNXtMy8dpmC8_Yvb_4MyJ+GD8ZEptg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_H78rpT-9-M-NhTNXtMy8dpmC8_Yvb_4MyJ+GD8ZEptg@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Mon, Oct 15, 2018 at 05:55:27PM +0100, Peter Maydell wrote:
> On 15 October 2018 at 17:33, Markus Armbruster <armbru@redhat.com> wrote:
> > Kevin Wolf <kwolf@redhat.com> writes:
> >
> >> Am 15.10.2018 um 12:02 hat Peter Maydell geschrieben:
> >> It's easier to port stuff to Python 3 though than making them work with
> >> both. I think Eduardo's RFC is in part motivated by a patch from
> >> Philippe that converted something in iotests to work with Python 3,
> >> passed review and then turned out to break Python 2.
> >
> > Seconded.  This is not about the cost of maintaining existing
> > compatibility gunk, it's about the extra effort to first get the
> > remainder to work with 2 and 3, only to throw away 2 a few months later.
> >
> > I propose we permit ourselves to port stuff that isn't essential to
> > building QEMU straight to 3 instead.  This includes iotests.
> 
> No particular objection, as long as nothing run via 'make'
> or 'make check' needs Python 3.

Sounds like a good plan for 3.1.

But:

> 
> I also suspect "a few months" is an underestimate. My guess
> would be we're going to want to keep Python 2 support for
> at least the next year, maybe two.

Python 2.7 will die in less than 15 months[1].  I really want us
to stop reviewing and maintaining Python 2 code in QEMU in less
than 1 year.  Preferably in less than 6 months.

[1] https://pythonclock.org/

-- 
Eduardo
