Received: from eggs.gnu.org ([209.51.188.92]:44878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1s9L-0007JV-0t
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1s9K-0005QN-80
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:29:23 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1s9J-0005Pf-Vc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:29:22 -0500
Received: by mail-ot1-x342.google.com with SMTP id n71so13883123ota.10
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 04:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-9-peter.maydell@linaro.org>
	<20190307014028.hggeogcxuwldc5ms@localhost.localdomain>
	<CAFEAcA8jcshKLW8+fQJ30Y02LTmqxrwpShZKDP7NNOOGSwaY3A@mail.gmail.com>
	<20190307121417.fztvzzb6lyrpnjyx@dhcp-17-118.bos.redhat.com>
In-Reply-To: <20190307121417.fztvzzb6lyrpnjyx@dhcp-17-118.bos.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 12:29:08 +0000
Message-ID: <CAFEAcA_rSdxsJLVyg-E1=1viw0f-p2G60VLvVZ-k8ERr6P_=gw@mail.gmail.com>
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

On Thu, 7 Mar 2019 at 12:14, Cleber Rosa <crosa@redhat.com> wrote:
>
> On Thu, Mar 07, 2019 at 09:49:44AM +0000, Peter Maydell wrote:
> > On Thu, 7 Mar 2019 at 01:40, Cleber Rosa <crosa@redhat.com> wrote:
> > Thanks for pointing out the tags functionality. That said,
> > this won't do what we want, will it?
> >  * building the docs gives all the docs in the build tree
> >  * but we only install via 'make install' the ones the user wants
> >
>
> It should be doable.  I put a PoC here:
>
>   https://github.com/clebergnu/sphinx-conditional-project/tree/master
>
> I'm understanding that the `make install` step is nothing but a copy
> of the produced build.  For this PoC, I used an HTML builder.

I'm still not clear how this helps. Either the top level
index file has everything in it (in which case it's no good
for 'make install'), or we just have separate manuals per
document (which doesn't seem to me to gain much over what
we currently have in this patchset, and you end up listing
everything multiple times in the index.rst).

thanks
-- PMM
