Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A325C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB01E206F8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVNdYLp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB01E206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHTPx-0000k8-25
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 10:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHTP1-0008KX-2T
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHTOz-0007XX-Gl
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:22:34 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHTOz-0007Vz-9m
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:22:33 -0400
Received: by mail-oi1-x243.google.com with SMTP id u20so850912oic.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=79bE4HFkn+Mv3FHlnfFcSF5KRjYC0PX/AvR+wG7Riuw=;
 b=wVNdYLp2MvkPHULLyrlFiyLDzd5IiECxfyyyV2j/jrGDllA0MG1AFQqzQoXqoLlWmg
 e8zp3cHqSwIf3UtXLXy7TNaARtn14j0YfqiECvE5cuBJmjV0ychmESE1+WqM+/CTBzl3
 PV/pzaAEID0R1rx/Wmhkooxt1btRM7TkjpMg3kmVU2BJRdKXC1zM/N4+/1OSUY6ZfaEl
 onCcw1YakDW97KhP8pVz+rzcP+Tf+a11ZfZ17iE5FtQw2ACch8T+QO5iFPhdgDWtTQpZ
 yIJFOMJuJfulFcNYS5mIoncvpnVgsn8tKsWVY2F8PutvAAunaB2ikslMqIC3mA+ekeVx
 oEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=79bE4HFkn+Mv3FHlnfFcSF5KRjYC0PX/AvR+wG7Riuw=;
 b=KKfQZ3Wp+DA+5XXB1xY128jpUFIzogyeWZ7RYUnyOn0SRcOFpenCExQ/ENiPLFLMoE
 fa0jbmGFfp1jNSkef+sGH4ki86r6LDJnQ0HX/Vn9JznpWszem8laVWoFyr5Sqzc3pUku
 ReAF8BYX9rNgfWQlEIMS5e3+yvuN82mait+BWxFHNK9QOvW7sPmUzW9ZnTOMtEY9z8I1
 BBiFkzvqlGO3dG+6L0N6hL7VhwW2FjFqDYT/UJ4GMCwkWCITZ1ZesuRak3+GCXKiLiC1
 6qoZoCpUg+EXj0v+gDf5Bdj/ifgMgLuRjAPznTvys67Z2zdk4RlvhTeACXPyE/MxzrZK
 VjzA==
X-Gm-Message-State: ANhLgQ0hMbrs6uoDC+mf41fET9NtZsxKKL80PfBxJlNeqj91K1zqCUS3
 IyuCUwzr1UCQu11/pDUwzpQUMXgzcJ6hYlgnKuixQ6jSxLjN6A==
X-Google-Smtp-Source: ADFU+vvACXaRkbUmH6KGTTrEFld24Qaa7kS6CL7XaPQP1/7rWBXuZ+KxCMWmu1kHUymdRuiZ+9dDdd0/RSBRIfX5WN4=
X-Received: by 2002:aca:2318:: with SMTP id e24mr124400oie.0.1585232551714;
 Thu, 26 Mar 2020 07:22:31 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 14:22:20 +0000
Message-ID: <CAFEAcA84QTW+p57pccbgGnp5v_=deZT7g52ure+=s96WdM0oXw@mail.gmail.com>
Subject: booke206_tlb_ways() returning 0
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

Hi; Coverity points out a possible issue in booke206_get_tlbm()
(this is CID 1421942):


static inline ppcmas_tlb_t *booke206_get_tlbm(CPUPPCState *env, const int tlbn,
                                              target_ulong ea, int way)
{
    int r;
    uint32_t ways = booke206_tlb_ways(env, tlbn);
    int ways_bits = ctz32(ways);
    int tlb_bits = ctz32(booke206_tlb_size(env, tlbn));
    int i;

    way &= ways - 1;
    ea >>= MAS2_EPN_SHIFT;
    ea &= (1 << (tlb_bits - ways_bits)) - 1;
    r = (ea << ways_bits) | way;

Here if booke206_tlb_ways() returns zero, then ways_bits()
will be 32 and the shift left 'ea << ways_bits' is undefined
behaviour.

My first assumption was that booke206_tlb_ways() is not supposed
to ever return 0 (it's looking at what I think are read-only
system registers, and it doesn't make much sense to have
a zero-way TLB). So I tried adding an assert:

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 88d94495554..aedb6bcb265 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2403,6 +2403,7 @@ static inline int booke206_tlb_ways(CPUPPCState
*env, int tlbn)
 {
     uint32_t tlbncfg = env->spr[SPR_BOOKE_TLB0CFG + tlbn];
     int r = tlbncfg >> TLBnCFG_ASSOC_SHIFT;
+    assert(r > 0);
     return r;
 }

However, this isn't right, because it causes one of the check-acceptance
tests to fail, with this backtrace:

#3  0x00007ffff074d412 in __GI___assert_fail (assertion=0x5555560a0d7d
"r > 0", file=0x5555560a0d40
"/home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/cpu.h",
line=2406, function=0x5555560a1720 <__PRETTY_FUNCTION__.20811>
"booke206_tlb_ways") at assert.c:101
#4  0x0000555555a9939b in booke206_tlb_ways (env=0x555556e52a30,
tlbn=2) at /home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/cpu.h:2406
#5  0x0000555555a9b3ac in mmubooke206_get_physical_address
(env=0x555556e52a30, ctx=0x7fffd77008a0, address=9223380835095282947,
rw=0, access_type=0, mmu_idx=1) at
/home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/mmu_helper.c:1093
#6  0x0000555555a9c25d in get_physical_address_wtlb
(env=0x555556e52a30, ctx=0x7fffd77008a0, eaddr=9223380835095282947,
rw=0, access_type=0, mmu_idx=1) at
/home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/mmu_helper.c:1455
#7  0x0000555555a9c82b in cpu_ppc_handle_mmu_fault
(env=0x555556e52a30, address=9223380835095282947, rw=0, mmu_idx=1)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/mmu_helper.c:1597
#8  0x0000555555a9f975 in ppc_cpu_tlb_fill (cs=0x555556e49560,
addr=9223380835095282947, size=1, access_type=MMU_DATA_LOAD,
mmu_idx=1, probe=false, retaddr=140735610345781) at
/home/petmay01/linaro/qemu-from-laptop/qemu/target/ppc/mmu_helper.c:3053
#9  0x00005555558e1422 in tlb_fill (cpu=0x555556e49560,
addr=9223380835095282947, size=1, access_type=MMU_DATA_LOAD,
mmu_idx=1, retaddr=140735610345781) at
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1017
#10 0x00005555558e279b in load_helper (env=0x555556e52a30,
addr=9223380835095282947, oi=1, retaddr=140735610345781, op=MO_8,
code_read=false, full_load=0x5555558e2b3a <full_ldub_mmu>) at
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1534
#11 0x00005555558e2b80 in full_ldub_mmu (env=0x555556e52a30,
addr=9223380835095282947, oi=1, retaddr=140735610345781)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1624
#12 0x00005555558e2bb4 in helper_ret_ldub_mmu (env=0x555556e52a30,
addr=9223380835095282947, oi=1, retaddr=140735610345781)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1630
#13 0x00007fff900fd9c6 in code_gen_buffer ()
#14 0x00005555558f9915 in cpu_tb_exec (cpu=0x555556e49560,
itb=0x7fff900fd780 <code_gen_buffer+1038163>)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:172
#15 0x00005555558fa732 in cpu_loop_exec_tb (cpu=0x555556e49560,
tb=0x7fff900fd780 <code_gen_buffer+1038163>, last_tb=0x7fffd7701078,
tb_exit=0x7fffd7701070) at
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:619
#16 0x00005555558faa4c in cpu_exec (cpu=0x555556e49560) at
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:732
#17 0x00005555558bcf29 in tcg_cpu_exec (cpu=0x555556e49560) at
/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1405
#18 0x00005555558bd77f in qemu_tcg_cpu_thread_fn (arg=0x555556e49560)
at /home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1713
#19 0x0000555555f2ff3f in qemu_thread_start (args=0x555556e8dd10) at
/home/petmay01/linaro/qemu-from-laptop/qemu/util/qemu-thread-posix.c:519
#20 0x00007ffff0b156db in start_thread (arg=0x7fffd7704700) at
pthread_create.c:463
#21 0x00007ffff083e88f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

So under what circumstances can booke206_tlb_ways()
validly return 0? Should booke206_get_tlbm() cope with a
zero return, or can it assert() that it will never
call booke206_tlb_ways() in a way that will cause one?

thanks
-- PMM

