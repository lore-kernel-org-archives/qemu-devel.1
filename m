Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B475C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B9320830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B9320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8OVW-0005bE-Mw
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i8OFZ-00081W-7A
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i8OFW-0001RO-Sd
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:31:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i8OFW-0001QN-Jg
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:30:58 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B145859FF
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:30:57 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n2so11981386wru.9
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EzxjB5An8E8Nm3CM2/EY8b8NER3+fyt8UIJMRYWHAlc=;
 b=N5ZqUUVIrIzIXLUaGH1dKexhNKuP+3HrIpL2VP1CYmJwhgBoLeOY8Bl53Qn8OSeqxd
 UDKTh65f+rmiW6SJPfUTJPJwF/I7+MeTOi1KLqu2M6Cu5dG4+nA63dfF7ZyR2sGfbv6i
 5ETjlDUW3pSbL2c2dAMlC61zVcSUulqIqoflU7j9TpSGmnCw0KPGpdhCz7S3ectWcKde
 uQvVykorJ3bVkGAoSKeQXjO6akM+4bBL019zCBT4o8m4PqTUT1LfsOqKpLFK7Q/QgHJm
 8dWJ4pwqBL70Y6s7W6oTjOo3T3EstOBzXW3519F6zhds4JoHLXIXYWICz6mMFTAYOng1
 3snA==
X-Gm-Message-State: APjAAAVaj9OvlDpnRtyaqpZp4RSFFcI0gMiBikmWnZL3U2OW/1Uu7vvf
 xtVHzOvQyMFjziOrXCEvdyzuNUGo9iq1pVfSQQ8OdHly/ICdFT5disn5Fma3VDjLBIs4WYVlfvs
 0VPdVZJGuc5vKf8Y=
X-Received: by 2002:a05:600c:24d2:: with SMTP id
 18mr8411812wmu.146.1568291455937; 
 Thu, 12 Sep 2019 05:30:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQQviFx4+M42IyZRP0mSHIypU6GRz63Ve3zvGMQfxoxWMMAxw8Gmuyxrqr3nYLCF+Oa7O+tQ==
X-Received: by 2002:a05:600c:24d2:: with SMTP id
 18mr8411802wmu.146.1568291455681; 
 Thu, 12 Sep 2019 05:30:55 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h21sm19262008wrc.71.2019.09.12.05.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2019 05:30:55 -0700 (PDT)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, ehabkost@redhat.com, berrange@redhat.com,
 quintela@redhat.com
References: <20190911190622.7629-1-dgilbert@redhat.com>
 <20190911190622.7629-2-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e8802180-3c9a-97b9-dae1-5e07d7843de3@redhat.com>
Date: Thu, 12 Sep 2019 14:30:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911190622.7629-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/5] rcu: Add automatically released
 rcu_read_lock variant
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

On 11/09/19 21:06, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> RCU_READ_LOCK_AUTO takes the rcu_read_lock and then uses glib's
> g_auto infrastructure (and thus whatever the compiler's hooks are) to
> release it on all exits of the block.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/qemu/rcu.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> index 22876d1428..8768a7b60a 100644
> --- a/include/qemu/rcu.h
> +++ b/include/qemu/rcu.h
> @@ -154,6 +154,24 @@ extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
>        }),                                                                \
>        (RCUCBFunc *)g_free);
>  
> +typedef void RCUReadAuto;
> +static inline RCUReadAuto *rcu_read_auto_lock(void)
> +{
> +    rcu_read_lock();
> +    /* Anything non-NULL causes the cleanup function to be called */
> +    return (void *)0x1;

Doesn't this cause a warning (should be "(void *)(uintptr_t)1" instead)?

> +}
> +
> +static inline void rcu_read_auto_unlock(RCUReadAuto *r)
> +{
> +    rcu_read_unlock();
> +}
> +
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(RCUReadAuto, rcu_read_auto_unlock)
> +
> +#define RCU_READ_LOCK_AUTO \
> +    g_autoptr(RCUReadAuto) _rcu_read_auto = rcu_read_auto_lock()
> +
>  #ifdef __cplusplus
>  }
>  #endif
> 

Is it possible to make this a scope, like

	WITH_RCU_READ_LOCK() {
	}

?  Perhaps something like

#define WITH_RCU_READ_LOCK()  \
	WITH_RCU_READ_LOCK_(_rcu_read_auto##__COUNTER__)

#define WITH_RCU_READ_LOCK_(var) \
	for (g_autoptr(RCUReadAuto) var = rcu_read_auto_lock();
	     (var); rcu_read_auto_unlock(), (var) = NULL)

where the dummy variable doubles as an execute-once guard and the gauto
cleanup is still used in case of a "break".  I'm not sure if the above
raises a warning because of the variable declaration inside the for
loop, though.

Thanks,

Paolo

