Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059F1C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 09:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DC7214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 09:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DC7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38575 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH3YG-0006N2-Vq
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 05:41:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hH3Wu-0005Zi-Fy
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hH3Ws-00055l-Ag
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:40:28 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hH3Ws-00054l-4U
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:40:26 -0400
Received: by mail-wm1-f42.google.com with SMTP id h18so2100698wml.1
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 02:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=QA0DhC1HRtcwAmd80K3MuoV05EMEnRCrHgszvLiSkSM=;
	b=pcMomRfoxza6BUjCihCjxSuBOqC2JchC7rcXrSx/yxAdF5EzLK6sAXgP6LkhVCoDan
	mXvP8GMjASrsJ6RqY0No555fGqFxdXMzXcUhSPJ0rQpagfxyJ+hlZTUumfd+DRXWz4FZ
	VVzs8vciYkDUbGlvk+VNPnlFucqwMCspToiCm8np9YpvDobC9Hx1fkleZTyTBY3yfbkX
	ZEnT46Qzz9ABNxNpitfE5ZEPYYHztNejOOXerF98qQWXhrrfCQkBLb4i1lZDIn6Plw50
	XR0KT/ikqZOvxHxi/ajb8Yfyljh1FZ6MZC2d3MxABpWughiWT2mVG+4IFv3zlbMVoGpU
	rI1Q==
X-Gm-Message-State: APjAAAXEjv58LZuzgYssdWmHJ7bdj24UfrGNriyjoUj2EFwOeb2FnpbK
	bE8HjbdOHGN1V21Gl/uYp0Vmj+usUbg=
X-Google-Smtp-Source: APXvYqwXKEbhBSLeHrBsjCLbeucoKCBWMcZ2B4LUVvTBmCIkMradluA+WqKNJtQ+zpsFta32Lh+sAA==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr2278848wmf.107.1555580423923;
	Thu, 18 Apr 2019 02:40:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:49bf:c33a:2074:ab2?
	([2001:b07:6468:f312:49bf:c33a:2074:ab2])
	by smtp.gmail.com with ESMTPSA id
	t14sm1540473wmi.16.2019.04.18.02.40.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 02:40:23 -0700 (PDT)
To: Frank Yang <lfy@google.com>, qemu-devel <qemu-devel@nongnu.org>
References: <CAEkmjvU2chrbUnbV9GHidwrVb5roP+XCu0CmygaQnaFQAw8ALQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32307490-982c-055b-c521-16b754c46fdc@redhat.com>
Date: Thu, 18 Apr 2019 11:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAEkmjvU2chrbUnbV9GHidwrVb5roP+XCu0CmygaQnaFQAw8ALQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.42
Subject: Re: [Qemu-devel] tsan: many race conditions involving mmio
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418094021.ZLXJs0UoKKrlLOEqbqNxJDJC_od6u7GkO6jSWx1aAks@z>

On 17/04/19 21:50, Frank Yang via Qemu-devel wrote:
> What's a quick fix for stuff like this?

It's a false positive.  The access in T14 is protected via
rcu_read_lock/rcu_read_unlock.

Paolo

> WARNING: ThreadSanitizer: data race (pid=168036)
>   Write of size 8 at 0x7b900017a100 by thread T1 (mutexes: write M2141):
>     #0 free
> /toolchain/llvm/projects/compiler-rt/lib/tsan/rtl/tsan_interceptors.cc:715:3
> (qemu-system-x86_64+0x484028)
>     #1 phys_sections_free
> /usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:1455:5
> (qemu-system-x86_64+0x523608)
>     #2 address_space_dispatch_free
> /usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:3236
> (qemu-system-x86_64+0x523608)
>     #3 flatview_destroy
> /usr/local/google/home/lfy/emu/external/qemu/objs/../memory.c:290:9
> (qemu-system-x86_64+0x5bfcd1)
>     #4 call_rcu_thread
> /usr/local/google/home/lfy/emu/external/qemu/objs/../util/rcu.c:284:13
> (qemu-system-x86_64+0xb23274)
>     #5 qemu_thread_trampoline
> /usr/local/google/home/lfy/emu/external/qemu/objs/../util/qemu-thread-posix.c:551:17
> (qemu-system-x86_64+0xb033c6)
> 
>   Previous read of size 8 at 0x7b900017a100 by thread T14:
>     #0 address_space_lookup_region
> /usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:431:37
> (qemu-system-x86_64+0x51b9b8)
>     #1 address_space_translate_internal
> /usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:447
> (qemu-system-x86_64+0x51b9b8)
>     #2 flatview_do_translate
> /usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:616:15
> (qemu-system-x86_64+0x51b318)
>     #3 flatview_translate
> /usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:680:15
> (qemu-system-x86_64+0x52bf20)
>     #4 address_space_translate
> /usr/local/google/home/lfy/emu/external/qemu/objs/../include/exec/memory.h:1896
> (qemu-system-x86_64+0x52bf20)
>     #5 address_space_lduw_internal_cached
> /usr/local/google/home/lfy/emu/external/qemu/objs/../memory_ldst.inc.c:264
> (qemu-system-x86_64+0x52bf20)
>     #6 address_space_lduw_le_cached
> /usr/local/google/home/lfy/emu/external/qemu/objs/../memory_ldst.inc.c:315:12
> (qemu-system-x86_64+0x52c44b)
>     #7 lduw_le_phys_cached
> /usr/local/google/home/lfy/emu/external/qemu/objs/../memory_ldst.inc.c:334
> (qemu-system-x86_64+0x52c44b)
>     #8 virtio_lduw_phys_cached
> /usr/local/google/home/lfy/emu/external/qemu/objs/../include/hw/virtio/virtio-access.h:166:12
> (qemu-system-x86_64+0x65c97b)
>     #9 vring_avail_idx
> /usr/local/google/home/lfy/emu/external/qemu/objs/../hw/virtio/virtio.c:240
> (qemu-system-x86_64+0x65c97b)
>     #10 virtio_queue_empty
> /usr/local/google/home/lfy/emu/external/qemu/objs/../hw/virtio/virtio.c:392
> (qemu-system-x86_64+0x65c97b)
>     #11 virtio_queue_host_notifier_aio_poll
> /usr/local/google/home/lfy/emu/external/qemu/objs/../hw/virtio/virtio.c:2427
> (qemu-system-x86_64+0x65c97b)
>     #12 run_poll_handlers_once
> /usr/local/google/home/lfy/emu/external/qemu/objs/../util/aio-posix.c:502:13
> (qemu-system-x86_64+0xaffd63)
>     #13 try_poll_mode
> /usr/local/google/home/lfy/emu/external/qemu/objs/../util/aio-posix.c:587
> (qemu-system-x86_64+0xaffd63)
>     #14 aio_poll
> /usr/local/google/home/lfy/emu/external/qemu/objs/../util/aio-posix.c:618
> (qemu-system-x86_64+0xaffd63)
>     #15 iothread_run
> /usr/local/google/home/lfy/emu/external/qemu/objs/../iothread.c:64:9
> (qemu-system-x86_64+0xa53344)
>     #16 qemu_thread_trampoline
> /usr/local/google/home/lfy/emu/external/qemu/objs/../util/qemu-thread-posix.c:551:17
> (qemu-system-x86_64+0xb033c6)
> 


