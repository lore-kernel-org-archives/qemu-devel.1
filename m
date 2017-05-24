Received: from eggs.gnu.org ([2001:4830:134:3::10]:59131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dDM7l-0003sJ-JF
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dDM7g-0001ps-Jo
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:34:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49446
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1dDM7g-0001pe-Eb
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:34:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4O2Sw6W007583
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 22:34:03 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2amrehnk9u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 22:34:02 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 23 May 2017 23:34:00 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4O2XnYD19464688
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 23:33:57 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4O2XP1r026196
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 23:33:25 -0300
Date: Tue, 23 May 2017 23:33:03 -0300
From: joserz@linux.vnet.ibm.com
References: <mailman.73115.1495441935.22737.qemu-devel@nongnu.org>
	<BBC4E515-FE7D-4600-A5CA-BBCE26059415@gmail.com>
	<87efvghzb9.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87efvghzb9.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Message-Id: <20170524023303.GA12163@pacoca>
Subject: Re: [Qemu-devel] [PATCH risu] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: programmingkidx@gmail.com
Cc: aNikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Sandipan Das <sandipandas1990@gmail.com>

On Tue, May 23, 2017 at 11:47:30AM +0530, Nikunj A Dadhania wrote:
> G 3 <programmingkidx@gmail.com> writes:
> 
> > On May 22, 2017, at 4:32 AM, qemu-devel-request@nongnu.org wrote:
> >
> > Hello I have also done some work risu. My patches add ppc32 support.  
> > Well my patches were made to work with Mac OS X but they are required  
> > to work with Linux. Do you think you could help port these patches to  
> > Linux?
> 
> Ziviani did the ppc64 work, lets see if he can spare some time.
> 
> The patches haven't come right on the mailing list, its tedious to pull
> them. Please resend them with git send-mail.
> 

Hey, sure I can help. I'll take a look on them.

> >
> > ppc.risu:
> > https://patchwork.kernel.org/patch/9697489/
> >
> > risu_ppc.c:
> > https://patchwork.kernel.org/patch/9697491/
> >
> > risu_reginfo_ppc.c:
> > https://patchwork.kernel.org/patch/9697493/
> >
> > risu_reginfo_ppc.h:
> > https://patchwork.kernel.org/patch/9697495/
> >
> > risugen_ppc.pm:
> > https://patchwork.kernel.org/patch/9697497/
> >
> > Add ppc support to configure:
> > https://patchwork.kernel.org/patch/9697499/
> >
> > Add verbose option:
> > https://patchwork.kernel.org/patch/9697501/
> >
> > Add end of test message:
> > https://patchwork.kernel.org/patch/9697503/
> >
> > Add more descriptive comment for mismatch or end of test condition:
> > https://patchwork.kernel.org/patch/9697505/
> 
> Regards
> Nikunj
> 
