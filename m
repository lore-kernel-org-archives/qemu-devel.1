Received: from eggs.gnu.org ([2001:4830:134:3::10]:52375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euEZR-0001pW-MH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euEZQ-0008S5-HY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:44:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1euEZQ-0008S1-Cv
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:44:12 -0500
Date: Fri, 9 Mar 2018 10:44:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180309094403.gcsspbs4lzozx2zl@sirius.home.kraxel.org>
References: <20180308083231.20180-1-kraxel@redhat.com>
	<CAFEAcA8wUN_T9XrUULCROVFdv+vGipdMuhNz5km1mcX_nVrQgg@mail.gmail.com>
	<20180309065247.xzribx4zjgx5bnj5@sirius.home.kraxel.org>
	<20180309075054.e4bpa4wsl2wak57w@sirius.home.kraxel.org>
	<f0968a33-fb14-4de2-3a1b-130e2ae7b0ee@redhat.com>
	<20180309091533.uj3qpyjnczugfivh@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309091533.uj3qpyjnczugfivh@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PULL 0/8] Ui 20180308 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Mar 09, 2018 at 10:15:33AM +0100, Gerd Hoffmann wrote:
> On Fri, Mar 09, 2018 at 09:46:44AM +0100, Thomas Huth wrote:
> > On 09.03.2018 08:50, Gerd Hoffmann wrote:
> > >   Hi,
> > > 
> > >> Maybe I should move the code to a separate source file so it can be
> > >> built with different compiler flags, without needing #pragma?  I don't
> > >> feel like building all gtk code with -Wno-deprecated-declarations ...
> > > 
> > > Hmm, that idea doesn't fly, seems per-object cflags don't work for
> > > object files which get linked into a module.
> > > 
> > > Other ideas anyone?
> > 
> > Maybe simply remove the '#pragma GCC diagnostic ignored
> > "-Wunused-but-set-variable"' from the configure test and change
> > util/coroutine-ucontext.c:
> 
> I'll try.  Will probably have the effect that freebsd builds with
> -Werror then (which is now turned off by configure due to missing
> pragma support), which might trigger more issues ...

Well, guessed almost right.  -Werror is enabled on linux only, so
freebsd builds do not fail.  But clang builds on linux fail, due to a
bunch of warnings (now errors) about unaligned access to struct members.

cheers,
  Gerd
