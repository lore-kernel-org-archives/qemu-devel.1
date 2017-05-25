Received: from eggs.gnu.org ([2001:4830:134:3::10]:43263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dDz1E-0003Ko-Sy
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dDz19-0003up-Mb
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:06:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45152
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1dDz19-0003uW-An
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:05:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4PK4hDm134773
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 16:05:54 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ap5vg09xj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 16:05:53 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 25 May 2017 17:05:51 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4PK5nDb34078840
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 17:05:50 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4PK5n9s031781
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 17:05:49 -0300
Date: Thu, 25 May 2017 17:05:37 -0300
From: joserz@linux.vnet.ibm.com
References: <mailman.73115.1495441935.22737.qemu-devel@nongnu.org>
	<BBC4E515-FE7D-4600-A5CA-BBCE26059415@gmail.com>
	<87efvghzb9.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170524023303.GA12163@pacoca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170524023303.GA12163@pacoca>
Message-Id: <20170525200537.GA12666@pacoca>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Sandipan Das <sandipandas1990@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, aNikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On Tue, May 23, 2017 at 11:33:03PM -0300, joserz@linux.vnet.ibm.com wrote:
> On Tue, May 23, 2017 at 11:47:30AM +0530, Nikunj A Dadhania wrote:
> > G 3 <programmingkidx@gmail.com> writes:
> > 
> > > On May 22, 2017, at 4:32 AM, qemu-devel-request@nongnu.org wrote:
> > >
> > > Hello I have also done some work risu. My patches add ppc32 support.  
> > > Well my patches were made to work with Mac OS X but they are required  
> > > to work with Linux. Do you think you could help port these patches to  
> > > Linux?
> > 
> > Ziviani did the ppc64 work, lets see if he can spare some time.
> > 
> > The patches haven't come right on the mailing list, its tedious to pull
> > them. Please resend them with git send-mail.
> > 
> 
> Hey, sure I can help. I'll take a look on them.
> 
> > >
> > > ppc.risu:
> > > https://patchwork.kernel.org/patch/9697489/

Hi John,

What do you think about sharing the same ppc64.risu file to ppc and ppc64/ppc64le. Then, instead of:

<NAME> PPC64LE 01111...

we'd have:

<NAME> PPC 01111...

So, specific instructions would be:

<NAME> PPC64LE 01111...
<NAME> PPC64 01111...
<NAME> PPC32 01111...

It will allow users to select the arch by using patterns like: ./risugen
--pattern "PPC64*", or --pattern "PPC32*".

Finally, we could rename ppc64.risu to powerpc.risu :).

What do you think?

Thanks
