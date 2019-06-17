Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA1DC31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 07:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197462147A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 07:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197462147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hclew-0006rW-VM
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 03:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vkuznets@redhat.com>) id 1hclcQ-00069d-CA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 02:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1hclcO-00034d-Kh
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 02:59:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hclcM-0002p3-D1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 02:59:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so7794753wmj.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 23:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=PBftxRUAXaoCPgWDmIbrWA+kygELqzLyHOo8Tk9SZVo=;
 b=ki4XTMjP5FCOIizyauTMOLIxa0ctjp1+Ffk/gQdKPnQUlFMDVfRTEgwWRCnRyoJjDf
 5S+KeMQZxxSUHEcpe8rQBDWy88hVpnIPQ5mNAbdv8xW8x5k8HduYgV1rreUg8HThJqrQ
 UaqgdNtcv2IRx94NAM8cemVR+dXUzWkBprrPjDNs4Ax6jBRS/n0jO6mdS4payFUdgytX
 MIQGXu9JlHzgFB43hizmFX87aLBVr8qkcCxWDOT6KW9FDzaufL46ZaOWj1bLQYsQGYOX
 SSgXKcEght0jen1Z5RNIaWbHaUrgVS3VAzWi6J0yB88dCHAgrlA0HfJzXAiqV53hH3N4
 2VUQ==
X-Gm-Message-State: APjAAAWtJX9WfyHrPnwNURgZt9MHxzifDT3RF5LeLSlOjbS8Z2X2ey5Z
 wNnzGADFRSlQ9ol2BpfpfQzADBZZMgY=
X-Google-Smtp-Source: APXvYqwDpkWc/xcJkyz3m26j4aI6txhTiWic9Dik6MA3bVpa3Jyy0oAbQo7MPCB94TmK53fnXfoAww==
X-Received: by 2002:a7b:c001:: with SMTP id c1mr17455160wmb.49.1560754772083; 
 Sun, 16 Jun 2019 23:59:32 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-31.net.upcbroadband.cz.
 [89.176.127.31])
 by smtp.gmail.com with ESMTPSA id u25sm8554007wmc.3.2019.06.16.23.59.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 23:59:31 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
In-Reply-To: <20190615200505.31348-1-ehabkost@redhat.com>
References: <20190615200505.31348-1-ehabkost@redhat.com>
Date: Mon, 17 Jun 2019 08:59:34 +0200
Message-ID: <87imt466jt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] i386: Fix signedness of
 hyperv_spinlock_attempts
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> The current default value for hv-spinlocks is 0xFFFFFFFF (meaning
> "never retry").  However, the value is stored as a signed
> integer, making the getter of the hv-spinlocks QOM property
> return -1 instead of 0xFFFFFFFF.
>
> Fix this by changing the type of X86CPU::hyperv_spinlock_attempts
> to uint32_t.  This has no visible effect to guest operating
> systems, affecting just the behavior of the QOM getter.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0732e059ec..8158d0de73 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1372,7 +1372,7 @@ struct X86CPU {
>  
>      bool hyperv_vapic;
>      bool hyperv_relaxed_timing;
> -    int hyperv_spinlock_attempts;
> +    uint32_t hyperv_spinlock_attempts;
>      char *hyperv_vendor_id;
>      bool hyperv_time;
>      bool hyperv_crash;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

