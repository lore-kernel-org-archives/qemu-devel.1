Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBDEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970D0206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtkKeYXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970D0206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4rb-0003tO-Pm
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD4qk-0003Fd-UN
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD4qj-0002su-5g
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598961195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tGkEbbK8tdGNXIXWDxYnxATTDsewwQ+W9h16itPFo4=;
 b=gtkKeYXCvp5PVaq2GoDNj4teeV60sruZMhVYjHkdXEEYck4kKgIq0XzwQcJqq59OpfJ7nH
 STwYQX8DE+bnbbIRUXYnPB2fcEQzbK/aX2MK3lkImyiWTXeMe/gVC7IbKgNKc1ybH5gdnt
 uCHD+5Af0Sd7795+FxFb2nwr4TgIZKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-izG32lE3P-aEf6kihzH8mQ-1; Tue, 01 Sep 2020 07:53:12 -0400
X-MC-Unique: izG32lE3P-aEf6kihzH8mQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1DC8CCE72;
 Tue,  1 Sep 2020 11:52:53 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5702D5C22B;
 Tue,  1 Sep 2020 11:52:52 +0000 (UTC)
Date: Tue, 1 Sep 2020 13:52:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 09/10] i386: Simplify CPUID_8000_001E for AMD
Message-ID: <20200901135249.22db38e1@imammedo-mac>
In-Reply-To: <159889938099.21294.9493474163204060713.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889938099.21294.9493474163204060713.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 13:43:01 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Remove all the hardcoded values and replace with generalized
> fields.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c |   31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ba4667b33c..d434c8545a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -395,9 +395,10 @@ static int cores_in_core_complex(int nr_cores)
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
>      uint32_t l3_cores;
>      assert(cache->size == cache->line_size * cache->associativity *
> @@ -408,10 +409,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
>  
>      /* L3 is shared among multiple cores */
>      if (cache->level == 3) {
> -        l3_cores = cores_in_core_complex(cs->nr_cores);
> -        *eax |= ((l3_cores * cs->nr_threads) - 1) << 14;
> +        l3_cores = DIV_ROUND_UP((topo_info->cores_per_die *
> +                                 topo_info->threads_per_core),
> +                                 topo_info->dies_per_pkg);

from spec:
"
NumSharingCache: number of '''logical processors''' sharing cache.
"

s/l3_cores/l3_vcpus|l3_threads/

Also why not use just:

  val = topo_info->cores_per_die * topo_info->threads_per_core



> +        *eax |= (l3_cores - 1) << 14;
>      } else {
> -        *eax |= ((cs->nr_threads - 1) << 14);
> +        *eax |= ((topo_info->threads_per_core - 1) << 14);
>      }
>  
>      assert(cache->line_size > 0);
> @@ -5994,20 +5997,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


