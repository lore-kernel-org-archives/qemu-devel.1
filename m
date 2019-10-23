Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183D5CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06CA21906
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06CA21906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNBhA-0000XM-SC
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNBeV-0007kk-VA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNBeU-0000kS-M3
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:05:55 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iNBeU-0000jF-Cy
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:05:54 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MPp0l-1ibIW20IKp-00MtG5; Wed, 23 Oct 2019 10:05:37 +0200
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v4_3/3=5d_tests/migration=ef=bc=9afix_unre?=
 =?UTF-8?Q?achable_path_in_stress_test?=
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
References: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
 <8e28cb658bc89a14958e1a7e1073f8cda4349019.1570208781.git.maozhongyi@cmss.chinamobile.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4e8e0512-a61a-2bed-efb6-169760d77f9f@vivier.eu>
Date: Wed, 23 Oct 2019 10:05:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8e28cb658bc89a14958e1a7e1073f8cda4349019.1570208781.git.maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UEA4gYHi6Okwif0za6fyUPOTG+yKJMdOy1Rbf9VWW0BRqNmv/MB
 YuVvKbEBTrC8IylUH1dwn6h/NKXAI+CNRP/Yl0XFXso3fv2Ur2/GzVVA4bV41PXjm22g0mj
 CTGMKJVQ3mC7eXeUByY1pQoKUVyWKM2cMIhhhTWqzEuJl5AK9aeVLbCwVv5ak7gNZJzYhrs
 9PrFmw3Fy/4YtEOXQCHag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YrXGYncAVTQ=:v2ZgatPX4RwCezXvfE5MdW
 g3iS8zXIOu+jA6WriHzBVzY4GcxaHjYVnJPTxSqO+D8D8Xzw1PF8b58ouEs91r7ScfMtppyH+
 PMEEXxxCgFvizxLayA7rhPq/mgBmUJu2A/5JEeoZSQW7HYGUbVBeVZ0jtXEq3AbxqAwHfTX4o
 6mJ05Yb1t4qk0YW+6PtYH7cRTG/4+Nq/VFmZfdZEpP4F5H0eHl1LoRnQ3pJ4v0vx7NlU8sIf5
 GRibilG7vBSZrQRVo2TT3NXQm/BxIMd0VF6Zs+QPxKa+vYD/f32NwL0/Vr998mybKE/PYRzoB
 DFrDu3euDiiGMM+1X9BRoXOxyVKXXC3TWi69J4ojpjP5ZGpvQox4loLXJpYVHlfqE/e5LSmLp
 FOoF8qlLubkX1a8TwQ5P59ttAmubQZ8MHcZMDXG6SC6YWTTOuHqyxnYuiwIg4YFk19PRheCNE
 im+wnsnXPQrAC99JtlACY8k8zyHGwDUSKNiVNPQE5skIYULyS9i/1qx1WdmV6+C/5DlD1sGrS
 z367HbMbp7hQGNgkSIoXLH2LG3YA1IamAqwMwk1vKK4Qo0tHqecnAOZiD5ifQGarnbl2SJVR5
 D7rq35xLfcbm2bIn4lpUoVkI+8/TQGUbRmusnjU7Jr7Pabhjwonv72ikdUteK+tFumpjp6/Lz
 Kxz62jwoXe3oMoToT0VTcZn1MUJUYCr/dBSWGjruMorXSHGFKzCPCfW8TFRKXlAF6SNjADKuY
 OHAS88/fLPeHyRdzpg63WO1FI446BzlFT9/bVuPapDEHwGGfTae5uOZZzHV/LWL88Wdz2sUmR
 8Qa7IiA6VRTJlTeTEoFllNsLvqJslfsG+IAEgCht7x8+Sp+0pryPwCfYPXyvKHD1RCBK3yo57
 9cRY+Lm3hFEBwWw6e9BBgwwXac+fB+ZR0BXZC0AJ4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
> If stressone() or stress() exits it's because of a failure
> because the test runs forever otherwise, so change stressone
> and stress type to void to make the exit_failure() as the exit
> function of main().
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  tests/migration/stress.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index f9626d50ee..a062ef6b55 100644
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
> @@ -186,7 +186,7 @@ static int stressone(unsigned long long ramsizeMB)
>      memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
>  
>      if (random_bytes(data, PAGE_SIZE) < 0) {
> -        return -1;
> +        return;
>      }
>  
>      before = now();
> @@ -225,7 +225,7 @@ static void *stressthread(void *arg)
>      return NULL;
>  }
>  
> -static int stress(unsigned long long ramsizeGB, int ncpus)
> +static void stress(unsigned long long ramsizeGB, int ncpus)
>  {
>      size_t i;
>      unsigned long long ramsizeMB = ramsizeGB * 1024 / ncpus;
> @@ -238,8 +238,6 @@ static int stress(unsigned long long ramsizeGB, int ncpus)
>      }
>  
>      stressone(ramsizeMB);
> -
> -    return 0;
>  }
>  
>  
> @@ -335,8 +333,7 @@ int main(int argc, char **argv)
>      fprintf(stdout, "%s (%05d): INFO: RAM %llu GiB across %d CPUs\n",
>              argv0, gettid(), ramsizeGB, ncpus);
>  
> -    if (stress(ramsizeGB, ncpus) < 0)
> -        exit_failure();
> +    stress(ramsizeGB, ncpus);
>  
> -    exit_success();
> +    exit_failure();
>  }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

