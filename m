Received: from eggs.gnu.org ([2001:4830:134:3::10]:39440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciimV-0005ZA-J9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciimS-00046l-Dj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:29:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1ciimS-00046c-4e
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:29:32 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SETBGK078960
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:29:30 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28w2hcr086-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:29:30 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 28 Feb 2017 11:29:27 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 0C20C1DC0071
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:29:26 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1SETOcd26083442
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 11:29:24 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
	by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1SETON8016676
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 11:29:24 -0300
Date: Tue, 28 Feb 2017 11:29:18 -0300
From: joserz@linux.vnet.ibm.com
References: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1488224492-20316-3-git-send-email-joserz@linux.vnet.ibm.com>
	<CAFEAcA_DD1KmSR+U-4jSVbycO+QwZ9ebc_k4RJ2+TqZD2jiB5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_DD1KmSR+U-4jSVbycO+QwZ9ebc_k4RJ2+TqZD2jiB5w@mail.gmail.com>
Message-Id: <20170228142918.GA7745@pacoca>
Subject: Re: [Qemu-devel] [PATCH Risu 2/5] risu_reginfo_ppc64le: Remove
 unused code from PPC64 register comparison
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

On Tue, Feb 28, 2017 at 01:43:22PM +0000, Peter Maydell wrote:
> On 27 February 2017 at 19:41, Jose Ricardo Ziviani
> <joserz@linux.vnet.ibm.com> wrote:
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > ---
> >  risu_reginfo_ppc64le.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
> > index e6bc0e0..a76f296 100644
> > --- a/risu_reginfo_ppc64le.c
> > +++ b/risu_reginfo_ppc64le.c
> > @@ -86,14 +86,6 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
> >                  m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
> >                  m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
> >                  m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
> > -
> > -            if (uc != NULL && (m->gregs[CCR] & 0x10)) {
> > -                uc->uc_mcontext.v_regs->vrregs[i][0] = a->vrregs.vrregs[i][0];
> > -                uc->uc_mcontext.v_regs->vrregs[i][1] = a->vrregs.vrregs[i][1];
> > -                uc->uc_mcontext.v_regs->vrregs[i][2] = a->vrregs.vrregs[i][2];
> > -                uc->uc_mcontext.v_regs->vrregs[i][3] = a->vrregs.vrregs[i][3];
> > -                return 1;
> > -            }
> >              return 0;
> >          }
> >      }
> > --
> 
> I have a variation on this patch already in my set of refactoring
> patches that I posted last week:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg06152.html

Sorry, I missed that commit. I'll send a v2 with the fix suggested by
Nikunj and without this one.

Thanks Peter

> 
> thanks
> -- PMM
> 
