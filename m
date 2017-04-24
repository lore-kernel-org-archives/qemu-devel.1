Received: from eggs.gnu.org ([2001:4830:134:3::10]:36968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2hIq-0008Mf-RE
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2hIm-0003Ir-PT
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2hIm-0003Ie-J2
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:57:28 -0400
Date: Mon, 24 Apr 2017 17:57:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170424165723.GK2362@work-vm>
References: <20170424153244.2600-1-dgilbert@redhat.com>
	<CAFEAcA8Gq5iS1uSO1czmGsGdXiSU96rTfwNkQXDrCTeFQ0f=bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Gq5iS1uSO1czmGsGdXiSU96rTfwNkQXDrCTeFQ0f=bA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/4] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 24 April 2017 at 16:32, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > The following changes since commit 4c55b1d0bad8a703f0499fe62e3761a0cd288da3:
> >
> >   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2017-04-24' into staging (2017-04-24 14:49:48 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/dagrh/qemu.git tags/pull-hmp-20170424
> >
> > for you to fetch changes up to e4e3992e626c4cc7514b271807c90f587771c646:
> >
> >   tests: Add a tester for HMP commands (2017-04-24 15:55:35 +0100)
> >
> > ----------------------------------------------------------------
> > HMP pull
> >
> > ----------------------------------------------------------------
> 
> 
> clang doesn't like some code in test-hmp.c:
> 
> /home/petmay01/linaro/qemu-for-merges/tests/test-hmp.c:138:9: error:
> logical not is only applied to the left hand side of this comparison
> [-Werror,-Wlogical-not-parentheses]
>     if (!strcmp("isapc", mname) == 0 ||  !strcmp("puv3", mname)
>         ^                       ~~

<snip>

> It does look rather odd:
> 
> +    /* Ignore blacklisted machines that have known problems */
> +    if (!strcmp("isapc", mname) == 0 ||  !strcmp("puv3", mname)
> +        || !strcmp("tricore_testboard", mname)
> +        || !strcmp("xenfv", mname) == 0 || !strcmp("xenpv", mname)) {
> +        return;
> +    }
> 
> since it's not using the same kind of expression to test
> each board name -- is that deliberate, or accidental ?
> 
> I think this expression means we'll actually skip every machine...

Yep, you're right, just tried it with logging.

That's accidental; hmm I should add a clang build somewhere.

Thomas: Do you want to send me a fixed version?

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
