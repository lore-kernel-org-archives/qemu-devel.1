Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8423C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 07:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAEA2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 07:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAEA2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGHqu-0000OS-TD
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 03:18:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iGHqF-0008NN-Er
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iGHqD-0006x2-Bx
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:17:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33095)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iGHqD-0006vf-34
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:17:29 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MVv8f-1iflAG3ZGH-00RpZk; Fri, 04 Oct 2019 09:17:10 +0200
Subject: Re: [PATCH v3 1/3] tests/migration: mem leak fix
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
References: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
 <bcf225d9b90600b10951ac0a87569344e150ef51.1570159624.git.maozhongyi@cmss.chinamobile.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <86833d97-aeaf-3121-6bcc-b2ae24d07351@vivier.eu>
Date: Fri, 4 Oct 2019 09:17:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <bcf225d9b90600b10951ac0a87569344e150ef51.1570159624.git.maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:m1GUiq64OZNfs8UZ9c+sNzfAF/ZVBct09ATstdZ8zpsXtdndOlF
 vytLKvNrWcOVEJ1Kdp6fZ0pPaKqmruaFfwo6dc/OZPONvmCRiu7MtNVtbp+6Fbg+rdnwPSN
 QwwRIBRpCCsYSX798p5z0pWX6AJHjidVgTA+xpHaM59GGRw9/4MMK5aoNpbrcYjZtDERQYg
 uxpQb/H6/h8BUaxdyWzRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gHUJnsUcnGU=:lhhh60L7MA34K8RGa6AlWU
 mGfe1tyxcYdmxf6GWuOzLpKD/xpHGL4x7K6kt5su5KDipZXbVYniCQrMejrvbIBW2FzMlLXbq
 NjM73J8UWJ0zBmpUCRGtAb1++gwPvamcEluxkC+9ZQEz5k9a07twKbJzIrwXdMGvpiWfVq8Zq
 RdhN5RwJytnDqT83CElb77m0QOZ7rwrqGG7IWm6nFi78CJ/pbGc8Y3Nrfm5XksIhQhXCi+x9T
 rF40Q6eCO2tNOXJ7an2IFIeYbC6HOuBDRS87mfNNz2pzm1rbBh2ZH33m1EHHUfYXLw5mtqekH
 12ybM5oUiM31tVjWaiLGdywIg6KKoNtg4hPQ2gvlSaLpUTYIRROm51Ijq6p52/f3x/OHblVNO
 FUOTN75WKLd4Avf+aYlxknKf4+AKLI9t/dhUBEv77nyLTsnW+S7PfatbU0xum9fTu8elLNRyo
 roiOPW3UydB4jaYJVrEW7ODQ9apEg6rdf0Oy35BpGhBtPL6OBSFTUOMYxMVKyXNlUGr9Fq7kr
 fhfIuaCT3sYxUOe1Hx5og7hU96/rNa3yWa1EWfJT1fUGgBVsA945Ik/a1Ozeq4cz+JjbWZZ5Z
 dN9sKGcQXDKO/Zvo2JW6GtiVfakjHoicJ/U6ghinsNFFa7Tv5X68nielvuiBTdjD5u6KcZWyd
 Qet+dZ8Ykg48gSJeNdrCtMotHA9bMtZsEjjWoM1WAK3k1mHj6F/7FX3nELbRQhJfts/2EFSov
 oQS4JDM9uQMuuJgDPEAzpm59KISIkoo71fJ3lSVm6cS+vbeKbaYGvtpXXVFDPEWkCdmt3ANLR
 q10YxkdSlKPnVQpi3Npyx8ykfBJ0j9JNYCLOgrH6QAbq0qsa4pRd0XesIovwfyENhnNfae0UR
 5sTQ5eKDORWw1qQ8w5wbbBFQzeZ2CTdx2pMxjQoOY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: tony.nguyen@bt.com, alex.bennee@linaro.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/10/2019 à 05:43, Mao Zhongyi a écrit :
> ‘data’ has the possibility of memory leaks， so use the
> glib macros g_autofree recommended by CODING_STYLE.rst
> to automatically release the memory that returned from
> g_malloc().
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/migration/stress.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index d9aa4afe92..9e128eef50 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -170,10 +170,10 @@ static unsigned long long now(void)
>  static int stressone(unsigned long long ramsizeMB)
>  {
>      size_t pagesPerMB = 1024 * 1024 / PAGE_SIZE;
> -    char *ram = malloc(ramsizeMB * 1024 * 1024);
> +    g_autofree char *ram = g_malloc(ramsizeMB * 1024 * 1024);
>      char *ramptr;
>      size_t i, j, k;
> -    char *data = malloc(PAGE_SIZE);
> +    g_autofree char *data = g_malloc(PAGE_SIZE);
>      char *dataptr;
>      size_t nMB = 0;
>      unsigned long long before, after;
> @@ -186,7 +186,6 @@ static int stressone(unsigned long long ramsizeMB)
>      if (!data) {

As g_malloc() aborts on error, data is never NULL.
There is the same thing for ram.

Thanks,
Laurent

