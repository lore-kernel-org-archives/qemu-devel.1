Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CCAC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532982184B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532982184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNUo-0007HR-KH
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51240)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hiLpB-0007WS-Lv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hiLp9-0001oy-CC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:40:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hiLp5-0001Vx-C1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:40:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so18609961wrr.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 09:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=89JzHazKkLt0rnC7Q/hksVSrRUZdomcRTw+AhbuGiRM=;
 b=S/zAU4McjD4yfk2v47H3zZ0Q7WLcf+dfSqyXWmbupEOUCfb3QlCMdJlKkwsOa4Iy2y
 epsmHSKeGQQoC6TERw/J0DAbtF3sgyIXplIuyO2bYopl00LVKX2EhjlHJ9I2ypdnQjSu
 dSeIs2OHjUb72f6conoXYki68lPElRlQB8paYq7bVJJrnUVX4HEDUUXn6XaswyiomYGF
 WRqFkaUlRd43wNIDaADFpXTuiNtgIb0GXQsohMMCeqVKxJ+vUT14aBY61HP2kdFu0z9S
 lcv3z/otQbN4i6BvD1T0woNaDhXzSIBSLolKxMwCz/13Mg6EE2QQSK6tAxKhTDXBKsD2
 SPCA==
X-Gm-Message-State: APjAAAVSrOeLdyN2D4cLpA4gwG5Xydfn5DR4tP3KiKMONTSINDwWUG4h
 oBAp9npCd4ocY5iYcczAX01iaA==
X-Google-Smtp-Source: APXvYqy5EHQlpOFDkiKzKqbJ6+g1TVh8VsVpOr4feuxwdnA1jIV4TrmY3bMpw/b27dqFIiJf+ZfKjA==
X-Received: by 2002:a5d:470d:: with SMTP id y13mr19747003wrq.81.1562085599683; 
 Tue, 02 Jul 2019 09:39:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b8:794:183e:9e2a?
 ([2001:b07:6468:f312:b8:794:183e:9e2a])
 by smtp.gmail.com with ESMTPSA id d201sm2155255wmd.19.2019.07.02.09.39.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 09:39:58 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190624230514.53326-1-liran.alon@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6499083f-c159-1c3e-0339-87aa5b13c2c0@redhat.com>
Date: Tue, 2 Jul 2019 18:39:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190624230514.53326-1-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] target/i386: kvm: Fix when nested state is
 needed for migration
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
Cc: Karl Heubaum <karl.heubaum@oracle.com>, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/19 01:05, Liran Alon wrote:
> When vCPU is in VMX operation and enters SMM mode,
> it temporarily exits VMX operation but KVM maintained nested-state
> still stores the VMXON region physical address, i.e. even when the
> vCPU is in SMM mode then (nested_state->hdr.vmx.vmxon_pa != -1ull).
> 
> Therefore, there is no need to explicitly check for
> KVM_STATE_NESTED_SMM_VMXON to determine if it is necessary
> to save nested-state as part of migration stream.
> 
> In addition, destination must enable eVMCS if it is enabled on
> source as specified by the KVM_STATE_NESTED_EVMCS flag, even if
> the VMXON region is not set. Thus, change the code to require saving
> nested-state as part of migration stream in case it is set.
> 
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  target/i386/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 851b249d1a39..e7d72faf9e24 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -999,7 +999,7 @@ static bool vmx_nested_state_needed(void *opaque)
>  
>      return ((nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
>              ((nested_state->hdr.vmx.vmxon_pa != -1ull) ||
> -             (nested_state->hdr.vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON)));
> +             (nested_state->flags & KVM_STATE_NESTED_EVMCS)));
>  }
>  
>  static const VMStateDescription vmstate_vmx_nested_state = {
> 

Queued, thanks.

Paolo

