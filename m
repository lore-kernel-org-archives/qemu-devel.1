Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEE8C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6B3208B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zUA95hvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6B3208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqtzf-0007FA-No
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 03:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqtyu-0006m4-1V
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:50:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqtys-0007b6-5d
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:50:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id j4so24512633wrp.10
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tfeT6xEk9VyHMj6sACTjMcgaZC0sh/30Lu250Hq9+TY=;
 b=zUA95hvnLqSb4v5ApFWhIQ2gfreQrsNnIMTR6w/RSNZhmdGU90mXfvGTBkHaPlpMRT
 4Obe91imbpO4c69jchYictzaQpucfy7z8lzcOpLVBPb3CKU4zU9VTkCdN9TwXbX3W8A0
 4DLbt4HdW+LfDipTv3U8hcQ3+dhILdXNeIiO7O3zL/PRfe+cDbBt5uw8kcMdQFoupBUP
 nRO84/roXBUWuODV1r+frqcHVf6XeFnSA0bgSw2RfzK0qWlVgvVuZOQQRqqnYQbXC1S9
 FhxC3WHPVOdn8IjSUvyH8j21NdZuupBwrpKLFaPzaUXZc/GJxZ5d6MwT6mPPp8YSVfAd
 UMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tfeT6xEk9VyHMj6sACTjMcgaZC0sh/30Lu250Hq9+TY=;
 b=fUR7qLLjUNuZZWCpesun/rk3MokpfF0l17mXDosPd/mEuk6nE3C+We+WpxxKnzZxcD
 R1VuC4lJH208b/Q2rvtc2qkyL7XZIVZ+ivZK9MF3as49Bbfh/mf4bABA72mLX2lkuzuu
 qxyZK9koFDzRdx9G9rmIP1Ugatc/c8HWZSMKqtLArIl2n43Hq7KQ3A54YTySOcLejJiE
 ccnLzZkvliPzSFrDUEI/ifE/aiqy3SS4S0YenrKLncmO2zls0ekfU/BqFZ3Fim+c/ikD
 jyt89YnjI1ES861mEq/ca0AHLZB6h/SBn0w097xx2PDce3roieM/azVi2YGGghA3rQDR
 UNiQ==
X-Gm-Message-State: AOAM533SXcSfk1DwieNCVDV+Z5xE8mgFmvoqgxZhwEg8Mf0bndyzZXsF
 T5wPNluEVO+wY2+VdoJKeR5e5Q==
X-Google-Smtp-Source: ABdhPJz44vL66cPH6EVClz26ludBCWjI77CIO3U74NptJ+6yxARCdQ8WFJ0rPhsbjzYw9U0+vzYdsA==
X-Received: by 2002:adf:f082:: with SMTP id n2mr31982355wro.326.1593676200360; 
 Thu, 02 Jul 2020 00:50:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c206sm10244481wmf.36.2020.07.02.00.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 00:49:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A91801FF7E;
 Thu,  2 Jul 2020 08:49:58 +0100 (BST)
References: <87v9j7qyuh.fsf@linaro.org>
 <CAMgSi0G+_3ZVDMpYL5XYWvUyUUtP__zUCLPpRJ+adn3t7B8a7g@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Subject: Re: Race with atexit functions in system emulation
In-reply-to: <CAMgSi0G+_3ZVDMpYL5XYWvUyUUtP__zUCLPpRJ+adn3t7B8a7g@mail.gmail.com>
Date: Thu, 02 Jul 2020 08:49:58 +0100
Message-ID: <87blkyqrtl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Pavel.Dovgaluk" <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgaluk@gmail.com> writes:

> Is it true, that semihosting can be used to access (read and write) host
> files from the guest?

They can - but in these test cases we are only using semihosting for
console output and signalling an exit code at the end of the test. I
don't think that gets in the way of record/replay (aside from the exit
race described).

> In such a case it can't be used with RR for the following reasons:
> 1. We don't preserve modified files, therefore the execution result may
> change in the future runs.
> 2. Even in the case, when all the files are read only, semihosting FDs
> can't be saved, therefore it may not be used with reverse debugging.

This raises a wider question of what is the best way to indicate support
(or lack of support) for a particular device to a user? Do we need a
"replay aware" list or annotation?

>
> On Wed, Jul 1, 2020 at 2:06 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
>> Hi,
>>
>> While running some TSAN tests I ran into the following race condition:
>>
>>   WARNING: ThreadSanitizer: data race (pid=3D1605)
>>     Write of size 4 at 0x55c437814d98 by thread T2 (mutexes: write M619):
>>       #0 replay_finish
>> /home/alex.bennee/lsrc/qemu.git/replay/replay.c:393:17
>> (qemu-system-aarch64+0xc55116)
>>       #1 at_exit_wrapper() <null> (qemu-system-aarch64+0x368988)
>>       #2 handle_semihosting
>> /home/alex.bennee/lsrc/qemu.git/target/arm/helper.c:9740:25
>> (qemu-system-aarch64+0x5e75b0)
>>       #3 arm_cpu_do_interrupt
>> /home/alex.bennee/lsrc/qemu.git/target/arm/helper.c:9788:9
>> (qemu-system-aarch64+0x5e75b0)
>>       #4 cpu_handle_exception
>> /home/alex.bennee/lsrc/qemu.git/accel/tcg/cpu-exec.c:504:13
>> (qemu-system-aarch64+0x4a4690)
>>       #5 cpu_exec
>> /home/alex.bennee/lsrc/qemu.git/accel/tcg/cpu-exec.c:712:13
>> (qemu-system-aarch64+0x4a4690)
>>       #6 tcg_cpu_exec /home/alex.bennee/lsrc/qemu.git/cpus.c:1452:11
>> (qemu-system-aarch64+0x441157)
>>       #7 qemu_tcg_rr_cpu_thread_fn
>> /home/alex.bennee/lsrc/qemu.git/cpus.c:1554:21
>> (qemu-system-aarch64+0x441157)
>>       #8 qemu_thread_start
>> /home/alex.bennee/lsrc/qemu.git/util/qemu-thread-posix.c:521:9
>> (qemu-system-aarch64+0xe38bd0)
>>
>>     Previous read of size 4 at 0x55c437814d98 by main thread:
>>       #0 replay_mutex_lock
>> /home/alex.bennee/lsrc/qemu.git/replay/replay-internal.c:217:9
>> (qemu-system-aarch64+0xc55c03)
>>       #1 os_host_main_loop_wait
>> /home/alex.bennee/lsrc/qemu.git/util/main-loop.c:239:5
>> (qemu-system-aarch64+0xe5af4f)
>>       #2 main_loop_wait
>> /home/alex.bennee/lsrc/qemu.git/util/main-loop.c:518:11
>> (qemu-system-aarch64+0xe5af4f)
>>       #3 qemu_main_loop
>> /home/alex.bennee/lsrc/qemu.git/softmmu/vl.c:1664:9
>> (qemu-system-aarch64+0x5ce806)
>>       #4 main /home/alex.bennee/lsrc/qemu.git/softmmu/main.c:49:5
>> (qemu-system-aarch64+0xdbf8b7)
>>
>>     Location is global 'replay_mode' of size 4 at 0x55c437814d98
>> (qemu-system-aarch64+0x0000021a9d98)
>>
>> Basically we have a clash between semihosting wanting to do an exit,
>> which is useful for reporting status and the fact that we have atexit()
>> handlers to clean up that clash with the main loop accessing the mutex
>> while we go. Ultimately I think this is harmless as we are shutting down
>> anyway but I was wondering how we would clean something like this up?
>>
>> Should we maybe defer the exit to once the main loop has been exited
>> with a some sort of vmstop? Or could we have an atexit handler that
>> kills the main thread?
>>
>> I should point out that linux-user has a fairly heavy preexit_cleanup
>> function to do this sort of tidying up. atexit() is also fairly heavily
>> used for other devices in system emulation.
>>
>> Ideas?
>>
>> --
>> Alex Benn=C3=A9e
>>


--=20
Alex Benn=C3=A9e

