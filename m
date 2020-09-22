Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C936C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 00:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10B9207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 00:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByZWOL3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10B9207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKVnt-0007Vo-QS
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 20:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKVmY-000737-HV
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 20:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKVmV-0005o9-UZ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 20:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600733016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L875qe4IKaNmSV4wIo6c13C8iZme6ehIbqJxbNfUJD8=;
 b=ByZWOL3gmJzDZd7uCvbMjGCMN+6uhcK558jDoeWC+CtstOKj5C20o3ef2SQaKnyYclZlf5
 NHtATrlz7OOdedDfC8HXJSs2BeI7tOg2X0rd0potoWEnhwgnypKVSAUWlGRyLfyIBbv+m4
 8dqQDPW4hl5X8qsoQwz0GnsvUYyZzVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-l5uuwHxZN22Cp_ohKGjBNA-1; Mon, 21 Sep 2020 20:03:34 -0400
X-MC-Unique: l5uuwHxZN22Cp_ohKGjBNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C02291005E64;
 Tue, 22 Sep 2020 00:03:33 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C9B460BF4;
 Tue, 22 Sep 2020 00:03:32 +0000 (UTC)
Date: Mon, 21 Sep 2020 20:03:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2] target/i386: Remove core_id assert check in CPUID
 0x8000001E
Message-ID: <20200922000332.GT57321@habkost.net>
References: <160072824160.9666.8890355282135970684.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <160072824160.9666.8890355282135970684.stgit@naples-babu.amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 05:47:28PM -0500, Babu Moger wrote:
> With x2apic enabled, configurations can have more that 255 cores.
> Noticed the device add test is hitting an assert when during cpu
> hotplug with core_id > 255. This is due to assert check in the
> CPUID 0x8000001E.
> 
> Remove the assert check and fix the problem.
> 
> Fixes the bug:
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1834200
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Queued, thanks!

> ---
> v2:
>   Resubmitting an old patch which was lost in the mix.
>   Just rebased on the latest tree.
> v1:
>   https://lore.kernel.org/qemu-devel/159257395689.52908.4409314503988289481.stgit@naples-babu.amd.com/
> 
>  target/i386/cpu.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1c58f764dc..4f1d62c838 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5912,9 +5912,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          break;
>      case 0x8000001E:
> -        assert(cpu->core_id <= 255);
> -        encode_topo_cpuid8000001e(cpu, &topo_info,
> -                                  eax, ebx, ecx, edx);
> +        if (cpu->core_id <= 255) {
> +            encode_topo_cpuid8000001e(cpu, &topo_info, eax, ebx, ecx, edx);
> +        } else {
> +            *eax = 0;
> +            *ebx = 0;
> +            *ecx = 0;
> +            *edx = 0;
> +        }
>          break;
>      case 0xC0000000:
>          *eax = env->cpuid_xlevel2;
> 

-- 
Eduardo


