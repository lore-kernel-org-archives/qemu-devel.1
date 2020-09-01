Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07770C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29A020767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlH3kftU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29A020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5C7-0007FZ-TZ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD5BY-0006pS-0E
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD5BW-00060D-B1
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598962485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+uNpT0vW2xoyambPgG2z04NqPLw2Q/ZuaY0rW6P11c=;
 b=hlH3kftUHNI0VyEqHi96DoQoYzdud1r3UGU3uzAjDUU9uRjzkAh08QwDmDJ/3gGTIz4zAH
 2l2z4kqCH1E6yy6gn41bMDqRhNtFBjkLGe2NTxIilMAwrmnqsP62yS/sLsQy/9slS5zXCI
 fMZIZbsXZqFVQHouV3FALnx//S2bdco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-ilXGOTK7O-eFDgc5BQL0ww-1; Tue, 01 Sep 2020 08:14:41 -0400
X-MC-Unique: ilXGOTK7O-eFDgc5BQL0ww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93F7018A2252;
 Tue,  1 Sep 2020 12:14:40 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 214301002D50;
 Tue,  1 Sep 2020 12:14:35 +0000 (UTC)
Date: Tue, 1 Sep 2020 14:14:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 04/10] Revert "i386: Introduce
 use_epyc_apic_id_encoding in X86CPUDefinition"
Message-ID: <20200901141434.7950f3b1@imammedo-mac>
In-Reply-To: <159889935015.21294.1425332462852607813.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889935015.21294.1425332462852607813.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On Mon, 31 Aug 2020 13:42:30 -0500
Babu Moger <babu.moger@amd.com> wrote:

> This reverts commit 0c1538cb1a26287c072645f4759b9872b1596d79.
> 
> Remove the EPYC specific apicid decoding and use the generic
> default decoding.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c |   16 ----------------
>  target/i386/cpu.h |    1 -
>  2 files changed, 17 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c9c1e681c2..b72b4b08ac 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1638,10 +1638,6 @@ typedef struct X86CPUDefinition {
>      FeatureWordArray features;
>      const char *model_id;
>      CPUCaches *cache_info;
> -
> -    /* Use AMD EPYC encoding for apic id */
> -    bool use_epyc_apic_id_encoding;
> -
>      /*
>       * Definitions for alternative versions of CPU model.
>       * List is terminated by item with version == 0.
> @@ -1683,18 +1679,6 @@ static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDefinition
>      return def->versions ?: default_version_list;
>  }
>  
> -bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type)
> -{
> -    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(cpu_type));
> -
> -    assert(xcc);
> -    if (xcc->model && xcc->model->cpudef) {
> -        return xcc->model->cpudef->use_epyc_apic_id_encoding;
> -    } else {
> -        return false;
> -    }
> -}
> -
>  static CPUCaches epyc_cache_info = {
>      .l1d_cache = &(CPUCacheInfo) {
>          .type = DATA_CACHE,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index d5ad42d694..5ff8ad8427 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1918,7 +1918,6 @@ void cpu_clear_apic_feature(CPUX86State *env);
>  void host_cpuid(uint32_t function, uint32_t count,
>                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
>  void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
> -bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type);
>  
>  /* helper.c */
>  bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> 


