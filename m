Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A9C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F5F2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F5F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdwdX-0004Rj-VR
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40963)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hdwZA-00017W-HL
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hdwKf-0001Y0-M3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:38:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hdwKe-0001QX-08
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:38:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so2859837wre.7
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 05:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PBe9hQeFMayLD/0ZRDInVi5N4QsHohL3ze/iPL3VAN0=;
 b=P/aQifjBSz2UDPSRmRDvf7jyO331JkLaRCO8dLDonh31uaKcEMLcgOFq7H/8cb+FPL
 9c9wVrC5USGUOFhTpxtwFXAx/LKKZHpBUdOrsDQV5culCLWVTV7e+LgYhZTUaNn4VOCc
 7X2aLSL+5Gzu+EVYuEPXaT4xYdB3cib+LBjg9gIfx/LQ5cgPQbbZghTQaP42hKGGKzC5
 50DgDjYXko5MLePkakLbgxBTKAs+UY/B5iGN4POAL0LekgUA+141K28ZzjH6n1X7TLY+
 HsDslrEv2xwTF2OS6HwzdAi8cJfohfOwK2WD5C2KElnwwNhPXGJAhsBHjw1WHWSIVvIu
 zYLA==
X-Gm-Message-State: APjAAAWehQpJmlg9y60SobHh/v0j9TbRbMycUGErX9bJfdrUG3myzQO1
 ZaFZUOLdm+JgtFpN3twY4sgj0w==
X-Google-Smtp-Source: APXvYqy1Jw/TS72GgFtDeH8i1rM2d4XdyxY4oOs6mdaUyGtOWtneGJJdreyqFL2pxbg4xntCGufPBA==
X-Received: by 2002:a5d:620f:: with SMTP id y15mr13438905wru.262.1561034287746; 
 Thu, 20 Jun 2019 05:38:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab?
 ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
 by smtp.gmail.com with ESMTPSA id c17sm15734547wrv.82.2019.06.20.05.38.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 05:38:07 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190619162140.133674-1-liran.alon@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bcb617b1-7d20-d2ff-81c5-9f165eae5683@redhat.com>
Date: Thu, 20 Jun 2019 14:38:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619162140.133674-1-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [QEMU PATCH v4 0/10]: target/i386: kvm: Add
 support for save and restore of nested state
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, dgilbert@redhat.com, jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/19 18:21, Liran Alon wrote:
> Hi,
> 
> This series aims to add support for QEMU to be able to migrate VMs that
> are running nested hypervisors. In order to do so, it utilizes the new
> IOCTLs introduced in KVM commit 8fcc4b5923af ("kvm: nVMX: Introduce
> KVM_CAP_NESTED_STATE") which was created for this purpose.

Applied with just three minor changes that should be uncontroversial:

> 6rd patch updates linux-headers to have updated struct kvm_nested_state.
> The updated struct now have explicit fields for the data portion.

Changed patch title to "linux-headers: sync with latest KVM headers from
Linux 5.2"

> 7rd patch add vmstate support for saving/restoring kernel integer types (e.g. __u16).
> 
> 8th patch adds support for saving and restoring nested state in order to migrate
> guests which run a nested hypervisor.

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index e924663f32..f3cf6e1b27 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1671,10 +1671,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
             struct kvm_vmx_nested_state_hdr *vmx_hdr =
                 &env->nested_state->hdr.vmx;

+            env->nested_state->format = KVM_STATE_NESTED_FORMAT_VMX;
             vmx_hdr->vmxon_pa = -1ull;
             vmx_hdr->vmcs12_pa = -1ull;
         }
-
     }

     cpu->kvm_msr_buf = g_malloc0(MSR_BUF_SIZE);

which is a no-op since KVM_STATE_NESTED_FORMAT_VMX is zero, but it's tidy.

> 9th patch add support for KVM_CAP_EXCEPTION_PAYLOAD. This new KVM capability
> allows userspace to properly distingiush between pending and injecting exceptions.
> 
> 10th patch changes the nested virtualization migration blocker to only
> be added when kernel lack support for one of the capabilities required
> for correct nested migration. i.e. Either KVM_CAP_NESTED_STATE or
> KVM_CAP_EXCEPTION_PAYLOAD.

Had to disable this for SVM unfortunately.

