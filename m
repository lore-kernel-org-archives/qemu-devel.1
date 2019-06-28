Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D93DC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027CB20828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027CB20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgyra-0004kR-9A
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 17:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgyqv-0003wp-AP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgyqu-0000qb-Cr
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:56:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgyqu-0000pk-6S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:56:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so10414984wma.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 14:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N0+KrtE79ca4v1/f87L6Kw5TzopVtRS4YfvxUVF02nk=;
 b=gcfUJ7alr5GHInysMbwBeSma/gX8QhIR+Dj0XHVL+RdlR0uxZIXJNspdD0DCHCN+Ge
 PuWwOsPn8SpdWDj6/zjId35rqTdGgw/XkYO8x0pLf1qQKDRqzeuLL+8js4ZRcKN8jTtE
 cGzxrqV7CueCuiFAOtLN86DARtAvmv6nNvJnt/kEYPNd0nvUTjDjLAs8MfuoDhaIPHMx
 ln1z6plDAqueVilYNv9QdWgJN4Sf3RBmbgMDlBhXdIq7LpbcQLeLq3TA4RZtUyEfzBjE
 m+LWO9KZa22t1Hb8565c+Y8Hdj4IXdW9+EEroBxwmbU8aZc3MDM+GpeeCTX/7oh5QPh8
 YB7A==
X-Gm-Message-State: APjAAAVIaGCCit7dIVUWYd0Oqzrb6VKHZX+Z0YHj41Ofax9VqaRtLMZO
 2kICGPNjYqtKcR9biGMRod107vNrH40=
X-Google-Smtp-Source: APXvYqx22dHLLkiqmOYbzUuuKi58jWxv6Kd4w8YGgiUOYaEt6jNtezcmODYU6K/bZIMX+kbsDGybZQ==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr8486169wmg.152.1561758974853; 
 Fri, 28 Jun 2019 14:56:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a5c0:d60f:9764:1c58?
 ([2001:b07:6468:f312:a5c0:d60f:9764:1c58])
 by smtp.gmail.com with ESMTPSA id b71sm2181218wmb.7.2019.06.28.14.56.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 14:56:14 -0700 (PDT)
To: Sergio Lopez <slp@redhat.com>, Maran Wilson <maran.wilson@oracle.com>
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-5-slp@redhat.com>
 <32a9e3dd-4813-f83b-166d-97864b14656a@oracle.com> <87o92hwhda.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30f0f3e2-a2a0-7eb0-1f7a-c7ef82874716@redhat.com>
Date: Fri, 28 Jun 2019 23:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87o92hwhda.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/i386: Introduce the microvm machine
 type
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
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/06/19 23:05, Sergio Lopez wrote:
> The main reason for relying on Linux's Zero Page, is to be able to
> pass the e820 table with the basic physical memory layout to the kernel
> through it, as there isn't a BIOS nor ACPI. AFAIK, we can't do that with
> PVH.

e820 is passed through both PVH and multiboot.  qboot supports all
three, and also literally three 16-bit BIOS services for use with
vmlinuz.  I agree with Maran that it would be better to use a normal
firmware and reuse the fw_cfg code from the pc and q35 machine types.

qboot doesn't do mptable yet (it can only take ACPI tables from fwcfg)
but it should be easy to lift the SeaBIOS code that generate the tables.

It should be very interesting to have a comparison between running
"firmware" code in the host vs. the guest.

Another promising thing to do is to mmap the -kernel ELF file instead of
reading it.  You still have the memcpy when it is read into guest memory
with fw_cfg, but given Linux patches the heck out of itself at boot, it
should be faster to memcpy than to mmap vmlinux directly as MAP_PRIVATE
and hen suffer a thousand CoW page faults.

Thanks,

Paolo

> I'm inclined to keep it this way, and once there's an interest to use
> the microvm machine type with a different kernel, try to find some
> common ground.

