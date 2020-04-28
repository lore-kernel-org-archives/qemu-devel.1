Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D1C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 06:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEECE206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 06:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZThV5EoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEECE206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTJvR-0005bd-LA
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 02:41:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTJqz-0001cU-4Y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTJpQ-0001n9-5d
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:36:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTJpP-0001mt-NU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:34:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id u16so1459668wmc.5
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 23:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RjMRO79Rn0uGO75pwKgK9W0cHTRjadDSVv8aF0XV5Gw=;
 b=ZThV5EoDf8Cou1Ioi+fvhujpFITciIIQt4RTaRQgfwsvld9Nl/x6qX+e729Qa3F2rB
 /p5AkuaYp4aWTYmhQRhQe5GN17xZgRMJyfUVCX3kDlzfTRsZdlTJnQ3AzriGSwmaeZ2O
 tvclDP7KM5UO4NB5N+O5APcF8WZG8HLk90tLP27kzyBnyH32IzxaGBb/WFsImgaMEmhY
 p8HLh6/CwvKJSM4SRxknbshkSXtmdVEOBHVmGKv0THVQOVeGrol+ubO1fOzeM+dmHn1S
 Uhvon+kywkyOxXOVC8khorWCgP04w5OuGMHUXngfNFeE/QsIP3sx6JId0uSJlC9dORGR
 BBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RjMRO79Rn0uGO75pwKgK9W0cHTRjadDSVv8aF0XV5Gw=;
 b=jflk0uc/RzMn5hkrfaHA0M4YerBfiOrK+69jZihun4WUShki84xuiMRLpGwCisjfM4
 8WqkMTTpnWhWa4R9JGbU0SL/CIQchylJ3C+ZKc3t8wD3cEVpqWyYihBsk9Tk+og7hU+/
 0k141reVDo1CzdrODl5gto7KSR3laQ9Kn36UMdVahWQ7IZKpeO9F3nvjQ3vpg8G0p7BP
 XHxjxKIilmmyGdlR9uaxzujSotSj3g9dgisc9tl/4Lul3VS9c2LPKmqhdVJTIj8LJahw
 t8dOSJ68OUQu+FUx3AcvWvvxuT38/z1PdL1m41PDUCGmwmXFaK7oqfWWxsbriAgjmEwk
 7VdA==
X-Gm-Message-State: AGi0PuZw+bg6u/7Ztn9qf0WXDVCN8pjuOGZOpGIL9JWlOcnv2otP+SCF
 +ZjA2pbLfenv9CraHri2tkFreark5f4=
X-Google-Smtp-Source: APiQypLjdkvK81fTXm6+uaZz09P2tLTOkbt3GwLoSiXTXC/lxCZrON6dOOYVwN135v5k/305vyn88A==
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr2739073wma.70.1588055686135; 
 Mon, 27 Apr 2020 23:34:46 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id j10sm2016559wmi.18.2020.04.27.23.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 23:34:45 -0700 (PDT)
Subject: Re: [PATCH for-5.1 4/7] target/mips: Add Loongson-3 CPU definition
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-4-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <c1a3aec6-dc45-3484-3a70-c06449bee609@amsat.org>
Date: Tue, 28 Apr 2020 08:34:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1587979995-17717-4-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Huacai,

On 4/27/20 11:33 AM, Huacai Chen wrote:
> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2. Loongson-3A R4 is the newest and its ISA is almost the superset
> of all others. To reduce complexity, we just define a "Loongson-3A" CPU
> which is corresponding to Loongson-3A R4. Loongson-3A has CONFIG6 and
> CONFIG7, so add their bit-fields as well.

Is there a public datasheet for R4? (If possible in English).

> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  target/mips/cpu.h                | 28 ++++++++++++++++++++++
>  target/mips/internal.h           |  2 ++
>  target/mips/mips-defs.h          |  7 ++++--
>  target/mips/translate.c          |  2 ++
>  target/mips/translate_init.inc.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 94d01ea..0b3c987 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -940,7 +940,35 @@ struct CPUMIPSState {
>  #define CP0C5_UFR          2
>  #define CP0C5_NFExists     0
>      int32_t CP0_Config6;
> +    int32_t CP0_Config6_rw_bitmask;
> +#define CP0C6_BPPASS          31
> +#define CP0C6_KPOS            24
> +#define CP0C6_KE              23
> +#define CP0C6_VTLBONLY        22
> +#define CP0C6_LASX            21
> +#define CP0C6_SSEN            20
> +#define CP0C6_DISDRTIME       19
> +#define CP0C6_PIXNUEN         18
> +#define CP0C6_SCRAND          17
> +#define CP0C6_LLEXCEN         16
> +#define CP0C6_DISVC           15
> +#define CP0C6_VCLRU           14
> +#define CP0C6_DCLRU           13
> +#define CP0C6_PIXUEN          12
> +#define CP0C6_DISBLKLYEN      11
> +#define CP0C6_UMEMUALEN       10
> +#define CP0C6_SFBEN           8
> +#define CP0C6_FLTINT          7
> +#define CP0C6_VLTINT          6
> +#define CP0C6_DISBTB          5
> +#define CP0C6_STPREFCTL       2
> +#define CP0C6_INSTPREF        1
> +#define CP0C6_DATAPREF        0
>      int32_t CP0_Config7;
> +    int64_t CP0_Config7_rw_bitmask;
> +#define CP0C7_NAPCGEN       2
> +#define CP0C7_UNIMUEN       1
> +#define CP0C7_VFPUCGEN      0
>      uint64_t CP0_LLAddr;
>      uint64_t CP0_MAAR[MIPS_MAAR_MAX];
>      int32_t CP0_MAARI;
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 1bf274b..7853cb1 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -36,7 +36,9 @@ struct mips_def_t {
>      int32_t CP0_Config5;
>      int32_t CP0_Config5_rw_bitmask;
>      int32_t CP0_Config6;
> +    int32_t CP0_Config6_rw_bitmask;
>      int32_t CP0_Config7;
> +    int32_t CP0_Config7_rw_bitmask;
>      target_ulong CP0_LLAddr_rw_bitmask;
>      int CP0_LLAddr_shift;
>      int32_t SYNCI_Step;
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index a831bb4..c2c96db 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -51,8 +51,9 @@
>   */
>  #define INSN_LOONGSON2E   0x0001000000000000ULL
>  #define INSN_LOONGSON2F   0x0002000000000000ULL
> -#define INSN_VR54XX       0x0004000000000000ULL
> -#define INSN_R5900        0x0008000000000000ULL
> +#define INSN_LOONGSON3A   0x0004000000000000ULL
> +#define INSN_VR54XX       0x0008000000000000ULL
> +#define INSN_R5900        0x0010000000000000ULL
>  /*
>   *   bits 56-63: vendor-specific ASEs
>   */
> @@ -94,6 +95,8 @@
>  /* Wave Computing: "nanoMIPS" */
>  #define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
>  
> +#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A)
> +
>  /*
>   * Strictly follow the architecture standard:
>   * - Disallow "special" instruction handling for PMON/SPIM.
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 25b595a..2caf4cb 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -31206,7 +31206,9 @@ void cpu_state_reset(CPUMIPSState *env)
>      env->CP0_Config5 = env->cpu_model->CP0_Config5;
>      env->CP0_Config5_rw_bitmask = env->cpu_model->CP0_Config5_rw_bitmask;
>      env->CP0_Config6 = env->cpu_model->CP0_Config6;
> +    env->CP0_Config6_rw_bitmask = env->cpu_model->CP0_Config6_rw_bitmask;
>      env->CP0_Config7 = env->cpu_model->CP0_Config7;
> +    env->CP0_Config7_rw_bitmask = env->cpu_model->CP0_Config7_rw_bitmask;
>      env->CP0_LLAddr_rw_bitmask = env->cpu_model->CP0_LLAddr_rw_bitmask
>                                   << env->cpu_model->CP0_LLAddr_shift;
>      env->CP0_LLAddr_shift = env->cpu_model->CP0_LLAddr_shift;
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
> index 6d145a9..a32412d 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -802,6 +802,57 @@ const mips_def_t mips_defs[] =
>          .mmu_type = MMU_TYPE_R4000,
>      },
>      {
> +        .name = "Loongson-3A",
> +        .CP0_PRid = 0x14C000,
> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
> +        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
> +                       (MMU_TYPE_R4000 << CP0C0_MT),
> +        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
> +                       (2 << CP0C1_IS) | (4 << CP0C1_IL) | (3 << CP0C1_IA) |
> +                       (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
> +        .CP0_Config2 = MIPS_CONFIG2,
> +        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MSAP) |
> +                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_ULRI) |
> +                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
> +        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE) |
> +                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrExist),
> +        .CP0_Config4_rw_bitmask = 0,
> +        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_NFExists) | (1 << 18),
> +        .CP0_Config5_rw_bitmask = (1 << CP0C5_K) | (1 << CP0C5_CV) |
> +                                  (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) |
> +                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),
> +        .CP0_Config6 = (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) | (1 << CP0C6_SFBEN) |
> +                       (1 << CP0C6_FLTINT) | (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
> +        .CP0_Config6_rw_bitmask = (1 << CP0C6_BPPASS) | (0x3f << CP0C6_KPOS) |
> +                                  (1 << CP0C6_KE) | (1 << CP0C6_VTLBONLY) | (1 << CP0C6_LASX) |
> +                                  (1 << CP0C6_SSEN) | (1 << CP0C6_DISDRTIME) |
> +                                  (1 << CP0C6_PIXNUEN) | (1 << CP0C6_SCRAND) |
> +                                  (1 << CP0C6_LLEXCEN) | (1 << CP0C6_DISVC) |
> +                                  (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) |
> +                                  (1 << CP0C6_PIXUEN) | (1 << CP0C6_DISBLKLYEN) |
> +                                  (1 << CP0C6_UMEMUALEN) | (1 << CP0C6_SFBEN) |
> +                                  (1 << CP0C6_FLTINT) | (1 << CP0C6_VLTINT) |
> +                                  (1 << CP0C6_DISBTB) | (3 << CP0C6_STPREFCTL) |
> +                                  (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
> +        .CP0_Config7 = 0,
> +        .CP0_Config7_rw_bitmask = (1 << CP0C7_NAPCGEN) | (1 << CP0C7_UNIMUEN) | \
> +                                  (1 << CP0C7_VFPUCGEN),
> +        .CP0_LLAddr_rw_bitmask = 1,
> +        .SYNCI_Step = 16,
> +        .CCRes = 2,
> +        .CP0_Status_rw_bitmask = 0x7DDBFFFF,
> +        .CP0_PageGrain_rw_bitmask = (1U << CP0PG_RIE) | (1 << CP0PG_XIE) |
> +                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
> +        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64),
> +        .CP1_fcr31 = 0,
> +        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
> +        .SEGBITS = 48,
> +        .PABITS = 48,
> +        .insn_flags = CPU_LOONGSON3A,
> +        .mmu_type = MMU_TYPE_R4000,
> +    },
> +    {
>          /* A generic CPU providing MIPS64 DSP R2 ASE features.
>             FIXME: Eventually this should be replaced by a real CPU model. */
>          .name = "mips64dspr2",
> 

