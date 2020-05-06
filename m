Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C2C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328702073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ueKYye/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328702073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIE2-0005tn-9w
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 07:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWICM-00050R-U7
 for qemu-devel@nongnu.org; Wed, 06 May 2020 07:26:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWICL-0006PU-A5
 for qemu-devel@nongnu.org; Wed, 06 May 2020 07:26:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id h9so1776884wrt.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9ajHyZDjj19qkaeavLFsEz0T72+60eTRBcrBi5UQEGA=;
 b=ueKYye/dWfysjaldofZJ3/lO/Ggt//0+JLr7A5R1Fnfx7JLYhI5Vjt9tsJSbVjjgpM
 QIM9XQAtMAEYydEf5faGR7THZ3BryRQeE7BMP6EhPbYkWyioCMypNPUVHPDQStPTn4PC
 rKhKQt/ucU/iFApPRape0H3mkxJNh3h2mYlHKhGBzoeotNdW2UtZzpGDaoIecgPz/rj+
 M/f5WmiLYx+8U2VyTDzIOmtFkVe2byqdxNZ4okGizYvcLaFTy1QNf3V88LNxpEvdH3s4
 1lzDfNUE5+p1qkU8tXaFXFR4LdG1b+FGeTFc/SFnhmOltH7Z0WllSJQSj2I5M92gwNDo
 jYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9ajHyZDjj19qkaeavLFsEz0T72+60eTRBcrBi5UQEGA=;
 b=l+dV813rqg+IByDPMwgRI+JaBra6ub2+TrD3ACv0Q19rou+prCProT7dqUGUzq+h6u
 cXQr59FCzjHwa0OgEq7H8P3R+/qHsigIJj2mPDtMiME2RVrlE1CFGbAkYElqSOZdVOZ2
 rI32AT3GeS4kQQBYE0LwG1g9AJk/793t8U9dlbGCZFiaO7IgRpmQtnN7sTeycp5B4/6F
 GPRqEgmW3Qxqj38lprSOdqDVIdnXstcrA9r76PKCW05Zu49ObwpeP9V3KmAmvbgb+O0z
 Z7xbdNP0NveYH3hPHaVEzuYxAXvpK1UBrxC6Qd5QTLU/prl4li478llmS98QCzG5VtLC
 GA5A==
X-Gm-Message-State: AGi0PuZuja8JPWwD2fmUmK/O1315Asp0mOCCghtMBwOpAjqQox+HsSPs
 cttLAXP3wTKkumkgWs6DREvn7A==
X-Google-Smtp-Source: APiQypJLhuu5lgOu4bObuKexLgM+vWeNS8uyNtwjq1PMfIL25JEun7HrSQDuzjGo9RLZnZXYT1lRxQ==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr8770742wrn.82.1588764403506; 
 Wed, 06 May 2020 04:26:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c190sm2686177wme.10.2020.05.06.04.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 04:26:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DFB031FF7E;
 Wed,  6 May 2020 12:26:40 +0100 (BST)
References: <CAHiYmc67UNCKt0fqaGtj9d+w+qTHc3pYONqD_xLQsOXhMhKRDQ@mail.gmail.com>
 <CAHiYmc4JuaPW7VsDiqK8ToZZzdBJhJjyKB-7614xts22p00RMQ@mail.gmail.com>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [INFO] Some preliminary performance data
In-reply-to: <CAHiYmc4JuaPW7VsDiqK8ToZZzdBJhJjyKB-7614xts22p00RMQ@mail.gmail.com>
Date: Wed, 06 May 2020 12:26:40 +0100
Message-ID: <87imh95mof.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, ahmedkhaledkaraman@gmail.com,
 "Emilio G . Cota" <cota@braap.org>, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

Some preliminary thoughts....

>> Hi, all.
>>
>> I just want to share with you some bits and pieces of data that I got
>> while doing some preliminary experimentation for the GSoC project "TCG
>> Continuous Benchmarking", that Ahmed Karaman, a student of the fourth fi=
nal
>> year of Electical Engineering Faculty in Cairo, will execute.
>>
>> *User Mode*
>>
>>    * As expected, for any program dealing with any substantional
>> floating-point calculation, softfloat library will be the the heaviest C=
PU
>> cycles consumer.
>>    * We plan to examine the performance behaviour of non-FP programs
>> (integer arithmetic), or even non-numeric programs (sorting strings, for
>> example).

Emilio was the last person to do extensive bench-marking on TCG and he
used a mild fork of the venerable nbench:

  https://github.com/cota/dbt-bench

as the hot code is fairly small it offers a good way of testing quality
of the output. Larger programs will differ as they can involve more code
generation.

>>
>> *System Mode*
>>
>>    * I did profiling of booting several machines using a tool called
>> callgrind (a part of valgrind). The tool offers pletora of information,
>> however it looks it is little confused by usage of coroutines, and that
>> makes some of its reports look very illogical, or plain ugly.

Doesn't running through valgrind inherently serialise execution anyway?
If you are looking for latency caused by locks we have support for the
QEMU sync profiler built into the code. See "help sync-profile" on the HMP.

>> Still, it
>> seems valid data can be extracted from it. Without going into details, h=
ere
>> is what it says for one machine (bear in mind that results may vary to a
>> great extent between machines):

You can also use perf to use sampling to find hot points in the code.
One of last years GSoC student wrote some patches that included the
ability to dump a jit info file for perf to consume. We never got it
merged in the end but it might be worth having a go at pulling the
relevant bits out from:

  Subject: [PATCH  v9 00/13] TCG code quality tracking and perf integration
  Date: Mon,  7 Oct 2019 16:28:26 +0100
  Message-Id: <20191007152839.30804-1-alex.bennee@linaro.org>

>>      ** The booting involved six threads, one for display handling, one
>> for emulations, and four more. The last four did almost nothing during
>> boot, just almost entire time siting idle, waiting for something. As far=
 as
>> "Total Instruction Fetch Count" (this is the main measure used in
>> callgrind), they were distributed in proportion 1:3 between display thre=
ad
>> and emulation thread (the rest of threads were negligible) (but,
>> interestingly enough, for another machine that proportion was 1:20).
>>      ** The display thread is dominated by vga_update_display() function
>> (21.5% "self" time, and 51.6% "self + callees" time, called almost 40000
>> times). Other functions worth mentioning are
>> cpu_physical_memory_snapshot_get_dirty() and
>> memory_region_snapshot_get_dirty(), which are very small functions, but =
are
>> both invoked over 26 000 000 times, and contribute with over 20% of disp=
lay
>> thread instruction fetch count together.

The memory region tracking code will end up forcing the slow path for a
lot of memory accesses to video memory via softmmu. You may want to
measure if there is a difference using one of the virtio based graphics
displays.

>>      ** Focusing now on emulation thread, "Total Instruction Fetch Count=
s"
>> were roughly distributed this way:
>>            - 15.7% is execution of GIT-ed code from translation block
>> buffer
>>            - 39.9% is execution of helpers
>>            - 44.4% is code translation stage, including some coroutine
>> activities
>>         Top two among helpers:
>>           - helper_le_stl_memory()

I assume that is the MMU slow-path being called from the generated code.

>>           - helper_lookup_tb_ptr() (this one is invoked whopping 36 000
>> 000 times)

This is an optimisation to avoid exiting the run-loop to find the next
block. From memory I think the two main cases you'll see are:

 - computed jumps (i.e. target not known at JIT time)
 - jumps outside of the current page

>>         Single largest instruction consumer of code translation:
>>           - liveness_pass_1(), that constitutes 21.5% of the entire
>> "emulation thread" consumption, or, in other way, almost half of code
>> translation stage (that sits at 44.4%)

This is very much driven by how much code generation vs running you see.
In most of my personal benchmarks I never really notice code generation
because I give my machines large amounts of RAM so code tends to stay
resident so not need to be re-translated. When the optimiser shows up
it's usually accompanied by high TB flush and invalidate counts in "info
jit" because we are doing more translation that we usually do.

I'll also mention my foray into tracking down the performance regression
of DOSBox Doom:

  https://diasp.eu/posts/8659062

it presented a very nice demonstration of the increasing complexity (and
run time) of the optimiser which was completely wasted due to
self-modifying code causing us to regenerate code all the time.

>>
>> Please take all this with a little grain of salt, since these results are
>> just of preliminary nature.
>>
>> I would like to use this opportunity to welcome Ahmed Karaman, a talented
>> young man from Egypt, into QEMU development community, that'll work on "=
TCG
>> Continuous Benchmarking" project this summer. Please do help them in his
>> first steps as our colleague. Best luck to Ahmed!

Welcome to the QEMU community Ahmed. Feel free to CC me on TCG
performance related patches. I like to see things go faster ;-)

--=20
Alex Benn=C3=A9e

