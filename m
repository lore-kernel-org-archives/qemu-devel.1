Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC093C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C6C2073A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C6C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuLn2-0006jk-LY
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 14:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1iuLmJ-00064u-0r
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1iuLmH-0007Bp-C9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:35:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8888
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1iuLmH-0007Az-7A; Wed, 22 Jan 2020 14:35:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00MJXxe0059379; Wed, 22 Jan 2020 14:34:54 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xp9kg5s2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jan 2020 14:34:54 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00MJY3Bi059670;
 Wed, 22 Jan 2020 14:34:54 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xp9kg5s29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jan 2020 14:34:54 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00MJUoZ0013677;
 Wed, 22 Jan 2020 19:34:53 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 2xksn79u51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jan 2020 19:34:53 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00MJYqJ548562550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2020 19:34:52 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E241CBE054;
 Wed, 22 Jan 2020 19:34:51 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36BA2BE04F;
 Wed, 22 Jan 2020 19:34:50 +0000 (GMT)
Received: from localhost (unknown [9.85.139.52])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 22 Jan 2020 19:34:49 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 3/3] target/ppc: support single stepping with KVM HV
In-Reply-To: <20200122031149.GE2347@umbus.fritz.box>
References: <20200110151344.278471-1-farosas@linux.ibm.com>
 <20200110151344.278471-4-farosas@linux.ibm.com>
 <20200120023555.GK54439@umbus> <87d0bd28hl.fsf@linux.ibm.com>
 <20200121033241.GM54439@umbus> <87y2u0wod4.fsf@linux.ibm.com>
 <20200122031149.GE2347@umbus.fritz.box>
Date: Wed, 22 Jan 2020 16:34:46 -0300
Message-ID: <87tv4nxp2h.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-22_08:2020-01-22,
 2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1011 suspectscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220166
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

> On Tue, Jan 21, 2020 at 05:23:03PM -0300, Fabiano Rosas wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> (...)
>> >> > Hrm.... I don't actually see how changing env->msr helps you here.
>> >> > AFAICT if kvm_insert_breakpoint() resolves to kvm_arch_sw_breakpoint()
>> >> > it doesn't rely on the MSR value at all.  If it resolves to
>> >> > kvm_arch_hw_breakpoint(), then it looks like it just stashes
>> >> > information to be pushed into KVM when we re-enter the guest.  None of
>> >> > the information stashed appears to depend on the current MSR, and once
>> >> > we re-enter the MSR will already have been restored.
>> >> >
>> >>
>> >> This is the call chain:
>> >> 
>> >> kvm_arch_insert_sw_breakpoint -> cpu_memory_rw_debug ->
>> >> cpu_get_phys_page_attrs_debug -> ppc_cpu_get_phys_page_debug ->
>> >> ppc64_v3_get_phys_page_debug -> ppc_radix64_get_phys_page_debug:
>> >> 
>> >>     /* Handle Real Mode */
>> >>     if (msr_dr == 0) {
>> >>         /* In real mode top 4 effective addr bits (mostly) ignored */
>> >>         return eaddr & 0x0FFFFFFFFFFFFFFFULL;
>> >>     }
>> >
>> > Ah, right.  Basically the issue is that kvm_insert_breakpoint() takes
>> > an effective address, not a real address, but it might be happening in
>> > a different context than we're executing right now.
>> >
>> > Ok, that makes sense.  Though.. aren't you always inserting the
>> > breakpoint into an interrupt vector?  So wouldn't it always be MMU
>> > off?  Under what circumstances would this get called with mmu_on =
>> > true?
>> 
>> Well, the MSR state at the moment of the breakpoint is that of the
>> currently executing instruction.
>
> Uh... at the moment of setting the breakpoint, or the moment of
> hitting the breakpoint.
>

Setting. I reworded that sentence so many times it actually got worse.

>> So this gets called with mmu_on = true
>> very often because we're often debugging code than runs with
>> IR|DR=1.
>
> Uh... but isn't the whole point here that the state of mmu_on might
> not match the MSR state.  So the two sentences above don't seem to
> mesh together.
>

I meant that they match most of the time but when they don't we hit the
issue we are discussing right now.

> What I think I'm understanding from the code is that in order to *set*
> the breakpoint, you need to set up the MSR to match what you expect it
> will be when you *hit* the breakpoint.  Yes?
>

Yes.

> But since the breakpoint is always placed in an interrupt vector,
> won't that always be real mode?  Or is this one of the vectors that
> can be entered in virtual mode on recent chips?
>

The interrupt sets IR DR according to the AIL value, so it may be
handled in virtual mode as well.

>> However, we could be at a point when IR|DR=1, but the next traced
>> instruction will execute with IR|DR=0. This happens at the rfid at the
>> end of __enter_rtas, for instance.
>> 
>> So ppc_radix64_get_phys_page_debug will check the MSR, see that we are
>> (now) not in real mode and proceed with the page table walk, which could
>> fail.
>> 
>> In the particular case of the __enter_rtas rfid, we have PIDR=1 [1] so
>> if we don't exit ppc_radix64_get_phys_page_debug at the msr_dr == 0
>> check, it will fail to translate the address.
>> 
>> 1 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eeb715c3e995fbdda0cc05e61216c6c5609bce66
>> 
>> >> Actually, I think there is a bug after ppc_cpu_get_phys_page_debug
>> >> somewhere. There are some cases where GDB wants to read/write to some
>> >> memory, but it gets denied access. Presumably because of one such
>> >> discrepancy as the one above. I need to spend more time looking at this
>> >> to define the problem properly, though.
>> >
>> > Hm, ok.
>> >
>> >> >> +    /*
>> >> >> +     * MSR_SE = 1 will cause a Trace Interrupt in the guest after the
>> >> >> +     * next instruction executes. If this is a rfid, use SRR1 instead
>> >> >> +     * of MSR.
>> >> >> +     */
>> >> >> +    if (rfid) {
>> >> >> +        if ((env->spr[SPR_SRR1] >> MSR_SE) & 1) {
>> >> >> +            /*
>> >> >> +             * The guest is doing a single step itself. Make sure we
>> >> >> +             * restore it later.
>> >> >> +             */
>> >> >> +            env->sstep_kind = SSTEP_GUEST;
>> >> >> +        }
>> >> >> +
>> >> >> +        env->spr[SPR_SRR1] |= (1ULL << MSR_SE);
>> >> >> +        mmu_on = srr1_ir & srr1_dr;
>> >> >
>> >> > s/&/&&/
>> >> >
>> >> 
>> >> Ack.
>> >> 
>> >> >> +    } else {
>> >> >> +        env->msr |= (1ULL << MSR_SE);
>> >> >> +        mmu_on = msr_ir & msr_dr;
>> >> >
>> >> > s/&/&&/
>> >> >
>> >> 
>> >> Ack.
>> >> 
>> >> > Also, what happens if the guest is using MSR[DR] != MSR[IR]?  It's
>> >> > rare, but it is occasionally useful.
>> >> 
>> >> I understand from the ISA that for the purposes of AIL, both bits need
>> >> to be set. So mmu_on = 0 is correct here.
>> >
>> > I'm not sure what you mean by "for the purposes of AIL".
>> >
>> 
>> The reason I'm tracking the translation state here is to be able to tell
>> what will be the value of AIL, since an Alternate Interrupt Location is
>> not used when translation is disabled. In the ISA, under "Alternate
>> Interrupt Location" the only mention of MSR_IR != MSR_DR is:
>> 
>> "Other interrupts that occur when MSR IR=0 or MSR DR=0, are taken as
>> if LPCR AIL=0."
>> 
>> and my interpretation of that text is that AIL value is 0 when IR DR are
>> either 0b00, 0b01 or 0b10.
>> 
>> So "for the purposes of AIL", I'm considering either IR=0 or DR=0 as
>> meaning MMU off.
>
> But AFAICT the mmu_on flag you're setting here has influences other
> than tracking AIL.

The purpose of the mmu_on flag is to know what the AIL value will be at
the time the interrupt happens and therefore know in which mode the
interrupt will be handled, i.e where to put the breakpoint. Remember:

MMU off or AIL = 0 => 0xd00
AIL = 3 => 0xc000000000004d00

With this recent change, I also use it to know what I should temporarily
put in MSR_DR|IR so that the address translation doesn't
fail. Ultimately, the mmu_on flag only influences the placement of the
breakpoint at the Trace Interrupt handler.


