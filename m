Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDECCC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813B620727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlS9iiYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813B620727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJGG-0003am-NC
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBJFL-0003AC-Qq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBJFK-00006H-Tw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:19:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60932
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBJFK-000065-Pz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583763546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bCldrJmZ7NLkcm6c3DHVx/QP9SKNhwe6l/xqW192XA=;
 b=PlS9iiYS+6s/5fNd73TNIu/8dtNqik/JH8pb9gIfyuWWsc0qj/w+Xs1s12WW9ARzvGByaX
 gSsg51lj98Xgnlolf+SkLXvOg9DTh6G/Ybc5mMbDIBD71rArzljhflygIdk/HUGsJvYu/9
 Luuzc0seSHPQuCMXwwqOg2H9/sAVus4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-1QMlgp0JOo6J6RAWQyruQg-1; Mon, 09 Mar 2020 10:19:00 -0400
X-MC-Unique: 1QMlgp0JOo6J6RAWQyruQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E70EE8017CC;
 Mon,  9 Mar 2020 14:18:58 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-206-77.brq.redhat.com [10.40.206.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E3ED8F341;
 Mon,  9 Mar 2020 14:18:54 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:18:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 05/16] hw/i386: Remove unnecessary initialization in
 x86_cpu_new
Message-ID: <20200309151852.43b4f1c8@Igors-MacBook-Pro>
In-Reply-To: <158326544443.40452.17613849801643778536.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326544443.40452.17613849801643778536.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Tue, 03 Mar 2020 13:57:24 -0600
Babu Moger <babu.moger@amd.com> wrote:

> The function pc_cpu_pre_plug takes care of initialization of CPUX86State.
> So, remove the initialization here.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/x86.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 03b8962c98..79badcc4ec 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -103,13 +103,9 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
>  {
>      Object *cpu = NULL;
>      Error *local_err = NULL;
> -    CPUX86State *env = NULL;
>  
>      cpu = object_new(MACHINE(x86ms)->cpu_type);
>  
> -    env = &X86_CPU(cpu)->env;
> -    env->nr_dies = x86ms->smp_dies;
> -
>      object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
>      object_property_set_bool(cpu, true, "realized", &local_err);
>  
> 


