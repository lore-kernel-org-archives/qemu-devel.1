Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F6DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C91F2072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV00paD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C91F2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDN5R-0004IE-LH
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 03:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kDN4S-0003p7-Kw
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:20:40 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kDN4Q-0003wD-OT
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:20:40 -0400
Received: by mail-io1-xd43.google.com with SMTP id g14so4769446iom.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zVFOIVqx+taeQIVzVnUUbjAm2esGq23+lCReOrUG5JU=;
 b=bV00paD+5b9mgIBAt0uPYpFW+fN9fq4cPzF/z8m596bTMkWtp2s9ZMTDwxR03gnJ70
 LfT4tgblBq1JvT3+btwGd0ZNKm3hJlgw0KFqASxGezteCdjVfsBGj+073q2faTWOFopj
 MFQeHpU4BWQRbTVsnmvK6ON/rAHjZptVicEhcMq2ZM9/R1TqWlw04i0ish9mqb8QcdGI
 bK86pOF3J7hESJOmDFVMdKNPHcYuySFDGOb6SKWkYcent9LAql6mwG3xEM0jO/erP5mx
 cDyF5pLaaY2X2/iHhXfCjm81RIPewutMBFAuvwqn6JHT51UCjL1plbJrnwXhzPNjh2bj
 gsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zVFOIVqx+taeQIVzVnUUbjAm2esGq23+lCReOrUG5JU=;
 b=sruK6y2yGo5sG/p/fd0ajzkVw4SircyPV+hGhNhoh58/Mi1K0WffCTJPaqQ6DGxL0x
 dgpPEKZOZcjmsgDOtkjzfvodPL+obX6TzPmse36N8Ne9uGGmoBq94QDD3YfNGxcwIqDR
 oxPUWrgpoPGFqnUZc+BmY+7i9HQcI7fUATXKfS/J9GBC6Fsra2gYnoOSqKEltyYNBTss
 9lXhyw5mEkD/bZpAPcdI/X4VQAUQOTf+7U1/M0sZMfvwzGBE0kRQLdNP5ZDfijQF5oo8
 2TnXTYbCQyviaGAg9dtJ4/VXql4ouCxg9Rqwf8TedVWfTcejtmwkr1br1Ur0FSK58Cqi
 Lq4Q==
X-Gm-Message-State: AOAM533SRfQlCjhl8HJmVzf1nEWwmeSsGVf2LNNHpaLQLmzFPsn3VQ1V
 VL8h8mOq2Cx3JPyFA0y78HyP1DLZFSt75xCZGWQ=
X-Google-Smtp-Source: ABdhPJyCoVUJjepxeCTAnvD0II9mi3LRJXkDGxGiWi3dOt5NnILghTKAwU7snIlknOaAc7MOPEruVutefvMReJJ17pI=
X-Received: by 2002:a6b:d603:: with SMTP id w3mr2475574ioa.29.1599031237263;
 Wed, 02 Sep 2020 00:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
 <159897584649.30750.3939159632943292252.stgit@naples-babu.amd.com>
In-Reply-To: <159897584649.30750.3939159632943292252.stgit@naples-babu.amd.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 2 Sep 2020 09:20:25 +0200
Message-ID: <CAM9Jb+juk1pdvMmyn+fsixpbBXPudV=G_9+_k-wh6aXoE1178A@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] i386: Simplify CPUID_8000_001d for AMD
To: Babu Moger <babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Remove all the hardcoded values and replace with generalized
> fields.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c |   31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ba4667b33c..b12addf323 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -395,11 +395,12 @@ static int cores_in_core_complex(int nr_cores)
>  }
>
>  /* Encode cache info for CPUID[8000001D] */
> -static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
> -                                uint32_t *eax, uint32_t *ebx,
> -                                uint32_t *ecx, uint32_t *edx)
> +static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> +                                       X86CPUTopoInfo *topo_info,
> +                                       uint32_t *eax, uint32_t *ebx,
> +                                       uint32_t *ecx, uint32_t *edx)
>  {
> -    uint32_t l3_cores;
> +    uint32_t l3_threads;
>      assert(cache->size == cache->line_size * cache->associativity *
>                            cache->partitions * cache->sets);
>
> @@ -408,10 +409,10 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
>
>      /* L3 is shared among multiple cores */
>      if (cache->level == 3) {
> -        l3_cores = cores_in_core_complex(cs->nr_cores);
> -        *eax |= ((l3_cores * cs->nr_threads) - 1) << 14;
> +        l3_threads = topo_info->cores_per_die * topo_info->threads_per_core;
> +        *eax |= (l3_threads - 1) << 14;
>      } else {
> -        *eax |= ((cs->nr_threads - 1) << 14);
> +        *eax |= ((topo_info->threads_per_core - 1) << 14);
>      }
>
>      assert(cache->line_size > 0);
> @@ -5994,20 +5995,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          switch (count) {
>          case 0: /* L1 dcache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
> -                                       eax, ebx, ecx, edx);
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
> +                                       &topo_info, eax, ebx, ecx, edx);
>              break;
>          case 1: /* L1 icache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs,
> -                                       eax, ebx, ecx, edx);
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
> +                                       &topo_info, eax, ebx, ecx, edx);
>              break;
>          case 2: /* L2 cache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
> -                                       eax, ebx, ecx, edx);
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
> +                                       &topo_info, eax, ebx, ecx, edx);
>              break;
>          case 3: /* L3 cache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
> -                                       eax, ebx, ecx, edx);
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
> +                                       &topo_info, eax, ebx, ecx, edx);
>              break;
>          default: /* end of info */
>              *eax = *ebx = *ecx = *edx = 0;
>
Nice clean up.
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

