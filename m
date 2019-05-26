Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8C2C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 13:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1202075E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 13:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1202075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUswG-0003IM-Vx
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 09:11:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUsvC-0002Yk-8j
	for qemu-devel@nongnu.org; Sun, 26 May 2019 09:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUsvA-0003ED-UI
	for qemu-devel@nongnu.org; Sun, 26 May 2019 09:10:42 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hUsvA-0003B7-Jb
	for qemu-devel@nongnu.org; Sun, 26 May 2019 09:10:40 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MPooN-1hHSu81ypH-00Ms21; Sun, 26 May 2019 15:10:27 +0200
To: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
References: <20190526072826.32956-1-lucienmp_antispam@yahoo.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b7c64daf-5036-b492-92a5-b25524d8cbde@vivier.eu>
Date: Sun, 26 May 2019 15:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190526072826.32956-1-lucienmp_antispam@yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wnXRM6GWM20KYCwyo3CQT+ERu3h5sSvPpZp8XPs9+W9anm+eofI
	xgDla2DiAex0eWeMB3sdfUlPKRDeg/sWZS63qKRz79gCHnLNNskyq5uOtZVGuKfPkWW1BKa
	uqiJNFdY8EBywRXfHCc6/X8qzbnFcTnOeOhi55j0js+eXtzPzQ9kyMQ7iRJpbIkC/ygHWSC
	Kr0xw76QkY/UR7Z7/s1pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0qKOIEtStq8=:mLJXDqt+09u4REPeMwgnKX
	bVSk5CsrW+39HJ5Kenfk95a6+KDr4a97le4ulI1VomqhlgjrnCy6dbDf88sm6e1ixO+ZTBzkd
	6UfB+Ub5sjkU1CtEodNWv2bPQ4aIPoHJ5M4Jw2GYxPRtU2ZkOCKZ4cxCggIw0VtB5zehFMk6v
	gmBGFPBK4CT09UsVolOJQt4sYk/HADCXukCTbPd/rOvUTbiMJPig0WgWXXNExmN8tPhLSVAmj
	CBE4cvv/bIh+vKEQRKg2iYx10dpeOyuMThDprRCCBdipBedjFcyvGOa56L06Ic/RtUJRx+C0Q
	qhT71pYl8BquJSVZp9lNDoCTrNFkTMu4cflaOap4a8l/MAnyrh5/yIJzktSnNYfQOVl/UtOqD
	aukJ0jEQ+iSXuS2GQIXtyACeSiMk8XbkwUNTeLzTiuyBJYWi5lGxyH9OZJoMmznWX5+YMRhD+
	e89w4sFxSFPCSlEPpGB/synzflsjr36tnQqRxWIR9JGSkphcK339n3v26hW0tVtgzsX1Dl5I3
	j4XqG77uBXCV4NKQYSr3Zr1OdTe0fOWOfRdcwZm6A0DohCmEFVIRG2LSKqg0k7ZjTNR2NMvtE
	wFjhIZeaPFNcvPp2+QiSQE95esE+4HB86VYjOaWs/qIIHoOBqbxryzXEkEy5xJ0vNG4pOt0GH
	Dcm1lmpCEHBdJwPW0nIkddxfBLsFCpLJp72sI2OUW6YVPS7+0algYtqk3ifh3K1JSzDb73vmL
	j1EsTmuCHlZjEytqB/CbZrgR4CPautePRE7jvz4ekfhIWpyQtbdP+9/0D5w=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [PATCH] Incorrect Stack Pointer shadow register
 support on some m68k CPUs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Emilio G . Cota" <cota@braap.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/2019 09:28, Lucien Murray-Pitts wrote:
> On CPU32 and the early 68000 and 68010 the ISP doesnt exist.
> These CPUs only have SSP/USP.
> 
> The availability of this feature is determined by the
> implementation of Master mode bit in the SR register.
> 
> Those with the master-mode bit have ISP.
> 
> Additional comments added to the features set to claify
> exactly what differentiates each class.  (m68k_features)
> 
> The movec instruction when accessing these shadow registers
> in some configurations should issue a TRAP.  This patch does not
> add this funcitonality to the helpers.
> 

I think it's better to also update movec in the same patch.

Could you also update the comment about sp in CPUM68KState structure 
definition?

And, if possible, could you fix style problem reported by patchew.

Thanks,
LAurent

> Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
> ---
>   target/m68k/cpu.c    |  1 +
>   target/m68k/cpu.h    | 12 ++++++++++--
>   target/m68k/helper.c |  3 ++-
>   3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index b16957934a..61368d1a9a 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -121,6 +121,7 @@ static void m68020_cpu_initfn(Object *obj)
>       CPUM68KState *env = &cpu->env;
>   
>       m68k_set_feature(env, M68K_FEATURE_M68000);
> +    m68k_set_feature(env, M68K_FEATURE_MSP);
>       m68k_set_feature(env, M68K_FEATURE_USP);
>       m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
>       m68k_set_feature(env, M68K_FEATURE_QUAD_MULDIV);
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 9deff9e234..8be68e5e4f 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -462,12 +462,19 @@ void m68k_switch_sp(CPUM68KState *env);
>   
>   void do_m68k_semihosting(CPUM68KState *env, int nr);
>   
> -/* There are 4 ColdFire core ISA revisions: A, A+, B and C.
> +/* The ColdFire core ISA is a RISC-style reduction of the 68000 series
> +   Whilst the 68000 flourished by adding extended stack/instructions in
> +   five main flavors original 68000, 680010/20/30/40, and a CPU32/CPU32+
> +
> +   CPU32/32+ are basically 68000/10 compatible, with and 68020.  Mostly
> +   Supervisor state differences.
> +
> +   There are 4 ColdFire core ISA revisions: A, A+, B and C.
>      Each feature covers the subset of instructions common to the
>      ISA revisions mentioned.  */
>   
>   enum m68k_features {
> -    M68K_FEATURE_M68000,
> +    M68K_FEATURE_M68000,   /* Base m68k set, as opposed to ColdFire */
>       M68K_FEATURE_CF_ISA_A,
>       M68K_FEATURE_CF_ISA_B, /* (ISA B or C).  */
>       M68K_FEATURE_CF_ISA_APLUSC, /* BIT/BITREV, FF1, STRLDSR (ISA A+ or C).  */
> @@ -477,6 +484,7 @@ enum m68k_features {
>       M68K_FEATURE_CF_EMAC,
>       M68K_FEATURE_CF_EMAC_B, /* Revision B EMAC (dual accumulate).  */
>       M68K_FEATURE_USP, /* User Stack Pointer.  (ISA A+, B or C).  */
> +    M68K_FEATURE_MSP, /* Master Stack Pointer. Not 68000/10,Coldfire,CPU32 */
>       M68K_FEATURE_EXT_FULL, /* 68020+ full extension word.  */
>       M68K_FEATURE_WORD_INDEX, /* word sized address index registers.  */
>       M68K_FEATURE_SCALED_INDEX, /* scaled address index registers.  */
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 6db93bdd81..64c8a82a92 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -337,7 +337,8 @@ void m68k_switch_sp(CPUM68KState *env)
>       env->sp[env->current_sp] = env->aregs[7];
>       if (m68k_feature(env, M68K_FEATURE_M68000)) {
>           if (env->sr & SR_S) {
> -            if (env->sr & SR_M) {
> +            /* SR:Master-Mode bit unimplemented then ISP is not available */
> +            if (!m68k_feature(env, M68K_FEATURE_MSP) || env->sr & SR_M) {
>                   new_sp = M68K_SSP;
>               } else {
>                   new_sp = M68K_ISP;
> 


