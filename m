Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A340CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A07F2080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyVzIUIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A07F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlalZ-0003ib-Mv
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlakD-0002d8-Fi
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:16:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlakB-0001At-7A
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:16:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id x6so2939974wrm.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q4tWHY+z1zEOE/nbzm970wsmGr5MqFQLYhiccIDZuis=;
 b=pyVzIUIZoEk2SyhJPT06TmnBQ1NNT8hdSINgP+p7NhYW7UY6BNywm4S6LYqyCRtnft
 DVNItRvbJprnvpiwwkOVRn9o4nHZfS+fnW9A/k93CVkBEkjuVVM1CiFkaP130QlITlis
 +WYbZN4GzYM0XWPl1Paqy//3fMn8T640d3LLP2jcNeRlY1l4k7+41expkwrbLOV8dcy2
 hm/yBypjqbOicDdHDdiHI6RJoZrO+6nOYFPvEl9eL45uU6fQkWzV/6SOJMQGXoWZMs7V
 rNdSRDUMlGzM/XqFtr/zLiB8eG3g/XDUjB/z7RmNI6iCqjExV0qjYSLm8RXTiEA5RpBV
 6SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q4tWHY+z1zEOE/nbzm970wsmGr5MqFQLYhiccIDZuis=;
 b=BUJHQtg/yPrVKTBdSRMMRZw6RtkOttphitcVESt+iYoShMwMFe7upvAqm5H27DUr0m
 VDLoRHXvBtxB6C32BmfnQuhUx4ogNOMIQguvWaVDSNHjdKZVFldlodJDWDhHR+ZxM4Jr
 m707OqhD3pQu+FOc+Dffw3yxVExIpAm+HsC1TCx21djcKRZhwBTIxROU5uaQEB0lf/pm
 FP4VohNXtnOuUYEe4n249WH/vLczwqskBiY1zp2MQxrtEZgGIEtVwD5DqdDTQvFTQxeq
 iRxM0vkyjtFzwpXinJ+WgIuy2+dBDj9564xqIwnyIo9A/ZC9GAUK2zTom8FlCUXPPGjK
 cGcg==
X-Gm-Message-State: AOAM5301p69du/SP5vhTwRXIwvE+PE7jdokRw7IzvFfn9VOLnVV214O5
 Yim6hUg98DP3Y1mwsVADr3P3Sjk08mhwZQtTywE=
X-Google-Smtp-Source: ABdhPJxMjBWntDW+Q/Dy2DlZW5C+LDFxJE2vs5uDgTN6SnncqLbV74xwaXtV/DiVt8IawS8zzCg1PB1nsjQFiZuI6ek=
X-Received: by 2002:adf:c98a:: with SMTP id f10mr9268442wrh.329.1592410613114; 
 Wed, 17 Jun 2020 09:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <1944be57-7253-c3d5-737c-16537e1e71ac@redhat.com> <87mu51wvsj.fsf@linaro.org>
In-Reply-To: <87mu51wvsj.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 17 Jun 2020 18:16:35 +0200
Message-ID: <CAHiYmc7hAFQ1ho0GQVt1rEGxvmrmTBswjWVJ+Y0w+kcmtjhNSg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add Scripts for Finding Top 25 Executed Functions
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 17. =D1=98=D1=83=D0=BD 2020. =D1=83 17:34 Alex Benn=C3=
=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> Eric Blake <eblake@redhat.com> writes:
>
> > On 6/16/20 6:12 PM, Ahmed Karaman wrote:
> >> Greetings,
> >>
> >> As a part of the TCG Continous Benchmarking project for GSoC this
> >> year, detailed reports discussing different performance measurement
> >> methodologies and analysis results will be sent here on the mailing
> >> list.
> >>
> >> The project's first report is currently being revised and will be
> >> posted on the mailing list in the next few days.
> >> A section in this report will deal with measuring the top 25 executed
> >> functions when running QEMU. It includes two Python scripts that
> >> automatically perform this task.
> >>
> >> This series adds these two scripts to a new performance directory
> >> created under the scripts directory. It also adds a new
> >> "Miscellaneous" section to the end of the MAINTAINERS file with a
> >> "Performance Tools and Tests" subsection.
> >>
> >> Best regards,
> >> Ahmed Karaman
> >>
> >> Ahmed Karaman (3):
> >>    MAINTAINERS: Add 'Miscellaneous' section
> >>    scripts/performance: Add callgrind_top_25.py script
> >>    scripts/performance: Add perf_top_25.py script
> >>
> >>   MAINTAINERS                             |  7 ++
> >>   scripts/performance/callgrind_top_25.py | 95 +++++++++++++++++++++++=
++
> >>   scripts/performance/perf_top_25.py      | 82 +++++++++++++++++++++
> >>   3 files changed, 184 insertions(+)
> >>   create mode 100644 scripts/performance/callgrind_top_25.py
> >>   create mode 100644 scripts/performance/perf_top_25.py
> >
> > Are the new scripts supposed to have executable permissions, or are the=
y
> > always invoked as 'python path/to/script.py' where the executable bit i=
s
> > less important?
>
> I would assume +x for directly invocable scripts - certainly we have a
> lot of those in the scripts directory.
>

There is no reason IMHO for these scripts not having +x and Ahmed
should correct this in v2, and I think that was his original
intention.

However, I was a little surprized though when I found out this in our
scripts directory:

$ find . -name \*.py -type f  -print | xargs ls -l
-rwxr-xr-x 1 rtrk rtrk  9103 May 10 11:21 ./analyse-9p-simpletrace.py
-rwxr-xr-x 1 rtrk rtrk  3544 May 10 11:21 ./analyse-locks-simpletrace.py
-rwxr-xr-x 1 rtrk rtrk 20647 Jun  2 10:22 ./analyze-migration.py
-rwxr-xr-x 1 rtrk rtrk 38358 Jun  2 10:22 ./decodetree.py
-rw-r--r-- 1 rtrk rtrk 20723 May 10 11:21 ./dump-guest-memory.py
-rwxr-xr-x 1 rtrk rtrk 23599 May 10 11:21 ./minikconf.py
-rw-r--r-- 1 rtrk rtrk  2751 Jun  2 10:22 ./modules/module_block.py
-rw-r--r-- 1 rtrk rtrk  7842 May 10 11:21 ./qapi/commands.py
-rw-r--r-- 1 rtrk rtrk  5673 May 10 11:21 ./qapi/common.py
-rw-r--r-- 1 rtrk rtrk  9742 May 10 11:21 ./qapi/doc.py
-rw-r--r-- 1 rtrk rtrk  1107 May 10 11:21 ./qapi/error.py
-rw-r--r-- 1 rtrk rtrk  6148 May 10 11:21 ./qapi/events.py
-rw-r--r-- 1 rtrk rtrk 12297 May 10 11:21 ./qapi/expr.py
-rwxr-xr-x 1 rtrk rtrk  2066 May 10 11:21 ./qapi-gen.py
-rw-r--r-- 1 rtrk rtrk  8280 May 10 11:21 ./qapi/gen.py
-rw-r--r-- 1 rtrk rtrk     0 May 10 11:21 ./qapi/__init__.py
-rw-r--r-- 1 rtrk rtrk  8533 May 10 11:21 ./qapi/introspect.py
-rw-r--r-- 1 rtrk rtrk 21696 May 10 11:21 ./qapi/parser.py
-rw-r--r-- 1 rtrk rtrk 41301 May 10 11:21 ./qapi/schema.py
-rw-r--r-- 1 rtrk rtrk  1789 May 10 11:21 ./qapi/source.py
-rw-r--r-- 1 rtrk rtrk  8724 May 10 11:21 ./qapi/types.py
-rw-r--r-- 1 rtrk rtrk  9980 May 10 11:21 ./qapi/visit.py
-rw-r--r-- 1 rtrk rtrk  1843 Jun  2 10:22 ./qemugdb/aio.py
-rw-r--r-- 1 rtrk rtrk  3514 Jun  2 10:22 ./qemugdb/coroutine.py
-rw-r--r-- 1 rtrk rtrk   897 Jun  2 10:22 ./qemugdb/__init__.py
-rw-r--r-- 1 rtrk rtrk  2741 Jun  2 10:22 ./qemugdb/mtree.py
-rw-r--r-- 1 rtrk rtrk  1213 Jun  2 10:22 ./qemu-gdb.py
-rw-r--r-- 1 rtrk rtrk  1469 Jun  2 10:22 ./qemugdb/tcg.py
-rw-r--r-- 1 rtrk rtrk  1850 Jun  2 10:22 ./qemugdb/timers.py
-rwxr-xr-x 1 rtrk rtrk  3791 May 10 11:21 ./render_block_graph.py
-rwxr-xr-x 1 rtrk rtrk 12118 May 10 11:21 ./replay-dump.py
-rwxr-xr-x 1 rtrk rtrk  1272 May 10 11:21 ./signrom.py
-rwxr-xr-x 1 rtrk rtrk  3963 May 10 11:21 ./simplebench/bench_block_job.py
-rw-r--r-- 1 rtrk rtrk  2447 May 10 11:21 ./simplebench/bench-example.py
-rw-r--r-- 1 rtrk rtrk  4615 May 10 11:21 ./simplebench/simplebench.py
-rwxr-xr-x 1 rtrk rtrk  8572 May 10 11:21 ./simpletrace.py
-rw-r--r-- 1 rtrk rtrk  1443 May 10 11:21 ./tracetool/backend/dtrace.py
-rw-r--r-- 1 rtrk rtrk  1471 May 10 11:21 ./tracetool/backend/ftrace.py
-rw-r--r-- 1 rtrk rtrk  4098 May 10 11:21 ./tracetool/backend/__init__.py
-rw-r--r-- 1 rtrk rtrk  1499 May 10 11:21 ./tracetool/backend/log.py
-rw-r--r-- 1 rtrk rtrk  3116 May 10 11:21 ./tracetool/backend/simple.py
-rw-r--r-- 1 rtrk rtrk  1175 May 10 11:21 ./tracetool/backend/syslog.py
-rw-r--r-- 1 rtrk rtrk  1190 May 10 11:21 ./tracetool/backend/ust.py
-rw-r--r-- 1 rtrk rtrk  2094 May 10 11:21 ./tracetool/format/c.py
-rw-r--r-- 1 rtrk rtrk  1744 May 10 11:21 ./tracetool/format/d.py
-rw-r--r-- 1 rtrk rtrk  2912 May 10 11:21 ./tracetool/format/h.py
-rw-r--r-- 1 rtrk rtrk  2402 May 10 11:21 ./tracetool/format/__init__.py
-rw-r--r-- 1 rtrk rtrk  3725 May 10 11:21 ./tracetool/format/log_stap.py
-rw-r--r-- 1 rtrk rtrk  2467 May 10 11:21 ./tracetool/format/simpletrace_st=
ap.py
-rw-r--r-- 1 rtrk rtrk  1653 May 10 11:21 ./tracetool/format/stap.py
-rw-r--r-- 1 rtrk rtrk  2388 May 10 11:21 ./tracetool/format/tcg_helper_c.p=
y
-rw-r--r-- 1 rtrk rtrk  1343 May 10 11:21 ./tracetool/format/tcg_helper_h.p=
y
-rw-r--r-- 1 rtrk rtrk  2145 May 10 11:21
./tracetool/format/tcg_helper_wrapper_h.py
-rw-r--r-- 1 rtrk rtrk  2749 May 10 11:21 ./tracetool/format/tcg_h.py
-rw-r--r-- 1 rtrk rtrk   968 May 10 11:21 ./tracetool/format/ust_events_c.p=
y
-rw-r--r-- 1 rtrk rtrk  3678 May 10 11:21 ./tracetool/format/ust_events_h.p=
y
-rw-r--r-- 1 rtrk rtrk 14489 May 10 11:21 ./tracetool/__init__.py
-rwxr-xr-x 1 rtrk rtrk  4525 May 10 11:21 ./tracetool.py
-rw-r--r-- 1 rtrk rtrk  4301 May 10 11:21 ./tracetool/transform.py
-rw-r--r-- 1 rtrk rtrk  2067 May 10 11:21 ./tracetool/vcpu.py
-rwxr-xr-x 1 rtrk rtrk 16117 May 10 11:21 ./vmstate-static-checker.py

$ find . -name \*.pl -type f -print | xargs ls -l
-rwxr-xr-x 1 rtrk rtrk 84694 May 10 11:21 ./checkpatch.pl
-rwxr-xr-x 1 rtrk rtrk  6559 May 10 11:21 ./clean-header-guards.pl
-rwxr-xr-x 1 rtrk rtrk  1396 May 10 11:21 ./cleanup-trace-events.pl
-rwxr-xr-x 1 rtrk rtrk  2725 May 10 11:21 ./disas-objdump.pl
-rwxr-xr-x 1 rtrk rtrk 54645 May 10 11:21 ./get_maintainer.pl
-rwxr-xr-x 1 rtrk rtrk  4289 May 10 11:21 ./hxtool-conv.pl
-rw-r--r-- 1 rtrk rtrk   310 May 10 11:21 ./shaderinclude.pl
-rwxr-xr-x 1 rtrk rtrk  9933 May 10 11:21 ./tap-driver.pl
-rwxr-xr-x 1 rtrk rtrk  3011 May 10 11:21 ./tap-merge.pl
-rwxr-xr-x 1 rtrk rtrk 13657 May 10 11:21 ./texi2pod.pl

Are all these permissions all right?

Thanks,
Aleksandar







> --
> Alex Benn=C3=A9e

