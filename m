Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71836C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4734F214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4734F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCgQo-0008CK-WE
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 04:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCgP3-00076D-HC
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCgP1-0004bT-0K
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:42:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCgP0-0004an-JY
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:42:30 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8298C7BDA2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:42:27 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id 32so297404wrk.15
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 01:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zAlxz3ekuyArKerXAyo+KvAyKVI/hFYdCrtWeyB90mU=;
 b=AUOReXZECBiWhlDcgRvD5FNk47thoN2sK+Fl7/jublKdFxVHzfBGJvS/TILy+l1p9v
 ZvBe86Kiak4yIt9soPPahxrVefsgF+eeOxWgYdqIyismehz7eqwr3DsHxPT5CTBsoYVu
 nYpLytMiih/tJSs8+CIkRU88euqOiwb1AC8bG+E/vPgTheS0/dXOjkDIN6uWVNTs+J0y
 qUkf5FQh0E6DLjgy+/3kcVa+kuE3fY/jlDDoYAUcF5K/y+E/XIG820gHJSDjmpoocFKS
 LkaZYAECGIZolBULn1VwOJ7yEHpyzo5z3+7Q+5l9oAK2nm6+ddD+oPyzmiq0C3pzYNrI
 AN2A==
X-Gm-Message-State: APjAAAUE5L3Mmbc1MPX1U/6oC9xlK1Ij0IQNb0qRLGEkVHbdV9Fx4kpn
 +LqTz/G2JHYhTZ6uuuC3h8j43zJKSY/PP3gtC4MN2Pg/ICy4goJEdlhiuX+j0UkQilGYdUhscNV
 az+9DwV+bQ6IW/WA=
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr1596885wma.119.1569314545867; 
 Tue, 24 Sep 2019 01:42:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzbNnBjbN9PwWk5gU/OGdJP98VJYxKlMcDj6yePk92Qgqy4BVw+649AnK0RYUyWJ2fxN3aOLA==
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr1596858wma.119.1569314545502; 
 Tue, 24 Sep 2019 01:42:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d958:8ffa:a1f9:6bfa?
 ([2001:b07:6468:f312:d958:8ffa:a1f9:6bfa])
 by smtp.gmail.com with ESMTPSA id r65sm1243472wmr.9.2019.09.24.01.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 01:42:24 -0700 (PDT)
Subject: Re: [PATCH] target/i386/kvm: Silence warning from Valgrind about
 uninitialized bytes
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20190924074738.13104-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dc0c0363-6795-d0cf-f7b8-a88787e34e6c@redhat.com>
Date: Tue, 24 Sep 2019 10:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924074738.13104-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/19 09:47, Thomas Huth wrote:
> When I run QEMU with KVM under Valgrind, I currently get this warning:
> 
>  Syscall param ioctl(generic) points to uninitialised byte(s)
>     at 0x95BA45B: ioctl (in /usr/lib64/libc-2.28.so)
>     by 0x429DC3: kvm_ioctl (kvm-all.c:2365)
>     by 0x51B249: kvm_arch_get_supported_msr_feature (kvm.c:469)
>     by 0x4C2A49: x86_cpu_get_supported_feature_word (cpu.c:3765)
>     by 0x4C4116: x86_cpu_expand_features (cpu.c:5065)
>     by 0x4C7F8D: x86_cpu_realizefn (cpu.c:5242)
>     by 0x5961F3: device_set_realized (qdev.c:835)
>     by 0x7038F6: property_set_bool (object.c:2080)
>     by 0x707EFE: object_property_set_qobject (qom-qobject.c:26)
>     by 0x705814: object_property_set_bool (object.c:1338)
>     by 0x498435: pc_new_cpu (pc.c:1549)
>     by 0x49C67D: pc_cpus_init (pc.c:1681)
>   Address 0x1ffeffee74 is on thread 1's stack
>   in frame #2, created by kvm_arch_get_supported_msr_feature (kvm.c:445)
> 
> It's harmless, but a little bit annoying, so silence it by properly
> initializing the whole structure with zeroes.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/i386/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 92069099ab..bd92dabea6 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -447,7 +447,7 @@ uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
>      struct {
>          struct kvm_msrs info;
>          struct kvm_msr_entry entries[1];
> -    } msr_data;
> +    } msr_data = {};
>      uint32_t ret;
>  
>      if (kvm_feature_msrs == NULL) { /* Host doesn't support feature MSRs */
> 

Queued, thanks.

Paolo

