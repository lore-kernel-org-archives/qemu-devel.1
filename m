Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92193C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA49208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA49208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfhOZ-0005aF-Pl
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 05:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37121)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hfhND-0004aC-At
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hfhN5-0005c6-Ra
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hfhN5-0005bK-LH
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:04:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A6403001814
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 09:04:10 +0000 (UTC)
Received: from work-vm (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EEEC5D9D3;
 Tue, 25 Jun 2019 09:04:08 +0000 (UTC)
Date: Tue, 25 Jun 2019 10:04:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190625090406.GC3226@work-vm>
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625050008.12789-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625050008.12789-3-ehabkost@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 25 Jun 2019 09:04:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/6] i386: Remove unused host_cpudef
 variable
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
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> The variable is completely unused, probably a leftover from
> previous code clean up.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  target/i386/cpu.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1bad957f6e..cf03dc786e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3133,14 +3133,8 @@ static void max_x86_cpu_initfn(Object *obj)
>          char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
>          char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
>          int family, model, stepping;
> -        X86CPUDefinition host_cpudef = { };
> -        uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
> -
> -        host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
> -        x86_cpu_vendor_words2str(host_cpudef.vendor, ebx, edx, ecx);
>  
>          host_vendor_fms(vendor, &family, &model, &stepping);
> -
>          cpu_x86_fill_model_id(model_id);
>  
>          object_property_set_str(OBJECT(cpu), vendor, "vendor", &error_abort);
> -- 
> 2.18.0.rc1.1.g3f1ff2140
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

