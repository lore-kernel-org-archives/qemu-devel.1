Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E214C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2F0206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqmcqWU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2F0206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIE3n-000827-3z
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kIDzf-0005Oq-PG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:39:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kIDzd-00076B-CB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:39:47 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so4019277wrm.9
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=VAVwptGPTZh8EsjK9BtVG0lVM8GWJY52hf6+eD9P9lg=;
 b=pqmcqWU32DwvPQ6x2Wun6WZ3vhocGPnTlc4PTZ4CNaEApQpIEoTlimQc/Sm6cBBo2X
 xWiL6nWz8w75Gcl0YuX/9SHpfCqmgYEuBjwTlxU5MbbYR6EqyUzXAOzt4R1LwvP9QrQU
 EhZmHB3+BcpgXLrIDKo59GogloUjGVNWc3ZFGbFAhFeyLF6mu0VlTN6bCRBAwVjvSzII
 /mpFyeHW2gRJEA/PsKE+elzLwm1RibZhP0cc4gVYt7oYBVGAboK71KQj0JvgVKa04/Qu
 UNceS30TDhMPBNTVbYIGlFoBrtWTDiaE1VFTIbXaq2jw5iKAHh7oyXL8xR9XqEfzC5Rz
 LqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=VAVwptGPTZh8EsjK9BtVG0lVM8GWJY52hf6+eD9P9lg=;
 b=ganKM3M7ybBaSiY1nNLJoplTA8amAvAw3XzDmI5QHU4+/bIES5t0f/WLZLcAhStjSv
 eknldCyP+GFh4jSIm+3d0QIDMTvKkq9jcp3spcMR7Rsdsy0oYahoTjGhha2xIzgEi0oU
 Ei/Jy9CnXoqTHEZhS3eQ4IqNzvm8MsksvZuRrVw4hrdXMZ2ff83kugkinAMHQ3ChfEVm
 OAkt5DxmfSpU91hx0kEMJyc4kFLi0FIZZvpBztolQ/gOruhFuXsRz7nnPZ7oV6A6EZE2
 3q3d0Z0rPn+g7/iwp7DDwuUSJcpw0xjj4JU8NLg749l1OPuhLldo4yeZ5DzwVNh8kJoc
 XoGQ==
X-Gm-Message-State: AOAM531LP3oK4WiSng+/f75OmD+I7vC4XppJoN0sJiKyT53XUG2HCp1j
 pvFbIBfs1pml2V6nMh6+HqBK+EICkG1+pfomP98=
X-Google-Smtp-Source: ABdhPJzuwfOsJzB76SzMSIFXtFkKSn4/kVXgHiGgjY30NVH54esNO+0jICzINnS/Y9TOrk9WmCR3KWWJ+ibW/+JGfYE=
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr9103398wrt.162.1600187983245; 
 Tue, 15 Sep 2020 09:39:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7504:0:0:0:0:0 with HTTP; Tue, 15 Sep 2020 09:39:42
 -0700 (PDT)
In-Reply-To: <87zh6848e2.fsf@linaro.org>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-8-ahmedkhaledkaraman@gmail.com>
 <87zh6848e2.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 15 Sep 2020 18:39:42 +0200
Message-ID: <CAHiYmc4_NkSxHJQSYDATPM5MnatO_PD3-MSGsLrQ2+HywsgAfw@mail.gmail.com>
Subject: Re: [PATCH 7/9] tests/performance: Add nightly tests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000050c23e05af5ccc59"
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000050c23e05af5ccc59
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, September 2, 2020, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:

>
> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
>
> > A nightly performance testing system to monitor any change in QEMU
> > performance across seventeen different targets.
> >
> > The system includes eight different benchmarks to provide a variety
> > of testing workloads.
> >
> > dijkstra_double:
> > Find the shortest path between the source node and all other nodes
> > using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where al=
l nxn
> > distances are double values. The value of n can be specified using
> > the -n flag. The default value is 2000.
> >
> > dijkstra_int32:
> > Find the shortest path between the source node and all other nodes
> > using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where al=
l nxn
> > distances are int32 values. The value of n can be specified using
> > the -n flag. The default value is 2000.
> >
> > matmult_double:
> > Standard matrix multiplication of an n*n matrix of randomly generated
> > double numbers from 0 to 100. The value of n is passed as an argument
> > with the -n flag. The default value is 200.
> >
> > matmult_int32:
> > Standard matrix multiplication of an n*n matrix of randomly generated
> > integer numbers from 0 to 100. The value of n is passed as an
> > argument with the -n flag. The default value is 200.
> >
> > qsort_double:
> > Quick sort of an array of n randomly generated double numbers from 0
> > to 1000. The value of n is passed as an argument with the -n flag.
> > The default value is 300000.
> >
> > qsort_int32:
> > Quick sort of an array of n randomly generated integer numbers from 0
> > to 50000000. The value of n is passed as an argument with the -n
> > flag.The default value is 300000.
> >
> > qsort_string:
> > Quick sort of an array of 10000 randomly generated strings of size 8
> > (including null terminating character). The sort process is repeated
> > n number of times. The value of n is passed as an argument with the
> > -n flag. The default value is 20.
> >
> > search_string:
> > Search for the occurrence of a small string in a much larger random
> > string (=E2=80=9Cneedle in a hay=E2=80=9D). The search process is repea=
ted n number
> > of times and each time, a different large random string (=E2=80=9Chay=
=E2=80=9D) is
> > generated. The value of n can be specified using the -n flag. The
> > default value is 20.
> >
> > Syntax:
> >     nightly_tests_core.py [-h] [-r REF]
> >     Optional arguments:
> >         -h, --help            Show this help message and exit
> >         -r REF, --reference REF
> >                         Reference QEMU version - Default is v5.1.0
> >     Example of usage:
> >         nightly_tests_core.py -r v5.1.0 2>log.txt
> >
> > The following report includes detailed setup and execution details
> > of the system:
> > https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/
> QEMU-Nightly-Performance-Tests/
> >
> > Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> > ---
> >  tests/performance/nightly-tests/README.md     | 243 +++++
> >  .../source/dijkstra_double/dijkstra_double.c  | 194 ++++
> >  .../source/dijkstra_int32/dijkstra_int32.c    | 192 ++++
> >  .../source/matmult_double/matmult_double.c    | 123 +++
> >  .../source/matmult_int32/matmult_int32.c      | 121 +++
> >  .../source/qsort_double/qsort_double.c        | 104 ++
> >  .../source/qsort_int32/qsort_int32.c          | 103 ++
> >  .../source/qsort_string/qsort_string.c        | 122 +++
> >  .../source/search_string/search_string.c      | 110 +++
> >  .../scripts/nightly_tests_core.py             | 920 ++++++++++++++++++
> >  .../scripts/run_nightly_tests.py              | 135 +++
> >  .../nightly-tests/scripts/send_email.py       |  56 ++
> >  12 files changed, 2423 insertions(+)
> >  create mode 100644 tests/performance/nightly-tests/README.md
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
> dijkstra_double/dijkstra_double.c
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
> dijkstra_int32/dijkstra_int32.c
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
> matmult_double/matmult_double.c
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
> matmult_int32/matmult_int32.c
> >  create mode 100644 tests/performance/nightly-
> tests/benchmarks/source/qsort_double/qsort_double.c
> >  create mode 100644 tests/performance/nightly-
> tests/benchmarks/source/qsort_int32/qsort_int32.c
> >  create mode 100644 tests/performance/nightly-
> tests/benchmarks/source/qsort_string/qsort_string.c
> >  create mode 100644
> > tests/performance/nightly-tests/benchmarks/source/
> search_string/search_string.c
>
> Perhaps we could compress these paths down to:
>
>   tests/tcg/benchmarks/foo.c
>   tests/tcg/benchmarks/bar.c
>
> and then we can also ensure they are built using the existing TCG tests
> cross compile framework.
>
>
Hi,

May I just bring some alternative views on this topic of
benchmarks/multiple cross-compiling/nightly tests?

Having a known source code of any benchmark (and also license-compatible
with QEMU) is, for sure, a good thing. However, for actual test execution,
source code is not relevant, but the executables built for a diverse set of
targets. Expectation that a test bed should be able to build let's say 17
version for each benchmark is a tall order - and, in fact, unnecessary
self-imposed limitation.

My suggestion is that 17x8 executables needed for nightly tests in its
current form should be prebuilt - and kept permanently in a separate
repository (just not to burden QEMU repository). They are anyway built only
once, there is no need to update them at all.

This will allow nightly test execution on any system that can execute qemu,
without any prerequisite for cross-compiling.

Their source code could and should be integrated into QEMU tree, at the
place of choice, but the test beds should not be subject to any burden of
cross-compiling, simply because there is no need for that.

Yours,
Aleksandar




> >  create mode 100755 tests/performance/nightly-
> tests/scripts/nightly_tests_core.py
> >  create mode 100755 tests/performance/nightly-tests/scripts/run_nightly=
_
> tests.py
> >  create mode 100644 tests/performance/nightly-
> tests/scripts/send_email.py
> >
> > diff --git a/tests/performance/nightly-tests/README.md
> b/tests/performance/nightly-tests/README.md
> > new file mode 100644
> > index 0000000000..6db3b351b3
> > --- /dev/null
> > +++ b/tests/performance/nightly-tests/README.md
> > @@ -0,0 +1,243 @@
> > +### QEMU Nightly Tests
> > +
> > +**Required settings:**
> > +
> > +Update the `GMAIL_USER` object in `send_email.py` with your credential=
s.
> > +
> > +For more details on how the system works, please check the [eighth
> > report](https://ahmedkrmn.github.io/TCG-Continuous-
> Benchmarking/QEMU-Nightly-Performance-Tests/)
> > of the "TCG Continuos Benchmarking" series.
>
> As external URLs are potentially unstable I think we want to distil the
> details into a rst do in docs/devel/
>
> <snip>
>
> --
> Alex Benn=C3=A9e
>

--00000000000050c23e05af5ccc59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, September 2, 2020, Alex Benn=C3=A9e &lt;<a href=3D"ma=
ilto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br>
Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhal=
edkaraman@gmail.com</a>&gt; writes:<br>
<br>
&gt; A nightly performance testing system to monitor any change in QEMU<br>
&gt; performance across seventeen different targets.<br>
&gt;<br>
&gt; The system includes eight different benchmarks to provide a variety<br=
>
&gt; of testing workloads.<br>
&gt;<br>
&gt; dijkstra_double:<br>
&gt; Find the shortest path between the source node and all other nodes<br>
&gt; using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where a=
ll nxn<br>
&gt; distances are double values. The value of n can be specified using<br>
&gt; the -n flag. The default value is 2000.<br>
&gt;<br>
&gt; dijkstra_int32:<br>
&gt; Find the shortest path between the source node and all other nodes<br>
&gt; using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where a=
ll nxn<br>
&gt; distances are int32 values. The value of n can be specified using<br>
&gt; the -n flag. The default value is 2000.<br>
&gt;<br>
&gt; matmult_double:<br>
&gt; Standard matrix multiplication of an n*n matrix of randomly generated<=
br>
&gt; double numbers from 0 to 100. The value of n is passed as an argument<=
br>
&gt; with the -n flag. The default value is 200.<br>
&gt;<br>
&gt; matmult_int32:<br>
&gt; Standard matrix multiplication of an n*n matrix of randomly generated<=
br>
&gt; integer numbers from 0 to 100. The value of n is passed as an<br>
&gt; argument with the -n flag. The default value is 200.<br>
&gt;<br>
&gt; qsort_double:<br>
&gt; Quick sort of an array of n randomly generated double numbers from 0<b=
r>
&gt; to 1000. The value of n is passed as an argument with the -n flag.<br>
&gt; The default value is 300000.<br>
&gt;<br>
&gt; qsort_int32:<br>
&gt; Quick sort of an array of n randomly generated integer numbers from 0<=
br>
&gt; to 50000000. The value of n is passed as an argument with the -n<br>
&gt; flag.The default value is 300000.<br>
&gt;<br>
&gt; qsort_string:<br>
&gt; Quick sort of an array of 10000 randomly generated strings of size 8<b=
r>
&gt; (including null terminating character). The sort process is repeated<b=
r>
&gt; n number of times. The value of n is passed as an argument with the<br=
>
&gt; -n flag. The default value is 20.<br>
&gt;<br>
&gt; search_string:<br>
&gt; Search for the occurrence of a small string in a much larger random<br=
>
&gt; string (=E2=80=9Cneedle in a hay=E2=80=9D). The search process is repe=
ated n number<br>
&gt; of times and each time, a different large random string (=E2=80=9Chay=
=E2=80=9D) is<br>
&gt; generated. The value of n can be specified using the -n flag. The<br>
&gt; default value is 20.<br>
&gt;<br>
&gt; Syntax:<br>
&gt;=C2=A0 =C2=A0 =C2=A0nightly_tests_core.py [-h] [-r REF]<br>
&gt;=C2=A0 =C2=A0 =C2=A0Optional arguments:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-h, --help=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 Show this help message and exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-r REF, --reference REF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Reference QEMU version - Default is v5.1.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0Example of usage:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nightly_tests_core.py -r v5.1.0 2&gt;=
log.txt<br>
&gt;<br>
&gt; The following report includes detailed setup and execution details<br>
&gt; of the system:<br>
&gt; <a href=3D"https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEM=
U-Nightly-Performance-Tests/" target=3D"_blank">https://ahmedkrmn.github.io=
/<wbr>TCG-Continuous-Benchmarking/<wbr>QEMU-Nightly-Performance-<wbr>Tests/=
</a><br>
&gt;<br>
&gt; Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@=
gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/performance/nightly-<wbr>tests/README.md=C2=A0 =C2=A0 =C2=
=A0| 243 +++++<br>
&gt;=C2=A0 .../source/dijkstra_double/<wbr>dijkstra_double.c=C2=A0 | 194 ++=
++<br>
&gt;=C2=A0 .../source/dijkstra_int32/<wbr>dijkstra_int32.c=C2=A0 =C2=A0 | 1=
92 ++++<br>
&gt;=C2=A0 .../source/matmult_double/<wbr>matmult_double.c=C2=A0 =C2=A0 | 1=
23 +++<br>
&gt;=C2=A0 .../source/matmult_int32/<wbr>matmult_int32.c=C2=A0 =C2=A0 =C2=
=A0 | 121 +++<br>
&gt;=C2=A0 .../source/qsort_double/qsort_<wbr>double.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 104 ++<br>
&gt;=C2=A0 .../source/qsort_int32/qsort_<wbr>int32.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 103 ++<br>
&gt;=C2=A0 .../source/qsort_string/qsort_<wbr>string.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 122 +++<br>
&gt;=C2=A0 .../source/search_string/<wbr>search_string.c=C2=A0 =C2=A0 =C2=
=A0 | 110 +++<br>
&gt;=C2=A0 .../scripts/nightly_tests_<wbr>core.py=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 920 ++++++++++++++++++<br>
&gt;=C2=A0 .../scripts/run_nightly_tests.<wbr>py=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 135 +++<br>
&gt;=C2=A0 .../nightly-tests/scripts/<wbr>send_email.py=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 56 ++<br>
&gt;=C2=A0 12 files changed, 2423 insertions(+)<br>
&gt;=C2=A0 create mode 100644 tests/performance/nightly-<wbr>tests/README.m=
d<br>
&gt;=C2=A0 create mode 100644 tests/performance/nightly-<wbr>tests/benchmar=
ks/source/<wbr>dijkstra_double/dijkstra_<wbr>double.c<br>
&gt;=C2=A0 create mode 100644 tests/performance/nightly-<wbr>tests/benchmar=
ks/source/<wbr>dijkstra_int32/dijkstra_int32.<wbr>c<br>
&gt;=C2=A0 create mode 100644 tests/performance/nightly-<wbr>tests/benchmar=
ks/source/<wbr>matmult_double/matmult_double.<wbr>c<br>
&gt;=C2=A0 create mode 100644 tests/performance/nightly-<wbr>tests/benchmar=
ks/source/<wbr>matmult_int32/matmult_int32.c<br>
&gt;=C2=A0 create mode 100644 tests/performance/nightly-<wbr>tests/benchmar=
ks/source/qsort_<wbr>double/qsort_double.c<br>
&gt;=C2=A0 create mode 100644 tests/performance/nightly-<wbr>tests/benchmar=
ks/source/qsort_<wbr>int32/qsort_int32.c<br>
&gt;=C2=A0 create mode 100644 tests/performance/nightly-<wbr>tests/benchmar=
ks/source/qsort_<wbr>string/qsort_string.c<br>
&gt;=C2=A0 create mode 100644<br>
&gt; tests/performance/nightly-<wbr>tests/benchmarks/source/<wbr>search_str=
ing/search_string.c<br>
<br>
Perhaps we could compress these paths down to:<br>
<br>
=C2=A0 tests/tcg/benchmarks/foo.c<br>
=C2=A0 tests/tcg/benchmarks/bar.c<br>
<br>
and then we can also ensure they are built using the existing TCG tests<br>
cross compile framework.<br>
<br></blockquote><div><br></div><div>Hi,</div><div><br></div><div>May I jus=
t bring some alternative views on this topic of benchmarks/multiple cross-c=
ompiling/nightly tests?</div><div><br></div><div>Having a known source code=
 of any benchmark (and also license-compatible with QEMU) is, for sure, a g=
ood thing. However, for actual test execution, source code is not relevant,=
 but the executables built for a diverse set of targets. Expectation that a=
 test bed should be able to build let&#39;s say 17 version for each benchma=
rk is a tall order - and, in fact, unnecessary self-imposed limitation.</di=
v><div><br></div><div>My suggestion is that 17x8 executables needed for nig=
htly tests in its current form should be prebuilt - and kept permanently in=
 a separate repository (just not to burden QEMU repository). They are anywa=
y built only once, there is no need to update them at all.</div><div><br></=
div><div>This will allow nightly test execution on any system that can exec=
ute qemu, without any prerequisite for cross-compiling.</div><div><br></div=
><div>Their source code could and should be integrated into QEMU tree, at t=
he place of choice, but the test beds should not be subject to any burden o=
f cross-compiling, simply because there is no need for that.</div><div><br>=
</div><div>Yours,</div><div>Aleksandar</div><div><br></div><div><br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
&gt;=C2=A0 create mode 100755 tests/performance/nightly-<wbr>tests/scripts/=
nightly_tests_<wbr>core.py<br>
&gt;=C2=A0 create mode 100755 tests/performance/nightly-<wbr>tests/scripts/=
run_nightly_<wbr>tests.py<br>
&gt;=C2=A0 create mode 100644 tests/performance/nightly-<wbr>tests/scripts/=
send_email.py<br>
&gt;<br>
&gt; diff --git a/tests/performance/nightly-<wbr>tests/README.md b/tests/pe=
rformance/nightly-<wbr>tests/README.md<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..6db3b351b3<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/performance/nightly-<wbr>tests/README.md<br>
&gt; @@ -0,0 +1,243 @@<br>
&gt; +### QEMU Nightly Tests<br>
&gt; +<br>
&gt; +**Required settings:**<br>
&gt; +<br>
&gt; +Update the `GMAIL_USER` object in `send_email.py` with your credentia=
ls.<br>
&gt; +<br>
&gt; +For more details on how the system works, please check the [eighth<br=
>
&gt; report](<a href=3D"https://ahmedkrmn.github.io/TCG-Continuous-Benchmar=
king/QEMU-Nightly-Performance-Tests/" target=3D"_blank">https://ahmedkrmn.<=
wbr>github.io/TCG-Continuous-<wbr>Benchmarking/QEMU-Nightly-<wbr>Performanc=
e-Tests/</a>)<br>
&gt; of the &quot;TCG Continuos Benchmarking&quot; series.<br>
<br>
As external URLs are potentially unstable I think we want to distil the<br>
details into a rst do in docs/devel/<br>
<br>
&lt;snip&gt;<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote>

--00000000000050c23e05af5ccc59--

