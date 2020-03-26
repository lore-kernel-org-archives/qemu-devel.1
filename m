Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE528C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A4B2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A4B2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHVeV-0005sv-Mn
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 12:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jHVcE-0004WU-E5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jHVcC-0001GB-9o
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:44:21 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48229)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jHVc4-0000iR-6H; Thu, 26 Mar 2020 12:44:13 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MjSDU-1jg8vl1U0w-00kt1i; Thu, 26 Mar 2020 17:44:07 +0100
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>
References: <CAFEAcA84QTW+p57pccbgGnp5v_=deZT7g52ure+=s96WdM0oXw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: booke206_tlb_ways() returning 0
Message-ID: <016564f3-18ff-e34a-4ce1-a4916a01c7bb@vivier.eu>
Date: Thu, 26 Mar 2020 17:44:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84QTW+p57pccbgGnp5v_=deZT7g52ure+=s96WdM0oXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lgFRY1b3bXE41DlYyq/Qe0spNHQirXV3iu+LhfQGSRRocnT7BhI
 cKozl4jCm2popfOHwwYfEyE62Yl92El+XKsgohbNlg9wF7z3ztp/OPO/AYcv6YyGWPBl5x0
 GHh/Gp07T+DofGRg+5KaV+ZLvgLjvfcI3CNQIPRtv8z0Y1TYpwgKqF18V6GJ64IU7f7sBTm
 keI/pA+QG7dMDLWhlR8xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BhRvb8HFxmg=:Ux5knrrFjrGzXYYrZb/cQv
 wcA340mSJ9pfzNckE8zSgK9TTs5kGpn7tPhxvCtPQle3n13eU5Qs5hYK675ylHSH/4G6A6J7i
 ybsGvwmq6vO5TudlgxfJgqSKVlp8e1gHR3m1PoSe6KWdWtbmPJ/Wbf2zcf97qlX4GxNz/ceHP
 VtJYjJXs5K5bfYb37E3C3UuoBzmNX8Gwb4ylhiuW1hjrBLCFmPvxPr4KkWui428j01/IcJyyq
 wJrf/zQrNT2I77zu7KMBvRXU5CB+ncA7mFv5DPnsesHs3PLwauH5PrimCsgO5c0KF3pna9xZG
 3MX+xus7gii4URNMPfAzckOrgizWmt5aG5Po78+NdBM/LJ/P75ESnjdRfUHP3nIBjhKOijm4t
 AA3FMGFgio4Mfuyu314Bd7w4zDI1zFAUPF7B97D0WemjQRGMGbM2EQvshZZK8Sx+nIk3NhCPt
 K+5fPP7N/am+7Vxia5/4wNw6lRCVFTKHSlg2SlabqV8y/WBMMupViKUAOByJ0JG+H5kbaXAtW
 UrhIm3W2AB6FPTgggow9iG83aadnhO1Nf0Q6pN9bNPbbwekOa4caEjqxYKbdtuSQS8FT+oRve
 PF4qDQi8i22S9930pDUo53lC2fnOgvrMoyQP5bUWHRsuNiRekZ7zDwNyXR4Q1OK8ZZIGXsC+f
 IZrXgeahZjdACmlOGSOwgNdH825hqT2w2WyzazCpEDe9lwLD0pEPZZ90ZXo87quE7CqIbtzuv
 zTBfyB5MVdAv5cNAdKzh9lDXYhS7Kf8CUvhA2SL0oHtCZABqTctgXnCf5CdMAeb+0DSrtw3zc
 tjEkYQSa3due95FtJGBnXOfMljs6N/ZkCDy66wwsQH22TQ+J2wvfTum+jNS31S/FvHFc7NH
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/03/2020 à 15:22, Peter Maydell a écrit :
> Hi; Coverity points out a possible issue in booke206_get_tlbm()
> (this is CID 1421942):
> 
> 
> static inline ppcmas_tlb_t *booke206_get_tlbm(CPUPPCState *env, const int tlbn,
>                                               target_ulong ea, int way)
> {
>     int r;
>     uint32_t ways = booke206_tlb_ways(env, tlbn);
>     int ways_bits = ctz32(ways);
>     int tlb_bits = ctz32(booke206_tlb_size(env, tlbn));
>     int i;
> 
>     way &= ways - 1;
>     ea >>= MAS2_EPN_SHIFT;
>     ea &= (1 << (tlb_bits - ways_bits)) - 1;
>     r = (ea << ways_bits) | way;
> 
> Here if booke206_tlb_ways() returns zero, then ways_bits()
> will be 32 and the shift left 'ea << ways_bits' is undefined
> behaviour.
> 
> My first assumption was that booke206_tlb_ways() is not supposed
> to ever return 0 (it's looking at what I think are read-only
> system registers, and it doesn't make much sense to have
> a zero-way TLB). So I tried adding an assert:
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 88d94495554..aedb6bcb265 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2403,6 +2403,7 @@ static inline int booke206_tlb_ways(CPUPPCState
> *env, int tlbn)
>  {
>      uint32_t tlbncfg = env->spr[SPR_BOOKE_TLB0CFG + tlbn];
>      int r = tlbncfg >> TLBnCFG_ASSOC_SHIFT;
> +    assert(r > 0);
>      return r;
>  }
> 
> However, this isn't right, because it causes one of the check-acceptance
> tests to fail, with this backtrace:
> 
> #3  0x00007ffff074d412 in __GI___assert_fail (assertion=0x5555560a0d7d
> "r > 0", file=0x5555560a0d40
> "/home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/cpu.h",
> line=2406, function=0x5555560a1720 <__PRETTY_FUNCTION__.20811>
> "booke206_tlb_ways") at assert.c:101
> #4  0x0000555555a9939b in booke206_tlb_ways (env=0x555556e52a30,
> tlbn=2) at /home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/cpu.h:2406
> #5  0x0000555555a9b3ac in mmubooke206_get_physical_address
> (env=0x555556e52a30, ctx=0x7fffd77008a0, address=9223380835095282947,
> rw=0, access_type=0, mmu_idx=1) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/mmu_helper.c:1093
> #6  0x0000555555a9c25d in get_physical_address_wtlb
> (env=0x555556e52a30, ctx=0x7fffd77008a0, eaddr=9223380835095282947,
> rw=0, access_type=0, mmu_idx=1) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/mmu_helper.c:1455
> #7  0x0000555555a9c82b in cpu_ppc_handle_mmu_fault
> (env=0x555556e52a30, address=9223380835095282947, rw=0, mmu_idx=1)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/mmu_helper.c:1597
> #8  0x0000555555a9f975 in ppc_cpu_tlb_fill (cs=0x555556e49560,
> addr=9223380835095282947, size=1, access_type=MMU_DATA_LOAD,
> mmu_idx=1, probe=false, retaddr=140735610345781) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/mmu_helper.c:3053
> #9  0x00005555558e1422 in tlb_fill (cpu=0x555556e49560,
> addr=9223380835095282947, size=1, access_type=MMU_DATA_LOAD,
> mmu_idx=1, retaddr=140735610345781) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1017
> #10 0x00005555558e279b in load_helper (env=0x555556e52a30,
> addr=9223380835095282947, oi=1, retaddr=140735610345781, op=MO_8,
> code_read=false, full_load=0x5555558e2b3a <full_ldub_mmu>) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1534
> #11 0x00005555558e2b80 in full_ldub_mmu (env=0x555556e52a30,
> addr=9223380835095282947, oi=1, retaddr=140735610345781)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1624
> #12 0x00005555558e2bb4 in helper_ret_ldub_mmu (env=0x555556e52a30,
> addr=9223380835095282947, oi=1, retaddr=140735610345781)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1630
> #13 0x00007fff900fd9c6 in code_gen_buffer ()
> #14 0x00005555558f9915 in cpu_tb_exec (cpu=0x555556e49560,
> itb=0x7fff900fd780 <code_gen_buffer+1038163>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:172
> #15 0x00005555558fa732 in cpu_loop_exec_tb (cpu=0x555556e49560,
> tb=0x7fff900fd780 <code_gen_buffer+1038163>, last_tb=0x7fffd7701078,
> tb_exit=0x7fffd7701070) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:619
> #16 0x00005555558faa4c in cpu_exec (cpu=0x555556e49560) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:732
> #17 0x00005555558bcf29 in tcg_cpu_exec (cpu=0x555556e49560) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1405
> #18 0x00005555558bd77f in qemu_tcg_cpu_thread_fn (arg=0x555556e49560)
> at /home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1713
> #19 0x0000555555f2ff3f in qemu_thread_start (args=0x555556e8dd10) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/util/qemu-thread-posix.c:519
> #20 0x00007ffff0b156db in start_thread (arg=0x7fffd7704700) at
> pthread_create.c:463
> #21 0x00007ffff083e88f in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> So under what circumstances can booke206_tlb_ways()
> validly return 0? Should booke206_get_tlbm() cope with a
> zero return, or can it assert() that it will never
> call booke206_tlb_ways() in a way that will cause one?

It seems the value of booke206_tlb_ways() is the associativity
(TLBnCFG_ASSOC_SHIFT) that seems to be generated by gen_tlbncfg() and
set in init_proc_e500().

And used values are: 2, 4 ,16, and 64, but only for tlbn 0 and 1.

According to PowerISA 2.06:

booke206_tlb_size() booke206_tlb_ways()

0		    0		No TLB present
0		    1		TLB geometry is completely
				implementation-defined.
				MAS0 ESEL is ignored
0		    > 1		TLB geometry and number of
				entries is implementation
				defined,...
n > 0		    n or 0	TLB is fully associative

In mmubooke206_get_physical_address(), helper_booke206_tlbsx(),
booke206_invalidate_ea_tlb() and helper_booke206_tlbilx3(),
booke206_get_tlbm() is not called if ways is 0.

In booke206_cur_tlb(), the function is only called  with tlbn number
provided by SPR_BOOKE_MAS0, so we can guess we are using the ones with
the initialized values.

It is also called in mmubooke_create_initial_mapping() but only for tlbn 1.

But r can be 0 if ea and way are 0 (in
mmubooke206_get_physical_address() if ways > 0, way will start with
value 0 and ea >> ways_bit can be 0). I think it's why your assert() is
triggered.

Thanks,
Laurent

