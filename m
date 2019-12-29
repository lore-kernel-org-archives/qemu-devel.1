Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47847C2D0CE
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 15:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012332071E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 15:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo5hGigP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012332071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilaNT-0004zb-1I
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 10:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ilaMX-0004V8-Pd
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 10:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ilaMU-0007B5-6Q
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 10:20:13 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ilaMT-000764-QJ
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 10:20:10 -0500
Received: by mail-ot1-x341.google.com with SMTP id k16so38483829otb.2
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 07:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=SsvcxihDIrQNiNsy0fbrUbqVYY3Rx3Qt26NA1y7JJZc=;
 b=fo5hGigP/qCygW8+iNMYp40j1P7MUw3Zx90XgwxoFgzvtHVYyydFQgh6KUC/+0jt5M
 567Aty/+i9hVheDyrtNjDvk38PkBzwLTiHttmzPeYJpGwW2vJ+sc6Pr0TQtfJIRJP4tF
 0jmN9GrP3Ep5Lb6/1qFQRLacZ95hOsxE/AV3wXKfJ8xeYiBhloUSG+6cekCl4t5JZNOP
 65jN8azbPNhJ3qneFHfFthid45WAow8Kk7E+vKXri9cVTI/U0yV5kxYVKbVMlVHc5BkT
 qYCsaeSobR3MKhx3qaMIBDmSriHPVVXCa3x9ksdW+aLQfDTs0CzxJX3xPfvpqbasNH8M
 uLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=SsvcxihDIrQNiNsy0fbrUbqVYY3Rx3Qt26NA1y7JJZc=;
 b=Swn/iCoMXicuXsIVZgAvQ1UN49qc5giPTssRGWOQe5PJtAEJ8MoZ1er5iBxX6N0Raq
 3WN52/hrIjHFF6DQ/gU/jPWGgRk62GBJ8ZwHLf5Y9Ggrzvqswiz490hjH1Vk/hsXxXI6
 2BVMVAM/HQmfMG/ROysc9XAN2rRwzcMS8aQhYnIrxi+7bHxZQ+2MgGoexIDSVRkytlcx
 JVsp7A95LZsHVc9bRRXITGs5p8mbTn1qZdjEAvWgrrHgf3U6TmBYhaxDxqj1IoG2BEzh
 jOrYJ3HNytUDYtYtdbe8o/KGRECPAAQuntZ71yMZDgPAlYW73lwQ3a8zRdFPXLJyijYz
 GzcQ==
X-Gm-Message-State: APjAAAXM7LT86dSIxcSrlMBuch6zi8ZsIlmGjx996sG1uqkbBgiYmlSg
 v2fgpF6wjdTIBZ8ycPmJ7ZU+L2cMLtV2013qJLE=
X-Google-Smtp-Source: APXvYqyaNZ4C6DIRXRaDa8ELI58QiNN4zorR0G6LZ1GW30lUrq/4exmwLdVqHdUvIOBesGIqdadxVPN8poPvD5Gy8rI=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr69209463otp.306.1577632808845; 
 Sun, 29 Dec 2019 07:20:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sun, 29 Dec 2019 07:20:08 -0800 (PST)
In-Reply-To: <20191228231124.18307-14-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
 <20191228231124.18307-14-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 29 Dec 2019 16:20:08 +0100
Message-ID: <CAL1e-=ij8_1GqT-wxLkkfbQ+gKrFXmx5EJxLFDwJjx4F5rYDbg@mail.gmail.com>
Subject: Re: [PATCH v3 13/29] cputlb: Provide cpu_(ld,
 st}*_mmuidx_ra for user-only
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002844ff059ad943c8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002844ff059ad943c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, December 29, 2019, Richard Henderson <
richard.henderson@linaro.org> wrote:

> This finishes the new interface began with the previous patch.
> Document the interface and deprecate MMU_MODE<N>_SUFFIX.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu_ldst.h     |  80 +++++++++++++-
>  docs/devel/loads-stores.rst | 211 ++++++++++++++++++++++++++----------
>  2 files changed, 230 insertions(+), 61 deletions(-)
>
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index ef59ed61e4..41b98ba801 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -25,9 +25,13 @@
>   *
>   * The syntax for the accessors is:
>   *
> - * load: cpu_ld{sign}{size}_{mmusuffix}(env, ptr)
> + * load:  cpu_ld{sign}{size}_{mmusuffix}(env, ptr)
> + *        cpu_ld{sign}{size}_{mmusuffix}_ra(env, ptr, retaddr)
> + *        cpu_ld{sign}{size}_mmuidx_ra(env, ptr, mmu_idx, retaddr)
>   *
> - * store: cpu_st{sign}{size}_{mmusuffix}(env, ptr, val)
> + * store: cpu_st{size}_{mmusuffix}(env, ptr, val)
> + *        cpu_st{size}_{mmusuffix}_ra(env, ptr, val, retaddr)
> + *        cpu_st{size}_mmuidx_ra(env, ptr, val, mmu_idx, retaddr)
>   *
>   * sign is:
>   * (empty): for 32 and 64 bit sizes
> @@ -40,9 +44,10 @@
>   *   l: 32 bits
>   *   q: 64 bits
>   *
> - * mmusuffix is one of the generic suffixes "data" or "code", or
> - * (for softmmu configs)  a target-specific MMU mode suffix as defined
> - * in target cpu.h.
> + * mmusuffix is one of the generic suffixes "data" or "code", or "mmuidx=
".
> + * The "mmuidx" suffix carries an extra mmu_idx argument that specifies
> + * the index to use; the "data" and "code" suffixes take the index from
> + * cpu_mmu_index().
>   */
>  #ifndef CPU_LDST_H
>  #define CPU_LDST_H
> @@ -145,6 +150,71 @@ static inline void clear_helper_retaddr(void)
>  #undef MEMSUFFIX
>  #undef CODE_ACCESS
>
> +/*
> + * Provide the same *_mmuidx_ra interface as for softmmu.
> + * The mmu_idx argument is ignored.
> + */
> +
> +static inline uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr
> addr,
> +                                          int mmu_idx, uintptr_t ra)
> +{
> +    return cpu_ldub_data_ra(env, addr, ra);
> +}
> +
> +static inline uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr
> addr,
> +                                          int mmu_idx, uintptr_t ra)
> +{
> +    return cpu_lduw_data_ra(env, addr, ra);
> +}
> +
> +static inline uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr=
,
> +                                         int mmu_idx, uintptr_t ra)
> +{
> +    return cpu_ldl_data_ra(env, addr, ra);
> +}
> +
> +static inline uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr=
,
> +                                         int mmu_idx, uintptr_t ra)
> +{
> +    return cpu_ldq_data_ra(env, addr, ra);
> +}
> +
> +static inline int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                                     int mmu_idx, uintptr_t ra)
> +{
> +    return cpu_ldsb_data_ra(env, addr, ra);
> +}
> +
> +static inline int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                                     int mmu_idx, uintptr_t ra)
> +{
> +    return cpu_ldsw_data_ra(env, addr, ra);
> +}
> +
> +static inline void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                                     uint32_t val, int mmu_idx, uintptr_=
t
> ra)
> +{
> +    cpu_stb_data_ra(env, addr, val, ra);
> +}
> +
> +static inline void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                                     uint32_t val, int mmu_idx, uintptr_=
t
> ra)
> +{
> +    cpu_stw_data_ra(env, addr, val, ra);
> +}
> +
> +static inline void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                                     uint32_t val, int mmu_idx, uintptr_=
t
> ra)
> +{
> +    cpu_stl_data_ra(env, addr, val, ra);
> +}
> +
> +static inline void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                                     uint64_t val, int mmu_idx, uintptr_=
t
> ra)
> +{
> +    cpu_stq_data_ra(env, addr, val, ra);
> +}
> +
>  #else
>
>  /* Needed for TCG_OVERSIZED_GUEST */
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index 8a5bc912a5..03aa9e7ff8 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -72,31 +72,34 @@ Regexes for git grep
>   - ``\<ldn_\([hbl]e\)?_p\>``
>   - ``\<stn_\([hbl]e\)?_p\>``
>
> -``cpu_{ld,st}_*``
> -~~~~~~~~~~~~~~~~~
> +``cpu_{ld,st}*_mmuidx_ra``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -These functions operate on a guest virtual address. Be aware
> -that these functions may cause a guest CPU exception to be
> -taken (e.g. for an alignment fault or MMU fault) which will
> -result in guest CPU state being updated and control longjumping
> -out of the function call. They should therefore only be used
> -in code that is implementing emulation of the target CPU.
> +These functions operate on a guest virtual address plus a context,
> +known as a "mmu index" or ``mmuidx``, which controls how that virtual
> +address is translated.  The meaning of the indexes are target specific,
> +but specifying a particular index might be necessary if, for instance,
> +the helper requires an "always as non-privileged" access rather that
> +the default access for the current state of the guest CPU.
>
> -These functions may throw an exception (longjmp() back out
> -to the top level TCG loop). This means they must only be used
> -from helper functions where the translator has saved all
> -necessary CPU state before generating the helper function call.
> -It's usually better to use the ``_ra`` variants described below
> -from helper functions, but these functions are the right choice
> -for calls made from hooks like the CPU do_interrupt hook or
> -when you know for certain that the translator had to save all
> -the CPU state that ``cpu_restore_state()`` would restore anyway.
> +These functions may cause a guest CPU exception to be taken
> +(e.g. for an alignment fault or MMU fault) which will result in
> +guest CPU state being updated and control longjmp'ing out of the
> +function call.  They should therefore only be used in code that is
> +implementing emulation of the guest CPU.
> +
> +The ``retaddr`` parameter is used to control unwinding of the
> +guest CPU state in case of a guest CPU exception.  This is passed
> +to ``cpu_restore_state()``.  Therefore the value should either be 0,
> +to indicate that the guest CPU state is already synchronized, or
> +the result of ``GETPC()`` from the top level ``HELPER(foo)``
> +function, which is a return address into the generated code.
>
>  Function names follow the pattern:
>
> -load: ``cpu_ld{sign}{size}_{mmusuffix}(env, ptr)``
> +load: ``cpu_ld{sign}{size}_mmuidx_ra(env, ptr, mmuidx, retaddr)``
>
> -store: ``cpu_st{size}_{mmusuffix}(env, ptr, val)``
> +store: ``cpu_st{size}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
>
>  ``sign``
>   - (empty) : for 32 or 64 bit sizes
> @@ -109,56 +112,151 @@ store: ``cpu_st{size}_{mmusuffix}(env, ptr, val)``
>   - ``l`` : 32 bits
>   - ``q`` : 64 bits
>
> -``mmusuffix`` is one of the generic suffixes ``data`` or ``code``, or
> -(for softmmu configs) a target-specific MMU mode suffix as defined
> -in the target's ``cpu.h``.
> +Regexes for git grep:
> + - ``\<cpu_ld[us]\?[bwlq]_mmuidx_ra\>``
> + - ``\<cpu_st[bwlq]_mmuidx_ra\>``
>
> -Regexes for git grep
> - - ``\<cpu_ld[us]\?[bwlq]_[a-zA-Z0-9]\+\>``
> - - ``\<cpu_st[bwlq]_[a-zA-Z0-9]\+\>``
> +``cpu_{ld,st}*_data_ra``
> +~~~~~~~~~~~~~~~~~~~~~~~~
>
> -``cpu_{ld,st}_*_ra``
> -~~~~~~~~~~~~~~~~~~~~
> -
> -These functions work like the ``cpu_{ld,st}_*`` functions except
> -that they also take a ``retaddr`` argument. This extra argument
> -allows for correct unwinding of any exception that is taken,
> -and should generally be the result of GETPC() called directly
> -from the top level HELPER(foo) function (i.e. the return address
> -in the generated code).
> +These functions work like the ``cpu_{ld,st}_mmuidx_ra`` functions
> +except that the ``mmuidx`` parameter is taken from the current mode
> +of the guest CPU, as determined by ``cpu_mmu_index(env, false)``.
>
>  These are generally the preferred way to do accesses by guest
> -virtual address from helper functions; see the documentation
> -of the non-``_ra`` variants for when those would be better.
> -
> -Calling these functions with a ``retaddr`` argument of 0 is
> -equivalent to calling the non-``_ra`` version of the function.
> +virtual address from helper functions, unless the access should
> +be performed with a context other than the default.
>
>  Function names follow the pattern:
>
> -load: ``cpu_ld{sign}{size}_{mmusuffix}_ra(env, ptr, retaddr)``
> +load: ``cpu_ld{sign}{size}_data_ra(env, ptr, ra)``
>
> -store: ``cpu_st{sign}{size}_{mmusuffix}_ra(env, ptr, val, retaddr)``
> +store: ``cpu_st{size}_data_ra(env, ptr, val, ra)``
> +
> +``sign``
> + - (empty) : for 32 or 64 bit sizes
> + - ``u`` : unsigned
> + - ``s`` : signed
> +
> +``size``
> + - ``b`` : 8 bits
> + - ``w`` : 16 bits
> + - ``l`` : 32 bits
> + - ``q`` : 64 bits
> +
> +Regexes for git grep:
> + - ``\<cpu_ld[us]\?[bwlq]_data_ra\>``
> + - ``\<cpu_st[bwlq]_data_ra\>``
> +
> +``cpu_{ld,st}*_data``
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +These functions work like the ``cpu_{ld,st}_data_ra`` functions
> +except that the ``retaddr`` parameter is 0, and thus does not
> +unwind guest CPU state.
> +
> +This means they must only be used from helper functions where the
> +translator has saved all necessary CPU state.  These functions are
> +the right choice for calls made from hooks like the CPU ``do_interrupt``
> +hook or when you know for certain that the translator had to save all
> +the CPU state anyway.
> +
> +Function names follow the pattern:
> +
> +load: ``cpu_ld{sign}{size}_data(env, ptr)``
> +
> +store: ``cpu_st{size}_data(env, ptr, val)``
> +
> +``sign``
> + - (empty) : for 32 or 64 bit sizes
> + - ``u`` : unsigned
> + - ``s`` : signed
> +
> +``size``
> + - ``b`` : 8 bits
> + - ``w`` : 16 bits
> + - ``l`` : 32 bits
> + - ``q`` : 64 bits
>
>  Regexes for git grep
> - - ``\<cpu_ld[us]\?[bwlq]_[a-zA-Z0-9]\+_ra\>``
> - - ``\<cpu_st[bwlq]_[a-zA-Z0-9]\+_ra\>``
> + - ``\<cpu_ld[us]\?[bwlq]_data\>``
> + - ``\<cpu_st[bwlq]_data\+\>``
>
> -``helper_*_{ld,st}*mmu``
> -~~~~~~~~~~~~~~~~~~~~~~~~
> +``cpu_ld*_code``
> +~~~~~~~~~~~~~~~~
> +
> +These functions perform a read for instruction execution.  The ``mmuidx`=
`
> +parameter is taken from the current mode of the guest CPU, as determined
> +by ``cpu_mmu_index(env, true)``.  The ``retaddr`` parameter is 0, and
> +thus does not unwind guest CPU state, because CPU state is always
> +synchronized while translating instructions.  Any guest CPU exception
> +that is raised will indicate an instruction execution fault rather than
> +a data read fault.
> +
> +In general these functions should not be used directly during translatio=
n.
> +There are wrapper functions that are to be used which also take care of
> +plugins for tracing.
> +
> +Function names follow the pattern:
> +
> +load: ``cpu_ld{sign}{size}_code(env, ptr)``
> +
> +``sign``
> + - (empty) : for 32 or 64 bit sizes
> + - ``u`` : unsigned
> + - ``s`` : signed
> +
> +``size``
> + - ``b`` : 8 bits
> + - ``w`` : 16 bits
> + - ``l`` : 32 bits
> + - ``q`` : 64 bits
> +
> +Regexes for git grep:
> + - ``\<cpu_ld[us]\?[bwlq]_code\>``
> +
> +``translator_ld*``
> +~~~~~~~~~~~~~~~~~~
> +
> +These functions are a wrapper for ``cpu_ld*_code`` which also perform
> +any actions required by any tracing plugins.  They are only to be
> +called during the translator callback ``translate_insn``.
> +
> +There is a set of functions ending in ``_swap`` which, if the parameter
> +is true, returns the value in the endianness that is the reverse of
> +the guest native endianness, as determined by ``TARGET_WORDS_BIGENDIAN``=
.
> +
> +Function names follow the pattern:
> +
> +load: ``translator_ld{sign}{size}(env, ptr)``
> +
> +swap: ``translator_ld{sign}{size}_swap(env, ptr, swap)``
> +
> +``sign``
> + - (empty) : for 32 or 64 bit sizes
> + - ``u`` : unsigned
> + - ``s`` : signed
> +
> +``size``
> + - ``b`` : 8 bits
> + - ``w`` : 16 bits
> + - ``l`` : 32 bits
> + - ``q`` : 64 bits
> +
> +Regexes for git grep
> + - ``\<translator_ld[us]\?[bwlq]\(_swap\)\?\>``
> +
> +``helper_*_{ld,st}*_mmu``
> +~~~~~~~~~~~~~~~~~~~~~~~~~
>
>  These functions are intended primarily to be called by the code
>  generated by the TCG backend. They may also be called by target
> -CPU helper function code. Like the ``cpu_{ld,st}_*_ra`` functions
> -they perform accesses by guest virtual address; the difference is
> -that these functions allow you to specify an ``opindex`` parameter
> -which encodes (among other things) the mmu index to use for the
> -access. This is necessary if your helper needs to make an access
> -via a specific mmu index (for instance, an "always as non-privileged"
> -access) rather than using the default mmu index for the current state
> -of the guest CPU.
> +CPU helper function code. Like the ``cpu_{ld,st}_mmuidx_ra`` functions
> +they perform accesses by guest virtual address, with a given ``mmuidx``.
>
> -The ``opindex`` parameter should be created by calling
> ``make_memop_idx()``.
> +These functions specify an ``opindex`` parameter which encodes
> +(among other things) the mmu index to use for the access.  This paramete=
r
> +should be created by calling ``make_memop_idx()``.
>
>  The ``retaddr`` parameter should be the result of GETPC() called directl=
y
>  from the top level HELPER(foo) function (or 0 if no guest CPU state
> @@ -166,8 +264,9 @@ unwinding is required).
>
>  **TODO** The names of these functions are a bit odd for historical
>  reasons because they were originally expected to be called only from
> -within generated code. We should rename them to bring them
> -more in line with the other memory access functions.
> +within generated code. We should rename them to bring them more in
> +line with the other memory access functions. The explicit endianness
> +is the only feature they have beyond ``*_mmuidx_ra``.
>
>  load: ``helper_{endian}_ld{sign}{size}_mmu(env, addr, opindex, retaddr)`=
`
>
> --
> 2.20.1
>
>
>

--0000000000002844ff059ad943c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 29, 2019, Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">This finishes the new interface began w=
ith the previous patch.<br>
Document the interface and deprecate MMU_MODE&lt;N&gt;_SUFFIX.<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
>alex.bennee@linaro.org</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/exec/cpu_ldst.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 80 +++++++++++++-<=
br>
=C2=A0docs/devel/loads-stores.rst | 211 ++++++++++++++++++++++++++----<wbr>=
------<br>
=C2=A02 files changed, 230 insertions(+), 61 deletions(-)<br>
<br></blockquote><div><br></div><div><br></div><div><span style=3D"color:rg=
b(34,34,34);font-size:14px;line-height:22.1200008392334px">Reviewed-by: Ale=
ksandar Markovic &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=
=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.com</=
a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000083=
92334px">&gt;</span></div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h<br>
index ef59ed61e4..41b98ba801 100644<br>
--- a/include/exec/cpu_ldst.h<br>
+++ b/include/exec/cpu_ldst.h<br>
@@ -25,9 +25,13 @@<br>
=C2=A0 *<br>
=C2=A0 * The syntax for the accessors is:<br>
=C2=A0 *<br>
- * load: cpu_ld{sign}{size}_{mmusuffix}<wbr>(env, ptr)<br>
+ * load:=C2=A0 cpu_ld{sign}{size}_{mmusuffix}<wbr>(env, ptr)<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_ld{sign}{size}_{mmusuffix}<wbr>_ra(env, =
ptr, retaddr)<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_ld{sign}{size}_mmuidx_ra(<wbr>env, ptr, =
mmu_idx, retaddr)<br>
=C2=A0 *<br>
- * store: cpu_st{sign}{size}_{mmusuffix}<wbr>(env, ptr, val)<br>
+ * store: cpu_st{size}_{mmusuffix}(env, ptr, val)<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_st{size}_{mmusuffix}_ra(<wbr>env, ptr, v=
al, retaddr)<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_st{size}_mmuidx_ra(env, ptr, val, mmu_id=
x, retaddr)<br>
=C2=A0 *<br>
=C2=A0 * sign is:<br>
=C2=A0 * (empty): for 32 and 64 bit sizes<br>
@@ -40,9 +44,10 @@<br>
=C2=A0 *=C2=A0 =C2=A0l: 32 bits<br>
=C2=A0 *=C2=A0 =C2=A0q: 64 bits<br>
=C2=A0 *<br>
- * mmusuffix is one of the generic suffixes &quot;data&quot; or &quot;code=
&quot;, or<br>
- * (for softmmu configs)=C2=A0 a target-specific MMU mode suffix as define=
d<br>
- * in target cpu.h.<br>
+ * mmusuffix is one of the generic suffixes &quot;data&quot; or &quot;code=
&quot;, or &quot;mmuidx&quot;.<br>
+ * The &quot;mmuidx&quot; suffix carries an extra mmu_idx argument that sp=
ecifies<br>
+ * the index to use; the &quot;data&quot; and &quot;code&quot; suffixes ta=
ke the index from<br>
+ * cpu_mmu_index().<br>
=C2=A0 */<br>
=C2=A0#ifndef CPU_LDST_H<br>
=C2=A0#define CPU_LDST_H<br>
@@ -145,6 +150,71 @@ static inline void clear_helper_retaddr(void)<br>
=C2=A0#undef MEMSUFFIX<br>
=C2=A0#undef CODE_ACCESS<br>
<br>
+/*<br>
+ * Provide the same *_mmuidx_ra interface as for softmmu.<br>
+ * The mmu_idx argument is ignored.<br>
+ */<br>
+<br>
+static inline uint32_t cpu_ldub_mmuidx_ra(<wbr>CPUArchState *env, abi_ptr =
addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
nt mmu_idx, uintptr_t ra)<br>
+{<br>
+=C2=A0 =C2=A0 return cpu_ldub_data_ra(env, addr, ra);<br>
+}<br>
+<br>
+static inline uint32_t cpu_lduw_mmuidx_ra(<wbr>CPUArchState *env, abi_ptr =
addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
nt mmu_idx, uintptr_t ra)<br>
+{<br>
+=C2=A0 =C2=A0 return cpu_lduw_data_ra(env, addr, ra);<br>
+}<br>
+<br>
+static inline uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t mmu_idx, uintptr_t ra)<br>
+{<br>
+=C2=A0 =C2=A0 return cpu_ldl_data_ra(env, addr, ra);<br>
+}<br>
+<br>
+static inline uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t mmu_idx, uintptr_t ra)<br>
+{<br>
+=C2=A0 =C2=A0 return cpu_ldq_data_ra(env, addr, ra);<br>
+}<br>
+<br>
+static inline int cpu_ldsb_mmuidx_ra(<wbr>CPUArchState *env, abi_ptr addr,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mmu_idx, uin=
tptr_t ra)<br>
+{<br>
+=C2=A0 =C2=A0 return cpu_ldsb_data_ra(env, addr, ra);<br>
+}<br>
+<br>
+static inline int cpu_ldsw_mmuidx_ra(<wbr>CPUArchState *env, abi_ptr addr,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mmu_idx, uin=
tptr_t ra)<br>
+{<br>
+=C2=A0 =C2=A0 return cpu_ldsw_data_ra(env, addr, ra);<br>
+}<br>
+<br>
+static inline void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t val, in=
t mmu_idx, uintptr_t ra)<br>
+{<br>
+=C2=A0 =C2=A0 cpu_stb_data_ra(env, addr, val, ra);<br>
+}<br>
+<br>
+static inline void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t val, in=
t mmu_idx, uintptr_t ra)<br>
+{<br>
+=C2=A0 =C2=A0 cpu_stw_data_ra(env, addr, val, ra);<br>
+}<br>
+<br>
+static inline void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t val, in=
t mmu_idx, uintptr_t ra)<br>
+{<br>
+=C2=A0 =C2=A0 cpu_stl_data_ra(env, addr, val, ra);<br>
+}<br>
+<br>
+static inline void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val, in=
t mmu_idx, uintptr_t ra)<br>
+{<br>
+=C2=A0 =C2=A0 cpu_stq_data_ra(env, addr, val, ra);<br>
+}<br>
+<br>
=C2=A0#else<br>
<br>
=C2=A0/* Needed for TCG_OVERSIZED_GUEST */<br>
diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst<br>
index 8a5bc912a5..03aa9e7ff8 100644<br>
--- a/docs/devel/loads-stores.rst<br>
+++ b/docs/devel/loads-stores.rst<br>
@@ -72,31 +72,34 @@ Regexes for git grep<br>
=C2=A0 - ``\&lt;ldn_\([hbl]e\)?_p\&gt;``<br>
=C2=A0 - ``\&lt;stn_\([hbl]e\)?_p\&gt;``<br>
<br>
-``cpu_{ld,st}_*``<br>
-~~~~~~~~~~~~~~~~~<br>
+``cpu_{ld,st}*_mmuidx_ra``<br>
+~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
-These functions operate on a guest virtual address. Be aware<br>
-that these functions may cause a guest CPU exception to be<br>
-taken (e.g. for an alignment fault or MMU fault) which will<br>
-result in guest CPU state being updated and control longjumping<br>
-out of the function call. They should therefore only be used<br>
-in code that is implementing emulation of the target CPU.<br>
+These functions operate on a guest virtual address plus a context,<br>
+known as a &quot;mmu index&quot; or ``mmuidx``, which controls how that vi=
rtual<br>
+address is translated.=C2=A0 The meaning of the indexes are target specifi=
c,<br>
+but specifying a particular index might be necessary if, for instance,<br>
+the helper requires an &quot;always as non-privileged&quot; access rather =
that<br>
+the default access for the current state of the guest CPU.<br>
<br>
-These functions may throw an exception (longjmp() back out<br>
-to the top level TCG loop). This means they must only be used<br>
-from helper functions where the translator has saved all<br>
-necessary CPU state before generating the helper function call.<br>
-It&#39;s usually better to use the ``_ra`` variants described below<br>
-from helper functions, but these functions are the right choice<br>
-for calls made from hooks like the CPU do_interrupt hook or<br>
-when you know for certain that the translator had to save all<br>
-the CPU state that ``cpu_restore_state()`` would restore anyway.<br>
+These functions may cause a guest CPU exception to be taken<br>
+(e.g. for an alignment fault or MMU fault) which will result in<br>
+guest CPU state being updated and control longjmp&#39;ing out of the<br>
+function call.=C2=A0 They should therefore only be used in code that is<br=
>
+implementing emulation of the guest CPU.<br>
+<br>
+The ``retaddr`` parameter is used to control unwinding of the<br>
+guest CPU state in case of a guest CPU exception.=C2=A0 This is passed<br>
+to ``cpu_restore_state()``.=C2=A0 Therefore the value should either be 0,<=
br>
+to indicate that the guest CPU state is already synchronized, or<br>
+the result of ``GETPC()`` from the top level ``HELPER(foo)``<br>
+function, which is a return address into the generated code.<br>
<br>
=C2=A0Function names follow the pattern:<br>
<br>
-load: ``cpu_ld{sign}{size}_{<wbr>mmusuffix}(env, ptr)``<br>
+load: ``cpu_ld{sign}{size}_mmuidx_<wbr>ra(env, ptr, mmuidx, retaddr)``<br>
<br>
-store: ``cpu_st{size}_{mmusuffix}(<wbr>env, ptr, val)``<br>
+store: ``cpu_st{size}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``<br>
<br>
=C2=A0``sign``<br>
=C2=A0 - (empty) : for 32 or 64 bit sizes<br>
@@ -109,56 +112,151 @@ store: ``cpu_st{size}_{mmusuffix}(<wbr>env, ptr, val=
)``<br>
=C2=A0 - ``l`` : 32 bits<br>
=C2=A0 - ``q`` : 64 bits<br>
<br>
-``mmusuffix`` is one of the generic suffixes ``data`` or ``code``, or<br>
-(for softmmu configs) a target-specific MMU mode suffix as defined<br>
-in the target&#39;s ``cpu.h``.<br>
+Regexes for git grep:<br>
+ - ``\&lt;cpu_ld[us]\?[bwlq]_mmuidx_<wbr>ra\&gt;``<br>
+ - ``\&lt;cpu_st[bwlq]_mmuidx_ra\&gt;``<br>
<br>
-Regexes for git grep<br>
- - ``\&lt;cpu_ld[us]\?[bwlq]_[a-zA-<wbr>Z0-9]\+\&gt;``<br>
- - ``\&lt;cpu_st[bwlq]_[a-zA-Z0-9]\+<wbr>\&gt;``<br>
+``cpu_{ld,st}*_data_ra``<br>
+~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
-``cpu_{ld,st}_*_ra``<br>
-~~~~~~~~~~~~~~~~~~~~<br>
-<br>
-These functions work like the ``cpu_{ld,st}_*`` functions except<br>
-that they also take a ``retaddr`` argument. This extra argument<br>
-allows for correct unwinding of any exception that is taken,<br>
-and should generally be the result of GETPC() called directly<br>
-from the top level HELPER(foo) function (i.e. the return address<br>
-in the generated code).<br>
+These functions work like the ``cpu_{ld,st}_mmuidx_ra`` functions<br>
+except that the ``mmuidx`` parameter is taken from the current mode<br>
+of the guest CPU, as determined by ``cpu_mmu_index(env, false)``.<br>
<br>
=C2=A0These are generally the preferred way to do accesses by guest<br>
-virtual address from helper functions; see the documentation<br>
-of the non-``_ra`` variants for when those would be better.<br>
-<br>
-Calling these functions with a ``retaddr`` argument of 0 is<br>
-equivalent to calling the non-``_ra`` version of the function.<br>
+virtual address from helper functions, unless the access should<br>
+be performed with a context other than the default.<br>
<br>
=C2=A0Function names follow the pattern:<br>
<br>
-load: ``cpu_ld{sign}{size}_{<wbr>mmusuffix}_ra(env, ptr, retaddr)``<br>
+load: ``cpu_ld{sign}{size}_data_ra(<wbr>env, ptr, ra)``<br>
<br>
-store: ``cpu_st{sign}{size}_{<wbr>mmusuffix}_ra(env, ptr, val, retaddr)``<=
br>
+store: ``cpu_st{size}_data_ra(env, ptr, val, ra)``<br>
+<br>
+``sign``<br>
+ - (empty) : for 32 or 64 bit sizes<br>
+ - ``u`` : unsigned<br>
+ - ``s`` : signed<br>
+<br>
+``size``<br>
+ - ``b`` : 8 bits<br>
+ - ``w`` : 16 bits<br>
+ - ``l`` : 32 bits<br>
+ - ``q`` : 64 bits<br>
+<br>
+Regexes for git grep:<br>
+ - ``\&lt;cpu_ld[us]\?[bwlq]_data_<wbr>ra\&gt;``<br>
+ - ``\&lt;cpu_st[bwlq]_data_ra\&gt;``<br>
+<br>
+``cpu_{ld,st}*_data``<br>
+~~~~~~~~~~~~~~~~~~~~~<br>
+<br>
+These functions work like the ``cpu_{ld,st}_data_ra`` functions<br>
+except that the ``retaddr`` parameter is 0, and thus does not<br>
+unwind guest CPU state.<br>
+<br>
+This means they must only be used from helper functions where the<br>
+translator has saved all necessary CPU state.=C2=A0 These functions are<br=
>
+the right choice for calls made from hooks like the CPU ``do_interrupt``<b=
r>
+hook or when you know for certain that the translator had to save all<br>
+the CPU state anyway.<br>
+<br>
+Function names follow the pattern:<br>
+<br>
+load: ``cpu_ld{sign}{size}_data(env, ptr)``<br>
+<br>
+store: ``cpu_st{size}_data(env, ptr, val)``<br>
+<br>
+``sign``<br>
+ - (empty) : for 32 or 64 bit sizes<br>
+ - ``u`` : unsigned<br>
+ - ``s`` : signed<br>
+<br>
+``size``<br>
+ - ``b`` : 8 bits<br>
+ - ``w`` : 16 bits<br>
+ - ``l`` : 32 bits<br>
+ - ``q`` : 64 bits<br>
<br>
=C2=A0Regexes for git grep<br>
- - ``\&lt;cpu_ld[us]\?[bwlq]_[a-zA-<wbr>Z0-9]\+_ra\&gt;``<br>
- - ``\&lt;cpu_st[bwlq]_[a-zA-Z0-9]\+<wbr>_ra\&gt;``<br>
+ - ``\&lt;cpu_ld[us]\?[bwlq]_data\&gt;`<wbr>`<br>
+ - ``\&lt;cpu_st[bwlq]_data\+\&gt;``<br>
<br>
-``helper_*_{ld,st}*mmu``<br>
-~~~~~~~~~~~~~~~~~~~~~~~~<br>
+``cpu_ld*_code``<br>
+~~~~~~~~~~~~~~~~<br>
+<br>
+These functions perform a read for instruction execution.=C2=A0 The ``mmui=
dx``<br>
+parameter is taken from the current mode of the guest CPU, as determined<b=
r>
+by ``cpu_mmu_index(env, true)``.=C2=A0 The ``retaddr`` parameter is 0, and=
<br>
+thus does not unwind guest CPU state, because CPU state is always<br>
+synchronized while translating instructions.=C2=A0 Any guest CPU exception=
<br>
+that is raised will indicate an instruction execution fault rather than<br=
>
+a data read fault.<br>
+<br>
+In general these functions should not be used directly during translation.=
<br>
+There are wrapper functions that are to be used which also take care of<br=
>
+plugins for tracing.<br>
+<br>
+Function names follow the pattern:<br>
+<br>
+load: ``cpu_ld{sign}{size}_code(env, ptr)``<br>
+<br>
+``sign``<br>
+ - (empty) : for 32 or 64 bit sizes<br>
+ - ``u`` : unsigned<br>
+ - ``s`` : signed<br>
+<br>
+``size``<br>
+ - ``b`` : 8 bits<br>
+ - ``w`` : 16 bits<br>
+ - ``l`` : 32 bits<br>
+ - ``q`` : 64 bits<br>
+<br>
+Regexes for git grep:<br>
+ - ``\&lt;cpu_ld[us]\?[bwlq]_code\&gt;`<wbr>`<br>
+<br>
+``translator_ld*``<br>
+~~~~~~~~~~~~~~~~~~<br>
+<br>
+These functions are a wrapper for ``cpu_ld*_code`` which also perform<br>
+any actions required by any tracing plugins.=C2=A0 They are only to be<br>
+called during the translator callback ``translate_insn``.<br>
+<br>
+There is a set of functions ending in ``_swap`` which, if the parameter<br=
>
+is true, returns the value in the endianness that is the reverse of<br>
+the guest native endianness, as determined by ``TARGET_WORDS_BIGENDIAN``.<=
br>
+<br>
+Function names follow the pattern:<br>
+<br>
+load: ``translator_ld{sign}{size}(<wbr>env, ptr)``<br>
+<br>
+swap: ``translator_ld{sign}{size}_<wbr>swap(env, ptr, swap)``<br>
+<br>
+``sign``<br>
+ - (empty) : for 32 or 64 bit sizes<br>
+ - ``u`` : unsigned<br>
+ - ``s`` : signed<br>
+<br>
+``size``<br>
+ - ``b`` : 8 bits<br>
+ - ``w`` : 16 bits<br>
+ - ``l`` : 32 bits<br>
+ - ``q`` : 64 bits<br>
+<br>
+Regexes for git grep<br>
+ - ``\&lt;translator_ld[us]\?[bwlq]\<wbr>(_swap\)\?\&gt;``<br>
+<br>
+``helper_*_{ld,st}*_mmu``<br>
+~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
=C2=A0These functions are intended primarily to be called by the code<br>
=C2=A0generated by the TCG backend. They may also be called by target<br>
-CPU helper function code. Like the ``cpu_{ld,st}_*_ra`` functions<br>
-they perform accesses by guest virtual address; the difference is<br>
-that these functions allow you to specify an ``opindex`` parameter<br>
-which encodes (among other things) the mmu index to use for the<br>
-access. This is necessary if your helper needs to make an access<br>
-via a specific mmu index (for instance, an &quot;always as non-privileged&=
quot;<br>
-access) rather than using the default mmu index for the current state<br>
-of the guest CPU.<br>
+CPU helper function code. Like the ``cpu_{ld,st}_mmuidx_ra`` functions<br>
+they perform accesses by guest virtual address, with a given ``mmuidx``.<b=
r>
<br>
-The ``opindex`` parameter should be created by calling ``make_memop_idx()`=
`.<br>
+These functions specify an ``opindex`` parameter which encodes<br>
+(among other things) the mmu index to use for the access.=C2=A0 This param=
eter<br>
+should be created by calling ``make_memop_idx()``.<br>
<br>
=C2=A0The ``retaddr`` parameter should be the result of GETPC() called dire=
ctly<br>
=C2=A0from the top level HELPER(foo) function (or 0 if no guest CPU state<b=
r>
@@ -166,8 +264,9 @@ unwinding is required).<br>
<br>
=C2=A0**TODO** The names of these functions are a bit odd for historical<br=
>
=C2=A0reasons because they were originally expected to be called only from<=
br>
-within generated code. We should rename them to bring them<br>
-more in line with the other memory access functions.<br>
+within generated code. We should rename them to bring them more in<br>
+line with the other memory access functions. The explicit endianness<br>
+is the only feature they have beyond ``*_mmuidx_ra``.<br>
<br>
=C2=A0load: ``helper_{endian}_ld{sign}{<wbr>size}_mmu(env, addr, opindex, r=
etaddr)``<br>
=C2=A0<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--0000000000002844ff059ad943c8--

