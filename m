Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EDDC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72EE207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFDzo/DH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72EE207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYSur-0000Iw-Kx
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 07:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYStg-0008Hb-VQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:48:45 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:33005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYSte-0005YL-LO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:48:44 -0400
Received: by mail-ej1-x62e.google.com with SMTP id 7so8217292ejm.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 04:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7fwtICbBYe+/F6OKp/YleGzOqrVbe8F1FIKS6gzp7QI=;
 b=YFDzo/DHNmBEQFdyNfvuNqpTRDhA8KlCB1pp+37iqSCDAyhOllUj+Thi7Y8XIFrhlO
 nc2WwfENCsfp+Gb9eGqc7qrfKTGGr+SbfylTME/FMqIkl/sOjdLgJDAITK/Dmuf65sNX
 i+bl0jWnbmOEWeCkuMeHVrwm7V9BBrMVlZsAsbR7lNoLM7YaV5ZOI2PaQAdhdwDhSe80
 uPphzTCcg9ujYbaYP3HxBePBojanUKdi3W0uXa74bYUa2c9uWfRPSkFH2qiO1AtCcddO
 BxK7OLwrbS5k+54QzfiFWAJJGk3tRuMvejmCBqww12V+BVAF4EOcz7YoRb3VGL8kC6A+
 KqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7fwtICbBYe+/F6OKp/YleGzOqrVbe8F1FIKS6gzp7QI=;
 b=rQlWq7nosfCLPZBXNXESS3E0h2DlJg0+I2Mc/tVOna7Wj+kFz3IIqN+87+K7ILneF4
 f/JSXYAQDjulynsvVJn+QcewrukOedlMLxatO7OFFBGDRVn+ZX22hvMYANgvkT4RtWrE
 CA6RWrMCQaYao7SpZNoiSZLLN0Un6d7SusHKBwLim7yAseYNKxFfU2AtQ9NO8zcKcelp
 HM5m3YRj+7QBH1bty7KyhVB9dwortGNLKlS+ZN6bnIRBzeWCHsuOMEE09qNghlI9xBpC
 JE+wABUM5gswtnMVHSATNg2a7PBk/jgL3IiQALqRqpwUcnNN4EK1Th3vej5Ko1GwTI6j
 1m9A==
X-Gm-Message-State: AOAM533v6aYvoicDRmCMpeSocXhWLKLdAJLh+dxo7+cYlAbL9MWADYK6
 ud2SIaD1MvuVwoNln/GWx3yEayQ75/81attwFRJtpA==
X-Google-Smtp-Source: ABdhPJzAORxe8BTR+Z662VEVet601gHym6BF2Id2UOgAq13731yx63S7jzd8iFbRvL1zi18Rq7MqQbphkghHYMuc9V4=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr2170389ejf.56.1604058520093; 
 Fri, 30 Oct 2020 04:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-EsEZWDbUSy6_AXym5e-wP_B4buZYG0swF946ue41WKg@mail.gmail.com>
 <20201029174124.GD3335@work-vm>
 <CAFEAcA9ex69Ov=hfb4LUQak=_bnwQc8mjUx4MgEwgSciD8Ut+A@mail.gmail.com>
 <20201029193433.GE3335@work-vm> <20201029202810.GD455015@xz-x1>
In-Reply-To: <20201029202810.GD455015@xz-x1>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 11:48:28 +0000
Message-ID: <CAFEAcA_ZEHHdKO+82G_e16uZkSbtH-Rjn701Nc0e7pOfk3OUoA@mail.gmail.com>
Subject: Re: recent flakiness (intermittent hangs) of migration-test
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 20:28, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Oct 29, 2020 at 07:34:33PM +0000, Dr. David Alan Gilbert wrote:
> > > Here's qemu process 3514:
> > > Thread 5 (Thread 0x3ff4affd910 (LWP 3628)):
> > > #0  0x000003ff94c8d936 in futex_wait_cancelable (private=<optimized
> > > out>, expected=0, futex_word=0x2aa26cd74dc)
> > >     at ../sysdeps/unix/sysv/linux/futex-internal.h:88
> > > #1  0x000003ff94c8d936 in __pthread_cond_wait_common (abstime=0x0,
> > > mutex=0x2aa26cd7488, cond=0x2aa26cd74b0)
> > >     at pthread_cond_wait.c:502
> > > #2  0x000003ff94c8d936 in __pthread_cond_wait
> > > (cond=cond@entry=0x2aa26cd74b0, mutex=mutex@entry=0x2aa26cd7488)
> > >     at pthread_cond_wait.c:655
> > > #3  0x000002aa2497072c in qemu_sem_wait (sem=sem@entry=0x2aa26cd7488)
> > > at ../../util/qemu-thread-posix.c:328
> > > #4  0x000002aa244f4a02 in postcopy_pause (s=0x2aa26cd7000) at
> > > ../../migration/migration.c:3192
>
> So the postcopy pause state didn't continue successfully on src due to some
> reason ...
>
> > > #5  0x000002aa244f4a02 in migration_detect_error (s=0x2aa26cd7000) at
> > > ../../migration/migration.c:3255
> > > #6  0x000002aa244f4a02 in migration_thread
> > > (opaque=opaque@entry=0x2aa26cd7000) at
> > > ../../migration/migration.c:3564
> > > #7  0x000002aa2496fa3a in qemu_thread_start (args=<optimized out>) at
> > > ../../util/qemu-thread-posix.c:521
> > > #8  0x000003ff94c87aa8 in start_thread (arg=0x3ff4affd910) at
> > > pthread_create.c:463
> > > #9  0x000003ff94b7a896 in thread_start () at
> > > ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
>
> [...]
>
> > > And here's 3528:
> > > Thread 6 (Thread 0x3ff6ccfd910 (LWP 3841)):
> > > #0  0x000003ffb1b8d936 in futex_wait_cancelable (private=<optimized
> > > out>, expected=0, futex_word=0x2aa387a6aac)
> > >     at ../sysdeps/unix/sysv/linux/futex-internal.h:88
> > > #1  0x000003ffb1b8d936 in __pthread_cond_wait_common (abstime=0x0,
> > > mutex=0x2aa387a6a58, cond=0x2aa387a6a80)
> > >     at pthread_cond_wait.c:502
> > > #2  0x000003ffb1b8d936 in __pthread_cond_wait
> > > (cond=cond@entry=0x2aa387a6a80, mutex=mutex@entry=0x2aa387a6a58)
> > >     at pthread_cond_wait.c:655
> > > #3  0x000002aa36bf072c in qemu_sem_wait (sem=sem@entry=0x2aa387a6a58)
> > > at ../../util/qemu-thread-posix.c:328
> > > #4  0x000002aa366c369a in postcopy_pause_incoming (mis=<optimized
> > > out>) at ../../migration/savevm.c:2541
>
> Same on the destination side.
>
> > > #5  0x000002aa366c369a in qemu_loadvm_state_main
> > > (f=f@entry=0x2aa38897930, mis=mis@entry=0x2aa387a6820)
> > >     at ../../migration/savevm.c:2615
> > > #6  0x000002aa366c44fa in postcopy_ram_listen_thread
> > > (opaque=opaque@entry=0x0) at ../../migration/savevm.c:1830
> > > #7  0x000002aa36befa3a in qemu_thread_start (args=<optimized out>) at
> > > ../../util/qemu-thread-posix.c:521
> > > #8  0x000003ffb1b87aa8 in start_thread (arg=0x3ff6ccfd910) at
> > > pthread_create.c:463
> > > #9  0x000003ffb1a7a896 in thread_start () at
> > > ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
>
> Peter, is it possible that you enable QTEST_LOG=1 in your future migration-test
> testcase and try to capture the stderr?  With the help of commit a47295014d
> ("migration-test: Only hide error if !QTEST_LOG", 2020-10-26), the test should
> be able to dump quite some helpful information to further identify the issue.

Here's the result of running just the migration test with
QTEST_LOG=1:
https://people.linaro.org/~peter.maydell/migration.log
It's 300MB because when the test hangs one of the processes
is apparently in a polling state and continues to send status
queries.

My impression is that the test is OK on an unloaded machine but
more likely to fail if the box is doing other things at the
same time. Alternatively it might be a 'parallel make check' bug.

thanks
-- PMM

