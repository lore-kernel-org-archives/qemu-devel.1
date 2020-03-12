Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7289C4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA82A206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JouNphuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA82A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMvp-0006Qi-Vl
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jCMv8-0005Yu-3A
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jCMv6-0006p4-PJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:26:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jCMv6-0006o3-LB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584015995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+qmfhij1SG96WLJXFWjwbc/ncPahO1Bzpx8zf1zDbc=;
 b=JouNphuTkOivQqb/3UWClsq9AgIZ6D/VGjaEDtnDVSxhjRKk2meyhkuYIB5Eg1UqY22jTY
 8vHddGFtdzTEjBRrXgGm65hvu+9W0cxJaPxaLZuNxcac9+OTOoJRt/5TwwYYCx/iZGiIqA
 1sPHOjvl2hzIA/nwhd6ND8xt2X8V8VA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-mLg8E2_kOoS-6DFgydrfQw-1; Thu, 12 Mar 2020 08:26:33 -0400
X-MC-Unique: mLg8E2_kOoS-6DFgydrfQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90E5FDB24;
 Thu, 12 Mar 2020 12:26:32 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BDEF92D2D;
 Thu, 12 Mar 2020 12:26:28 +0000 (UTC)
Date: Thu, 12 Mar 2020 13:26:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v7 10/13] i386: Introduce use_epyc_apic_id_encoding in
 X86CPUDefinition
Message-ID: <20200312132626.3e20f530@redhat.com>
In-Reply-To: <158396723514.58170.14825482171652019765.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <158396723514.58170.14825482171652019765.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Wed, 11 Mar 2020 17:53:55 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Add a boolean variable use_epyc_apic_id_encoding in X86CPUDefinition.
> This will be set if this cpu model needs to use new EPYC based
> apic id encoding.
> 
> Override the handlers with EPYC based handlers if use_epyc_apic_id_encoding
> is set. This will be done in x86_cpus_init.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c |   16 ++++++++++++++++
>  target/i386/cpu.h |    1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7361a53166..1e4400df7a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1614,6 +1614,10 @@ typedef struct X86CPUDefinition {
>      FeatureWordArray features;
>      const char *model_id;
>      CPUCaches *cache_info;
> +
> +    /* Use AMD EPYC encoding for apic id */
> +    bool use_epyc_apic_id_encoding;
> +
>      /*
>       * Definitions for alternative versions of CPU model.
>       * List is terminated by item with version == 0.
> @@ -1655,6 +1659,18 @@ static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDefinition
>      return def->versions ?: default_version_list;
>  }
>  
> +bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type)
> +{
> +    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(cpu_type));
> +
> +    assert(xcc);
> +    if (xcc->model && xcc->model->cpudef) {
> +        return xcc->model->cpudef->use_epyc_apic_id_encoding;
> +    } else {
> +        return false;
> +    }
> +}
> +
>  static CPUCaches epyc_cache_info = {
>      .l1d_cache = &(CPUCacheInfo) {
>          .type = DATA_CACHE,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7e9e963d78..6e522fcd34 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1897,6 +1897,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
>  void host_cpuid(uint32_t function, uint32_t count,
>                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
>  void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
> +bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type);
>  
>  /* helper.c */
>  bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> 
> 


