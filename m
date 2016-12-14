Received: from eggs.gnu.org ([2001:4830:134:3::10]:56276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cH5BX-0002UX-Cu
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cH5BU-0008MF-AB
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:45:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cH5BU-0008Hv-1u
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:45:08 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBE8iG2c106369
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 03:45:05 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27b1u92vma-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 03:45:04 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 14:14:59 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20161212040733.GB31441@umbus.fritz.box>
References: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481285845-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20161212003055.GC12127@umbus.fritz.box>
	<CALAZu38RiyxcnV5uXucUcyyV9aeWqXXpEznUF9z2gNrn0Fy4tQ@mail.gmail.com>
	<20161212040733.GB31441@umbus.fritz.box>
Date: Wed, 14 Dec 2016 14:14:26 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d1guc32t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 5/6] target-ppc: implement
 xxextractuw instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Nikunj Dadhania <nikunj.dadhania@gmail.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

David Gibson <david@gibson.dropbear.id.au> writes:

> [ Unknown signature status ]
> On Mon, Dec 12, 2016 at 09:31:11AM +0530, Nikunj Dadhania wrote:
>> On 12 December 2016 at 06:00, David Gibson <david@gibson.dropbear.id.au> wrote:
>> > On Fri, Dec 09, 2016 at 05:47:24PM +0530, Nikunj A Dadhania wrote:
>> >> xxextractuw: VSX Vector Extract Unsigned Word
>> >>
>> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> >> +        tcg_gen_movi_i64(cpu_vsrh(xT(ctx->opcode)), 0);         \
>> >> +        tcg_gen_movi_i64(cpu_vsrl(xT(ctx->opcode)), 0);         \
>> >> +        return;                                                 \
>> >
>> > So, I know the architecture says it is undefined.  But since you're
>> > testing for the bogus case anyway, why not turn this into an
>> > exception. That seems like it would be more helpful for debugging the
>> > guest than just setting the result to zero.  Or is this done to match
>> > actual hardware behaviour?
>> 
>> I havent had a change to run on the real hardware, but on the system
>> simulator, it happily
>> returns extracted content even if UIMM > 12.
>
> Hm.  Returns what exactly?

So for LE case extracting from 15 returns following, basically its
rounding up to 0.

xxextractuw: 15 - ooTSET a si sihT
                  ________ihTo____

Regards,
Nikunj
