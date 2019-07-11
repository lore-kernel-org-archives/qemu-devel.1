Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916E5C73C66
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDE0208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDE0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44161 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hld4K-0004f6-Va
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hld3f-00025X-5P
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hld3d-0004Ty-QW
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:40:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hld3d-0004SM-KL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:40:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so2385277wme.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 10:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+qKePFgzBQx2x0+EEDPQl5k+tNxWs2tCceDLCZgK12g=;
 b=oXGZdQTw+a7uZzoRi5HrxDPfSoTGRIB7N2+DU2ujED7/En/NyNen0hz8Ca+v18lGOK
 1r2ma+un9EBo1XzVKIPPvgGsuQXMdJX1jfOAnjMDg65JprWRmh6kaRu6X78WcV89/kqG
 3OE+nkAfsElS5fZx5JuVvKjzcKtpqnapU+ezhORmhBtuZGDCkBqmmyyCEedM3iOExZdD
 hyF03afleCS9oojfMBKYoCIOjOrMILCMNx2bRvspvBHsiwTSAbRPQbfpAXs8U4Xq0BEJ
 1zn5EbecK/R+gY3Fz6wIVECxKqD9LkFHwQMyb/vmwtGQDOvVenffkhh8Rkoh9HqF0amw
 Xpfg==
X-Gm-Message-State: APjAAAXAK+kKahehD/RwoDeie7Xk18pvJPD0ObbKR130g6YmtH1PxFU5
 O+FVlX0vkhzUUThIQPcL+EQHvQ==
X-Google-Smtp-Source: APXvYqyU+nwcTpsDznkonbEo3ackIU0/ra7BjykLsUt+T5ma4I21JVpKcf5S3pnGM/mdc47gSrbQsw==
X-Received: by 2002:a05:600c:2245:: with SMTP id
 a5mr5155113wmm.121.1562866836452; 
 Thu, 11 Jul 2019 10:40:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id h1sm3761414wrt.20.2019.07.11.10.40.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 10:40:35 -0700 (PDT)
To: Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <1562745771-8414-1-git-send-email-wanpengli@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7a787356-2086-574b-fe24-7395d84410c0@redhat.com>
Date: Thu, 11 Jul 2019 19:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562745771-8414-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH RESEND v2] target-i386: adds PV_SCHED_YIELD
 CPUID feature bit
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/19 10:02, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Adds PV_SCHED_YIELD CPUID feature bit.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> Note: kvm part is merged
> v1 -> v2:
>  * use bit 13 instead of bit 12 since bit 12 has user now
> 
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5f07d68..f4c4b6b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -902,7 +902,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
>              "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
>              NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
> -            NULL, NULL, NULL, NULL,
> +            NULL, "kvm-pv-sched-yield", NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              "kvmclock-stable-bit", NULL, NULL, NULL,
> 

Queued for 4.2, thanks.

Paolo

