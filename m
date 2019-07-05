Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B137C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137D521670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137D521670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVQm-0001lr-7x
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 17:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34357)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjUkY-0004kS-QW
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjUkX-0003AC-GY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:06 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:34919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjUkX-00038V-94
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:05 -0400
Received: by mail-wm1-f45.google.com with SMTP id l2so3532622wmg.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pISn2Q9TggPTN1VP8GD0C/k47o2EYKfJweJ5Uc7BVD4=;
 b=U9K29McxaB9ktC8vA4mPbSiAX3MEC4BJYTcnP6QQTCmQlPnGFbIEbj/cY+BUNLc6P3
 DRElDTX6c8PkTRy8U2f4n2kwJZscK69WpmvgV3A9cI2fkmYzd6B4depHSEmKU+1mVOop
 DRICO4ddQOxJaL2xzQlUfAULl/DZmJMVhG5Y8jh84oNzzX4GS9haRkAX8VZX+2p918KG
 rMR/g+731C3jNzc7h3VZ2crCmo4VXVz4gV20nT64w4vzGdVAx/LnRbtmoOBrRYoND7rI
 MiuFKwwAQdDa9moSVqh+mFbyGs1uqsyE3pgyZJHrNsVuZHlaVc4j/0LBB6xc8noIsz9m
 lf5g==
X-Gm-Message-State: APjAAAWplflW/8dIq8TQuZqged4OyApweuLDLewyXuwBaL3rGjzaH9iH
 XkRNR6IQwCzB8WRt4IVfwIKwaFK18AA=
X-Google-Smtp-Source: APXvYqz9U6FS8wRmKQKKYLZt2nxxfkxdMrj6EUdpVAA151WPRHNabD0+sGKq+ywwY7Gav7KnAVaBeg==
X-Received: by 2002:a1c:c005:: with SMTP id q5mr4354265wmf.59.1562358242179;
 Fri, 05 Jul 2019 13:24:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id q193sm7550647wme.8.2019.07.05.13.24.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:24:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
Message-ID: <1a23a4a6-9275-e9d2-b78c-3fe21b2ea5a6@redhat.com>
Date: Fri, 5 Jul 2019 22:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.45
Subject: Re: [Qemu-devel] [PULL 00/12] Misc bugfixes for QEMU hard freeze
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

On 05/07/19 21:50, Paolo Bonzini wrote:
> The following changes since commit 68d7ff0cff0c4905802104843cf0100543b47314:
> 
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-06-21 13:32:10 +0100)
> 
> are available in the git repository at:
> 
> 
>   git://github.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 2994e7e66a8902d0e42c5e528489ca6484c66d2d:
> 
>   ioapic: use irq number instead of vector in ioapic_eoi_broadcast (2019-07-05 18:35:43 +0200)
> 
> ----------------------------------------------------------------
> Bugfixes.
> 
> ----------------------------------------------------------------
> Alex Bennée (1):
>       target/i386: fix feature check in hyperv-stub.c
> 
> Igor Mammedov (1):
>       pc: fix possible NULL pointer dereference in pc_machine_get_device_memory_region_size()
> 
> Julio Montes (2):
>       Makefile: generate header file with the list of devices enabled
>       hw/i386: Fix linker error when ISAPC is disabled
> 
> Li Qiang (2):
>       ioapic: clear irq_eoi when updating the ioapic redirect table entry
>       ioapic: use irq number instead of vector in ioapic_eoi_broadcast
> 
> Liran Alon (1):
>       target/i386: kvm: Fix when nested state is needed for migration
> 
> Max Reitz (1):
>       i386/kvm: Fix build with -m32
> 
> Paolo Bonzini (2):
>       checkpatch: do not warn for multiline parenthesized returned value
>       minikconf: do not include variables from MINIKCONF_ARGS in config-all-devices.mak
> 
> Peter Xu (1):
>       intel_iommu: Fix unexpected unmaps during global unmap
> 
> Yan Zhao (1):
>       intel_iommu: Fix incorrect "end" for vtd_address_space_unmap
> 
>  Makefile.target           |  5 ++++
>  hw/i386/intel_iommu.c     | 71 ++++++++++++++++++++++++++++-------------------
>  hw/i386/pc.c              |  6 +++-
>  hw/i386/pc_piix.c         | 12 ++++++--
>  hw/intc/ioapic.c          | 11 ++++----
>  scripts/checkpatch.pl     |  3 +-
>  scripts/clean-includes    |  2 +-
>  scripts/create_config     |  2 ++
>  scripts/minikconf.py      |  5 +++-
>  target/i386/hyperv-stub.c |  2 +-
>  target/i386/kvm.c         |  7 +++--
>  target/i386/machine.c     |  5 ++--
>  12 files changed, 84 insertions(+), 47 deletions(-)
> 

Sent v2 with a compilation fix I had not committed. :(

Paolo

