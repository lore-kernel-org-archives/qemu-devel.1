Received: from eggs.gnu.org ([2001:4830:134:3::10]:53597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqdxy-0002ls-Jz
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqdxv-00018O-C7
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:58:10 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:34548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cqdxv-00018J-50
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:58:07 -0400
Received: by mail-vk0-x241.google.com with SMTP id y16so10015408vky.1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 03:58:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149011293694.3910.1065708853924970955@loki>
References: <20170321120326.10011-1-sameeh@daynix.com>
	<149011293694.3910.1065708853924970955@loki>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 22 Mar 2017 12:58:05 +0200
Message-ID: <CAKPgXcELMpyTSS5H1jM52Dqh==xMnMk5KO=cj+_xGQ6+F48KBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH qemu-ga] Start VSS Provider after install
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

On Tue, Mar 21, 2017 at 6:15 PM, Michael Roth <mdroth@linux.vnet.ibm.com>
wrote:

> Quoting Sameeh Jubran (2017-03-21 07:03:26)
> > Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
>
> What happens without this patch? Fresh installs don't report the
> fsfreeze interface as available?
>
 It solves a bug (https://bugzilla.redhat.com/show_bug.cgi?id=1218937) that
was reported in bugzilla, however
 thinking about it again this patch is not needed as the service should
only be running when it is needed.

>
> > ---
> >  qga/vss-win32/install.cpp | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> > index f4160a3..7e38332 100644
> > --- a/qga/vss-win32/install.cpp
> > +++ b/qga/vss-win32/install.cpp
> > @@ -307,6 +307,7 @@ STDAPI COMRegister(void)
> >      chk(put_Value(pObj, L"User", L"SYSTEM"));
> >      chk(pUsersInRole->SaveChanges(&n));
> >
> > +    chk(pCatalog->StartApplication(_bstr_t(QGA_PROVIDER_LNAME)));
> >  out:
> >      if (unregisterOnFailure && FAILED(hr)) {
> >          COMUnregister();
> > --
> > 2.9.3
> >
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
