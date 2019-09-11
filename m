Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82671C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57129206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57129206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82Yn-0006Ot-2y
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i82V0-0003uV-5K
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i82Uy-0004S5-IM
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:17:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i82Uw-0004QW-J5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:17:27 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6673C05686D
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 13:17:24 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f63so1233978wma.7
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 06:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hg4QsQhcOx5h8CrbLPif/0tiAy7CaVNkBUpMohnMFYQ=;
 b=Q0xfpbDozjxzcYnZGS3a1xfqL76a9MS0H07k2iLtFg1BM7uA5XfUgokPsykTpUxuNi
 qTSlGsnf79Vcu6VE3yx6KvLadT2zBzXZnuoneV6xEKBikdULTB9bREUHVVmN+ZLQSnd9
 D13RtK+d3UB/eTbtGYh8jnxCKkM3kNQcaikHPjibqRispMDYMedXWLpKYPe9PrKvpSnQ
 /7nv4PcRLu6D1XwNnGtjHREmkWjYt41DTm7xEhD5Tmisakb+z/mgIfpeQqndRc+5TPV8
 KglynA3WmOTxiu9XX8r3o2Q9TOn24BldFJQiiH7vtXTnOlZUzOWLHLTyyxOHZktj+8iB
 M8zA==
X-Gm-Message-State: APjAAAWfxNVWhgbgt9IZI1B2WmKSsvVjHyO/lMmy55czd8SVofDMQwRM
 IQ9mWktmZmDe2HSP19IUWbr3DSzICNFSZLmw7+txeopHcQiJQWFXAxiVsE/jP8mSQvd7t9oEjlk
 APmXASCoqcOv2az0=
X-Received: by 2002:adf:e986:: with SMTP id h6mr31565848wrm.59.1568207843469; 
 Wed, 11 Sep 2019 06:17:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxn6WZQIKZHOQvj93lQdzh1MMi+BjkeG7n/P+IsSq+1ASTvsv66FMGixvN/Cc39OtVemidyYg==
X-Received: by 2002:adf:e986:: with SMTP id h6mr31565815wrm.59.1568207843046; 
 Wed, 11 Sep 2019 06:17:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:102b:3795:6714:7df6?
 ([2001:b07:6468:f312:102b:3795:6714:7df6])
 by smtp.gmail.com with ESMTPSA id q14sm45237767wrc.77.2019.09.11.06.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2019 06:17:22 -0700 (PDT)
To: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
Date: Wed, 11 Sep 2019 15:17:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible
 issues
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
Cc: QEMU Developers - ARM <qemu-arm@nongnu.org>,
 lizhengui <lizhengui@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note that the RCU thread is expected to sit most of the time doing 
nothing, so I don't think this matters.

Zhengui's theory that notify_me doesn't work properly on ARM is more
promising, but he couldn't provide a clear explanation of why he thought
notify_me is involved.  In particular, I would have expected notify_me to
be wrong if the qemu_poll_ns call came from aio_ctx_dispatch, for example:


    glib_pollfds_fill
      g_main_context_prepare
        aio_ctx_prepare
          atomic_or(&ctx->notify_me, 1)
    qemu_poll_ns
    glib_pollfds_poll
      g_main_context_check
        aio_ctx_check
          atomic_and(&ctx->notify_me, ~1)
      g_main_context_dispatch
        aio_ctx_dispatch
          /* do something for event */
            qemu_poll_ns 

but all backtraces show thread 1 in os_host_main_loop_wait:

Thread 1 (Thread 0x40000b573370 (LWP 27214)):
#0  0x000040000a489020 in ppoll () from /lib64/libc.so.6
#1  0x0000aaaaaadaefc0 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/bits/poll2.h:77
#2  qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=<optimized out>) at qemu_timer.c:391
#3  0x0000aaaaaadae014 in os_host_main_loop_wait (timeout=<optimized out>) at main_loop.c:272
#4  0x0000aaaaaadae190 in main_loop_wait (nonblocking=<optimized out>) at main_loop.c:534
#5  0x0000aaaaaad97be0 in convert_do_copy (s=0xffffdc32eb48) at qemu-img.c:1923
#6  0x0000aaaaaada2d70 in img_convert (argc=<optimized out>, argv=<optimized out>) at qemu-img.c:2414
#7  0x0000aaaaaad99ac4 in main (argc=7, argv=<optimized out>) at qemu-img.c:5305

Can you place somewhere your util/async.o object file for me to look at it?

Anyway:

On 11/09/19 04:15, Rafael David Tinoco wrote:
> I've caught the following stack trace after an HUNG in qemu-img convert:
> 
> (gdb) bt
> #0 syscall ()
> #1 0x0000aaaaaabd41cc in qemu_futex_wait
> #2 qemu_event_wait (ev=ev@entry=0xaaaaaac86ce8 <rcu_call_ready_event>)
> #3 0x0000aaaaaabed05c in call_rcu_thread
> #4 0x0000aaaaaabd34c8 in qemu_thread_start
> #5 0x0000ffffbf25c880 in start_thread
> #6 0x0000ffffbf1b6b9c in thread_start ()
> 
> (gdb) print rcu_call_ready_event
> $4 = {value = 4294967295, initialized = true}
> 
> value INT_MAX (4294967295) seems WRONG for qemu_futex_wait():

This is UINT_MAX, not INT_MAX.  qemu_futex_wait() doesn't care of the 
signedness of the value, which is why it is declared as void *.  (That said,
changing "ev" to "&ev->value" would be nicer indeed).

> - EV_BUSY, being -1, and passed as an argument qemu_futex_wait(void *,
> unsigned), is a two's complement, making argument into a INT_MAX when
> that's not what is expected (unless I missed something).
> 
> *** If that is the case, unsure if you, Paolo, prefer declaring
> *(QemuEvent)->value as an integer or changing EV_BUSY to "2" would okay
> here ***

You could change it to 3, but it has to have all the bits in EV_FREE 
(see atomic_or(&ev->value, EV_FREE) in qemu_event_reset).

You could also change it to -1u, but I don't see a particular need to do so.

> BUG: description:
> https://bugs.launchpad.net/qemu/+bug/1805256/comments/15
> 
> ========
> ISSUE #2
> ========
> 
> I found this when debugging lockups while in futex() in a specific ARM64
> server - https://bugs.launchpad.net/qemu/+bug/1805256 - which I'm still
> investigating.
> 
> After fixing the issue above, I'm still getting stuck into:

If you changed it to 2, it's wrong.

> - Should qemu_event_set() check return code from
> qemu_futex_wake()->qemu_futex()->syscall() in order to know if ANY
> waiter was ever woken up ? Maybe even loop until at least 1 is awaken ?

Why would it need to do so?

Paolo

