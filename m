Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F127AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3A220728
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAVWl6Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3A220728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYEXv-0003lX-6t
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 16:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kYEWx-0002pl-6V
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kYEWv-0003LI-DZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604003296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wZzaHMviqVkpZa7QSCxxrBkriR8R8iSg9XMVcOWnoI0=;
 b=KAVWl6NwTgqWTnrZK4AAxBq2nL6mrzGi6dY9z3NkhOd60FRd125GlzsdDV24mTKAef7OSD
 /2zMMZjw8MsDKa13PHAZq+/GC58QBvIIrLOkyvo6vvrdGwHcUc8TFQaF2n2aoIwOpp8N/f
 ZfLiT2u0FPjCwGRSkBj9SVipYG5QVao=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-RKfpN4zNNSG898VE80jMfQ-1; Thu, 29 Oct 2020 16:28:14 -0400
X-MC-Unique: RKfpN4zNNSG898VE80jMfQ-1
Received: by mail-il1-f197.google.com with SMTP id c19so2921272ilk.21
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 13:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wZzaHMviqVkpZa7QSCxxrBkriR8R8iSg9XMVcOWnoI0=;
 b=eHjYCWpIhe5cwkWYPvoz1Ux8cPk+bev89ju5gGkeHWvIck62tswQshNSskIOnLqNjz
 3pLRVQrNejr66DoXFkf89isAteS4rCNcL3MZrp7o2xGEi1QxIYNhTAcLMyG26pszVf38
 MvKldwC5SDcs5WCBowo5bRU+rqb7Qs5k2giTnYPiJOwc9m0txDo2sJjRpSlzcSG50iB3
 WHdE53GKlet3CWkG/K4VHWq60l7qV6suBNhIL35sZTv5UYBasdSLjW9kH1rYNFVOgLMp
 VMyFPEIse+6PKSELCUOvPAcvPijj9rx78iN9ILcSnIWFmOsk2yfkUN85o0OY2MtjJzDG
 YOxQ==
X-Gm-Message-State: AOAM5325Ukt6vS+1kCwxz4cgajjkRdtPLpvVaF73v2VZMR6NjGzVSBlA
 1kqpfZXJt+a5I2CiMRtIxi60gzW95lvWHpO3vB78C+TOIOQpoutCk58zPaGVlfDNEBAlz/qC4co
 9pwsSEVBYHaq6WjY=
X-Received: by 2002:a92:40d2:: with SMTP id d79mr4703470ill.7.1604003292977;
 Thu, 29 Oct 2020 13:28:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMA1kXQDDZFN/AxZ2pJ7HcZUwps9mHuCEy161RLxIL3fwIBP8gfVkmluG3D/a44QOFMxBtaw==
X-Received: by 2002:a92:40d2:: with SMTP id d79mr4703456ill.7.1604003292714;
 Thu, 29 Oct 2020 13:28:12 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id p18sm3020244ile.72.2020.10.29.13.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 13:28:11 -0700 (PDT)
Date: Thu, 29 Oct 2020 16:28:10 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: recent flakiness (intermittent hangs) of migration-test
Message-ID: <20201029202810.GD455015@xz-x1>
References: <CAFEAcA-EsEZWDbUSy6_AXym5e-wP_B4buZYG0swF946ue41WKg@mail.gmail.com>
 <20201029174124.GD3335@work-vm>
 <CAFEAcA9ex69Ov=hfb4LUQak=_bnwQc8mjUx4MgEwgSciD8Ut+A@mail.gmail.com>
 <20201029193433.GE3335@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201029193433.GE3335@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 07:34:33PM +0000, Dr. David Alan Gilbert wrote:
> > Here's qemu process 3514:
> > Thread 5 (Thread 0x3ff4affd910 (LWP 3628)):
> > #0  0x000003ff94c8d936 in futex_wait_cancelable (private=<optimized
> > out>, expected=0, futex_word=0x2aa26cd74dc)
> >     at ../sysdeps/unix/sysv/linux/futex-internal.h:88
> > #1  0x000003ff94c8d936 in __pthread_cond_wait_common (abstime=0x0,
> > mutex=0x2aa26cd7488, cond=0x2aa26cd74b0)
> >     at pthread_cond_wait.c:502
> > #2  0x000003ff94c8d936 in __pthread_cond_wait
> > (cond=cond@entry=0x2aa26cd74b0, mutex=mutex@entry=0x2aa26cd7488)
> >     at pthread_cond_wait.c:655
> > #3  0x000002aa2497072c in qemu_sem_wait (sem=sem@entry=0x2aa26cd7488)
> > at ../../util/qemu-thread-posix.c:328
> > #4  0x000002aa244f4a02 in postcopy_pause (s=0x2aa26cd7000) at
> > ../../migration/migration.c:3192

So the postcopy pause state didn't continue successfully on src due to some
reason ...

> > #5  0x000002aa244f4a02 in migration_detect_error (s=0x2aa26cd7000) at
> > ../../migration/migration.c:3255
> > #6  0x000002aa244f4a02 in migration_thread
> > (opaque=opaque@entry=0x2aa26cd7000) at
> > ../../migration/migration.c:3564
> > #7  0x000002aa2496fa3a in qemu_thread_start (args=<optimized out>) at
> > ../../util/qemu-thread-posix.c:521
> > #8  0x000003ff94c87aa8 in start_thread (arg=0x3ff4affd910) at
> > pthread_create.c:463
> > #9  0x000003ff94b7a896 in thread_start () at
> > ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

[...]

> > And here's 3528:
> > Thread 6 (Thread 0x3ff6ccfd910 (LWP 3841)):
> > #0  0x000003ffb1b8d936 in futex_wait_cancelable (private=<optimized
> > out>, expected=0, futex_word=0x2aa387a6aac)
> >     at ../sysdeps/unix/sysv/linux/futex-internal.h:88
> > #1  0x000003ffb1b8d936 in __pthread_cond_wait_common (abstime=0x0,
> > mutex=0x2aa387a6a58, cond=0x2aa387a6a80)
> >     at pthread_cond_wait.c:502
> > #2  0x000003ffb1b8d936 in __pthread_cond_wait
> > (cond=cond@entry=0x2aa387a6a80, mutex=mutex@entry=0x2aa387a6a58)
> >     at pthread_cond_wait.c:655
> > #3  0x000002aa36bf072c in qemu_sem_wait (sem=sem@entry=0x2aa387a6a58)
> > at ../../util/qemu-thread-posix.c:328
> > #4  0x000002aa366c369a in postcopy_pause_incoming (mis=<optimized
> > out>) at ../../migration/savevm.c:2541

Same on the destination side.

> > #5  0x000002aa366c369a in qemu_loadvm_state_main
> > (f=f@entry=0x2aa38897930, mis=mis@entry=0x2aa387a6820)
> >     at ../../migration/savevm.c:2615
> > #6  0x000002aa366c44fa in postcopy_ram_listen_thread
> > (opaque=opaque@entry=0x0) at ../../migration/savevm.c:1830
> > #7  0x000002aa36befa3a in qemu_thread_start (args=<optimized out>) at
> > ../../util/qemu-thread-posix.c:521
> > #8  0x000003ffb1b87aa8 in start_thread (arg=0x3ff6ccfd910) at
> > pthread_create.c:463
> > #9  0x000003ffb1a7a896 in thread_start () at
> > ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

Peter, is it possible that you enable QTEST_LOG=1 in your future migration-test
testcase and try to capture the stderr?  With the help of commit a47295014d
("migration-test: Only hide error if !QTEST_LOG", 2020-10-26), the test should
be able to dump quite some helpful information to further identify the issue.

I'll also try to find another s390 host to try reproduce on my side.

Thanks,

-- 
Peter Xu


