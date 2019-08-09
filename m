Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF3FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58222086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58222086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7Vm-0008C0-8m
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56359)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw7VK-0007m4-Pg
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw7VJ-0003FB-FK
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:12:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw7VJ-0003Ep-8y
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:12:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so6110603wme.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 09:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=esLdl4eFpkrf0X3EA9zdlUD/pVBRsE2RAYYeRr2puh0=;
 b=CVvi2A0RMtKvNS11+/ap6vIcS8VNR6RSBu960DVNibGKKm7E0Ao46VB9k0YTxE+UVz
 VqGSFakPSzrEzCZSycYnS2oGz5mNLk2c8ag0mq61u6qzHdas7Y+iNDl1ezk7DDaVpvuo
 2xA5iZr8FJE2AgjRnk7Q8zsB0zi0b5y5NM9Jw7H89jNcWuE1/0kdXgITpAV44ZTczKgE
 kcpRer7tNGCUcqZZ3DNOpCbSlrE/rJP1I6kd/3hswnxynp52C6Ce/mOaqrkwfG7CwvMm
 TeunVbE5GgLMxqouecA+eLdUvVu6W3o6q6WUuGOLuu/7jaMg2kWbr0EblqpUGoPZfKsJ
 xo4w==
X-Gm-Message-State: APjAAAX70lSa24l4RD9m+4EfKuifJLTLpcT4zTXnO9z3QsIuJee9441S
 MVyqFHsNAky+ebSMuLM1RYK6SQ==
X-Google-Smtp-Source: APXvYqwN+Yia6RcSEGHnn9RVoM6IoLOigmhaednD+MLomJutlyqz3+T4bAdhSgayfZPnz3ivNQzF4w==
X-Received: by 2002:a1c:721a:: with SMTP id n26mr3214649wmc.88.1565367152161; 
 Fri, 09 Aug 2019 09:12:32 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id c1sm7133020wmc.40.2019.08.09.09.12.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 09:12:31 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190809064645.22656-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c3c62a6a-2471-fbd5-0deb-21968799dd42@redhat.com>
Date: Fri, 9 Aug 2019 18:12:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 00/29] Tame a few "touch this,
 recompile the world" headers
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

On 8/9/19 8:46 AM, Markus Armbruster wrote:
> We have quite a few "touch this, recompile the world" headers.  My
> "build everything" tree has some 6600 objects (not counting tests and
> objects that don't depend on qemu/osdep.h).  Touching any of 54
> headers triggers a recompile of more than half of them.
> 
> This series reduces them to 46.
> 
> Six of the 54 are included always by design, via qemu/osdep.h.  These
> are
> 
>     bld/config-host.h
>     include/glib-compat.h
>     include/qemu/compiler.h
>     include/qemu/osdep.h
>     include/qemu/typedefs.h
>     include/sysemu/os-posix.h
> 
> Additionally, osdep.h includes either include/exec/poison.h or
> bld/TARGET_DIR/config-target.h.
> 
> The seven headers this series improves to my satisfaction (for now)
> are
> 
>     bld/qapi/qapi-types-common.h
>     include/block/aio.h
>     include/hw/irq.h
>     include/qemu/event_notifier.h
>     include/qemu/main-loop.h
>     include/qemu/uuid.h
>     include/sysemu/sysemu.h
> 
> Of these, block/aio.h, qemu/main-loop.h and sysemu/sysemu.h are
> particular significant, as they in turn include numerous other
> headers.
> 
> The series makes real progress on a few more, but they're still bad:
> 
>     bld/qapi/qapi-types-run-state.h
>     include/qemu/timer.h
>     include/qom/cpu.h
>     include/disas/dis-asm.h
>     include/qemu/notify.h
>     include/qemu/atomic.h
> 
> Minor improvements:
> 
>     bld/qapi/qapi-builtin-types.h
>     bld/qapi/qapi-types-sockets.h
>     include/exec/cpu-common.h
>     include/exec/hwaddr.h
>     include/exec/memattrs.h
>     include/exec/memory.h
>     include/exec/memory_ldst.inc.h
>     include/exec/memory_ldst_cached.inc.h
>     include/exec/memory_ldst_phys.inc.h
>     include/exec/ramlist.h
>     include/fpu/softfloat-types.h
>     include/hw/hotplug.h
>     include/hw/qdev-core.h
>     include/qapi/util.h
>     include/qemu/bitmap.h
>     include/qemu/bitops.h
>     include/qemu/bswap.h
>     include/qemu/coroutine.h
>     include/qemu/host-utils.h
>     include/qemu/int128.h
>     include/qemu/lockable.h
>     include/qemu/module.h
>     include/qemu/processor.h
>     include/qemu/qsp.h
>     include/qemu/queue.h
>     include/qemu/rcu.h
>     include/qemu/rcu_queue.h
>     include/qemu/sys_membarrier.h
>     include/qemu/thread-posix.h
>     include/qemu/thread.h
>     include/qom/object.h
> 
> Untouched:
> 
>     include/exec/cpu-all.h
>     include/exec/cpu-defs.h
>     tcg/i386/tcg-target.h
>     tcg/tcg-mo.h
> 
> Further improvement is certainly possible.  exec/cpu-all.h,
> exec/cpu-defs.h, exec/memory.h, hw/qdev-core.h, qemu/coroutine.h,
> qemu/lockable.h, and qom/cpu.h each pull in more than ten other
> headers, which makes them particularly wortwhile targets.
> 
> Observed patterns of #include misuse:
> 
> * Copy pasta
> 
>   I found and deleted quite a few #include that were almost certainly
>   never needed.  The most likely explanation is lazy copying from a
>   "similar" file.  My deletions produced only minor improvements,
>   though.
> 
> * "Convenience" headers
> 
>   We sometimes have a header include a bunch of other headers the
>   header itself doesn't need, so the header's users don't have to.  An
>   extreme case is hw/hw.h: it pulls in more than 40 other headers,
>   then declares just hw_error().  Most of its users need only a
>   fraction of it.  PATCH 08-09,12-18 fix that, trading the very
>   occasional convenience of not having to type a few #include
>   directives for build speed.
> 
> * "Fat" headers
> 
>   Some headers provide many things to many customers.  Bad when the
>   customers generally need only parts.  Worse when such a "fat" header
>   pulls in loads more.  This series grapples with three instances:
>   qapi/qapi-types-common.h (PATCH 03), hw/boards.h, which pulls in
>   almost 70 headers (PATCH 19-23), and sysemu/sysemu.h, which pulls in
>   more than 20 (PATCH 23-28).
> 
> * Design erosion
> 
>   Off-the-cuff additions to headers can erode design.  For instance,
>   the generated trace.h were carefully designed for minimal
>   dependencies.  We let them balloon when we added the per-vCPU
>   tracing feature a few years later.  PATCH 07 grapples with that.

What can prevent us from these misuse patterns?

Will you redo this analysis/series after each releases?

How to automate misuse checks?

Can we report some metrics and warn if there a considerable discrepancy?

