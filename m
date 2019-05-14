Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C0C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DB92085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DB92085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQURF-0006z4-0e
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 06:13:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hQULC-00032T-Iw
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hQULB-0008TP-MK
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:07:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hQULB-0008SD-G8
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:07:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so14684839otq.0
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 03:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=chIQv9D9N4cd7WaO9xjFgQmQm3EB1lvib6fmJ39p2nI=;
	b=AnYWtrjYtTd3KpMNiHDcn18lfczdiTYQavZuSoI4hrowhdnj5u40IqX+12Mqf5sS+c
	D+Nw9GZ9lkswPYN1Vo7rPHSKQ7GZMOdiCF5ZUF+qcjWcYYZwgXhtJQIlh+MmggxA3q1U
	/NhDVdObQePlttkA8fd4FV1xhOS+/6cEwD9W+MPqAX5zk2tT9sKSZP36g4aJ2uwK0xvk
	HSr76aQmchB63HsF18Rlswe37gAjequkgZVMGLeuIL1wxGyXsLWa0ZjyXdDZ1aHdBzd1
	Ai4f8NtrnXhtTU8JoebeqCHTjtnAYspdnOL8AoZVA6KL94iw/grx9dKYioh0KycjKKPu
	lYQg==
X-Gm-Message-State: APjAAAVT3+mbKVJXPSiX1TP1ws1Gu4cJLyEMQts2/LmspKsZ9/6Z8ld1
	Abu+Qcdd1kt5bc0+Qu2Zaun3SA==
X-Google-Smtp-Source: APXvYqzxX1cmi9LYja9te+FqmysKN+0+jaAB9XOqF3BSvhFapDRBnKfTBOei3YPMF0wJ+3fNb90xBA==
X-Received: by 2002:a9d:64:: with SMTP id 91mr3449996ota.19.1557828440213;
	Tue, 14 May 2019 03:07:20 -0700 (PDT)
Received: from [172.20.7.146] ([12.187.203.94])
	by smtp.gmail.com with ESMTPSA id
	z20sm5532532otm.33.2019.05.14.03.07.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 03:07:19 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190514100019.13263-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6fdd74ed-f226-1c69-6afe-6b1f2c88c59a@redhat.com>
Date: Tue, 14 May 2019 12:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514100019.13263-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.68
Subject: Re: [Qemu-devel] [PATCH 0/4] Kconfig switches for core / misc
 devices
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
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/19 12:00, Thomas Huth wrote:
> Here are some more Kconfig patches that introduce proper config
> switches for some devices in the hw/core and hw/misc directories.
> 
> Thomas Huth (4):
>   hw/core: Add a config switch for the "register" device
>   hw/core: Add a config switch for the "or-irq" device
>   hw/core: Add a config switch for the "split-irq" device
>   hw/misc: Add a config switch for the "unimplemented" device
> 
>  hw/arm/Kconfig        | 12 ++++++++++++
>  hw/core/Kconfig       |  9 +++++++++
>  hw/core/Makefile.objs |  6 +++---
>  hw/dma/Kconfig        |  1 +
>  hw/microblaze/Kconfig |  1 +
>  hw/misc/Kconfig       |  3 +++
>  hw/misc/Makefile.objs |  2 +-
>  hw/pci-host/Kconfig   |  3 ++-
>  hw/sparc64/Kconfig    |  1 +
>  hw/timer/Kconfig      |  1 +
>  10 files changed, 34 insertions(+), 5 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

