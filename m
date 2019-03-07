Received: from eggs.gnu.org ([209.51.188.92]:40936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1ruq-0003GA-Cf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1rup-0006ml-A1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:14:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1h1rup-0006k7-2N
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:14:23 -0500
Date: Thu, 7 Mar 2019 07:14:17 -0500
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190307121417.fztvzzb6lyrpnjyx@dhcp-17-118.bos.redhat.com>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-9-peter.maydell@linaro.org>
	<20190307014028.hggeogcxuwldc5ms@localhost.localdomain>
	<CAFEAcA8jcshKLW8+fQJ30Y02LTmqxrwpShZKDP7NNOOGSwaY3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8jcshKLW8+fQJ30Y02LTmqxrwpShZKDP7NNOOGSwaY3A@mail.gmail.com>
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

On Thu, Mar 07, 2019 at 09:49:44AM +0000, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 01:40, Cleber Rosa <crosa@redhat.com> wrote:
> > I have the impression that this can be simplified by making use of
> > "only" tags:
> >
> > https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-only
> >
> > So, conf.py could detect if it's being run on readthedocs.org:
> >
> >   ON_RTD = os.environ.get('READTHEDOCS', None) == 'True'
> >
> > And manipulate the "tags" variable accordingly:
> >
> >   if ON_RTD:
> >      tags.add('devel')
> >      tags.add('interop')
> >
> > Then, on an index.rst, it could be a simple matter of:
> >
> > .. only:: devel
> > ================
> > Developers Guide
> > ================
> > .. toctree::
> >    docs/devel
> >
> > .. only:: interop
> > =============
> > Interop Guide
> > =============
> > .. toctree::
> >    docs/interop
> >
> > .. only:: devel and interop
> > ===============
> > QEMU Full Guide
> > ===============
> > .. toctree::
> >    docs/devel
> >    docs/interop
> 
> Thanks for pointing out the tags functionality. That said,
> this won't do what we want, will it?
>  * building the docs gives all the docs in the build tree
>  * but we only install via 'make install' the ones the user wants
>

It should be doable.  I put a PoC here:

  https://github.com/clebergnu/sphinx-conditional-project/tree/master

I'm understanding that the `make install` step is nothing but a copy
of the produced build.  For this PoC, I used an HTML builder.

> thanks
> -- PMM

Regards,
- Cleber.
