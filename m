Received: from eggs.gnu.org ([2001:4830:134:3::10]:42884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gKaIw-0004b7-TB
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 21:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gKaIn-00078v-2j
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 21:44:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gKaIm-00076l-SM
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 21:44:12 -0500
Date: Thu, 8 Nov 2018 10:44:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181108024406.GB3170@xz-x1>
References: <20181030191620.32168-1-armbru@redhat.com>
	<CAFEAcA8RdNrbCLL7tXY=e95N2Y0LcZdCPr3EuQo1_hu08qJuaQ@mail.gmail.com>
	<87sh0eyzb0.fsf@dusky.pond.sub.org> <20181107025628.GB17134@xz-x1>
	<CAFEAcA_FhkA_1DiDM2PWDw27dupsAdP==kBUxRrw5rGDnLzMwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_FhkA_1DiDM2PWDw27dupsAdP==kBUxRrw5rGDnLzMwg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/8] Monitor patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Nov 07, 2018 at 11:21:32AM +0000, Peter Maydell wrote:
> On 7 November 2018 at 02:56, Peter Xu <peterx@redhat.com> wrote:
> > Strange, "make check -j8" failed on my hosts (I tried two) with either
> > Markus's pull tree or qemu master:
> >
> > hw/core/ptimer.o: In function `timer_new_tl':
> > /home/xz/git/qemu/include/qemu/timer.h:536: undefined reference to `timer_init_tl'
> > collect2: error: ld returned 1 exit status
> > make: *** [/home/xz/git/qemu/rules.mak:124: tests/ptimer-test] Error 1
> >
> > Is that only happening on my hosts?
> 
> Commit 89a603a0c80ae3 changed things so that there is no
> timer_new_tl() or timer_init_tl() any more, so if you have
> an object file that's referring to it then it's probably
> stale. Try a make clean.

Yeh it worked for me, thanks Peter.

Though after running a few more rounds of "configure --enable-debug &&
make check -j8" I still cannot see anything wrong with Markus's tree.
I'll see whether there's any news from Markus and then I'll consider
whether I should install a FreeBSD.

Regards,

-- 
Peter Xu
