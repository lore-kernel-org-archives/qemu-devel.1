Received: from eggs.gnu.org ([2001:4830:134:3::10]:37447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cg08Q-0000HG-AL
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cg08N-0006tz-3d
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:24:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cg08M-0006tP-QH
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:24:55 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1L2Oe23030849
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 21:24:52 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28r3p8c76j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 21:24:52 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 23:24:48 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id BBE981DC0054
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 21:24:47 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1L2OkZr27066388
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 23:24:46 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1L2Ojmm011402
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 23:24:45 -0300
Date: Mon, 20 Feb 2017 23:24:36 -0300
From: joserz@linux.vnet.ibm.com
References: <1478452528-13684-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1478452528-13684-8-git-send-email-joserz@linux.vnet.ibm.com>
	<CAFEAcA9HTc9QH51w5yhNoMjLk3jB4aM+Zp2MWBDN+xGnqf-cOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9HTc9QH51w5yhNoMjLk3jB4aM+Zp2MWBDN+xGnqf-cOw@mail.gmail.com>
Message-Id: <20170221022436.GA14453@pacoca>
Subject: Re: [Qemu-devel] [PATCH Risu v2 7/9] Add PPC64 in risu build system
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

On Sat, Feb 18, 2017 at 10:41:41PM +0000, Peter Maydell wrote:
> On 6 November 2016 at 17:15, Jose Ricardo Ziviani
> <joserz@linux.vnet.ibm.com> wrote:
> > Recognizes PPC64 as a valid architecture and setup the environment
> > variables to compile code for that.
> >
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > ---
> >  configure | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index 748b48a..f81bdb5 100755
> > --- a/configure
> > +++ b/configure
> > @@ -22,6 +22,12 @@ guess_arch() {
> >          ARCH="arm"
> >      elif check_define __aarch64__ ; then
> >          ARCH="aarch64"
> > +    elif check_define __powerpc64__ ; then
> > +        if check_define __BIG_ENDIAN__; then
> > +            ARCH="ppc64"
> > +        else
> > +            ARCH="ppc64le"
> > +        fi
> 
> Does the BE ppc64 risu build work for you? I tried
> installing the cross-compiler, but the build fails
> because there's no risu_ppc64.c. (ppc64le works fine.)
> If we don't support the big-endian variant yet maybe
> we should drop it from the configure file.

I want it to work to but I focused the efforts on LE only, never tested
at all. I have a small patchset to send to you. I'll make an effort to fix BE as well,
it's worth it.

Thanks Peter!

> 
> thanks
> -- PMM
> 
