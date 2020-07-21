Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B89C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5F520657
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRUqVzYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5F520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxoaZ-0007nr-0c
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 05:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxoa0-0007N2-VD
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:28:57 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxoZy-0001JV-WA
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:28:56 -0400
Received: by mail-ot1-x344.google.com with SMTP id 72so14585940otc.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/nNuwzob98wUjqjH7aYmJs9goOw8pREwSlDUGmskXFI=;
 b=HRUqVzYaC+OM11sMqNHSaTepj+BEA8liperTBiNaK+EsT/oYptFYbiEKoCNtYigJlU
 vb8bDqUBSj9AwJwIL1jcAQMRIU1MjDBUu49ZYLWrvp/Kmgc0sOviYMekrhSaPfSLe6WP
 BK0b051MS20Y0xdnZxoNyWlpadGZkkziCqJO+fbAY8BUV4C+/V7b8YkaKZhpXN510UFn
 N5UqhrEudZ4T06tbsLtFlTHwjaxbRvvimfACJh8l3tRq0QzPizxLDbshUihnaFw3cFqP
 Ztdj0AW3zOQ4pnlyg/NSkAz4hf4wDfnUWKGr2erFpaErfTOKNbdRie7OR+TFx5mEw57L
 V/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/nNuwzob98wUjqjH7aYmJs9goOw8pREwSlDUGmskXFI=;
 b=CgNF4IWmX59ekruIkH20Wk+QaA0vJVza1X7NiREPmHfpNWxYW8boojGqIZsmsnmoAY
 2Y6hgzeQ0e/byQt+iY9im4H4Bw2iP9dHmi02ui8QEswPFX7htrT3S8kiPFRtDS89miZ3
 TrgznUkAnH9M9Z3AS55yVrkfIe2ZVrBPvx+nwYuEL5LAufRWPWYNJhzaMGPr7mzUjFHk
 7NMwHnuPbWrM+bY/nqprUEQ9L8nq8LhhsUTgDfM5bKyNlma9aYqZlZ1n+7O/0LYytW3L
 hN0KqcRc+J4Me9BCV+xar9MjUMuVlmyMfIlcm0xegcEN9VsMYlknnOwCwMObauScVqT1
 eYcg==
X-Gm-Message-State: AOAM533/ynSxjr5IWPv0fVypk8TKRK/a9PZ8ZsWhytve0JAQhPqrdeDP
 cv6STvI32zmisycJSi9Q0/yICH7saNswdOyOUE88sA==
X-Google-Smtp-Source: ABdhPJxMFy6MCyRrYcqTit4bUZgttdawTnVFCRQ315HoMC7ISFWicGadtkYLB3ostnvXST6t1VZbc48ejENSDnz04qg=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr24350932oto.135.1595323733571; 
 Tue, 21 Jul 2020 02:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <b19e8210-7cac-e1b5-f89b-ae73ec21d8cb@siemens.com>
In-Reply-To: <b19e8210-7cac-e1b5-f89b-ae73ec21d8cb@siemens.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 10:28:42 +0100
Message-ID: <CAFEAcA-XwoUG+2wy8e404qnSRgy+LpzGph+BO3KKMbOhgmvECA@mail.gmail.com>
Subject: Re: aarch64: Crash with qemu master when starting Jailhouse
To: Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 08:22, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> Hi,
>
> I've seen this first a couple of weeks ago, ignored it, but it's still th=
ere today with master:

Richard, this looks like an issue with your recent rearrangement
of the cacheattrs handling: we get into get_phys_addr_lpae() with
a NULL cacheattrs pointer that we weren't expecting.

> Thread 13 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7f90e2ffd700 (LWP 26883)]
> 0x0000560ef0bddda7 in get_phys_addr_lpae (env=3D<optimized out>, address=
=3Daddress@entry=3D1095261192, access_type=3Daccess_type@entry=3DMMU_DATA_L=
OAD, mmu_idx=3Dmmu_idx@entry=3DARMMMUIdx_Stage2, s1_is_el0=3Ds1_is_el0@entr=
y=3Dfalse,
>     phys_ptr=3Dphys_ptr@entry=3D0x7f90e2ffc200, txattrs=3D0x7f90e2ffc1ec,=
 prot=3D0x7f90e2ffc1f0, page_size_ptr=3D0x7f90e2ffc1f8, fi=3D0x7f90e2ffc530=
, cacheattrs=3D0x0) at /data/qemu/target/arm/helper.c:11106
> 11106           cacheattrs->attrs =3D convert_stage2_attrs(env, extract32=
(attrs, 0, 4));
> (gdb) bt
> #0  0x0000560ef0bddda7 in get_phys_addr_lpae
>     (env=3D<optimized out>, address=3Daddress@entry=3D1095261192, access_=
type=3Daccess_type@entry=3DMMU_DATA_LOAD, mmu_idx=3Dmmu_idx@entry=3DARMMMUI=
dx_Stage2, s1_is_el0=3Ds1_is_el0@entry=3Dfalse, phys_ptr=3Dphys_ptr@entry=
=3D0x7f90e2ffc200, txattrs=3D0x7f90e2ffc1ec, prot=3D0x7f90e2ffc1f0, page_si=
ze_ptr=3D0x7f90e2ffc1f8, fi=3D0x7f90e2ffc530, cacheattrs=3D0x0) at /data/qe=
mu/target/arm/helper.c:11106
> #1  0x0000560ef0bde3c6 in S1_ptw_translate (env=3Denv@entry=3D0x560ef3274=
2b0, mmu_idx=3Dmmu_idx@entry=3DARMMMUIdx_Stage1_E1, addr=3D1095261192, txat=
trs=3D..., fi=3Dfi@entry=3D0x7f90e2ffc530) at /data/qemu/target/arm/helper.=
c:10218
> #2  0x0000560ef0bdd7f0 in arm_ldq_ptw (fi=3D0x7f90e2ffc530, mmu_idx=3DARM=
MMUIdx_Stage1_E1, is_secure=3Dfalse, addr=3D<optimized out>, cs=3D0x560ef32=
6ac10) at /data/qemu/target/arm/helper.c:10284
> #3  0x0000560ef0bdd7f0 in get_phys_addr_lpae
>     (env=3Denv@entry=3D0x560ef32742b0, address=3Daddress@entry=3D18446674=
270391351284, access_type=3Daccess_type@entry=3DMMU_INST_FETCH, mmu_idx=3Dm=
mu_idx@entry=3DARMMMUIdx_Stage1_E1, s1_is_el0=3Ds1_is_el0@entry=3Dfalse, ph=
ys_ptr=3Dphys_ptr@entry=3D0x7f90e2ffc490, txattrs=3D0x7f90e2ffc518, prot=3D=
0x7f90e2ffc514, page_size_ptr=3D0x7f90e2ffc528, fi=3D0x7f90e2ffc530, cachea=
ttrs=3D0x7f90e2ffc51c) at /data/qemu/target/arm/helper.c:11014
> #4  0x0000560ef0bdfacb in get_phys_addr (env=3Denv@entry=3D0x560ef32742b0=
, address=3D<optimized out>, address@entry=3D18446674270391351284, access_t=
ype=3Daccess_type@entry=3DMMU_INST_FETCH, mmu_idx=3D<optimized out>,
>     mmu_idx@entry=3DARMMMUIdx_Stage1_E1, phys_ptr=3Dphys_ptr@entry=3D0x7f=
90e2ffc490, attrs=3Dattrs@entry=3D0x7f90e2ffc518, prot=3D0x7f90e2ffc514, pa=
ge_size=3D0x7f90e2ffc528, fi=3D0x7f90e2ffc530, cacheattrs=3D0x7f90e2ffc51c)
>     at /data/qemu/target/arm/helper.c:12115
> #5  0x0000560ef0bdf5ca in get_phys_addr
>     (env=3Denv@entry=3D0x560ef32742b0, address=3Daddress@entry=3D18446674=
270391351284, access_type=3Daccess_type@entry=3DMMU_INST_FETCH, mmu_idx=3D<=
optimized out>, phys_ptr=3Dphys_ptr@entry=3D0x7f90e2ffc520, attrs=3Dattrs@e=
ntry=3D0x7f90e2ffc518, prot=3D0x7f90e2ffc514, page_size=3D0x7f90e2ffc528, f=
i=3D0x7f90e2ffc530, cacheattrs=3D0x7f90e2ffc51c) at /data/qemu/target/arm/h=
elper.c:11950
> #6  0x0000560ef0bef669 in arm_cpu_tlb_fill (cs=3D0x560ef326ac10, address=
=3D18446674270391351284, size=3D<optimized out>, access_type=3DMMU_INST_FET=
CH, mmu_idx=3D2, probe=3D<optimized out>, retaddr=3D0) at /data/qemu/target=
/arm/tlb_helper.c:177
> #7  0x0000560ef0adbd85 in tlb_fill (cpu=3D0x560ef326ac10, addr=3D18446674=
270391351284, size=3D0, access_type=3DMMU_INST_FETCH, mmu_idx=3D2, retaddr=
=3D0) at /data/qemu/accel/tcg/cputlb.c:1032
> #8  0x0000560ef0adf216 in get_page_addr_code_hostp (env=3D<optimized out>=
, addr=3Daddr@entry=3D18446674270391351284, hostp=3Dhostp@entry=3D0x0) at /=
data/qemu/accel/tcg/cputlb.c:1211
> #9  0x0000560ef0adf287 in get_page_addr_code (env=3D<optimized out>, addr=
=3Daddr@entry=3D18446674270391351284) at /data/qemu/accel/tcg/cputlb.c:1243
> #10 0x0000560ef0af21c4 in tb_htable_lookup (cpu=3Dcpu@entry=3D0x560ef326a=
c10, pc=3D18446674270391351284, cs_base=3D<optimized out>, flags=3D21821071=
37, cf_mask=3D4278714368) at /data/qemu/accel/tcg/cpu-exec.c:337
> #11 0x0000560ef0af2fd6 in tb_lookup__cpu_state (cf_mask=3D<optimized out>=
, flags=3D0x7f90e2ffc718, cs_base=3D0x7f90e2ffc720, pc=3D0x7f90e2ffc728, cp=
u=3D0x0) at /data/qemu/include/exec/tb-lookup.h:43
> #12 0x0000560ef0af2fd6 in tb_find (cf_mask=3D524288, tb_exit=3D0, last_tb=
=3D0x0, cpu=3D0x0) at /data/qemu/accel/tcg/cpu-exec.c:404
> #13 0x0000560ef0af2fd6 in cpu_exec (cpu=3Dcpu@entry=3D0x560ef326ac10) at =
/data/qemu/accel/tcg/cpu-exec.c:748
> #14 0x0000560ef0bb779f in tcg_cpu_exec (cpu=3D0x560ef326ac10) at /data/qe=
mu/softmmu/cpus.c:1356
> #15 0x0000560ef0bb980b in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x560=
ef326ac10) at /data/qemu/softmmu/cpus.c:1664
> #16 0x0000560ef10aaf76 in qemu_thread_start (args=3D<optimized out>) at /=
data/qemu/util/qemu-thread-posix.c:521
> #17 0x00007f919e9434f9 in start_thread () at /lib64/libpthread.so.0
> #18 0x00007f919e67bf2f in clone () at /lib64/libc.so.6
>
> I've reproduced that with a local Jailhouse installation, but I suspect
> (do not have the time right now to check) that a vanilla jailhouse-
> images [1] build for qemu-arm64 will trigger it as well. Once time
> permits, I could try to generate and share such an image.
>
> qemu 3.1.1.1 of my distro is fine, also f4d8cf148e43.
>
> Any ideas?
>
> Jan
>
> [1] https://github.com/siemens/jailhouse-images

thanks
-- PMM

