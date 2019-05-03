Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8679DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBB8206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBB8206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbLW-00071M-K2
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:47:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbK6-0006Pu-6B
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbK4-0006YS-Ud
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:46:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMbK4-0006UK-Jz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:46:08 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N17cq-1gd01U0yOg-012VeT; Fri, 03 May 2019 18:46:06 +0200
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20181210165636.28366-1-peter.maydell@linaro.org>
	<20181210165636.28366-3-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <57e90be8-0652-8204-cc9e-1ce347e446d8@vivier.eu>
Date: Fri, 3 May 2019 18:46:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181210165636.28366-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Al/j7ttYiWfKrYgTZJ+MV+Q5SUOwHb0UnmVTFq1EKlxjff5k/qJ
	8dmCN9AI6kRa+y/NeuFpbZd3hBJiHnCvp60zONgAHtGBxmEVAjcKEawTDfNJZLFu5hP7kjg
	i3+jj2NbpcQRLvuC6bDBM2ha3ZK366QjigYV20xPNFdPROxcOwimY4L7LHCDN9TExIIxjM3
	Fp0o6a1KizYIohq4LTuNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Y+nsCBFAaA=:CpXWtxD8N/9/ZK8vBBwvGi
	sgJdC30UKI3rPf6eeorenUzzTWF1top7dXQGNNQxU1kwKQHgv6E1Bzc6woBmaYrck5xO6bMSS
	pE1XpgUauCf+xCx4y2aeVNTGff02QGQFRhQh4/73lXRDntJQkca9LbPTsqT6ct3eyI5EweFEE
	mS9gY7NIaDyN5VUWRLrSxQYSe6xy+tBphPm2nE3V1Nf5LhiCbJB6+pHfrEv5TvHyXyV4Hjbvo
	88OahxBY56WNre/71AV+QFanswcsfK/uCUv7nu+ssr2QqWvA+XetDIroTvdSVeXkTYio9b+IP
	oKE2YCtttVyHNUi9LQceGtBeqU1j/ADaeJr2cVYpKTc8iprJm0V27hNPg5BGT2UGUbQoxo334
	jQ6yn6uOegtehnKGVKV2u0AHOenrNBXAPqiBjk4agAkBU2MSYMP4rFkxH1enhRWnAuiH8u9CL
	n48E1/ldISvM0RqPEdErIZcOZ50hk4M/080/NuMwp+eU8Rche3y4Xww9Za0sxmw99KvIM7rZS
	1vCK4ILNyTqN0t6J+GJui5YtfCTpXoOgy9flYshe1pJ3a3FEG5lCeO7+IzqiWyeYWNUdUAyQ+
	FeJNzlMEVca/Za2i3xZVDawt5qXkWgG0lUNvcEx2d0SoOJcvNurBIm9I/vkDpscMtXA44LT6n
	mBOxi+qyTehO9EEH+PzUYeNoBEuIafr50RHg+sq90RPSYj2tgBXg2DPjL/Y6V2BAVIUXEQnAY
	cwHZVCiWbRyV/+sD1E+62uLcgsQx9Z+MJLVnZrqJQAjb43A83/2Uc9KPyrg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [RFC 2/3] target/m68k: In get_physical_address()
 check for memory access failures
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
Message-ID: <20190503164605.r-H7O78cyAGRoJSwCNrLCWBRLvSetnZ_ZJGK66_5GEg@z>

On 10/12/2018 17:56, Peter Maydell wrote:
> In get_physical_address(), use address_space_ldl() and
> address_space_stl() instead of ldl_phys() and stl_phys().
> This allows us to check whether the memory access failed.
> For the moment, we simply return -1 in this case;
> add a TODO comment that we should ideally generate the
> appropriate kind of fault.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/m68k/helper.c | 62 +++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 374e4861886..b5fa2f8056d 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -660,6 +660,7 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
>       bool debug = access_type & ACCESS_DEBUG;
>       int page_bits;
>       int i;
> +    MemTxResult txres;
>   
>       /* Transparent Translation (physical = logical) */
>       for (i = 0; i < M68K_MAX_TTR; i++) {
> @@ -689,12 +690,19 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
>       /* Root Index */
>       entry = M68K_POINTER_BASE(next) | M68K_ROOT_INDEX(address);
>   
> -    next = ldl_phys(cs->as, entry);
> +    next = address_space_ldl(cs->as, entry, MEMTXATTRS_UNSPECIFIED, &txres);
> +    if (txres != MEMTX_OK) {
> +        goto txfail;
> +    }
>       if (!M68K_UDT_VALID(next)) {
>           return -1;
>       }
>       if (!(next & M68K_DESC_USED) && !debug) {
> -        stl_phys(cs->as, entry, next | M68K_DESC_USED);
> +        address_space_stl(cs->as, entry, next | M68K_DESC_USED,
> +                          MEMTXATTRS_UNSPECIFIED, &txres);
> +        if (txres != MEMTX_OK) {
> +            goto txfail;
> +        }
>       }
>       if (next & M68K_DESC_WRITEPROT) {
>           if (access_type & ACCESS_PTEST) {
> @@ -709,12 +717,19 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
>       /* Pointer Index */
>       entry = M68K_POINTER_BASE(next) | M68K_POINTER_INDEX(address);
>   
> -    next = ldl_phys(cs->as, entry);
> +    next = address_space_ldl(cs->as, entry, MEMTXATTRS_UNSPECIFIED, &txres);
> +    if (txres != MEMTX_OK) {
> +        goto txfail;
> +    }
>       if (!M68K_UDT_VALID(next)) {
>           return -1;
>       }
>       if (!(next & M68K_DESC_USED) && !debug) {
> -        stl_phys(cs->as, entry, next | M68K_DESC_USED);
> +        address_space_stl(cs->as, entry, next | M68K_DESC_USED,
> +                          MEMTXATTRS_UNSPECIFIED, &txres);
> +        if (txres != MEMTX_OK) {
> +            goto txfail;
> +        }
>       }
>       if (next & M68K_DESC_WRITEPROT) {
>           if (access_type & ACCESS_PTEST) {
> @@ -733,27 +748,46 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
>           entry = M68K_4K_PAGE_BASE(next) | M68K_4K_PAGE_INDEX(address);
>       }
>   
> -    next = ldl_phys(cs->as, entry);
> +    next = address_space_ldl(cs->as, entry, MEMTXATTRS_UNSPECIFIED, &txres);
> +    if (txres != MEMTX_OK) {
> +        goto txfail;
> +    }
>   
>       if (!M68K_PDT_VALID(next)) {
>           return -1;
>       }
>       if (M68K_PDT_INDIRECT(next)) {
> -        next = ldl_phys(cs->as, M68K_INDIRECT_POINTER(next));
> +        next = address_space_ldl(cs->as, M68K_INDIRECT_POINTER(next),
> +                                 MEMTXATTRS_UNSPECIFIED, &txres);
> +        if (txres != MEMTX_OK) {
> +            goto txfail;
> +        }
>       }
>       if (access_type & ACCESS_STORE) {
>           if (next & M68K_DESC_WRITEPROT) {
>               if (!(next & M68K_DESC_USED) && !debug) {
> -                stl_phys(cs->as, entry, next | M68K_DESC_USED);
> +                address_space_stl(cs->as, entry, next | M68K_DESC_USED,
> +                                  MEMTXATTRS_UNSPECIFIED, &txres);
> +                if (txres != MEMTX_OK) {
> +                    goto txfail;
> +                }
>               }
>           } else if ((next & (M68K_DESC_MODIFIED | M68K_DESC_USED)) !=
>                              (M68K_DESC_MODIFIED | M68K_DESC_USED) && !debug) {
> -                stl_phys(cs->as, entry,
> -                         next | (M68K_DESC_MODIFIED | M68K_DESC_USED));
> +            address_space_stl(cs->as, entry,
> +                              next | (M68K_DESC_MODIFIED | M68K_DESC_USED),
> +                              MEMTXATTRS_UNSPECIFIED, &txres);
> +            if (txres != MEMTX_OK) {
> +                goto txfail;
> +            }
>           }
>       } else {
>           if (!(next & M68K_DESC_USED) && !debug) {
> -            stl_phys(cs->as, entry, next | M68K_DESC_USED);
> +            address_space_stl(cs->as, entry, next | M68K_DESC_USED,
> +                              MEMTXATTRS_UNSPECIFIED, &txres);
> +            if (txres != MEMTX_OK) {
> +                goto txfail;
> +            }
>           }
>       }
>   
> @@ -785,6 +819,14 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
>       }
>   
>       return 0;
> +
> +txfail:
> +    /*
> +     * A page table load/store failed. TODO: we should really raise a
> +     * suitable guest fault here if this is not a debug access.
> +     * For now just return that the translation failed.
> +     */
> +    return -1;
>   }
>   
>   hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



