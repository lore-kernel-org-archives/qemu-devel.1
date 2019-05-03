Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC7AC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A922075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A922075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbFq-0002cX-3Z
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:41:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbEm-0001r5-Dt
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbEk-0000g0-RO
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:40:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMbEk-0000dg-HM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:40:38 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1Mgek6-1goe0F0KHk-00h2jS; Fri, 03 May 2019 18:40:35 +0200
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20181210165636.28366-1-peter.maydell@linaro.org>
	<20181210165636.28366-2-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <845ed993-5433-53ea-2d29-81450da95d1f@vivier.eu>
Date: Fri, 3 May 2019 18:40:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181210165636.28366-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Tokfp0CBVD9lFcrkx0NJ9mx2rVUuYcJ5/K1/Q7T4HO6+sWo4kVi
	C4IS/vCXZfaEtMAskKe/C5/+OQVQpj5boTmtT5mONYo/ozVZJ69AJIWC40LSgm6eaPwi71o
	+AObqYKYplolTjyt1r5l0W50dEu3mW66ikelnQoaQ0vgHfgLHUqs7XmKy62q4tdft9zj59X
	/kCrCeaemj/hCezURIJjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DTEFcDC25xM=:BGYW2GTo7oEVRda+9BPY3O
	aBn0BWoLWzCfbcKK4UIAXhE/sZE1QHcbkspFBjLxQALLYrUQCvH+HAixGR2Hb0oEllPF4Jyw0
	A+bMo8TRSyC0zU2cG9uwbVfSXYgM14fsD/snNHpz90MyW1mvRYeeMzzM9AxAGL5+DzrHkc4Ft
	GJEXm0hKBhB3jLhRXQ8q4FBDj0buJKWLQasmRjKXWjW0QWLrCbEMVlpfNk2rGqvU7QXXMqdtv
	s6yykGLjmjVNyYHIEMpm9oz/2a4x/nDNAHRMNLRWEm01YDs8ZWGcizrumKCvBRbeXgg2/D6lv
	WWyPYF3//hIfkxTazZPiwfyPDde7Ve8IIpLlZfQ0hp4dYAXdAmhzyuJevbmL8VPtYFUYCY9h5
	u7+/aSgBs5ImQerg2fQDjy/EPP1IO7L3mLjMXl6sJZ0CTw4k5oDnO3uiTe+AUgsXid6UhG8GW
	IXW42Je5PJVQHwrGfAxYgCKRyUN55PCskkyzvGO8K+MkXdtdv7xxPg3xe1qIYIWCkCS+vyteb
	ttJINoJY7e9nwaBWRlT4JlJI/IQIZdDaAv3Ed8vIc9nPgpKt2SuI2858cQCCBJp9waUo0rLdY
	w15Yyx8FbPlCrtqKvh5ReBMryTRMIHQwD/t6rzxNfQnND4L64WTL8BPd6IKfX1UX0xubyTpNy
	mS/MqKh4XcF8Fde0zh4eRCD4/6Bbz/aEgonboVN9iPaI8rYuHqisSKU7KATL4szKznpToQexl
	tZxH2Or85F0pEwYoEInZcz248MT8VurslEXfGn8f+pc0377GULiZI+uec5g=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [RFC 1/3] target/m68k: In dump_address_map() check
 for memory access failures
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, patches@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503164033.dRCuzMGYPqWRugkEp7F2XjCwgv3cW6tN7T9pjcd3fxU@z>

On 10/12/2018 17:56, Peter Maydell wrote:
> In dump_address_map(), use address_space_ldl() instead of ldl_phys().
> This allows us to check whether the memory access failed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/m68k/helper.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 917d46efcc3..374e4861886 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -411,6 +411,7 @@ static void dump_address_map(FILE *f, fprintf_function cpu_fprintf,
>       int last_attr = -1, attr = -1;
>       M68kCPU *cpu = m68k_env_get_cpu(env);
>       CPUState *cs = CPU(cpu);
> +    MemTxResult txres;
>   
>       if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
>           /* 8k page */
> @@ -424,22 +425,29 @@ static void dump_address_map(FILE *f, fprintf_function cpu_fprintf,
>           tib_mask = M68K_4K_PAGE_MASK;
>       }
>       for (i = 0; i < M68K_ROOT_POINTER_ENTRIES; i++) {
> -        tia = ldl_phys(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4);
> -        if (!M68K_UDT_VALID(tia)) {
> +        tia = address_space_ldl(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4,
> +                                MEMTXATTRS_UNSPECIFIED, &txres);
> +        if (txres != MEMTX_OK || !M68K_UDT_VALID(tia)) {
>               continue;
>           }
>           for (j = 0; j < M68K_ROOT_POINTER_ENTRIES; j++) {
> -            tib = ldl_phys(cs->as, M68K_POINTER_BASE(tia) + j * 4);
> -            if (!M68K_UDT_VALID(tib)) {
> +            tib = address_space_ldl(cs->as, M68K_POINTER_BASE(tia) + j * 4,
> +                                    MEMTXATTRS_UNSPECIFIED, &txres);
> +            if (txres != MEMTX_OK || !M68K_UDT_VALID(tib)) {
>                   continue;
>               }
>               for (k = 0; k < tic_size; k++) {
> -                tic = ldl_phys(cs->as, (tib & tib_mask) + k * 4);
> -                if (!M68K_PDT_VALID(tic)) {
> +                tic = address_space_ldl(cs->as, (tib & tib_mask) + k * 4,
> +                                        MEMTXATTRS_UNSPECIFIED, &txres);
> +                if (txres != MEMTX_OK || !M68K_PDT_VALID(tic)) {
>                       continue;
>                   }
>                   if (M68K_PDT_INDIRECT(tic)) {
> -                    tic = ldl_phys(cs->as, M68K_INDIRECT_POINTER(tic));
> +                    tic = address_space_ldl(cs->as, M68K_INDIRECT_POINTER(tic),
> +                                            MEMTXATTRS_UNSPECIFIED, &txres);
> +                    if (txres != MEMTX_OK) {
> +                        continue;
> +                    }
>                   }
>   
>                   last_logical = logical;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


