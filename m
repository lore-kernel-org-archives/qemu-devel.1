Received: from eggs.gnu.org ([2001:4830:134:3::10]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cnsyV-0004l9-Mb
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cnsyR-0007kf-Lo
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:23:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54405
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cnsyR-0007kJ-F0
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:23:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2EKE2kA111713
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 16:23:14 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 296nna505y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 16:23:14 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 14 Mar 2017 17:23:12 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v2EKN1EX34930724
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 17:23:09 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v2EKMcof002324
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 17:22:38 -0300
Date: Tue, 14 Mar 2017 17:22:12 -0300
From: joserz@linux.vnet.ibm.com
References: <1489084718-15294-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1489084718-15294-3-git-send-email-joserz@linux.vnet.ibm.com>
	<CAFEAcA8GPTVg-kUXfTJk17KPaPFAHJ-mGOEXPZLxQ0q9CNRckw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8GPTVg-kUXfTJk17KPaPFAHJ-mGOEXPZLxQ0q9CNRckw@mail.gmail.com>
Message-Id: <20170314202212.GA8995@pacoca>
Subject: Re: [Qemu-devel] [PATCH Risu v2 2/3] configure: Add initial support
 to PPC64 (big endian)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On Mon, Mar 13, 2017 at 12:10:10PM +0100, Peter Maydell wrote:
> On 9 March 2017 at 19:38, Jose Ricardo Ziviani
> <joserz@linux.vnet.ibm.com> wrote:
> > This commit set Makefile to point to ppc64le source for both archs
> > (ppc64 and ppc64le) because they do the exact same thing. The
> > difference is in risugen and how the binary is build.
> 
> If we're going to share a single set of source files for ppc64le
> and ppc64 (which makes sense) then I think we should use ARCH=ppc64
> for that, and rename the 'ppc64le' source files to 'ppc64'.
> 

Your idea makes more sense. I'll  do that and send another patch
tomorrow morning.

Thank you Peter!

> The rest of these patches look OK.
> 
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > ---
> >  configure | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 055e6d6..dd64d8b 100755
> > --- a/configure
> > +++ b/configure
> > @@ -51,11 +51,7 @@ guess_arch() {
> >      elif check_define __aarch64__ ; then
> >          ARCH="aarch64"
> >      elif check_define __powerpc64__ ; then
> > -        if check_define __BIG_ENDIAN__; then
> > -            ARCH="ppc64"
> > -        else
> > -            ARCH="ppc64le"
> > -        fi
> > +        ARCH="ppc64le"
> >      else
> >          echo "This cpu is not supported by risu. Try -h. " >&2
> >          exit 1
> > @@ -127,6 +123,9 @@ OBJDUMP="${OBJDUMP-${CROSS_PREFIX}objdump}"
> >
> >  if test "x${ARCH}" = "x"; then
> >      guess_arch
> > +elif test "x${ARCH}" = "xppc64"; then
> > +    # ppc64 and ppc64le uses the same C source code
> > +    ARCH="ppc64le"
> >  fi
> >
> >  generate_makefilein
> > --
> > 2.7.4
> >
> 
> Incidentally, maybe we should just drop support for
> specifying ARCH= manually to configure. I can't really
> see a use case where the auto-detection won't do the
> right thing.
> 
> thanks
> -- PMM
> 
