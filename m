Received: from eggs.gnu.org ([2001:4830:134:3::10]:51464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dFmL6-0007dV-Ub
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dFmL2-0001MH-2y
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:57:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34311
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1dFmL1-0001Lj-TR
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:57:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4UIriHt056595
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 14:57:50 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2asbnn029x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 14:57:50 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 30 May 2017 15:57:48 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4UIvjMS20578792
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 15:57:45 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4UIvjM2008001
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 15:57:46 -0300
Date: Tue, 30 May 2017 15:55:52 -0300
From: joserz@linux.vnet.ibm.com
References: <1495739423-32326-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1495739423-32326-5-git-send-email-joserz@linux.vnet.ibm.com>
	<CAFEAcA8ue3V+XFdRZ2tjd5EzQjD+RVbL62tf=zAWXxznOTMxwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8ue3V+XFdRZ2tjd5EzQjD+RVbL62tf=zAWXxznOTMxwA@mail.gmail.com>
Message-Id: <20170530185552.GA5357@pacoca>
Subject: Re: [Qemu-devel] [PATCH Risu v3 4/4] build: Add support to PowerPC
 BE and remove ARCH
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

On Tue, May 30, 2017 at 03:27:33PM +0100, Peter Maydell wrote:
> On 25 May 2017 at 20:10, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com> wrote:
> > Essentialy the code for PowerPC BE and LE are the same, so this patch
> > renames all *ppc64le.* files to *ppc64.* and reflects such in the
> > Makefile.
> >
> > Due to the fact that all supported archs are covered by guess_arch
> > function, this also drops the ARCH parameter from the Makefile.
> 
> This change isn't right -- the point is that guess_arch might
> (in theory) guess wrong, so the user can override it.
> 
> You forgot to delete the comment about "powerpc64-linux-gnu doesn't
> work" from the build-all-archs script.
> 
> The rest is fine though, so I've made those minor tweaks and
> applied the series to risu master.
> 
> PS: for patches like this there is a neat git option --find-renames
> which you can use when you're generating the patch email to
> create smaller and easier to read patches.
> 
> thanks
> -- PMM
> 

Peter, thanks for your review, I always learn from it. Just
added the "git config diff.renames true; git config diff.algorithm
patience" config here. Next time it'll be better indeed! :)

Thanks
