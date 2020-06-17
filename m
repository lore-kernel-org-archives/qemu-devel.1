Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09322C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA36212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHPZXzHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA36212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlc6G-0001hI-2r
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 13:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlc5U-0001FG-E0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:43:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlc5R-0006wg-PK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:42:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id d128so2942329wmc.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ym7PMNk9FXrMZRSHAUZBOQaels2vQlGA2ZnOKWD6QKw=;
 b=mHPZXzHssk9e+7ioowQvlQ3Z1SjpEyJNGcsWaHyVg6HLwT5D5Q+l0qjpVlxlwqmK4v
 KvI+3aIQBQHAZoA0qUJaWizDT7xmGCa5NJPFE9qYmyBAaQSSpKXmhrbLhtyItMgbtSl+
 6IRcrc8GnVZ9pSzG1bEY0HvN0oJZmnoGl33vJoTHe43lSnd/08nwIeDlLxYFXVKKQwyU
 IPXW5u2CJr6le5qMAq+9Ow5s6h3A4YwyKFcbGCM26jHm700TibGix4Dpe2+LP/6Wa3nG
 AmKdUp63Co8q/Iyq6egPePrl7Eatv6mdXZRHY0kzo2HnLFPsjgUzLjxD2r68wpjVEw1d
 TS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ym7PMNk9FXrMZRSHAUZBOQaels2vQlGA2ZnOKWD6QKw=;
 b=IzM04keQbLXu5lX3aVxhXlrYNAkRd6bNypgylwxm8s6iw37hoEc7eWtdnyfW96aPBO
 ke5V/NOvT31m03P7C6/NKh2L6FnxCrxGx+/bPLybFzmcZ3txJ4uGIhewuJPsMLoONago
 osmoRn9kz2bWIOZsiC21lsilfufMYfpYLQQ/JV1vJ1p/dVU3EawBqFDz3+ii2Rcwei45
 1Kpr2T96RU6Fv4bSE6GXNd+rIKoNv31SeaM38gBV1oANdqAT+7TMc11ktNiEkPe7+O57
 v7TRbmVXegfoBA7cfxvXaHvuZJKAbWzQBYVU83pvkd2UnQA6Wv7L1Yz7XqQBJD9XzmVd
 hNjQ==
X-Gm-Message-State: AOAM532/AxBAFuQHCrx/BIyCWbapcFFkU0d5SLoV6ymBJjOBU94pOuM4
 tZcsRHBnfeOtfsOY1bV1iEF6xg==
X-Google-Smtp-Source: ABdhPJzvt+o7CCZ98q0rBJ4YcesTJatNJgagfcEEWJpMsi9evM5iKmJM0gNqGb3hvubTcUbTKNwQ6A==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr10358449wme.65.1592415775609; 
 Wed, 17 Jun 2020 10:42:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d191sm459901wmd.44.2020.06.17.10.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 10:42:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A3F91FF7E;
 Wed, 17 Jun 2020 18:42:53 +0100 (BST)
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <1944be57-7253-c3d5-737c-16537e1e71ac@redhat.com>
 <87mu51wvsj.fsf@linaro.org>
 <CAHiYmc7hAFQ1ho0GQVt1rEGxvmrmTBswjWVJ+Y0w+kcmtjhNSg@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH 0/3] Add Scripts for Finding Top 25 Executed Functions
In-reply-to: <CAHiYmc7hAFQ1ho0GQVt1rEGxvmrmTBswjWVJ+Y0w+kcmtjhNSg@mail.gmail.com>
Date: Wed, 17 Jun 2020 18:42:53 +0100
Message-ID: <874kr9wpuq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

> =D1=81=D1=80=D0=B5, 17. =D1=98=D1=83=D0=BD 2020. =D1=83 17:34 Alex Benn=
=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>>
>> Eric Blake <eblake@redhat.com> writes:
>>
>> > On 6/16/20 6:12 PM, Ahmed Karaman wrote:
>> >> Greetings,
>> >>
>> >> As a part of the TCG Continous Benchmarking project for GSoC this
>> >> year, detailed reports discussing different performance measurement
>> >> methodologies and analysis results will be sent here on the mailing
>> >> list.
>> >>
>> >> The project's first report is currently being revised and will be
>> >> posted on the mailing list in the next few days.
>> >> A section in this report will deal with measuring the top 25 executed
>> >> functions when running QEMU. It includes two Python scripts that
>> >> automatically perform this task.
>> >>
>> >> This series adds these two scripts to a new performance directory
>> >> created under the scripts directory. It also adds a new
>> >> "Miscellaneous" section to the end of the MAINTAINERS file with a
>> >> "Performance Tools and Tests" subsection.
>> >>
>> >> Best regards,
>> >> Ahmed Karaman
>> >>
>> >> Ahmed Karaman (3):
>> >>    MAINTAINERS: Add 'Miscellaneous' section
>> >>    scripts/performance: Add callgrind_top_25.py script
>> >>    scripts/performance: Add perf_top_25.py script
>> >>
>> >>   MAINTAINERS                             |  7 ++
>> >>   scripts/performance/callgrind_top_25.py | 95 ++++++++++++++++++++++=
+++
>> >>   scripts/performance/perf_top_25.py      | 82 +++++++++++++++++++++
>> >>   3 files changed, 184 insertions(+)
>> >>   create mode 100644 scripts/performance/callgrind_top_25.py
>> >>   create mode 100644 scripts/performance/perf_top_25.py
>> >
>> > Are the new scripts supposed to have executable permissions, or are th=
ey
>> > always invoked as 'python path/to/script.py' where the executable bit =
is
>> > less important?
>>
>> I would assume +x for directly invocable scripts - certainly we have a
>> lot of those in the scripts directory.
>>
>
> There is no reason IMHO for these scripts not having +x and Ahmed
> should correct this in v2, and I think that was his original
> intention.
>
> However, I was a little surprized though when I found out this in our
> scripts directory:
>
> $ find . -name \*.py -type f  -print | xargs ls -l
<snip>
> -rw-r--r-- 1 rtrk rtrk 20723 May 10 11:21 ./dump-guest-memory.py
> -rw-r--r-- 1 rtrk rtrk  2751 Jun  2 10:22 ./modules/module_block.py
> -rw-r--r-- 1 rtrk rtrk  7842 May 10 11:21 ./qapi/commands.py
> -rw-r--r-- 1 rtrk rtrk  5673 May 10 11:21 ./qapi/common.py
> -rw-r--r-- 1 rtrk rtrk  9742 May 10 11:21 ./qapi/doc.py
> -rw-r--r-- 1 rtrk rtrk  1107 May 10 11:21 ./qapi/error.py
> -rw-r--r-- 1 rtrk rtrk  6148 May 10 11:21 ./qapi/events.py
> -rw-r--r-- 1 rtrk rtrk 12297 May 10 11:21 ./qapi/expr.py
> -rw-r--r-- 1 rtrk rtrk  8280 May 10 11:21 ./qapi/gen.py
> -rw-r--r-- 1 rtrk rtrk     0 May 10 11:21 ./qapi/__init__.py
> -rw-r--r-- 1 rtrk rtrk  8533 May 10 11:21 ./qapi/introspect.py
> -rw-r--r-- 1 rtrk rtrk 21696 May 10 11:21 ./qapi/parser.py
> -rw-r--r-- 1 rtrk rtrk 41301 May 10 11:21 ./qapi/schema.py
> -rw-r--r-- 1 rtrk rtrk  1789 May 10 11:21 ./qapi/source.py
> -rw-r--r-- 1 rtrk rtrk  8724 May 10 11:21 ./qapi/types.py
> -rw-r--r-- 1 rtrk rtrk  9980 May 10 11:21 ./qapi/visit.py
> -rw-r--r-- 1 rtrk rtrk  1843 Jun  2 10:22 ./qemugdb/aio.py
> -rw-r--r-- 1 rtrk rtrk  3514 Jun  2 10:22 ./qemugdb/coroutine.py
> -rw-r--r-- 1 rtrk rtrk   897 Jun  2 10:22 ./qemugdb/__init__.py
> -rw-r--r-- 1 rtrk rtrk  2741 Jun  2 10:22 ./qemugdb/mtree.py
> -rw-r--r-- 1 rtrk rtrk  1213 Jun  2 10:22 ./qemu-gdb.py
> -rw-r--r-- 1 rtrk rtrk  1469 Jun  2 10:22 ./qemugdb/tcg.py
> -rw-r--r-- 1 rtrk rtrk  1850 Jun  2 10:22 ./qemugdb/timers.py
> -rw-r--r-- 1 rtrk rtrk  2447 May 10 11:21 ./simplebench/bench-example.py
> -rw-r--r-- 1 rtrk rtrk  4615 May 10 11:21 ./simplebench/simplebench.py
> -rw-r--r-- 1 rtrk rtrk  1443 May 10 11:21 ./tracetool/backend/dtrace.py
> -rw-r--r-- 1 rtrk rtrk  1471 May 10 11:21 ./tracetool/backend/ftrace.py
> -rw-r--r-- 1 rtrk rtrk  4098 May 10 11:21 ./tracetool/backend/__init__.py
> -rw-r--r-- 1 rtrk rtrk  1499 May 10 11:21 ./tracetool/backend/log.py
> -rw-r--r-- 1 rtrk rtrk  3116 May 10 11:21 ./tracetool/backend/simple.py
> -rw-r--r-- 1 rtrk rtrk  1175 May 10 11:21 ./tracetool/backend/syslog.py
> -rw-r--r-- 1 rtrk rtrk  1190 May 10 11:21 ./tracetool/backend/ust.py
> -rw-r--r-- 1 rtrk rtrk  2094 May 10 11:21 ./tracetool/format/c.py
> -rw-r--r-- 1 rtrk rtrk  1744 May 10 11:21 ./tracetool/format/d.py
> -rw-r--r-- 1 rtrk rtrk  2912 May 10 11:21 ./tracetool/format/h.py
> -rw-r--r-- 1 rtrk rtrk  2402 May 10 11:21 ./tracetool/format/__init__.py
> -rw-r--r-- 1 rtrk rtrk  3725 May 10 11:21 ./tracetool/format/log_stap.py
> -rw-r--r-- 1 rtrk rtrk  2467 May 10 11:21 ./tracetool/format/simpletrace_=
stap.py
> -rw-r--r-- 1 rtrk rtrk  1653 May 10 11:21 ./tracetool/format/stap.py
> -rw-r--r-- 1 rtrk rtrk  2388 May 10 11:21 ./tracetool/format/tcg_helper_c=
.py
> -rw-r--r-- 1 rtrk rtrk  1343 May 10 11:21 ./tracetool/format/tcg_helper_h=
.py
> -rw-r--r-- 1 rtrk rtrk  2145 May 10 11:21
> ./tracetool/format/tcg_helper_wrapper_h.py
> -rw-r--r-- 1 rtrk rtrk  2749 May 10 11:21 ./tracetool/format/tcg_h.py
> -rw-r--r-- 1 rtrk rtrk   968 May 10 11:21 ./tracetool/format/ust_events_c=
.py
> -rw-r--r-- 1 rtrk rtrk  3678 May 10 11:21 ./tracetool/format/ust_events_h=
.py
> -rw-r--r-- 1 rtrk rtrk 14489 May 10 11:21 ./tracetool/__init__.py
> -rw-r--r-- 1 rtrk rtrk  4301 May 10 11:21 ./tracetool/transform.py
> -rw-r--r-- 1 rtrk rtrk  2067 May 10 11:21 ./tracetool/vcpu.py

So I think these are all modules or loaded indirectly (in the case of
the gdb helpers). There was a big clean-up recently removing the
#!/bin/env python headers from a chunk of these.

<snip>
> -rw-r--r-- 1 rtrk rtrk   310 May 10 11:21 ./shaderinclude.pl

Arguably this could be +x but it seems to be there for the benefit of
the make system which explicitly calls perl anyway.

>
> Are all these permissions all right?

I think so.

--=20
Alex Benn=C3=A9e

