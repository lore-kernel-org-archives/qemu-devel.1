Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E7FC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AA423CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AA423CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCp7-0003tS-A3
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 13:02:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hYCng-0003DI-RB
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hYCnf-0000vy-2d
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:00:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hYCne-0000sf-SF
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:00:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id o12so9499644wrj.9
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 10:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=riT6wEPLQ4KsZpojwzOKkZqvOV48mi/3Dou4pUvlc9w=;
	b=rO2zmYmyCrMoqvn5R3fxTZL0PDSNHCE5u/2hftTMxxPzRELLjcA7Fpycwm77e56GQC
	AreZvQj3HdsxDAqG3PXBcgVz/+aqwv/r/0hYKyCaW7+1QnsjcJivSrZzXs+RZ45K/Pxy
	QIAv5TxMtbpZU56kLIWDNiQkugv4+HcpTMeojF0TmV0Xi647K1cPn77txFO7kEx2Glw9
	eXDmkhS2twO7P27XG7dWYgPHF7+PUyBsFZ9U/Xv10dgmIDnfwAnEJNErcsdXsmz7Kndr
	Wxw5ZRK6vHy9cjcm831GMW9zKiXLiIJcV/NafkCYdBC87psQwpCGs3LOaA3GY4MBuvgp
	H3yA==
X-Gm-Message-State: APjAAAWYARqGqfCUezHgrnkSXijTbE/IGapArCOr76a66xK7YAYNA5+y
	bqNdaWss0B66kmMAWT6cq8/sSA==
X-Google-Smtp-Source: APXvYqzICAVp6DhymatU3IrL4xvoXhOaS3p2RhSewcASAJYZDycpiY3vNJw2QBYIzbBrx3vwke4Xpg==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr3496934wrp.352.1559667637449; 
	Tue, 04 Jun 2019 10:00:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:657f:501:149f:5617?
	([2001:b07:6468:f312:657f:501:149f:5617])
	by smtp.gmail.com with ESMTPSA id
	u11sm12507046wrn.1.2019.06.04.10.00.36
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 10:00:36 -0700 (PDT)
To: Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org,
	kvm@vger.kernel.org
References: <1558419467-7155-1-git-send-email-wanpengli@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7bca9a01-4450-df89-ac26-6b5fee103cbd@redhat.com>
Date: Tue, 4 Jun 2019 19:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558419467-7155-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] kvm: support guest access CORE cstate
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

On 21/05/19 08:17, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Allow guest reads CORE cstate when exposing host CPU power management capabilities 
> to the guest. PKG cstate is restricted to avoid a guest to get the whole package 
> information in multi-tenant scenario.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  linux-headers/linux/kvm.h | 4 +++-
>  target/i386/kvm.c         | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index b53ee59..d648fde 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -696,9 +696,11 @@ struct kvm_ioeventfd {
>  #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
>  #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
>  #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
> +#define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
>  #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
>                                                KVM_X86_DISABLE_EXITS_HLT | \
> -                                              KVM_X86_DISABLE_EXITS_PAUSE)
> +                                              KVM_X86_DISABLE_EXITS_PAUSE | \
> +                                              KVM_X86_DISABLE_EXITS_CSTATE)
>  
>  /* for KVM_ENABLE_CAP */
>  struct kvm_enable_cap {
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 3b29ce5..49a0cc1 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1645,7 +1645,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          if (disable_exits) {
>              disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
>                                KVM_X86_DISABLE_EXITS_HLT |
> -                              KVM_X86_DISABLE_EXITS_PAUSE);
> +                              KVM_X86_DISABLE_EXITS_PAUSE |
> +                              KVM_X86_DISABLE_EXITS_CSTATE);
>          }
>  
>          ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
> 

Hi,

instead of this, with the new design I've proposed QEMU will have to
save/restore the MSRs, but otherwise no change is needed to
kvm_arch_init and to the KVM headers.

Paolo

