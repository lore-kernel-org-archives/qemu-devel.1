Received: from eggs.gnu.org ([209.51.188.92]:38262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hBn4M-0006lv-JY
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 17:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hBn4I-0005ih-Q3
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 17:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hBn4D-0005Rt-JX
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 17:05:10 -0400
Date: Wed, 3 Apr 2019 18:04:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190403210458.GB7238@habkost.net>
References: <20190403124948.GA14129@ls3530.dellerweb.de>
	<CAFEAcA8qyunxOtqrWLPsr34fUt5t2kCrXa8hOMti0bYYbZDpyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8qyunxOtqrWLPsr34fUt5t2kCrXa8hOMti0bYYbZDpyA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Helge Deller <deller@gmx.de>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Eduardo Otubo <otubo@redhat.com>


CCing the right Eduardo.  :)

On Wed, Apr 03, 2019 at 10:16:15PM +0700, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 19:51, Helge Deller <deller@gmx.de> wrote:
> 
> [cc'ing Eduardo as the seccomp submaintainer]
> 
> > On a non-release architecture, the configure program aborts if the
> > --enable-seccomp flag was given (with no way to work around it on the
> > command line):
> >
> > ERROR: User requested feature libseccomp
> >         configure was not able to find it.
> >         libseccomp is not supported for host cpu parisc64
> 
> Surely the workaround is "don't pass --enable-seccomp on
> the configure command line" ?
> 
> Our general approach with configure arguments is:
>  --disable-foo means "don't try to look for or use foo"
>  --enable-foo means "use foo, and stop with an error if we can't use
>      foo for any reason (eg not found, version too old)"
> passing nothing means "look for foo, use it if we can,
>      but if we can't then just silently don't use foo"
> 
> So I think if the user specifically asks us to use seccomp on a
> host architecture where it won't work then configure should fail.
> 
> Is the underlying problem here:
>  * we use a whitelist of host architectures to enable seccomp for
>    and we should not do that (eg blacklist instead, or just allow it
>    for any host architecture)?
>  * using a whitelist is ok, but we should add some more host archs to it?
>  * something else?
> 
> What particular host arch are you using?
> 
> thanks
> -- PMM

-- 
Eduardo
