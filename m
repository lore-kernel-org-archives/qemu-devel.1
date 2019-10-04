Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2156BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 07:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E136D2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 07:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E136D2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGHuj-0001zq-1O
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 03:22:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iGHtf-0001Mf-Tr
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iGHte-00084p-Od
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:21:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56401)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iGHte-00082C-Fa
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:21:02 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M3loZ-1iG0mD05C7-000vIr; Fri, 04 Oct 2019 09:20:46 +0200
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v3_3/3=5d_tests/migration=ef=bc=9afix_unre?=
 =?UTF-8?Q?achable_path_in_stress_test?=
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
References: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
 <4d7e66c152fad6230978619000766fa4d01db078.1570159624.git.maozhongyi@cmss.chinamobile.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <03660d88-52e4-f105-3f55-155736b8e179@vivier.eu>
Date: Fri, 4 Oct 2019 09:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <4d7e66c152fad6230978619000766fa4d01db078.1570159624.git.maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vtpo0DFymCnn7kKRJkL3l30vOuY3iJ92Pbjuk9oeeLwIG4J5f7j
 k53HO/r/YUaslsGb6BdLAHequo2rsnbjpM6vKWD5XjEsHfr/5oH+GtU7VXt6ehSKd8fbYWI
 jXHBH5MW7a/aOwv9vvVHx3bZMbp122AIJoQ20/Zrq6EF4hli/xquX0kkiQrqvRZy6nHFMsU
 Q4IOTKzzy0RK5AK/Tg8vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n0LsazjNWww=:DBXA/AuUUIZYvV+8te8kib
 7XPn34mk9tq2dH4gSXoViE7iXz13nyipMxPVuHGx38Nk+pqI6MjfBCbkNA2DwnWjagnAB0jg0
 /S9ClJuTDIwbzzLMZrPrWXzw9fC9O7eduyFPcoAFU5n2r91ETUrChD973Nk6wBi8cBA0Q5j2u
 ls/+pyGrKsUr4ZyBoXPCdrPJtjhvwjQANL6p1MjRDK74+7onsoKvO+UtQRnfnLQvHilRgC1L5
 XULWOH++WIzLw5eiQhuodRD0Hb8hK2QhJnkoRClL/suEC/IFN0SEmTrisUqGg8r2ON9ud9OyL
 ddK0gWaHzFAbO5Gakx8IQou6tCGwE66jQhutVgUfKJNPeYybRmPnveNA2PQ6zZOUmizS/ognp
 UWJHQ2m41Wrti6MKwefsujqRY2bXsYocOCQjx4fBZF6O46WMs4E25b0815MR0lJYb0Z8xi7xy
 cnlU6xwZ2FxFelMwRxEv6Sk9x2oinqiIEFc4XL4QIQPW5CyEhGPzEGsynbv3gPmO0R/zQyyXb
 j7peDWOr076Hh6HvrGMcAVV1v+zVrV48ccP453DAzbBUk6FtOCEzG7D6Nijx7YKfRnVau3io0
 0muOn0pXA+iGq3WMDi995n8XTqbITi0acgs/6jPHBgyV2TA2y8zg6uM8HJ0hw3Tvg+ldRb4Gf
 I1OtKwP9FkM11B8XL2itHc3iYsRWdnHM3kektHkArGVPCmEMa3IGjewUQaqaz4tIh12FDslxa
 KTMNiSUlZi5hn2SlKFSwrbpaEFRtOzFuW7R3InlSQvWYaPzq4KEmE5HNA1yLtNZ1cUOBdSofO
 CqAWqnMCuJkBaVUq2UvuvBwX40GNixnSq2DUHZXb9R3aOOg5VSas4dIbyAijJIldV2dKfiPar
 haaLPT13bBvaAql4z4o4carKrdrSs0NGEDZW3yzs0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
> If stressone() or stress() exits it's because of a failure
> because the test runs forever otherwise, so change stressone
> type to void and stress should always return -1 to make the
> path of 'if (stress(ramsizeGB, ncpus) < 0)' can be reached.
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  tests/migration/stress.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index debf34359f..b0df1323bb 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -167,7 +167,7 @@ static unsigned long long now(void)
>      return (tv.tv_sec * 1000ull) + (tv.tv_usec / 1000ull);
>  }
>  
> -static int stressone(unsigned long long ramsizeMB)
> +static void stressone(unsigned long long ramsizeMB)
>  {
>      size_t pagesPerMB = 1024 * 1024 / PAGE_SIZE;
>      g_autofree char *ram = g_malloc(ramsizeMB * 1024 * 1024);
> @@ -181,12 +181,12 @@ static int stressone(unsigned long long ramsizeMB)
>      if (!ram) {
>          fprintf(stderr, "%s (%05d): ERROR: cannot allocate %llu MB of RAM: %s\n",
>                  argv0, gettid(), ramsizeMB, strerror(errno));
> -        return -1;
> +        return;
>      }
>      if (!data) {
>          fprintf(stderr, "%s (%d): ERROR: cannot allocate %d bytes of RAM: %s\n",
>                  argv0, gettid(), PAGE_SIZE, strerror(errno));
> -        return -1;
> +        return;
>      }

Thanks to the g_malloc() you can remove this two "if () { }" blocks.

>  
>      /* We don't care about initial state, but we do want
> @@ -197,7 +197,7 @@ static int stressone(unsigned long long ramsizeMB)
>      memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
>  
>      if (random_bytes(data, PAGE_SIZE) < 0) {
> -        return -1;
> +        return;
>      }
>  
>      before = now();
> @@ -250,7 +250,7 @@ static int stress(unsigned long long ramsizeGB, int ncpus)

you can change it to "void" too
>  
>      stressone(ramsizeMB);
>  
> -    return 0;
> +    return -1;
>  }
>  
>  
> @@ -348,6 +348,4 @@ int main(int argc, char **argv)
>  
>      if (stress(ramsizeGB, ncpus) < 0)

As it exits only on failure, you can remove the "if"

>          exit_failure();
> -
> -    exit_success();

and always use exit_failure().

>  }
> 


