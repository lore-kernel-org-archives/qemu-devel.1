Received: from eggs.gnu.org ([2001:4830:134:3::10]:35460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1co4TF-0007VE-N9
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1co4TC-0002eR-IA
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:39:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1co4TC-0002e7-89
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:39:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2F8ceHm039401
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 04:39:44 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 296nfwh61y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 04:39:44 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 15 Mar 2017 04:39:43 -0400
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica>
	<CAFEAcA9nZszkmH7-P9jkxoGxLYHKspDiS-PFUyVZrrtDfgPNMA@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 15 Mar 2017 09:39:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9nZszkmH7-P9jkxoGxLYHKspDiS-PFUyVZrrtDfgPNMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <b39c550f-55e1-5e80-1788-ffb1c30d0ded@de.ibm.com>
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

On 03/14/2017 11:56 AM, Peter Maydell wrote:
> On 14 March 2017 at 09:59, Juan Quintela <quintela@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 14 March 2017 at 09:13, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>> On Mon, Mar 13, 2017 at 11:02:01AM +0100, Peter Maydell wrote:
>>>> The minimum requirements for the new language:
>>>> 1. Does it support the host operating systems that QEMU runs on?
>>>> 2. Does it support the host architectures that QEMU runs on?
>>>
>>> Speaking of this, I was thinking that we should introduce
>>> a rule that for any host OS/arch we support we must have
>>> a build machine so we can at least do a compile test.
>>> For instance if you believe configure we support Solaris
>>> and AIX, but I bet they're bit-rotting. The ia64 backend
>>> has to be a strong candidate for being dumped too.
>>> Demanding "system we can test on or we drop support"
>>> would let us more clearly see what we're actually running
>>> on and avoid unnecessarily ruling things out because they
>>> don't support Itanium or AIX...
>>
>> YES, YES and YES.
>>
>> I demand an osX build machine NOW!!!!  Remote access is ok.
> 
> OSX is actually in the set that's OK because I have a
> machine I can test on. The ones that are problems are
> all the BSDs, AIX, Solaris, Haiku, and architectures
> sparc, mips, ia64, s390.

Peter,

if you need an s390 box, you can register for a virtual machine at
https://developer.ibm.com/linuxone/
If you have an account let me know the details and I will try to 
find the right people in IBM to extend the 120 day testing period 
to unlimited.
