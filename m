Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C49C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7961D2087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7961D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htaR5-00039K-PV
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1htaQh-0002io-3M
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1htaQf-0005sN-P7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:29:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1htaQf-0005sB-HV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:29:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so72907552edv.6
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pKoz4k0YNhIGSOgfBfhihxL4VUYRyug454y/eKA21c8=;
 b=Hoz2ebV49rg8UFYxJ1nEBjPRLAFQCzP26X4deqOFpjRaHjli8CzvzxisTFC/0elErZ
 jsepIQD8UraYxB0N9IpUEMCS/Wr32IkINJOQYRW/EcqZcwbgIm+/5fvJCjRcp2uOudNU
 qq0HE+tUwwl2IKcnFqYBPSLw5qtwubDz5Gz/DGzqVsWid3FWAJbF/wcfPTlagV4VAJci
 AfkWyd+5+hE3FbQqDsABdxQIQYuQQ2FvviyoJgCy7R/jr9ShtqjUtO9sI3P1SzisDHR9
 iMkLwqNciUU13VHomr9BZCs2+f1NXx5EDsg4N/rZRFuDVs5EN+JCUSQsQa8/yym/gqjg
 3jCg==
X-Gm-Message-State: APjAAAVh6KfzicBY+NOO7H1eJRjpUrVjBNuCebYm2Z1QgXSOY/+bw1a/
 t+z3hQtxfPYR2v801vn6ekK3sg==
X-Google-Smtp-Source: APXvYqyFb0d0Or1x0PZCLdGq074NaMHTmsN460Rivxtaahl8JBpJPTjpdaPmW3HMFrN1ikB/ruOVSQ==
X-Received: by 2002:a50:b122:: with SMTP id
 k31mr121526548edd.204.1564763356476; 
 Fri, 02 Aug 2019 09:29:16 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id x12sm17776994edr.60.2019.08.02.09.29.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:29:15 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190802160458.25681-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <565ed74a-5c6b-c1eb-035e-3eb981487de5@redhat.com>
Date: Fri, 2 Aug 2019 18:29:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190802160458.25681-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.65
Subject: Re: [Qemu-devel] [PATCH 0/3] target/mips: Convert to
 do_transaction_failed hook
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
Cc: Paul Burton <pburton@wavecomp.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing broader MIPS audience.

On 8/2/19 6:04 PM, Peter Maydell wrote:
> This patchset converts the MIPS target away from the
> old broken do_unassigned_access hook to the new (added in
> 2017...) do_transaction_failed hook.
> 
> The motivation here is:
>  * do_unassigned_access is broken because:
>     + it will be called for any kind of access to physical addresses
>       where there is no assigned device, whether that access is by the
>       CPU or by something else (like a DMA controller!), so it can
>       result in spurious guest CPU exceptions.
>     + It will also get called even when using KVM, when there's nothing
>       useful it can do.
>     + It isn't passed in the return-address within the TCG generated
>       code, so it isn't able to correctly restore the CPU state
>       before generating the exception, and so the exception will
>       often be generated with the wrong faulting guest PC value
>  * there are now only a few targets still using the old hook,
>    so if we can convert them we can delete all the old code
>    and complete this API transation. (Patches for SPARC are on
>    the list; the other user is RISCV, which accidentally
>    implemented the old hook rather than the new one recently.)
> 
> The general approach to the conversion is to check the target for
> load/store-by-physical-address operations which were previously
> implicitly causing exceptions, to see if they now need to explicitly
> check for and handle memory access failures. (The 'git grep' regexes
> in docs/devel/loads-stores.rst are useful here: the API families to
> look for are ld*_phys/st*_phys, address_space_ld/st*, and
> cpu_physical_memory*.)
> 
> For MIPS, there are none of these (the usual place where targets do
> this is hardware page table walks where the page table entries are
> loaded by physical address, and MIPS doesn't seem to have those).
> 
> Code audit out of the way, the actual hook changeover is pretty
> simple.
> 
> The complication here is the MIPS Jazz board, which has some rather
> dubious code that intercepts the do_unassigned_access hook to suppress
> generation of exceptions for invalid accesses due to data accesses,
> while leaving exceptions for invalid instruction fetches in place. I'm
> a bit dubious about whether the behaviour we have implemented here is
> really what the hardware does -- it seems pretty odd to me to not
> generate exceptions for d-side accesses but to generate them for
> i-side accesses, and looking back through git and mailing list history
> this code is here mainly as "put back the behaviour we had before a
> previous commit broke it", and that older behaviour in turn I think is
> more historical-accident than because anybody deliberately checked the
> hardware behaviour and made QEMU work that way. However, I don't have
> any real hardware to do comparative tests on, so this series retains
> the same behaviour we had before on this board, by making it intercept
> the new hook in the same way it did the old one. I've beefed up the
> comment somewhat to indicate what we're doing, why, and why it might
> not be right.
> 
> The patch series is structured in three parts:
>  * make the Jazz board code support CPUs regardless of which
>    of the two hooks they implement
>  * switch the MIPS CPUs over to implementing the new hook
>  * remove the no-longer-needed Jazz board code for the old
>    hook
> (This seemed cleaner to me than squashing the whole thing into
> a single patch that touched core mips code and the jazz board
> at the same time.)
> 
> I have tested this with:
>  * the ARC Multiboot BIOS linked to from the bug
>    https://bugs.launchpad.net/qemu/+bug/1245924 (and which
>    was the test case for needing the hook intercept)
>  * a Linux kernel for the 'mips' mips r4k machine
>  * 'make check'
> Obviously more extensive testing would be useful, but I
> don't have any other test images. I also don't have
> a KVM MIPS host, which would be worth testing to confirm
> that it also still works.
> 
> If anybody happens by some chance to still have a working
> real-hardware Magnum or PICA61 board, we could perhaps test
> how it handles accesses to invalid memory, but I suspect that
> nobody does any more :-)
> 
> thanks
> -- PMM
> 
> 
> Peter Maydell (3):
>   hw/mips/mips_jazz: Override do_transaction_failed hook
>   target/mips: Switch to do_transaction_failed() hook
>   hw/mips/mips_jazz: Remove no-longer-necessary override of
>     do_unassigned_access
> 
>  target/mips/internal.h  |  8 ++++---
>  hw/mips/mips_jazz.c     | 47 +++++++++++++++++++++++++++++------------
>  target/mips/cpu.c       |  2 +-
>  target/mips/op_helper.c | 24 +++++++--------------
>  4 files changed, 47 insertions(+), 34 deletions(-)
> 

