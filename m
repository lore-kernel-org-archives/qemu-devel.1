Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A41CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50ED12064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50ED12064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDGU-0004wR-En
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 05:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNDCv-0003b3-QB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNDCu-0003XT-Hp
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:45:33 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iNDCl-0003Of-9p
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:45:26 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N6KpF-1hv5Ol0VhJ-016cnV; Wed, 23 Oct 2019 11:45:06 +0200
Subject: Re: [PATCH v4 1/3] tests/migration: mem leak fix
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
References: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
 <95ceba2addaa3136db8ee233ea2e0ff9d13db7c0.1570208781.git.maozhongyi@cmss.chinamobile.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e231ec9f-5e2d-2ca5-33cb-2571e47c2561@vivier.eu>
Date: Wed, 23 Oct 2019 11:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <95ceba2addaa3136db8ee233ea2e0ff9d13db7c0.1570208781.git.maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XIHaaH8EIXzLP7CvliUaHGc/rmzYQzyr+JdBRIlz83wgEt+tUWI
 jMqYZN5pop6ba3bPgJy4MvQZ9N0G0VmcllXc/UGx3f3veMNIwrG33sCM4plB6nnVcHZoHLQ
 aOqWTt9a0JFol4H3b23hX9MYwqsUak/+lyeZHLTm4awdocLnXyBT6C3YqMUSa1aJJDg+KlQ
 dgQOse21YxuPbZVbNoAtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8w87hKJPvCc=:Om2lJMA1pjKP+n6CcyOKir
 MgJceb0oJ47ymySMdxLbTWjaw0MdTkJswAhppkGbNGl21wP1QwapU/epILh/Lc8Wig4ztPeBX
 2+8pCHkEv6jkjCFk0bAiJT8QCfMsT1VmtGq+527sBfyB5Dyv1sejL1u6CCf7/4T0Xa4iFKSuD
 QdWWe9PHDGHaOY19S9CYf+0EpAcmOQCqELf7wnxJDKsFtJUABV8QDBGc2q4UceLU17eQT3+KI
 eL04c70Jl/G14lgUf5BhcE/eRhV6NxC7IHRx5mSZvKM6KuLk57ne46toEnrVAqO/jfHTs/dlg
 2qXaHSeSwKxNt5Lu0wSmIKn55tXgM+mo7iYaaW9wixhJUrZn1tppx/3FhMMEbS6zkU1tyFhVt
 iHICS7w9XeQucmUg7H66B0DThsdChD0IV47B5kv8SB0inKlklVhFcSDB76iyYi2SzWVodlNPz
 x9/S8aOzjIsl54DMlnkTe66gjtQktOhf55pYuENFUR6N+lRxkhQK2lpeAA/iSQmQGzsO6d0Y0
 aBwmH4un+jh5nUCNunWLwO0Pf2+ujJvamx/1twQXBhVO7ohs6GwL3wX15qqYKsDrNKwvVYdtv
 U/CmTl2EIJmD06SuXIN/1nzjUn/H1Xl0PDv/jo8JinvQQ4BG7lgEgZHVUHYRT518u0wEy/mgL
 6PUAshrT7WmcRw4lX9xltZOVOxNYOuQPrMGrApXAkTIONq+43IAhrwukYWVYsrfG3B1KoSpVk
 jH81cl/pSZqrsAvNQtZPiN66/7yLHkHy1caC4Z0smp959yb68LxkPGRaCxINGqC+RV2dJtu8+
 /g5Y5GM36reTRdgnnOZme5FNSO9L3pkSo3jslm0G6yp5Mp3/csrYtcfBaGPfjdDH9H/IW9aVe
 CeIbhT9r9GYb7WJ8b6OWkaYETfj6ITZptESpA63zc=
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

Le 04/10/2019 à 19:32, Mao Zhongyi a écrit :
> ‘data’ has the possibility of memory leaks， so use the
> glib macros g_autofree recommended by CODING_STYLE.rst
> to automatically release the memory that returned from
> g_malloc().
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/migration/stress.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index d9aa4afe92..d8a6f64af0 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -170,26 +170,14 @@ static unsigned long long now(void)
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
>  
> -    if (!ram) {
> -        fprintf(stderr, "%s (%05d): ERROR: cannot allocate %llu MB of RAM: %s\n",
> -                argv0, gettid(), ramsizeMB, strerror(errno));
> -        return -1;
> -    }
> -    if (!data) {
> -        fprintf(stderr, "%s (%d): ERROR: cannot allocate %d bytes of RAM: %s\n",
> -                argv0, gettid(), PAGE_SIZE, strerror(errno));
> -        free(ram);
> -        return -1;
> -    }
> -
>      /* We don't care about initial state, but we do want
>       * to fault it all into RAM, otherwise the first iter
>       * of the loop below will be quite slow. We cna't use
> @@ -198,8 +186,6 @@ static int stressone(unsigned long long ramsizeMB)
>      memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
>  
>      if (random_bytes(data, PAGE_SIZE) < 0) {
> -        free(ram);
> -        free(data);
>          return -1;
>      }
>  
> @@ -227,9 +213,6 @@ static int stressone(unsigned long long ramsizeMB)
>              }
>          }
>      }
> -
> -    free(data);
> -    free(ram);
>  }
>  
>  
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

