Received: from eggs.gnu.org ([2001:4830:134:3::10]:38672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cs4nH-0005Re-11
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 05:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cs4nD-0008A9-Ko
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 05:49:03 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:35025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cs4nD-00089x-Dx
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 05:48:59 -0400
Received: by mail-vk0-x241.google.com with SMTP id z204so4211912vkd.2
	for <qemu-devel@nongnu.org>; Sun, 26 Mar 2017 02:48:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170323182127.GK12560@stefanha-x1.localdomain>
References: <20170323092211.29990-1-sameeh@daynix.com>
	<20170323182127.GK12560@stefanha-x1.localdomain>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 26 Mar 2017 12:48:58 +0300
Message-ID: <CAKPgXcHt2ERvH-zeHhX_7CQNd+FogEseO6-6LBSRh1fCDx_dew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH qemu-ga v2] qga: Make qemu-ga compile
 statically for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yan Vugenfirer <yan@daynix.com>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Mar 23, 2017 at 9:21 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Thu, Mar 23, 2017 at 11:22:11AM +0200, Sameeh Jubran wrote:
> > Attempting to compile qemu-ga statically as follows for Windows causes
> > the following error:
> >
> > Compilation:
> >     ./configure --disable-docs --target-list=x86_64-softmmu \
> >     --cross-prefix=x86_64-w64-mingw32- --static \
> >     --enable-guest-agent-msi --with-vss-sdk=/path/to/VSSSDK72
> >
> >     make -j8 qemu-ga
> >
> > Error:
> >     path/to/qemu/stubs/error-printf.c:7: undefined reference to
> `__imp_g_test_config_vars'
> >     collect2: error: ld returned 1 exit status
> >     Makefile:444: recipe for target 'qemu-ga.exe' failed
> >     make: *** [qemu-ga.exe] Error 1
> >
> > This is caused by a bug in the pkg-config file for glib as it doesn't
> define
> > GLIB_STATIC_COMPILATION for pkg-config --static.
>
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
>
> Please remove this.  I didn't post my Signed-off-by.  Only add
> Signed-off-by for someone else if they ask you to do so.
>
> For details on Signed-off-by please read:
> "11) Sign your work - the Developer's Certificate of Origin"
> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

 I added your signed off to indicate that you were involved in the
development of the patch as you are the one that suggested
this workaround in the first place. No problem I will drop it.

>
>
> > Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> > ---
> >  configure | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/configure b/configure
> > index b9a30cf..8210494 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3041,6 +3041,13 @@ if test "$modules" = yes; then
> >      glib_modules="$glib_modules gmodule-2.0"
> >  fi
> >
> > +# This workaround is required due to a bug in pkg-config file for glib
> as it
> > +# doesn't define GLIB_STATIC_COMPILATION for pkg-config --static
>
> Please add:
>
> # See https://bugzilla.gnome.org/show_bug.cgi?id=780399 for the glib bug
> # report.


> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
I'll add them in v3, thanks for the review.


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
