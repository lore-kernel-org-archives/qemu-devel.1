Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936CBC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C729206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwZec3o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C729206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIStQ-00025k-6b
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kISqo-0007aS-Fi
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:31:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kISql-0006WR-MA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:31:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id l9so2027050wme.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ipHoX8sk+0gkq6DGf5VUYKL9RMBkt8r9GNgCJyicNoE=;
 b=BwZec3o0IhxLmTO5X/RY62JNJvipEmRXZ7OBGP9+ClrIXoL2XQSy9u0/DRz3RPcFLY
 7/Feu+HgbTnA7fil+lsZAgZRRI51Btwg6Q85s0xA+z3/4ILF1+//BXM810OxFZFCGDcr
 vX3YKo3/nJkmsG6zEL7ED3XC6SJ3HmbJYzOIKeZbqxjiRK+dNkFvh5bwd6pLK2pn6C/O
 ETGzShfw2y9J1jG+XVZ2LTXTNLrow/RlWU9fEMlikps3Ssg1t5lohKpgpMz/RqMDdtl7
 UggAPiLoaCGFro8M1fYkj6ZPHpjfEDF9xWvc0imH26yhYnyY0XFkSL+shS0nOBOoPrZv
 FH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ipHoX8sk+0gkq6DGf5VUYKL9RMBkt8r9GNgCJyicNoE=;
 b=MdbnFWqop5OGPvZPy91OzFlbvMBQM9taSGP9/xU48G+9vu4MWfxku8ycmbJwLleVCC
 l52l8K01tOflG/5F2HWRgBG5n+LQWGDicpHuxh1ily181qsJBlhZn9PIOFO163nCKNuc
 MDBghGM3pnU7/8zPFmDKWM/lhQyqgdakIsWvzJE2YLmsNNJvlKzRNdRTR0+XzFZvj2D0
 qjfRF3lgOCtkJXGqQLQ2GdfBSEDr76oeh2Na9Cl0WlcVsLRxAsvcRyjHOyZU4CBX1Sih
 Nlh6mwma7+0PVizaDtZNkHwQcrrFTEpNuZVHpBW1JPDkG2qFuqY0f3jRD2zRTLoomLkF
 t5ig==
X-Gm-Message-State: AOAM5306GrHYvYdA/ufqsbpEOv4dKJvyLi41HLnZBS62TTxxSepfG6DJ
 2D/Eodl344rROI7rtTlChS8P+Q==
X-Google-Smtp-Source: ABdhPJwTX8OjyeA3cL9DHaukfHm+uIc9G0yE/VOy0Zld++BtkzAGKxvbxlPEh8cYpUoHke/qlq6o8g==
X-Received: by 2002:a1c:b703:: with SMTP id h3mr3313508wmf.131.1600245093792; 
 Wed, 16 Sep 2020 01:31:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p3sm3802418wmm.40.2020.09.16.01.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 01:31:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 01D531FF7E;
 Wed, 16 Sep 2020 09:31:32 +0100 (BST)
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-8-ahmedkhaledkaraman@gmail.com>
 <87zh6848e2.fsf@linaro.org>
 <CAHiYmc4_NkSxHJQSYDATPM5MnatO_PD3-MSGsLrQ2+HywsgAfw@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH 7/9] tests/performance: Add nightly tests
In-reply-to: <CAHiYmc4_NkSxHJQSYDATPM5MnatO_PD3-MSGsLrQ2+HywsgAfw@mail.gmail.com>
Date: Wed, 16 Sep 2020 09:31:31 +0100
Message-ID: <87zh5qyvfg.fsf@linaro.org>
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

> On Wednesday, September 2, 2020, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>
>>
>> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
>>
>> > A nightly performance testing system to monitor any change in QEMU
>> > performance across seventeen different targets.
>> >
>> > The system includes eight different benchmarks to provide a variety
>> > of testing workloads.
>> >
>> > dijkstra_double:
>> > Find the shortest path between the source node and all other nodes
>> > using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where a=
ll nxn
>> > distances are double values. The value of n can be specified using
>> > the -n flag. The default value is 2000.
>> >
>> > dijkstra_int32:
>> > Find the shortest path between the source node and all other nodes
>> > using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where a=
ll nxn
>> > distances are int32 values. The value of n can be specified using
>> > the -n flag. The default value is 2000.
>> >
>> > matmult_double:
>> > Standard matrix multiplication of an n*n matrix of randomly generated
>> > double numbers from 0 to 100. The value of n is passed as an argument
>> > with the -n flag. The default value is 200.
>> >
>> > matmult_int32:
>> > Standard matrix multiplication of an n*n matrix of randomly generated
>> > integer numbers from 0 to 100. The value of n is passed as an
>> > argument with the -n flag. The default value is 200.
>> >
>> > qsort_double:
>> > Quick sort of an array of n randomly generated double numbers from 0
>> > to 1000. The value of n is passed as an argument with the -n flag.
>> > The default value is 300000.
>> >
>> > qsort_int32:
>> > Quick sort of an array of n randomly generated integer numbers from 0
>> > to 50000000. The value of n is passed as an argument with the -n
>> > flag.The default value is 300000.
>> >
>> > qsort_string:
>> > Quick sort of an array of 10000 randomly generated strings of size 8
>> > (including null terminating character). The sort process is repeated
>> > n number of times. The value of n is passed as an argument with the
>> > -n flag. The default value is 20.
>> >
>> > search_string:
>> > Search for the occurrence of a small string in a much larger random
>> > string (=E2=80=9Cneedle in a hay=E2=80=9D). The search process is repe=
ated n number
>> > of times and each time, a different large random string (=E2=80=9Chay=
=E2=80=9D) is
>> > generated. The value of n can be specified using the -n flag. The
>> > default value is 20.
>> >
>> > Syntax:
>> >     nightly_tests_core.py [-h] [-r REF]
>> >     Optional arguments:
>> >         -h, --help            Show this help message and exit
>> >         -r REF, --reference REF
>> >                         Reference QEMU version - Default is v5.1.0
>> >     Example of usage:
>> >         nightly_tests_core.py -r v5.1.0 2>log.txt
>> >
>> > The following report includes detailed setup and execution details
>> > of the system:
>> > https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/
>> QEMU-Nightly-Performance-Tests/
>> >
>> > Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>> > ---
>> >  tests/performance/nightly-tests/README.md     | 243 +++++
>> >  .../source/dijkstra_double/dijkstra_double.c  | 194 ++++
>> >  .../source/dijkstra_int32/dijkstra_int32.c    | 192 ++++
>> >  .../source/matmult_double/matmult_double.c    | 123 +++
>> >  .../source/matmult_int32/matmult_int32.c      | 121 +++
>> >  .../source/qsort_double/qsort_double.c        | 104 ++
>> >  .../source/qsort_int32/qsort_int32.c          | 103 ++
>> >  .../source/qsort_string/qsort_string.c        | 122 +++
>> >  .../source/search_string/search_string.c      | 110 +++
>> >  .../scripts/nightly_tests_core.py             | 920 ++++++++++++++++++
>> >  .../scripts/run_nightly_tests.py              | 135 +++
>> >  .../nightly-tests/scripts/send_email.py       |  56 ++
>> >  12 files changed, 2423 insertions(+)
>> >  create mode 100644 tests/performance/nightly-tests/README.md
>> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
>> dijkstra_double/dijkstra_double.c
>> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
>> dijkstra_int32/dijkstra_int32.c
>> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
>> matmult_double/matmult_double.c
>> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
>> matmult_int32/matmult_int32.c
>> >  create mode 100644 tests/performance/nightly-
>> tests/benchmarks/source/qsort_double/qsort_double.c
>> >  create mode 100644 tests/performance/nightly-
>> tests/benchmarks/source/qsort_int32/qsort_int32.c
>> >  create mode 100644 tests/performance/nightly-
>> tests/benchmarks/source/qsort_string/qsort_string.c
>> >  create mode 100644
>> > tests/performance/nightly-tests/benchmarks/source/
>> search_string/search_string.c
>>
>> Perhaps we could compress these paths down to:
>>
>>   tests/tcg/benchmarks/foo.c
>>   tests/tcg/benchmarks/bar.c
>>
>> and then we can also ensure they are built using the existing TCG tests
>> cross compile framework.
>>
>>
> Hi,
>
> May I just bring some alternative views on this topic of
> benchmarks/multiple cross-compiling/nightly tests?
>
> Having a known source code of any benchmark (and also license-compatible
> with QEMU) is, for sure, a good thing. However, for actual test execution,
> source code is not relevant, but the executables built for a diverse set =
of
> targets. Expectation that a test bed should be able to build let's say 17
> version for each benchmark is a tall order - and, in fact, unnecessary
> self-imposed limitation.
>
> My suggestion is that 17x8 executables needed for nightly tests in its
> current form should be prebuilt - and kept permanently in a separate
> repository (just not to burden QEMU repository). They are anyway built on=
ly
> once, there is no need to update them at all.
>
> This will allow nightly test execution on any system that can execute qem=
u,
> without any prerequisite for cross-compiling.
>
> Their source code could and should be integrated into QEMU tree, at the
> place of choice, but the test beds should not be subject to any burden of
> cross-compiling, simply because there is no need for that.


I have no problem with the test binaries being stored somewhere and
accessed when needed - as long as we have a source build-able version in
the tree. It would seem silly not to at least integrate the build for
the 19 different cross compilers we already support for the check-tcg
tests.

I'm not proposing we run them every test either, but at least have the
option to do:

  make build-tcg-benchmark
  make run-tcg-benchmark

so it's easy for a developer to get to a state when they can tinker and
debug.


>
> Yours,
> Aleksandar
>
>
>
>
>> >  create mode 100755 tests/performance/nightly-
>> tests/scripts/nightly_tests_core.py
>> >  create mode 100755 tests/performance/nightly-tests/scripts/run_nightl=
y_
>> tests.py
>> >  create mode 100644 tests/performance/nightly-
>> tests/scripts/send_email.py
>> >
>> > diff --git a/tests/performance/nightly-tests/README.md
>> b/tests/performance/nightly-tests/README.md
>> > new file mode 100644
>> > index 0000000000..6db3b351b3
>> > --- /dev/null
>> > +++ b/tests/performance/nightly-tests/README.md
>> > @@ -0,0 +1,243 @@
>> > +### QEMU Nightly Tests
>> > +
>> > +**Required settings:**
>> > +
>> > +Update the `GMAIL_USER` object in `send_email.py` with your credentia=
ls.
>> > +
>> > +For more details on how the system works, please check the [eighth
>> > report](https://ahmedkrmn.github.io/TCG-Continuous-
>> Benchmarking/QEMU-Nightly-Performance-Tests/)
>> > of the "TCG Continuos Benchmarking" series.
>>
>> As external URLs are potentially unstable I think we want to distil the
>> details into a rst do in docs/devel/
>>
>> <snip>
>>
>> --
>> Alex Benn=C3=A9e
>>


--=20
Alex Benn=C3=A9e

