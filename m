Received: from eggs.gnu.org ([209.51.188.92]:56260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1suZ-00089n-F8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1suY-0003dO-Cz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:18:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1h1suY-0003ck-5v
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:18:10 -0500
Date: Thu, 7 Mar 2019 08:18:04 -0500
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190307131804.te3thn7hzi6xo3ed@dhcp-17-118.bos.redhat.com>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-9-peter.maydell@linaro.org>
	<20190307014028.hggeogcxuwldc5ms@localhost.localdomain>
	<CAFEAcA8jcshKLW8+fQJ30Y02LTmqxrwpShZKDP7NNOOGSwaY3A@mail.gmail.com>
	<20190307121417.fztvzzb6lyrpnjyx@dhcp-17-118.bos.redhat.com>
	<CAFEAcA_rSdxsJLVyg-E1=1viw0f-p2G60VLvVZ-k8ERr6P_=gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_rSdxsJLVyg-E1=1viw0f-p2G60VLvVZ-k8ERr6P_=gw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/12] docs: Provide separate conf.py
 for each manual we want
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, Mar 07, 2019 at 12:29:08PM +0000, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 12:14, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > On Thu, Mar 07, 2019 at 09:49:44AM +0000, Peter Maydell wrote:
> > > On Thu, 7 Mar 2019 at 01:40, Cleber Rosa <crosa@redhat.com> wrote:
> > > Thanks for pointing out the tags functionality. That said,
> > > this won't do what we want, will it?
> > >  * building the docs gives all the docs in the build tree
> > >  * but we only install via 'make install' the ones the user wants
> > >
> >
> > It should be doable.  I put a PoC here:
> >
> >   https://github.com/clebergnu/sphinx-conditional-project/tree/master
> >
> > I'm understanding that the `make install` step is nothing but a copy
> > of the produced build.  For this PoC, I used an HTML builder.
> 
> I'm still not clear how this helps. Either the top level
> index file has everything in it (in which case it's no good
> for 'make install'), or we just have separate manuals per

IIRC, it shouldn't matter what the "top level" index file (index.rst)
has, because it's the resulting build (not the source index.rst) that
will be 'make install'ed.  Or am I missing something?

> document (which doesn't seem to me to gain much over what
> we currently have in this patchset, and you end up listing
> everything multiple times in the index.rst).

I don't see the multiple listings you mention here, but I guess you're
referring to the "include" of the individual manual's index (devel.rst
and interop.rst in this example).  I chose to implement the logic for
choosing the content in the rst file, but an alternative would be to
do it in conf.py:

 if tags.has('devel'):
    master_doc = 'devel.rst'
 elif tags.has('interop'):
    master_doc = 'interop.rst'
 else:
    master_doc = 'index.rst'

IMO all options add a bit of poison (pick yours).  I do feel that the
tag approach reuses sphinx functionality, and thus facilitate
maintanance and minimize duplication.

Anyway, if it's not clear to you as it's to me, then I'm probably
biased or missing something.

> 
> thanks
> -- PMM

Best regards,
- Cleber.
