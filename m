Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207FCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAA420776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPvlYYn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAA420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbMp-0005eS-2B
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdbLz-00052I-8y
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:18:55 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdbLx-00043Y-Sy
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:18:54 -0400
Received: by mail-lf1-x143.google.com with SMTP id u16so10780674lfl.8
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vVSzdAKqE6KmoseQVyEwNs3FmY4GHcs3IHLEdy2oegc=;
 b=RPvlYYn8OvotsEfrR71bVlPuRagJoPNHpB7pGIWspI3ZrE/+fk/pWYCEMOd+CyrT6i
 QJAO30AFIj8U+bb/YY46h0fWBlU07kXHQELN4c8li1J0lQImh69/s4CAZwoPg98gfMnM
 U5BG0X7dAFNRusVWOAmvF1NswVEGjZB2y9j4GxmQioAFMBPAS/N8l0G7iy7+hpWraDj5
 ItrtcdNZ5MVvkYI5b1NCerVGWDjpLqLqJfZW8hTpBkI0UyHN6+n2cgnXG+Dm0F7d0X+G
 Vux+zRp+1yPXtTjqZ56lef/kMcY5r7yoXu4rpLkHSMPJ6BJQSIvJqcI7r5SjPGea18U5
 ki4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vVSzdAKqE6KmoseQVyEwNs3FmY4GHcs3IHLEdy2oegc=;
 b=L2V6zIAafgLSHiMFLVa93ZW6lJ/OL2kdqYKTHQnX1Xd83kp4qgAL7fbQyzG7p6WyQD
 KvVvmTxHoSjwqWGCjJa9JVOSYCX6hK2g4Le6lVxkQ/Xj0L0DqIdI1J8Mbu18Q4OkbCDF
 1Dcwj3aZH2eKi74+cvYTxSUzfKoRRQr81HTmz4zHkpvHz0xJi7JSr6YZYCGbsKv/b1W9
 cj3S7aWayfVtJw+vnvVSna9el3P5vaUqzHD+oEPfnuKx4co3ew4KTOO0zVuYainqJZfH
 t4GQv9CuViWaaHy0NCREzEIIxXgzlbM9RcXeDbVJqXFNdIY+yobkNGjQ8/uplsQovFJu
 a5hg==
X-Gm-Message-State: AOAM532piGogFaUYuj+yLFgnm8rlzKAi3BzjmmXSTrUKyrA7mRPOf8RM
 J9zrnve3mCRecBY9d1LCFcb7NRaxCP7b/HuJ7+Jqt1bfwmI=
X-Google-Smtp-Source: ABdhPJyoFjn7viDUMc8ev9Hnc8c2fSJHi2piAlwGpCWqm6WIAHABoS2yVsaCeTVhwG0VVXTPn4gUPufVPa3KVdk2d7s=
X-Received: by 2002:a05:6512:533:: with SMTP id o19mr763233lfc.6.1590506331790; 
 Tue, 26 May 2020 08:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200523213612.GJ382220@sff>
In-Reply-To: <20200523213612.GJ382220@sff>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 26 May 2020 11:18:47 -0400
Message-ID: <CAEyhzFtzS-OFdpPuMqsGt1a6_-VdjpoJhUQ1=s7khEUTvUx31w@mail.gmail.com>
Subject: Re: [PATCH 00/19] Add Thread Sanitizer support to QEMU
To: "Emilio G. Cota" <cota@braap.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 23 May 2020 at 17:36, Emilio G. Cota <cota@braap.org> wrote:
>
> On Fri, May 22, 2020 at 12:07:36 -0400, Robert Foley wrote:
> > This patch series continues the work done by Emilio Cota and others to =
add
> > Thread Sanitizer (TSan) support to QEMU.
> >
> > The starting point for this work was Emilio's branch here:
> > https://github.com/cota/qemu/commits/tsan
> > specifically this commit: 0be125fc0afd47218b34d2019abdd19b644f3199
> >
> > The purpose of this patch is not to fix all the TSan warnings, but to e=
nable
> > the TSan support so that QEMU developers can start using the tool.
> > We found this tool useful and even ran it on our recent changes in
> > the cpu-locks series.
> > Clearly there is work to do here to clean up all the warnings. :)
> > We have made a start to cleaning up these warnings by getting a VM to b=
oot
> > cleanly with no TSan warnings.
> > We have also made an effort to introduce enough of the TSan suppression
> > mechanisms, so that others can continue this work.
>
> Thank you for doing this work! Great to see this finally coming along.
>
> What are your plans wrt the per-cpu-lock branch? Given that some of
> the races reported here are fixed there, I think it would make sense to
> defer those patches to the per-cpu-lock series (i.e. patches 2/19, parts
> of 13/19, and 18/19) so that this series goes in first (it is a lot
> less likely to break anything).

I agree with you that we should defer my patches which overlap with
the per-cpu-lock patch series.

>
> Also, I would not worry too much about rushing to bring warnings to
> 0; what's important is that with the warnings we now know where to
> focus on, and then we can carefully fix races. In particular I think
> all annotations we add must have a comment, since otherwise we are
> at the risk of blindlessly silencing warnings of real races.

In order to re-focus the series a bit, we are planning to drop the
annotations from the series.  This allows for a bit more focus on
enabling TSan and less on bringing the warnings to 0 as you mentioned.

At the same time, we're also going to add in a bit more details to
testing.rst on how to use the various suppression mechanisms,
annotations, blacklist and suppressions.txt.

>
> > Issues:
> > - When running docker-test-quick under TSan there are several tests whi=
ch hang
> >   - The unit tests which seem to hang under TSan:
> >     test-char, test-qdev-global-props, and test-qga.
> >   - If we comment out those tests, check-unit finishes, albeit with
> >     a couple of warnings. :)
>
> I've noticed another issue (that I did not notice on my previous
> machine), which is that tsan blows up when in qht we lock all
> of the bucket's locks. We then get this assert from tsan, since
> it has a static limit of 64 mutexes held at any given time:
>
> FATAL: ThreadSanitizer CHECK failed: /build/llvm-toolchain-10-yegZYJ/llvm=
-toolchain-10-10.0.0/compiler-rt/lib/sanitizer_common/sanitizer_deadlock_de=
tector.h:67 "((n_all_locks_)) < (((sizeof(all_locks_with_contexts_)/sizeof(=
(all_locks_with_contexts_)[0]))))" (0x40, 0x40)
<snip>

> A workaround for now is to run qemu with TSAN_OPTIONS=3Ddetect_deadlocks=
=3D0,
> although selectively disabling tsan for qht_map_lock/unlock_buckets would
> be ideal (not sure if it's possible).

We have been using detect_deadlocks=3D0 to avoid this.
We will see if it is possible to disable tsan for just
qht_map_lock/unlock_buckets

>
> Another warning I'm reliably seen is:
> WARNING: ThreadSanitizer: double lock of a mutex (pid=3D489006)
>     #0 pthread_mutex_lock <null> (qemu-system-aarch64+0x457596)
>     #1 qemu_mutex_lock_impl /home/cota/src/qemu/util/qemu-thread-posix.c:=
79:11 (qemu-system-aarch64+0xaf7e3c)
>
>   Location is heap block of size 328 at 0x7b4800114900 allocated by main =
thread:
>     #0 calloc <null> (qemu-system-aarch64+0x438b80)
>     #1 g_malloc0 <null> (libglib-2.0.so.0+0x57d30)
>
>   Mutex M57 (0x7b4800114960) created at:
>     #0 pthread_mutex_init <null> (qemu-system-aarch64+0x43b74d)
>     #1 qemu_rec_mutex_init /home/cota/src/qemu/util/qemu-thread-posix.c:1=
19:11 (qemu-system-aarch64+0xaf815b)
>
> But this one seems safe to ignore.
>

This one we disabled in the suppressions.txt file.
TSan reports a double lock even when the mutex is flagged as recursive.


Thanks & Regards,
-Rob
> Thanks,
>                 E.

