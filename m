Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CA9C2D0DA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 10:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2F2206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 10:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM3mDlpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2F2206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikQCK-0001qm-Gk
	for qemu-devel@archiver.kernel.org; Thu, 26 Dec 2019 05:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ikQBW-0001Lh-DH
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 05:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ikQBU-0007ls-2K
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 05:16:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53854
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ikQBT-0007lK-ON
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 05:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577355358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OI7A68gj2Din2DZfSwx/Et9dxWagx28W+k5yRP0svU4=;
 b=VM3mDlpEyhaChQZF2rZISemXM3zMxo6CXMMRcv/p/m16kasCDedYb51GFKwc+FQM1chDML
 7mApOiLsCzJmf9HMAFl8cfKIeQQzFetNpi0pMCHcS5rATCwhw+n4kwk1ambBpqzwTXJFZ3
 52sNzzJed4vvY250GTRY6fKAksE0fmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-qjK6VuhKMyOyvnHvnsrPgQ-1; Thu, 26 Dec 2019 05:15:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87307107ACC5;
 Thu, 26 Dec 2019 10:15:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8078B5D9CA;
 Thu, 26 Dec 2019 10:15:51 +0000 (UTC)
Date: Thu, 26 Dec 2019 11:15:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1] hw: fix using 4.2 compat in 5.0 machine types for
 i440fx/q35
Message-ID: <20191226111549.1fb99a30@redhat.com>
In-Reply-To: <20191223072856.5369-1-dplotnikov@virtuozzo.com>
References: <20191223072856.5369-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: qjK6VuhKMyOyvnHvnsrPgQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Dec 2019 10:28:56 +0300
Denis Plotnikov <dplotnikov@virtuozzo.com> wrote:

> 5.0 machine type uses 4.2 compats. This seems to be incorrect, since
> the latests machine type by now is 5.0 and it should use its own
> compat or shouldn't use any relying on the defaults.
> Seems, like this appeared because of some problems on merge/rebase.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_piix.c | 1 -
>  hw/i386/pc_q35.c  | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ffb30c32ce..846e70bc55 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -431,7 +431,6 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
>      m->alias = "pc";
>      m->is_default = 1;
>      pcmc->default_cpu_version = 1;
> -    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>  }
>  
>  DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 7398d7baa2..ddd485d608 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -354,7 +354,6 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
>      pc_q35_machine_options(m);
>      m->alias = "q35";
>      pcmc->default_cpu_version = 1;
> -    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>  }
>  
>  DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,


