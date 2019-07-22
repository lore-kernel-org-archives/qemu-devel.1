Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2B4C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2157421911
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2157421911
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpWPr-0007s3-C4
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 07:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47841)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpWPg-0007Ta-SL
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpWPf-0001Jm-Im
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:23:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpWPf-0001Ih-Br
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:23:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so34762094wmj.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EqA8OpmMGRl3R9snNLkuHrEKYu19gzTmZJ3XTRU9D70=;
 b=FC/wF6RNZtgSRnSzfPuQrug+cT41DTJFmxIxvK4C4/n80CaTVDHz7EI0bB+Orq7JGQ
 q6IpiM3PXo6UOGzH1mFO5LUTRov96DIV7lMynVa/TzaCpeyQuQEQyVNDHC9g0uYhJ3ax
 S1Q0SK+TF+tYMJBy2KbbIl6KjtTBbP6XAVTDXGIm56IZb+lYGhbxHLrVxtZprikuK9ty
 o8O/Xh/VPpqxjxT6nb7zk1cgcspeHq0Qd9bwaT7LYLca/M117ceO1clQlE6xBUooVY5l
 /jjEbHb5z0bH6i/BSc6AyRaqOvSRz4oWr1X06MVSL0G+VWPBx01fpUJu3zD/ZLuJB86e
 WnEw==
X-Gm-Message-State: APjAAAXiaC4Wdllm8CZWzB1+DCRNlefiSOTp6TgOZw8KkYQnls0gi8XJ
 G/QzkuidII8iPSiIEWcbvlDCfsnhSi4=
X-Google-Smtp-Source: APXvYqx0RBmLelTo/RCmkMVTA8SirF4WkJI1IUs/lhUWIrztP0ESnqwaavLk/wIUVjfwtPJVYIV3PQ==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr63212553wmc.53.1563794605327; 
 Mon, 22 Jul 2019 04:23:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id x8sm33356364wmc.5.2019.07.22.04.23.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 04:23:24 -0700 (PDT)
To: Jan Kiszka <jan.kiszka@siemens.com>, Liran Alon <liran.alon@oracle.com>
References: <bdd53f40-4e60-f3ae-7ec6-162198214953@siemens.com>
 <A9036EC6-848A-4D42-95AF-42E2302EEC0B@oracle.com>
 <0972ccd9-386d-b618-f055-e8ae0181b64e@siemens.com>
 <AD612128-FB18-4E98-954D-BCF77954666B@oracle.com>
 <a0689914-e043-1ba7-dc50-15c7ad2b9cea@siemens.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <45845ea9-300a-6c01-4858-777d2be49207@redhat.com>
Date: Mon, 22 Jul 2019 13:23:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a0689914-e043-1ba7-dc50-15c7ad2b9cea@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: Do not sync nested state during
 runtime
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/07/19 12:43, Jan Kiszka wrote:
>> Currently QEMU writes to userspace maintained nested-state only at kvm_arch_init_vcpu() and
>> when loading vmstate_nested_state vmstate subsection.
>> kvm_arch_reset_vcpu() do not modify userspace maintained nested-state.
> Hmm, then we probably achieve that effect by clearing the related bit in CR4.

Almost: by clearing the VMX enable bit in MSR_IA32_FEATURE_CONTROL.
Actually I think you contributed that. :)

I think we could in principle skip that MSR write if env->nested_state
!= NULL, but it doesn't hurt either, and it makes sense that nested virt
state goes together with MSR_IA32_FEATURE_CONTROL since the latter is
indede nested virtualization related.

Paolo

> If doing that implies an invalidation of the nested state by KVM, we
> are fine. Otherwise, I would expect userspace to reset the state to
> VMCLEAR and purge any traces of prior use.

