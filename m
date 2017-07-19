Received: from eggs.gnu.org ([2001:4830:134:3::10]:59611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXkZG-0005L1-OF
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXkZD-0005Td-1X
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:42:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58823)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXkZC-0005Sj-Ni
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:42:46 -0400
Date: Wed, 19 Jul 2017 09:42:41 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170719084241.GC30084@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170718102519.15392-1-berrange@redhat.com>
	<CAFEAcA-Nri9i6woP_C954xRRdzqjtohiCjWQWSXM59knq9d5gg@mail.gmail.com>
	<20170719082801.GA30084@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170719082801.GA30084@redhat.com>
Subject: Re: [Qemu-devel] [PULL v1 00/18] Merge crypto 201/07/18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, Jul 19, 2017 at 09:28:01AM +0100, Daniel P. Berrange wrote:
> On Wed, Jul 19, 2017 at 09:11:17AM +0100, Peter Maydell wrote:
> > On 18 July 2017 at 11:25, Daniel P. Berrange <berrange@redhat.com> wrote:
> > > The following changes since commit 6c6076662d98c068059983d411cb2a8987ba5670:
> > >
> > >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-07-14 12:16:09 +0100)
> > >
> > > are available in the git repository at:
> > >
> > >   git://github.com/berrange/qemu tags/pull-qcrypto-2017-07-18-1
> > >
> > > for you to fetch changes up to 0e0fb56bcc8145d956bf527bfedc2be42bca101f:
> > >
> > >   tests: crypto: add hmac speed benchmark support (2017-07-18 11:18:30 +0100)
> > >
> > > ----------------------------------------------------------------
> > > Merge crypto 2017/07/18 v1
> > >
> > > ----------------------------------------------------------------
> > 
> > Hi; I'm afraid this failed to build on clang (x86 Linux, FreeBSD,
> > OSX):
> > 
> >   CC      crypto/cipher.o
> > /home/petmay01/linaro/qemu-for-merges/crypto/cipher.c:177:9: error:
> > variable 'drv' is used uninitialized whenever 'if' condition is false
> > [-Werror,-Wsometimes-uninitialized]
> >     if (!ctx) {
> >         ^~~~
> > /home/petmay01/linaro/qemu-for-merges/crypto/cipher.c:192:30: note:
> > uninitialized use occurs here
> >     cipher->driver = (void *)drv;
> >                              ^~~
> > /home/petmay01/linaro/qemu-for-merges/crypto/cipher.c:177:5: note:
> > remove the 'if' if its condition is always true
> >     if (!ctx) {
> >     ^~~~~~~~~~
> > /home/petmay01/linaro/qemu-for-merges/crypto/cipher.c:168:29: note:
> > initialize the variable 'drv' to silence this warning
> >     QCryptoCipherDriver *drv;
> >                             ^
> >                              = NULL
> > 1 error generated.
> > 
> > and also
> > 
> >   CC      crypto/hmac.o
> > /home/petmay01/linaro/qemu-for-merges/crypto/hmac.c:103:9: error:
> > variable 'drv' is used uninitialized whenever 'if' condition is false
> > [-Werror,-Wsometimes-uninitialized]
> >     if (!ctx) {
> >         ^~~~
> > /home/petmay01/linaro/qemu-for-merges/crypto/hmac.c:116:28: note:
> > uninitialized use occurs here
> >     hmac->driver = (void *)drv;
> >                            ^~~
> > /home/petmay01/linaro/qemu-for-merges/crypto/hmac.c:103:5: note:
> > remove the 'if' if its condition is always true
> >     if (!ctx) {
> >     ^~~~~~~~~~
> > /home/petmay01/linaro/qemu-for-merges/crypto/hmac.c:94:27: note:
> > initialize the variable 'drv' to silence this warning
> >     QCryptoHmacDriver *drv;
> >                           ^
> >                            = NULL
> > 
> > 
> > Looks like a false positive, I think :-(
> 
> Ok, I'll investigate.
> 
> BTW, any idea what's different between your clang builds and the
> clang builds that travis does - the latter passed on both OS-X
> and Linux.

Never mind, I just it must just be a newer version of clang - the travis
clang build uses 3.4.0 on Linux and 7.3.0 (?!?!??) on OS-X, where as latest
I see for Linux is 4.0.0

/me wonders how OS-X clang versions map to Lnux clang versions ??!

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
