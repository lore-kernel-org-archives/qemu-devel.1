Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2128AC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0A820815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0A820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35451 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSi25-0001DZ-0h
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 09:08:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hShtV-0003p7-Sv
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hShtU-0003oR-7y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:59:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hShtU-0003o1-0Y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:59:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so14453403wrr.13
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pkO4PC33MqiVXyJNRdC0g8/J88V1RdotEhUb7HdmXrk=;
	b=ZFcZ+L1PXX7GXxSjZO5BEM0S3DNdv9bJCx2KviNyEUBIvunB0AcOMvvfh6E3UwJm8J
	KxOSjERj1aikwdM3fWwObzuSMSn9SSXnIwhdeoSLIJGVo1BqjAYDvX0aXyKuisFdG0JR
	xsYq5/AokurjByA4W63ddrS5nFV87X/1qqsNvjdeSOqW0l9txXwGTHHeNYPTWOEa1bMG
	7Dc4Qg7PmpwK/H9zOvGu6WshnpAH9Kp+459i0RzTcJib/VhvovI7YeKEV0tmGwlmJ9qp
	CkhV6WcoXcdSuTuhxazD16QhzlyjRKF5lF3ZSx+WMY00SBLzHuWFz4TL9Vuv7EoxoRB1
	KTPg==
X-Gm-Message-State: APjAAAWzO8n4LaKAb0lyfyt2zaSGiVJ245FI+cag+R0RUOs+iK0rMCFl
	6KkODA4SNQmqs6CWrMxAHLogGg==
X-Google-Smtp-Source: APXvYqx5nismn0kDLWt2YpHHxnaA9nYk5Ow40f7u7NI9GV0L3vExEj8zGSyA+39NXUav1iOvK0tOrQ==
X-Received: by 2002:a5d:4089:: with SMTP id o9mr2703376wrp.6.1558357194916;
	Mon, 20 May 2019 05:59:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id y8sm13850354wmi.8.2019.05.20.05.59.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 05:59:54 -0700 (PDT)
To: Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org,
	kvm@vger.kernel.org
References: <1557813999-9175-1-git-send-email-wanpengli@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dcbf44c3-2fb9-02c0-79cc-c8a30373d35a@redhat.com>
Date: Mon, 20 May 2019 14:59:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557813999-9175-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] i386: Enable IA32_MISC_ENABLE MWAIT bit
 when exposing mwait/monitor
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/19 08:06, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> The CPUID.01H:ECX[bit 3] ought to mirror the value of the MSR 
> IA32_MISC_ENABLE MWAIT bit and as userspace has control of them 
> both, it is userspace's job to configure both bits to match on 
> the initial setup.

Queued, thanks.

Paolo

> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  target/i386/cpu.c | 3 +++
>  target/i386/cpu.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 722c551..40b6108 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4729,6 +4729,9 @@ static void x86_cpu_reset(CPUState *s)
>  
>      env->pat = 0x0007040600070406ULL;
>      env->msr_ia32_misc_enable = MSR_IA32_MISC_ENABLE_DEFAULT;
> +    if (enable_cpu_pm) {
> +        env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_MWAIT;
> +    }
>  
>      memset(env->dr, 0, sizeof(env->dr));
>      env->dr[6] = DR6_FIXED_1;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0128910..b94c329 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -387,6 +387,7 @@ typedef enum X86Seg {
>  #define MSR_IA32_MISC_ENABLE            0x1a0
>  /* Indicates good rep/movs microcode on some processors: */
>  #define MSR_IA32_MISC_ENABLE_DEFAULT    1
> +#define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
>  
>  #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
>  #define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)
> 


