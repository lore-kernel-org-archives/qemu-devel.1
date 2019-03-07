Received: from eggs.gnu.org ([209.51.188.92]:34329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1tHR-00077l-2t
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1tHQ-0000ef-A8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:41:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1h1tHQ-0000eC-14
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:41:48 -0500
Date: Thu, 7 Mar 2019 08:41:42 -0500
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190307134142.spkpqngtknbk47g5@dhcp-17-118.bos.redhat.com>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-9-peter.maydell@linaro.org>
	<20190307014028.hggeogcxuwldc5ms@localhost.localdomain>
	<CAFEAcA8jcshKLW8+fQJ30Y02LTmqxrwpShZKDP7NNOOGSwaY3A@mail.gmail.com>
	<20190307121417.fztvzzb6lyrpnjyx@dhcp-17-118.bos.redhat.com>
	<CAFEAcA_rSdxsJLVyg-E1=1viw0f-p2G60VLvVZ-k8ERr6P_=gw@mail.gmail.com>
	<20190307131804.te3thn7hzi6xo3ed@dhcp-17-118.bos.redhat.com>
	<CAFEAcA976P1zp8CnyxzK48E_55cz23Y1XfELAo+v1tj_kuqiaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA976P1zp8CnyxzK48E_55cz23Y1XfELAo+v1tj_kuqiaw@mail.gmail.com>
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

On Thu, Mar 07, 2019 at 01:30:39PM +0000, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 13:18, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > On Thu, Mar 07, 2019 at 12:29:08PM +0000, Peter Maydell wrote:
> > > I'm still not clear how this helps. Either the top level
> > > index file has everything in it (in which case it's no good
> > > for 'make install'), or we just have separate manuals per
> >
> > IIRC, it shouldn't matter what the "top level" index file (index.rst)
> > has, because it's the resulting build (not the source index.rst) that
> > will be 'make install'ed.  Or am I missing something?
> 
> I guess what I'm trying to ask is whether this tags
> approach results in different (or differently structured)
> final documents being produced, or whether it's just a
> different mechanism that gives the same end result.
>

I was pursuing the same result, as I understand the requirements are
sound and well defined, that is, we do want multiple final documents
produced in the non-readthedocs.org environment.

> > I don't see the multiple listings you mention here
> 
> I think I was looking at the sketch you had in a previous
> email rather than the more fleshed-out code in the git repo.
>

Oh, OK.

> > Anyway, if it's not clear to you as it's to me, then I'm probably
> > biased or missing something.
> 
> Well, I'm also a bit biased here, in that this is v3 of this
> patchset that's been on the list using this approach for
> a month, and I was planning to apply it to master today
> so that it could be in before the softfreeze on Tuesday
> next week. So late-breaking suggestions for significant
> restructurings are essentially saying "we should postpone
> this to 4.1" :-(
>

I apologize for not looking at this before... honestly speaking, my
bandwidth and efficiency doesn't allow me look at most patches :).  It
was only a CC on this v3 that caught my attention.

Anyway, I don't want to disrupt progress, and I do believe in
incremental betterment.  I have plans to add Python API docs once the
"python" directory structure gets in, so I might as well suggest
improvements in the form of patches later on.

Feel free to ignore this suggestion for now.

> thanks
> -- PMM

Best regards,
- Cleber.
