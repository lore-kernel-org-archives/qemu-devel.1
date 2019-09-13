Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D182C4CEC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 12:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2F42084F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 12:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2F42084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8kHQ-0008IC-SX
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 08:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i8kGC-0007kR-SA
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i8kGB-0003GF-Gk
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:01:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i8kGB-0003Fj-8J
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:01:07 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D2F7806CF
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 12:01:05 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id q10so407096wro.22
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 05:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fN3NreBGFzf7EA2veiuK2JJfFaDgjnZWRYPBpf3Fv9A=;
 b=LSz8r4rc2BMRXI04VHPBapsfvJWKgR7hNYFhNPaFVgY596duqGAlulK/C8PgcDIz2k
 jg9psitvEHDv5VIJ5uxnsJ2K9CKmdkL6GNifFTsMkk/HeX3cCK17MAwo8n6tMlj71/da
 zwitFFkBzKrKsJlAHH3bZ7s3X0tNvCBACNxEIQPMnWfxiVMblCaUEkR1C4CD21/Utkr0
 8xDi3F4Zf1I4QBpEZCMB+VhvmkytKNJKpxcRYZjfOAN63xRHRHYg60xfB4ulUsaXlglT
 +MUwVa3qu/DHPRP6qic5LfQh9G1/pwkgglhgWcM8jTBw+kZ1pRFV4J6LnEvvCfpaNjCO
 aNcQ==
X-Gm-Message-State: APjAAAWkdln5uNvTaHKZiK54pkywMpk8Ubsk0ecwUzhPnNjFLuBDbD6H
 XAurLxsb7bsdzxuOARAXnNvkBMXI2p0Yd6FvU5n6nMGaXmgcbuWTofC8BJK9zFf28RNNSozsMxy
 nBBH22tz+WexYRaI=
X-Received: by 2002:adf:f112:: with SMTP id r18mr1921513wro.88.1568376063979; 
 Fri, 13 Sep 2019 05:01:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJ9C49i1zITgzqIhIfyzIzyAQR9AbW3wDX/1LiQtem1Sa65sOXMJjlMTKE0G8UI2BwXes19Q==
X-Received: by 2002:adf:f112:: with SMTP id r18mr1921485wro.88.1568376063639; 
 Fri, 13 Sep 2019 05:01:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c5d2:4bb2:a923:3a9a?
 ([2001:b07:6468:f312:c5d2:4bb2:a923:3a9a])
 by smtp.gmail.com with ESMTPSA id u18sm2017487wmj.11.2019.09.13.05.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2019 05:01:02 -0700 (PDT)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, ehabkost@redhat.com, berrange@redhat.com,
 quintela@redhat.com
References: <20190913102538.24167-1-dgilbert@redhat.com>
 <20190913102538.24167-2-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <db74dc28-361e-a3a6-218d-0cedb83ee21d@redhat.com>
Date: Fri, 13 Sep 2019 14:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913102538.24167-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/5] rcu: Add automatically released
 rcu_read_lock variants
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/19 12:25, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> RCU_READ_LOCK_GUARD() takes the rcu_read_lock and then uses glib's
> g_auto infrastructure (and thus whatever the compiler's hooks are) to
> release it on all exits of the block.
> 
> WITH_RCU_READ_LOCK_GUARD() is similar but is used as a wrapper for the
> lock, i.e.:
> 
>    WITH_RCU_READ_LOCK_GUARD() {
>        stuff under lock
>    }
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  docs/devel/rcu.txt | 16 ++++++++++++++++
>  include/qemu/rcu.h | 25 +++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/docs/devel/rcu.txt b/docs/devel/rcu.txt
> index c84e7f42b2..d83fed2f79 100644
> --- a/docs/devel/rcu.txt
> +++ b/docs/devel/rcu.txt
> @@ -187,6 +187,22 @@ The following APIs must be used before RCU is used in a thread:
>  Note that these APIs are relatively heavyweight, and should _not_ be
>  nested.
>  
> +Convenience macros
> +==================
> +
> +Two macros are provided that automatically release the read lock at the
> +end of the scope.
> +
> +      RCU_READ_LOCK_GUARD()
> +
> +         Takes the lock and will release it at the end of the block it's
> +         used in.
> +
> +      WITH_RCU_READ_LOCK_GUARD()  { code }
> +
> +         Is used at the head of a block to protect the code within the block.
> +
> +Note that 'goto'ing out of the guarded block will also drop the lock.
>  
>  DIFFERENCES WITH LINUX
>  ======================
> diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> index 22876d1428..3a8d4cf28b 100644
> --- a/include/qemu/rcu.h
> +++ b/include/qemu/rcu.h
> @@ -154,6 +154,31 @@ extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
>        }),                                                                \
>        (RCUCBFunc *)g_free);
>  
> +typedef void RCUReadAuto;
> +static inline RCUReadAuto *rcu_read_auto_lock(void)
> +{
> +    rcu_read_lock();
> +    /* Anything non-NULL causes the cleanup function to be called */
> +    return (void *)(uintptr_t)0x1;
> +}
> +
> +static inline void rcu_read_auto_unlock(RCUReadAuto *r)
> +{
> +    rcu_read_unlock();
> +}
> +
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(RCUReadAuto, rcu_read_auto_unlock)
> +
> +#define WITH_RCU_READ_LOCK_GUARD() \
> +    WITH_RCU_READ_LOCK_GUARD_(_rcu_read_auto##__COUNTER__)
> +
> +#define WITH_RCU_READ_LOCK_GUARD_(var) \
> +    for (g_autoptr(RCUReadAuto) var = rcu_read_auto_lock(); \
> +        (var); rcu_read_auto_unlock(var), (var) = NULL)
> +
> +#define RCU_READ_LOCK_GUARD() \
> +    g_autoptr(RCUReadAuto) _rcu_read_auto = rcu_read_auto_lock()
> +
>  #ifdef __cplusplus
>  }
>  #endif
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

