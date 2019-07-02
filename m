Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C5C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75039206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75039206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFPa-0000go-IC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39337)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiFLU-0007NS-Mi
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiFLT-0006q7-IF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:45:04 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58281)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiFLT-0006oi-8q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:45:03 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MJnnV-1hxRmE09TV-00K95B; Tue, 02 Jul 2019 11:44:59 +0200
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>, qemu-devel@nongnu.org
References: <20190616142257.GA71205@localhost.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <16e65a41-7697-8c32-2f0f-45220d0174bf@vivier.eu>
Date: Tue, 2 Jul 2019 11:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616142257.GA71205@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1hJVHIrvG22g4jkM+kTLmnKUkIuaAD/0rE5V9ggWiAdmvFfTTel
 gVn/YTx95hZ1F13mQrU9smqmfMT5PqVjSMM7wt1EpwgVYlUoMBzbs8pqck9FFEQ4RnVkkzl
 OC2YYQ/1LmbR9Ny4EUtQVLw8+L3IWSj7koFJIAdPLAgDUwQENGVx066ov3rfDFnrSG9Owma
 3uz8ZgzW6UotrIOkDypxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gz6YBKWPvz0=:qAPwTSJK7N6t1d9ftQWodi
 DDhahnBg0WrAxYXvWAXgUJU0wH+4Q9czXtgMNcz7n6sUnhnBSFkTCFjdDirvIT3b5+Quzt3t0
 X/U5kjbCT2xEvqsNtTj7lO2tXe93IK+AMKXlVPFsrio0M2oCjWs+iueaJk3pumPBz01F1wFBM
 wk8BSrTD+1gjMOn+Vbqxu39fAuSP4lVGRRclDLYk8LBS8QItWfR9NVgO/UXysfLJyjkHoubhI
 hNy3M/PfZ8ZeVPev0jV/lBZShwLh765HWAnstdpFonc3VftKIQTIApCG+WfuPBfWDfL5Ado7h
 nEBh/qfHTaZKwDEpBCI0+UC/TV3o1WvF+l8SiMwgFOzcWEhW7fkRFCUtTFAiSgcQ2KkzKADCs
 Ou4EG2Nb+KDF4ltuZ2IG+UCYDX4aRBUu3AEe3ov4owTy9Zs1aNFhuJ1Jec4y0zQ0oFzTCJvO1
 To6817kYFtepc3sDaN/fa3XCUeMVLmice2za+kzdS6vDwobQBdIPOkpgWD6X0tq07BhEOUnUy
 Nlafau7wbkryCLAhEzmfe50mM1kCtD7zHfYda4qVGc9oVLHOqwS/fmK9+KB7J6zDnV3zKvFIH
 urFiz7zDYd2gWovTtRrmOAm0lYzUaeqB6rBoWxRFRpow4COB4zHs0nzGPKKO4aBsNW2iveZCb
 Ft+xuUPeWQvZTUjYKCdpxpx0WPDlqtwiuaX0trS/3WfyPXP8LnYMePHli06peJdgc96LiBkWw
 B8+4Z36njCvybXzZpcfhWRSIYLbYGg0Zvsh6b46cvm7qqC1mYDa+iTFxDxA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH 3/6] Improved comments on m68k_move_to/from
 helpers
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/06/2019 à 16:22, Lucien Murray-Pitts a écrit :
> Added more detailed comments to each case of m68k_move_to/from helpers to list
> the supported CPUs for that CR as they were wrong in some cases, and
> missing some cpu classes in other cases.
> 
> Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
> ---
>  target/m68k/helper.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index b0bb579403..5483ce9837 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c

I think it would be good to add references:

/* M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL
 * 1.3 SUPERVISOR PROGRAMMING MODEL
 * Table 1-1. Supervisor Registers
 *            Not Related To Paged Memory Managem
 * Table 1-2. Supervisor Registers
 *            Related To Paged Memory Management
 */

and a summary is in the movec instruction description of the same manual

/* MOVEC Move Control Register
 *      (MC68010, MC68020, MC68030, MC68040, CPU32)
*/

> @@ -197,40 +197,47 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
>      M68kCPU *cpu = m68k_env_get_cpu(env);
>  
>      switch (reg) {
> -    /* MC680[1234]0 */
> +    /* MC680[12346]0 */
>      case M68K_CR_SFC:
>          env->sfc = val & 7;
>          return;
> +    /* MC680[12346]0 */
>      case M68K_CR_DFC:
>          env->dfc = val & 7;
>          return;
> +    /* MC680[12346]0 */
>      case M68K_CR_VBR:
>          env->vbr = val;
>          return;
> -    /* MC680[234]0 */
> +    /* MC680[2346]0 */
>      case M68K_CR_CACR:
>          env->cacr = val;
>          m68k_switch_sp(env);
>          return;
> -    /* MC680[34]0 */
> +    /* MC680[46]0 */

030 uses pmove to manage MMU registers (SRP, CRP, TC MMUSR and ACUSR).
For the moment, I have only implemented the 040 MMU, that's why the
instructions is not implemented.

>      case M68K_CR_TC:
>          env->mmu.tcr = val;
>          return;
> +    /* MC680[4]0 */
>      case M68K_CR_MMUSR:
>          env->mmu.mmusr = val;
>          return;
> +    /* MC680[46]0 */
>      case M68K_CR_SRP:
>          env->mmu.srp = val;
>          return;
>      case M68K_CR_URP:
>          env->mmu.urp = val;
>          return;
> +    /* MC680[46]0 */
>      case M68K_CR_USP:
>          env->sp[M68K_USP] = val;
>          return;
> +    /* MC680[234]0 */
>      case M68K_CR_MSP:
>          env->sp[M68K_SSP] = val;
>          return;
> +    /* MC680[234]0 */
>      case M68K_CR_ISP:
>          env->sp[M68K_ISP] = val;
>          return;
...

Thanks,
Laurent

