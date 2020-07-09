Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 22:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51DE20672
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 22:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBjyjc8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51DE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jten4-0005y9-VP
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 18:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtemV-0005WV-95
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 18:12:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39331
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtemS-0003fo-NO
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 18:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594332754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N1mCkufpRLREc+9eTeDoIwzlzFpK023Z9H3JMSZ4OeQ=;
 b=hBjyjc8u7j9UWzjDvqRML/n8VtVX2lrt6+h3+gwmdJTXLBd4UeeI9LJFg8yAcaoplYlbKO
 8lBYP1nsY41r32QIEWnVtSKkPqZefljIVw0aU7YefCm5qlK3LMahvF8P+JRCeYTrvyeung
 Y30XpxdhTL8xZsokLKZZksO0KlOKiN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-dHoEW4GvM6SN_yI9xHlBuA-1; Thu, 09 Jul 2020 18:12:31 -0400
X-MC-Unique: dHoEW4GvM6SN_yI9xHlBuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45726106B244;
 Thu,  9 Jul 2020 22:12:29 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AABA65D9C9;
 Thu,  9 Jul 2020 22:12:28 +0000 (UTC)
Date: Thu, 9 Jul 2020 18:12:26 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v5 1/4] target/i386: add missing vmx features for several
 CPU models
Message-ID: <20200709221226.GM780932@habkost.net>
References: <20200619073114.24303-1-chenyi.qiang@intel.com>
 <20200619073114.24303-2-chenyi.qiang@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200619073114.24303-2-chenyi.qiang@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 18:12:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


I'm very sorry for taking so long to review this.  Question
below:

On Fri, Jun 19, 2020 at 03:31:11PM +0800, Chenyi Qiang wrote:
> Add some missing VMX features in Skylake-Server, Cascadelake-Server and
> Icelake-Server CPU models based on the output of Paolo's script.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>

Why are you changing the v1 definition instead adding those new
features in a new version of the CPU model, just like you did in
patch 3/4?

> ---
>  target/i386/cpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b1b311baa2..0b309ef3ab 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3002,6 +3002,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>               VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
>               VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
>               VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
> +        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
>          .xlevel = 0x80000008,
>          .model_id = "Intel Xeon Processor (Skylake)",
>          .versions = (X86CPUVersionDefinition[]) {
> @@ -3130,6 +3131,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>               VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
>               VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
>               VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
> +        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
>          .xlevel = 0x80000008,
>          .model_id = "Intel Xeon Processor (Cascadelake)",
>          .versions = (X86CPUVersionDefinition[]) {
> @@ -3477,7 +3479,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>               VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
>               VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
>               VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
> -             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
> +             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
> +        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
>          .xlevel = 0x80000008,
>          .model_id = "Intel Xeon Processor (Icelake)",
>          .versions = (X86CPUVersionDefinition[]) {
> -- 
> 2.17.1
> 
> 

-- 
Eduardo


