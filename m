Received: from eggs.gnu.org ([209.51.188.92]:59587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1t6r-0000IS-EK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1t6q-0001Hb-Ld
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:30:53 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1t6q-0001HU-Dc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:30:52 -0500
Received: by mail-ot1-x342.google.com with SMTP id g1so14053570otj.11
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 05:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-9-peter.maydell@linaro.org>
	<20190307014028.hggeogcxuwldc5ms@localhost.localdomain>
	<CAFEAcA8jcshKLW8+fQJ30Y02LTmqxrwpShZKDP7NNOOGSwaY3A@mail.gmail.com>
	<20190307121417.fztvzzb6lyrpnjyx@dhcp-17-118.bos.redhat.com>
	<CAFEAcA_rSdxsJLVyg-E1=1viw0f-p2G60VLvVZ-k8ERr6P_=gw@mail.gmail.com>
	<20190307131804.te3thn7hzi6xo3ed@dhcp-17-118.bos.redhat.com>
In-Reply-To: <20190307131804.te3thn7hzi6xo3ed@dhcp-17-118.bos.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 13:30:39 +0000
Message-ID: <CAFEAcA976P1zp8CnyxzK48E_55cz23Y1XfELAo+v1tj_kuqiaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, 7 Mar 2019 at 13:18, Cleber Rosa <crosa@redhat.com> wrote:
>
> On Thu, Mar 07, 2019 at 12:29:08PM +0000, Peter Maydell wrote:
> > I'm still not clear how this helps. Either the top level
> > index file has everything in it (in which case it's no good
> > for 'make install'), or we just have separate manuals per
>
> IIRC, it shouldn't matter what the "top level" index file (index.rst)
> has, because it's the resulting build (not the source index.rst) that
> will be 'make install'ed.  Or am I missing something?

I guess what I'm trying to ask is whether this tags
approach results in different (or differently structured)
final documents being produced, or whether it's just a
different mechanism that gives the same end result.

> I don't see the multiple listings you mention here

I think I was looking at the sketch you had in a previous
email rather than the more fleshed-out code in the git repo.

> Anyway, if it's not clear to you as it's to me, then I'm probably
> biased or missing something.

Well, I'm also a bit biased here, in that this is v3 of this
patchset that's been on the list using this approach for
a month, and I was planning to apply it to master today
so that it could be in before the softfreeze on Tuesday
next week. So late-breaking suggestions for significant
restructurings are essentially saying "we should postpone
this to 4.1" :-(

thanks
-- PMM
