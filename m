Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36009C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB982067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB982067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAJSM-0000hG-5k
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJRV-0008LG-Sb
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:51:49 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJRU-0000pm-4y
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:51:49 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mx0VH-1kZYQz0PMZ-00yQRe; Mon, 24 Aug 2020 22:51:46 +0200
Subject: Re: [PATCH v2] linux-user: detect mismatched ELF ABI in
 qemu-mips[n32][el]
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
 qemu-devel@nongnu.org
References: <20200823101703.18451-1-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ef2ca4b7-ba8a-0ba9-fdc8-2ed88ad7da12@vivier.eu>
Date: Mon, 24 Aug 2020 22:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823101703.18451-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ym5UUonNGtP+tliHeqiCJng8tBASZ7K+GBlj2HV9qr2M5nyP4yn
 F3fgSSNLZosbLrICtMlKMaLFF3IvJ76svOiytylpsf0/GJBg8W8IusAyGuJFepkd88D2jFA
 gJmI0COPn6OzC0Wy11vIXNED74of9kkSnSeAseQPyLLUV4H1cg0yVEEL3LFeqLcMeZxov6S
 tSewf8ndDwMGZJcc7RrZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jMoRagNmyQo=:Q3NjK8Ljf1BwFbjZ6+fkth
 l2VChhG3wN1d07uSr8YExJfGok0XXYvpOEKsRZAfpAvB0Xlt0fN8hSv0/EBC2ZonCwjwtIexj
 L05+d6OumejbRJngU78vQjGMAa5tj7/4r/sDHHg4zEuVYSQ8AkQ8EjDbs89bgBILWFrOzVCuy
 WNX0cv/DOpIskeTbvbYNnrQSwpbZUz8lTH9zMSTIXd1dOvaZ1VZba3X3yy3gelOHMLv4pr/Kc
 awVrdMIB08x8iDpaffKP45jDLy2QEsESmB2RtSKDroweeGAdENENE6MgMVi5IrSaDblwu8dlN
 MFSCTmSIzlMEZdIONi9ycT2+9EQOLty3B1oL/sj3e7dIPayh+RH7W+ofugQI2OH6BKkmO745U
 /G8AISa0WHI3ixMYcEvnRfQZCy4F3oNnNEQoKn4t3ZqWTL7a1MdHAFgq3sjCE3zodlkidKAT8
 f5B2xqfNvOxTlE6QWuh1NusHIck+3JD4tBPR54GHsfPURlCLuLIljPi+9WeIwdQRO9sUHeJq5
 lKEa9RHGHwBANYVLznQduv9Kis46iU4KPmoAw35tukQLyf+kB17KSJt29XmU3SU8F39vIcjmw
 1ONoiL0eOXb4Y99jvOQKQt0F9SoVzwJA4noWb8RTa7QPSZMq+3s1F6h5sNofsMjFZfFhSO6ug
 S+pQCZujOkkuJDUJ1NCh2Gc4NLag4/Eb9ypXCP/rmr87Ztz+TTLMp0HP36rbeMBThuCTEq3xH
 XtuywVLNy6HSaWf6r1CXv47H1FNeWcxsWp1H3Jukr+rXuNgVYcJ0Bmx5HD4FclJUvdLWOcAQx
 qK+8yZ5ir3C51ekOvPc0mfC+yS/7au9zC9FtCZNYkgWxQxnmKiJXCTS+sp01bX/WAF3e9LT
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 15:35:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: macro@linux-mips.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/08/2020 à 12:17, Carlo Marcelo Arenas Belón a écrit :
> MIPS provides 2 ILP32 ABIs, and therefore 4 possible qemu-mips binaries
> with 2 pairs using the same endianess and bitness.
> 
> This could lead to an O32 image loading in the N32 binary or vice versa
> and in cryptic errors (if lucky that the CPU doesn't match the FPU used)
> like :
> 
>   qemu: Unexpected FPU mode       (o32 ELF loaded to qemu-mipsn32[el])
>   ELF binary's NaN mode not supported by CPU    (n32 -> qemu-mips[el])
> 
> Add an ABI check macro that could be used while checking the ELF header
> that relies in the ABI2 flag to identify n32 binaries and abort instead
> early with a more descriptive error :
> 
>   Invalid ELF image for this architecture
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> Changes since v1:
> - Use the provided definition from include/elf.h (per Laurent)
> - Abort instead of warning (per Laurent, not using a custom error though)
> - Expand the check to all other combinations (per Aleksandar)
> 
>  linux-user/elfload.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index fe9dfe795d..69936dcd45 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -918,6 +918,12 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
>  
>  #define elf_check_arch(x) ((x) == EM_MIPS || (x) == EM_NANOMIPS)
>  
> +#ifdef TARGET_ABI_MIPSN32
> +#define elf_check_abi(x) ((x) & EF_MIPS_ABI2)
> +#else
> +#define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
> +#endif
> +
>  static inline void init_thread(struct target_pt_regs *regs,
>                                 struct image_info *infop)
>  {
> @@ -1487,6 +1493,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
>  #define elf_check_arch(x) ((x) == ELF_ARCH)
>  #endif
>  
> +#ifndef elf_check_abi
> +#define elf_check_abi(x) (1)
> +#endif
> +
>  #ifndef ELF_HWCAP
>  #define ELF_HWCAP 0
>  #endif
> @@ -1644,6 +1654,7 @@ static bool elf_check_ident(struct elfhdr *ehdr)
>  static bool elf_check_ehdr(struct elfhdr *ehdr)
>  {
>      return (elf_check_arch(ehdr->e_machine)
> +            && elf_check_abi(ehdr->e_flags)
>              && ehdr->e_ehsize == sizeof(struct elfhdr)
>              && ehdr->e_phentsize == sizeof(struct elf_phdr)
>              && (ehdr->e_type == ET_EXEC || ehdr->e_type == ET_DYN));
> 


Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


