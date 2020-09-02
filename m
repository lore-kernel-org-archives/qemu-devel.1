Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31786C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D4520773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqMu7+wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D4520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOHE-00044j-Rv
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kDOGH-0003Vl-2m
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:36:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kDOGA-0005nH-3Q
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:36:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id e16so4297155wrm.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=40569TUXGNMdKMs2m9l/Lgrw9x4OZU9J6619jg5+x7c=;
 b=pqMu7+wtNLeU8U3a5LygYFPj/3mOrgMV01VhmHc7/nvY+JCpp26+TMAVJGmDqJf4Ye
 Fjvyg7RUtsygV5jc3Cp+hXssuiwuMduskti0u4dsgC26JF5Vuz0QZkAtNu9FC9ZnDdD2
 AuFHlewxbztZ0CtDqCyPwR+ZBrv1K9nKa8GXOwrjBVthNJTgbMe46Ac7NXrVPirwUHnG
 Y0q//Gyk1DBRxYq7X9U5Zimodznk5GGep6ZKuXIEv9k2y3JPwrFtw14xO0DZCX3IyBZ9
 dQ/XJxlVQDyCI8lHsrABH05eL8BdqbzqGGqSQ9fgGNhRo1qQIcwexkbefmKgdGemJYOL
 cxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=40569TUXGNMdKMs2m9l/Lgrw9x4OZU9J6619jg5+x7c=;
 b=FTdWafCIsCilDclIzXt1xCTG289GaN44U/gO5Ym2DjMe+UOcnQmB/Mi1YLbPzm5bVk
 I6Ol2uuQaEaQORgOTGGIDkLg9T/57cy7VXvCC4S9UxNBCyJsZGrmuRaQ9hlDU9EOBOhQ
 vQK3OjOKIyuRM6URYz6jMFd1Q5mti5V1e2981mDedSO3rDaFMmNPp5Wvs593utx0uXkE
 +Htw4iNsptZrRat3T9vv6CRXbDkR9GT8Iqt71GfGeswWENEjOIdu/zQm4hpfadKJkNzF
 /v3D2UG+PH/8jBEMqXLAqPHDEQVHaLeV2J5HJftdHWq2qy+7ie1iSttwieJ+zkvIT5To
 Af7Q==
X-Gm-Message-State: AOAM532p3TZkUiV6szcprxB3OnTNMUqsMds7/lE7g69K1O7qKrnsfgzV
 0rM1ZwMbmN9/ynQp7uMfu9nHYfNGHhiX2MpvOkY=
X-Google-Smtp-Source: ABdhPJxmhlgAudf3VVwTFJkJiQaXwcCXGAPnJDDzDuwxwWxc6VLKz+cAT/DVDySVvHBGi90yP20tIc6kvqUf3jFd0rI=
X-Received: by 2002:adf:f98a:: with SMTP id f10mr5920799wrr.420.1599035807613; 
 Wed, 02 Sep 2020 01:36:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c351:0:0:0:0:0 with HTTP;
 Wed, 2 Sep 2020 01:36:47 -0700 (PDT)
In-Reply-To: <20200828104102.4490-8-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-8-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 2 Sep 2020 10:36:47 +0200
Message-ID: <CAHiYmc6SAqwDZ_S6JGm103oK5zSSRj5Uft9qWoJS_TSBthhYPA@mail.gmail.com>
Subject: Re: [PATCH 7/9] tests/performance: Add nightly tests
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000004bc6f805ae5089d5"
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42f.google.com
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@redhat.com" <philmd@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004bc6f805ae5089d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, August 28, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
wrote:

> A nightly performance testing system to monitor any change in QEMU
> performance across seventeen different targets.
>
>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>



> The system includes eight different benchmarks to provide a variety
> of testing workloads.
>
> dijkstra_double:
> Find the shortest path between the source node and all other nodes
> using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where all =
nxn
> distances are double values. The value of n can be specified using
> the -n flag. The default value is 2000.
>
> dijkstra_int32:
> Find the shortest path between the source node and all other nodes
> using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where all =
nxn
> distances are int32 values. The value of n can be specified using
> the -n flag. The default value is 2000.
>
> matmult_double:
> Standard matrix multiplication of an n*n matrix of randomly generated
> double numbers from 0 to 100. The value of n is passed as an argument
> with the -n flag. The default value is 200.
>
> matmult_int32:
> Standard matrix multiplication of an n*n matrix of randomly generated
> integer numbers from 0 to 100. The value of n is passed as an
> argument with the -n flag. The default value is 200.
>
> qsort_double:
> Quick sort of an array of n randomly generated double numbers from 0
> to 1000. The value of n is passed as an argument with the -n flag.
> The default value is 300000.
>
> qsort_int32:
> Quick sort of an array of n randomly generated integer numbers from 0
> to 50000000. The value of n is passed as an argument with the -n
> flag.The default value is 300000.
>
> qsort_string:
> Quick sort of an array of 10000 randomly generated strings of size 8
> (including null terminating character). The sort process is repeated
> n number of times. The value of n is passed as an argument with the
> -n flag. The default value is 20.
>
> search_string:
> Search for the occurrence of a small string in a much larger random
> string (=E2=80=9Cneedle in a hay=E2=80=9D). The search process is repeate=
d n number
> of times and each time, a different large random string (=E2=80=9Chay=E2=
=80=9D) is
> generated. The value of n can be specified using the -n flag. The
> default value is 20.
>
> Syntax:
>     nightly_tests_core.py [-h] [-r REF]
>     Optional arguments:
>         -h, --help            Show this help message and exit
>         -r REF, --reference REF
>                         Reference QEMU version - Default is v5.1.0
>     Example of usage:
>         nightly_tests_core.py -r v5.1.0 2>log.txt
>
> The following report includes detailed setup and execution details
> of the system:
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/
> QEMU-Nightly-Performance-Tests/
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  tests/performance/nightly-tests/README.md     | 243 +++++
>  .../source/dijkstra_double/dijkstra_double.c  | 194 ++++
>  .../source/dijkstra_int32/dijkstra_int32.c    | 192 ++++
>  .../source/matmult_double/matmult_double.c    | 123 +++
>  .../source/matmult_int32/matmult_int32.c      | 121 +++
>  .../source/qsort_double/qsort_double.c        | 104 ++
>  .../source/qsort_int32/qsort_int32.c          | 103 ++
>  .../source/qsort_string/qsort_string.c        | 122 +++
>  .../source/search_string/search_string.c      | 110 +++
>  .../scripts/nightly_tests_core.py             | 920 ++++++++++++++++++
>  .../scripts/run_nightly_tests.py              | 135 +++
>  .../nightly-tests/scripts/send_email.py       |  56 ++
>  12 files changed, 2423 insertions(+)
>  create mode 100644 tests/performance/nightly-tests/README.md
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
> dijkstra_double/dijkstra_double.c
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
> dijkstra_int32/dijkstra_int32.c
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
> matmult_double/matmult_double.c
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
> matmult_int32/matmult_int32.c
>  create mode 100644 tests/performance/nightly-
> tests/benchmarks/source/qsort_double/qsort_double.c
>  create mode 100644 tests/performance/nightly-
> tests/benchmarks/source/qsort_int32/qsort_int32.c
>  create mode 100644 tests/performance/nightly-
> tests/benchmarks/source/qsort_string/qsort_string.c
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/
> search_string/search_string.c
>  create mode 100755 tests/performance/nightly-tests/scripts/nightly_tests=
_
> core.py
>  create mode 100755 tests/performance/nightly-tests/scripts/run_nightly_
> tests.py
>  create mode 100644 tests/performance/nightly-tests/scripts/send_email.py
>
> diff --git a/tests/performance/nightly-tests/README.md
> b/tests/performance/nightly-tests/README.md
> new file mode 100644
> index 0000000000..6db3b351b3
> --- /dev/null
> +++ b/tests/performance/nightly-tests/README.md
> @@ -0,0 +1,243 @@
> +### QEMU Nightly Tests
> +
> +**Required settings:**
> +
> +Update the `GMAIL_USER` object in `send_email.py` with your credentials.
> +
> +For more details on how the system works, please check the [eighth
> report](https://ahmedkrmn.github.io/TCG-Continuous-
> Benchmarking/QEMU-Nightly-Performance-Tests/) of the "TCG Continuos
> Benchmarking" series.
> +
> +**Running the System:**
> +
> +The default reference version is v5.1.0. To specify a custom version,
> please use the `-r, --reference` flag.
> +
> +```bash
> +./run_nightly_tests.py
> +```
> +
> +**Output:**
> +
> +```
> +Host CPU         : Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
> +Host Memory      : 15.49 GB
> +
> +Start Time (UTC) : 2020-08-25 21:30:01
> +End Time (UTC)   : 2020-08-25 22:02:37
> +Execution Time   : 0:32:35.896990
> +
> +Status           : SUCCESS
> +
> +Note:
> +Changes denoted by '-----' are less than 0.01%.
> +
> +--------------------------------------------------------
> +            SUMMARY REPORT - COMMIT d1a2b51f
> +--------------------------------------------------------
> +                    AVERAGE RESULTS
> +--------------------------------------------------------
> +Target              Instructions      Latest      v5.1.0
> +----------  --------------------  ----------  ----------
> +aarch64            2 158 355 274       -----     +1.693%
> +alpha              1 914 967 171       -----     +3.524%
> +arm                8 076 402 940       -----     +2.304%
> +hppa               4 261 685 987     -0.182%     +3.164%
> +m68k               2 690 273 044       -----     +7.131%
> +mips               1 862 033 667       -----     +2.494%
> +mipsel             2 008 211 069       -----     +2.674%
> +mips64             1 918 635 565       -----     +2.818%
> +mips64el           2 051 565 677       -----     +3.026%
> +ppc                2 480 141 217       -----     +3.107%
> +ppc64              2 576 713 959       -----     +3.143%
> +ppc64le            2 558 853 539       -----     +3.173%
> +riscv64            1 406 704 050       -----      +2.65%
> +s390x              3 158 140 046       -----     +3.118%
> +sh4                2 364 449 748       -----      +3.33%
> +sparc64            3 318 544 783       -----     +3.851%
> +x86_64             1 775 844 158       -----     +2.156%
> +--------------------------------------------------------
> +
> +                   DETAILED RESULTS
> +--------------------------------------------------------
> +Test Program: dijkstra_double
> +--------------------------------------------------------
> +Target              Instructions      Latest      v5.1.0
> +----------  --------------------  ----------  ----------
> +aarch64            3 062 583 464       -----     +1.424%
> +alpha              3 191 864 698       -----     +3.696%
> +arm               16 357 157 526       -----     +2.347%
> +hppa               7 228 376 315     -0.139%     +3.086%
> +m68k               4 294 016 587       -----     +9.692%
> +mips               3 051 419 166       -----     +2.427%
> +mipsel             3 231 509 618       -----     +2.869%
> +mips64             3 245 837 754       -----     +2.596%
> +mips64el           3 414 195 796       -----     +3.021%
> +ppc                4 914 520 972     -0.041%      +4.74%
> +ppc64              5 098 154 311       -----     +4.565%
> +ppc64le            5 082 419 054       -----      +4.58%
> +riscv64            2 192 294 915       -----     +1.955%
> +s390x              4 584 503 977       -----     +2.896%
> +sh4                3 949 036 447       -----     +3.464%
> +sparc64            4 586 203 546       -----     +4.237%
> +x86_64             2 484 092 105       -----      +1.75%
> +--------------------------------------------------------
> +--------------------------------------------------------
> +Test Program: dijkstra_int32
> +--------------------------------------------------------
> +Target              Instructions      Latest      v5.1.0
> +----------  --------------------  ----------  ----------
> +aarch64            2 210 194 577       -----     +1.493%
> +alpha              1 494 133 274       -----      +2.15%
> +arm                8 262 935 967       -----     +2.665%
> +hppa               5 207 318 306       -----     +3.047%
> +m68k               1 725 856 962       -----     +2.527%
> +mips               1 495 227 032       -----     +1.492%
> +mipsel             1 497 147 869       -----     +1.479%
> +mips64             1 715 388 570       -----     +1.892%
> +mips64el           1 695 276 864       -----     +1.913%
> +ppc                2 014 557 389       -----     +1.819%
> +ppc64              2 206 267 901       -----     +2.139%
> +ppc64le            2 197 998 781       -----     +2.146%
> +riscv64            1 354 912 745       -----     +2.396%
> +s390x              2 916 247 062       -----     +1.241%
> +sh4                1 990 532 533       -----     +2.669%
> +sparc64            2 872 231 051       -----     +3.758%
> +x86_64             1 553 981 241       -----      +2.12%
> +--------------------------------------------------------
> +--------------------------------------------------------
> +Test Program: matmult_double
> +--------------------------------------------------------
> +Target              Instructions      Latest      v5.1.0
> +----------  --------------------  ----------  ----------
> +aarch64            1 412 273 223       -----     +0.302%
> +alpha              3 233 991 649       -----     +7.473%
> +arm                8 545 173 979       -----     +1.088%
> +hppa               3 483 597 802     -1.267%     +4.468%
> +m68k               3 919 065 529       -----    +18.431%
> +mips               2 344 774 894       -----     +4.091%
> +mipsel             3 329 886 464       -----     +5.177%
> +mips64             2 359 046 988       -----     +4.076%
> +mips64el           3 343 664 785       -----     +5.167%
> +ppc                3 209 457 051       -----     +3.246%
> +ppc64              3 287 503 981       -----     +3.173%
> +ppc64le            3 287 189 065       -----     +3.173%
> +riscv64            1 221 603 682       -----     +0.277%
> +s390x              2 874 199 923       -----     +5.827%
> +sh4                3 543 943 634       -----     +6.416%
> +sparc64            3 426 150 004       -----     +7.139%
> +x86_64             1 248 917 276       -----     +0.322%
> +--------------------------------------------------------
> +--------------------------------------------------------
> +Test Program: matmult_int32
> +--------------------------------------------------------
> +Target              Instructions      Latest      v5.1.0
> +----------  --------------------  ----------  ----------
> +aarch64              598 681 621       -----     +0.585%
> +alpha                372 437 418       -----     +0.677%
> +arm                  746 583 193       -----     +1.462%
> +hppa                 674 278 359       -----     +1.183%
> +m68k                 410 495 553       -----       +0.9%
> +mips                 499 698 837       -----     +0.531%
> +mipsel               499 500 429       -----     +0.497%
> +mips64               481 554 664       -----     +0.599%
> +mips64el             465 057 054       -----     +0.619%
> +ppc                  341 334 603       -----     +0.944%
> +ppc64                393 796 203       -----     +0.966%
> +ppc64le              393 977 298       -----     +0.965%
> +riscv64              351 709 769       -----     +0.785%
> +s390x                494 427 384       -----     +0.599%
> +sh4                  402 668 444       -----     +0.899%
> +sparc64              495 952 959       -----     +1.192%
> +x86_64               402 928 461       -----     +0.833%
> +--------------------------------------------------------
> +--------------------------------------------------------
> +Test Program: qsort_double
> +--------------------------------------------------------
> +Target              Instructions      Latest      v5.1.0
> +----------  --------------------  ----------  ----------
> +aarch64            2 709 683 624       -----     +2.417%
> +alpha              1 969 460 172       -----      +3.68%
> +arm                8 322 998 390       -----     +2.587%
> +hppa               3 188 301 995     -0.047%       +2.9%
> +m68k               4 953 930 065       -----    +15.153%
> +mips               2 123 919 587       -----     +3.055%
> +mipsel             2 124 212 187       -----     +3.048%
> +mips64             1 999 047 826       -----     +3.405%
> +mips64el           1 996 426 772       -----     +3.409%
> +ppc                2 819 267 902     -0.021%     +5.435%
> +ppc64              2 768 186 548       -----     +5.513%
> +ppc64le            2 724 803 772     -0.011%     +5.603%
> +riscv64            1 638 328 937       -----     +4.021%
> +s390x              2 519 081 708       -----     +3.362%
> +sh4                2 595 545 154       -----     +2.994%
> +sparc64            3 988 986 587       -----     +2.747%
> +x86_64             2 033 468 588       -----     +3.234%
> +--------------------------------------------------------
> +--------------------------------------------------------
> +Test Program: qsort_int32
> +--------------------------------------------------------
> +Target              Instructions      Latest      v5.1.0
> +----------  --------------------  ----------  ----------
> +aarch64            2 193 392 565       -----     +2.916%
> +alpha              1 521 291 933       -----     +4.193%
> +arm                3 465 445 043       -----     +2.756%
> +hppa               2 280 034 340       -----     +3.821%
> +m68k               1 843 189 041       -----     +3.583%
> +mips               1 558 024 873       -----     +3.863%
> +mipsel             1 560 583 980       -----     +3.846%
> +mips64             1 563 415 749       -----     +4.412%
> +mips64el           1 542 677 320       -----     +4.474%
> +ppc                1 728 698 880       -----     +3.665%
> +ppc64              1 842 444 545       -----     +3.555%
> +ppc64le            1 791 822 067       -----     +3.661%
> +riscv64            1 348 866 430       -----     +4.654%
> +s390x              2 184 073 151       -----     +3.319%
> +sh4                1 946 492 539       -----     +3.624%
> +sparc64            3 452 215 585       -----     +2.937%
> +x86_64             1 813 544 414       -----     +3.537%
> +--------------------------------------------------------
> +--------------------------------------------------------
> +Test Program: qsort_string
> +--------------------------------------------------------
> +Target              Instructions      Latest      v5.1.0
> +----------  --------------------  ----------  ----------
> +aarch64            2 592 218 418       -----     +2.468%
> +alpha              1 855 834 626       -----     +3.487%
> +arm                7 347 721 165       -----     +2.682%
> +hppa               4 758 753 926       -----     +3.543%
> +m68k               2 376 811 462       -----     +3.567%
> +mips               2 166 608 045       -----     +2.532%
> +mipsel             2 163 392 541       -----     +2.528%
> +mips64             2 029 251 969       -----     +3.117%
> +mips64el           2 011 628 621       -----     +3.145%
> +ppc                2 492 942 463       -----     +2.673%
> +ppc64              2 464 702 554       -----     +2.488%
> +ppc64le            2 445 253 307       -----     +2.505%
> +riscv64            1 625 053 328       -----     +3.953%
> +s390x              4 194 608 798       -----     +6.623%
> +sh4                2 164 142 539       -----     +3.166%
> +sparc64            4 299 516 539       -----     +4.065%
> +x86_64             2 940 456 780       -----     +2.649%
> +--------------------------------------------------------
> +--------------------------------------------------------
> +Test Program: search_string
> +--------------------------------------------------------
> +Target              Instructions      Latest      v5.1.0
> +----------  --------------------  ----------  ----------
> +aarch64            2 487 814 704       -----      +1.94%
> +alpha              1 680 723 605       -----     +2.835%
> +arm               11 563 208 260       -----     +2.848%
> +hppa               7 272 826 858       -----     +3.263%
> +m68k               1 998 819 159       -----     +3.198%
> +mips               1 656 596 909       -----     +1.959%
> +mipsel             1 659 455 464       -----     +1.947%
> +mips64             1 955 541 001       -----     +2.447%
> +mips64el           1 943 598 207       -----     +2.462%
> +ppc                2 320 350 477       -----     +2.332%
> +ppc64              2 552 655 634       -----     +2.742%
> +ppc64le            2 547 364 971       -----     +2.748%
> +riscv64            1 520 862 601       -----     +3.159%
> +s390x              5 497 978 370       -----     +1.078%
> +sh4                2 323 236 696       -----      +3.41%
> +sparc64            3 427 101 999       -----      +4.73%
> +x86_64             1 729 364 402       -----     +2.806%
> +--------------------------------------------------------
> +```
> diff --git a/tests/performance/nightly-tests/benchmarks/source/
> dijkstra_double/dijkstra_double.c b/tests/performance/nightly-
> tests/benchmarks/source/dijkstra_double/dijkstra_double.c
> new file mode 100644
> index 0000000000..9c0bb804ac
> --- /dev/null
> +++ b/tests/performance/nightly-tests/benchmarks/source/
> dijkstra_double/dijkstra_double.c
> @@ -0,0 +1,194 @@
> +/*
> + *  Source file of a benchmark program involving calculations of the
> + *  shortest distances between a source node and all other nodes in a
> + *  graph of n nodes in which all nxn distances are defined as "double".
> + *  The number n can be given via command line, and the default is 2000.
> + *  The algorithm used is Dijsktra's.
> + *
> + *  This file is a part of the project "TCG Continuous Benchmarking".
> + *
> + *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> + *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail=
.
> com>
> + *
> + *  This program is free software: you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation, either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program. If not, see <https://www.gnu.org/licenses/>=
.
> + *
> + */
> +
> +#include <float.h>
> +#include <limits.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +/* Number of columns and rows in all matrixes*/
> +#define DEFAULT_NODE_COUNT      2000
> +#define MIN_NODE_COUNT          3
> +#define MAX_NODE_COUNT          10000
> +
> +
> +int32_t closest_index(int32_t count, double *distances, bool *flags)
> +{
> +    int32_t closest;
> +    double minimum =3D DBL_MAX;
> +
> +    for (size_t i =3D 0; i < count; i++) {
> +        if (flags[i] =3D=3D false && distances[i] <=3D minimum) {
> +            closest =3D i;
> +            minimum =3D distances[i];
> +        }
> +    }
> +
> +    return closest;
> +}
> +
> +/**
> + * Calculate the shortest distances from the source node using Dijkstra
> method.
> + * @param (out) distances  An array of shortest distances from the sourc=
e
> node.
> + * @param (out) via  An array of nodes needed to be taken as the the las=
t
> + *                   before destination, for each destination.
> + * @param (out) eccent  Eccentricity of the source node.
> + * @param (in) count  The number of nodes.
> + * @param (in) source  Source node.
> + * @param (in) matrix  Distance matrix.
> + */
> +void find_shortest_distances(double *distances, int32_t *via, double
> *eccent,
> +                             int32_t count, int32_t source, double
> **matrix)
> +{
> +    bool *flags;
> +
> +    flags =3D (bool *)malloc(count * sizeof(bool));
> +
> +    for (size_t i =3D 0; i < count; i++) {
> +        distances[i] =3D DBL_MAX;
> +        flags[i] =3D false;
> +    }
> +
> +    distances[source] =3D 0.0;
> +    via[source] =3D source;
> +
> +    for (size_t i =3D 0; i < count - 1; i++) {
> +        int32_t closest =3D closest_index(count, distances, flags);
> +        flags[closest] =3D true;
> +        for (size_t j =3D 0; j < count; j++) {
> +            if ((!flags[j]) &&
> +                    (matrix[closest][j]) &&
> +                    (distances[closest] !=3D DBL_MAX) &&
> +                    (distances[j] > distances[closest] +
> matrix[closest][j])) {
> +                distances[j] =3D distances[closest] + matrix[closest][j]=
;
> +                via[j] =3D closest;
> +            }
> +        }
> +    }
> +
> +    *eccent =3D 0;
> +    for (size_t i =3D 0; i < count; i++) {
> +        if (*eccent < distances[i]) {
> +            *eccent =3D distances[i];
> +        }
> +    }
> +
> +    free(flags);
> +}
> +
> +
> +void main(int argc, char *argv[])
> +{
> +    double **distance_matrix;
> +    double *shortest_distances;
> +    int32_t *via_node;
> +    int32_t node_count =3D DEFAULT_NODE_COUNT;
> +    int32_t source_node =3D 0;
> +    double node_eccentricity =3D 0.0;
> +    double range_factor =3D 999.0 / (double)(RAND_MAX);
> +    int32_t option;
> +
> +    /* Parse command line options */
> +    while ((option =3D getopt(argc, argv, "n:")) !=3D -1) {
> +        if (option =3D=3D 'n') {
> +            int32_t user_node_count =3D atoi(optarg);
> +
> +            /* Check if the value is a string or zero */
> +            if (user_node_count =3D=3D 0) {
> +                fprintf(stderr, "Error ... Invalid value for option
> '-n'.\n");
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is a negative number */
> +            if (user_node_count < MIN_NODE_COUNT) {
> +                fprintf(stderr, "Error ... Value for option '-n' cannot
> be a "
> +                                "number less than %d.\n", MIN_NODE_COUNT=
);
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is too large */
> +            if (user_node_count > MAX_NODE_COUNT) {
> +                fprintf(stderr, "Error ... Value for option '-n' cannot
> be "
> +                                "more than %d.\n", MAX_NODE_COUNT);
> +                exit(EXIT_FAILURE);
> +            }
> +            node_count =3D user_node_count;
> +        } else {
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    /* Allocate the memory space for all matrixes */
> +    distance_matrix =3D (double **)malloc(node_count * sizeof(double *))=
;
> +    for (size_t i =3D 0; i < node_count; i++) {
> +        distance_matrix[i] =3D (double *)malloc(node_count *
> sizeof(double));
> +    }
> +    shortest_distances =3D (double *)malloc(node_count * sizeof(double))=
;
> +    via_node =3D (int32_t *)malloc(node_count * sizeof(int32_t));
> +
> +    /* Initialize helper arrays and populate distance_matrix */
> +    srand(1);
> +    for (size_t i =3D 0; i < node_count; i++) {
> +        shortest_distances[i] =3D 0.0;
> +        via_node[i] =3D -1;
> +        distance_matrix[i][i] =3D 0.0;
> +    }
> +    for (size_t i =3D 0; i < node_count; i++) {
> +        for (size_t j =3D i + 1; j < node_count; j++) {
> +            distance_matrix[i][j] =3D 1.0 + range_factor * (double)rand(=
);
> +            distance_matrix[j][i] =3D distance_matrix[i][j];
> +        }
> +    }
> +
> +    find_shortest_distances(shortest_distances, via_node,
> &node_eccentricity,
> +                            node_count, source_node, distance_matrix);
> +
> +    /* Control printing */
> +    printf("CONTROL RESULT:\n");
> +    printf(" Distance matrix (top left part):\n");
> +    for (size_t i =3D 0; i < 3; i++) {
> +        for (size_t j =3D 0; j < 3; j++) {
> +            printf("    %7.2f", distance_matrix[i][j]);
> +        }
> +        printf("\n");
> +    }
> +    printf(" Source: %d (eccentricity: %f)\n",
> +           source_node, node_eccentricity);
> +    printf(" Destination   Distance   Via Node\n");
> +    for (size_t i =3D 0; i < 3; i++) {
> +        printf("  %5d       %7.2f       %4d\n",
> +               i, shortest_distances[i], via_node[i]);
> +    }
> +
> +    /* Free all previously allocated space */
> +    for (size_t i =3D 0; i < node_count; i++) {
> +        free(distance_matrix[i]);
> +    }
> +    free(distance_matrix);
> +    free(shortest_distances);
> +    free(via_node);
> +}
> diff --git a/tests/performance/nightly-tests/benchmarks/source/
> dijkstra_int32/dijkstra_int32.c b/tests/performance/nightly-
> tests/benchmarks/source/dijkstra_int32/dijkstra_int32.c
> new file mode 100644
> index 0000000000..2663cde943
> --- /dev/null
> +++ b/tests/performance/nightly-tests/benchmarks/source/
> dijkstra_int32/dijkstra_int32.c
> @@ -0,0 +1,192 @@
> +/*
> + *  Source file of a benchmark program involving calculations of the
> + *  shortest distances between a source node and all other nodes in a
> + *  graph of n nodes in which all nxn distances are defined as "int32".
> + *  The number n can be given via command line, and the default is 2000.
> + *  The algorithm used is Dijsktra's.
> + *
> + *  This file is a part of the project "TCG Continuous Benchmarking".
> + *
> + *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> + *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail=
.
> com>
> + *
> + *  This program is free software: you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation, either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program. If not, see <https://www.gnu.org/licenses/>=
.
> + *
> + */
> +
> +#include <limits.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +/* Number of columns and rows in all matrixes*/
> +#define DEFAULT_NODE_COUNT      2000
> +#define MIN_NODE_COUNT          3
> +#define MAX_NODE_COUNT          10000
> +
> +
> +int32_t closest_index(int32_t count, int32_t *distances, bool *flags)
> +{
> +    int32_t closest;
> +    int32_t minimum =3D INT_MAX;
> +
> +    for (size_t i =3D 0; i < count; i++) {
> +        if (flags[i] =3D=3D false && distances[i] <=3D minimum) {
> +            closest =3D i;
> +            minimum =3D distances[i];
> +        }
> +    }
> +
> +    return closest;
> +}
> +
> +/**
> + * Calculate the shortest distances from the source node using Dijkstra
> method.
> + * @param (out) distances  An array of shortest distances from the sourc=
e
> node.
> + * @param (out) via  An array of nodes needed to be taken as the the las=
t
> + *                   before destination, for each destination.
> + * @param (out) eccent  Eccentricity of the source node.
> + * @param (in) count  The number of nodes.
> + * @param (in) source  Source node.
> + * @param (in) matrix  Distance matrix.
> + */
> +void find_shortest_distances(int32_t *distances, int32_t *via, int32_t
> *eccent,
> +                             int32_t count, int32_t source, int32_t
> **matrix)
> +{
> +    bool *flags;
> +
> +    flags =3D (bool *)malloc(count * sizeof(bool));
> +
> +    for (size_t i =3D 0; i < count; i++) {
> +        distances[i] =3D INT_MAX;
> +        flags[i] =3D false;
> +    }
> +
> +    distances[source] =3D 0;
> +    via[source] =3D source;
> +
> +    for (size_t i =3D 0; i < count - 1; i++) {
> +        int32_t closest =3D closest_index(count, distances, flags);
> +        flags[closest] =3D true;
> +        for (size_t j =3D 0; j < count; j++) {
> +            if ((!flags[j]) &&
> +                    (matrix[closest][j]) &&
> +                    (distances[closest] !=3D INT_MAX) &&
> +                    (distances[j] > distances[closest] +
> matrix[closest][j])) {
> +                distances[j] =3D distances[closest] + matrix[closest][j]=
;
> +                via[j] =3D closest;
> +            }
> +        }
> +    }
> +
> +    *eccent =3D 0;
> +    for (size_t i =3D 0; i < count; i++) {
> +        if (*eccent < distances[i]) {
> +            *eccent =3D distances[i];
> +        }
> +    }
> +
> +    free(flags);
> +}
> +
> +
> +void main(int argc, char *argv[])
> +{
> +    int32_t **distance_matrix;
> +    int32_t *shortest_distances;
> +    int32_t *via_node;
> +    int32_t node_count =3D DEFAULT_NODE_COUNT;
> +    int32_t source_node =3D 0;
> +    int32_t node_eccentricity =3D 0;
> +    int32_t option;
> +
> +    /* Parse command line options */
> +    while ((option =3D getopt(argc, argv, "n:")) !=3D -1) {
> +        if (option =3D=3D 'n') {
> +            int32_t user_node_count =3D atoi(optarg);
> +
> +            /* Check if the value is a string or zero */
> +            if (user_node_count =3D=3D 0) {
> +                fprintf(stderr, "Error ... Invalid value for option
> '-n'.\n");
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is a negative number */
> +            if (user_node_count < MIN_NODE_COUNT) {
> +                fprintf(stderr, "Error ... Value for option '-n' cannot
> be a "
> +                                "number less than %d.\n", MIN_NODE_COUNT=
);
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is too large */
> +            if (user_node_count > MAX_NODE_COUNT) {
> +                fprintf(stderr, "Error ... Value for option '-n' cannot
> be "
> +                                "more than %d.\n", MAX_NODE_COUNT);
> +                exit(EXIT_FAILURE);
> +            }
> +            node_count =3D user_node_count;
> +        } else {
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    /* Allocate the memory space for all matrixes */
> +    distance_matrix =3D (int32_t **)malloc(node_count * sizeof(int32_t *=
));
> +    for (size_t i =3D 0; i < node_count; i++) {
> +        distance_matrix[i] =3D (int32_t *)malloc(node_count *
> sizeof(int32_t));
> +    }
> +    shortest_distances =3D (int32_t *)malloc(node_count * sizeof(int32_t=
));
> +    via_node =3D (int32_t *)malloc(node_count * sizeof(int32_t));
> +
> +    /* Initialize helper arrays and populate distance_matrix */
> +    srand(1);
> +    for (size_t i =3D 0; i < node_count; i++) {
> +        shortest_distances[i] =3D 0;
> +        via_node[i] =3D -1;
> +        distance_matrix[i][i] =3D 0;
> +    }
> +    for (size_t i =3D 0; i < node_count; i++) {
> +        for (size_t j =3D i + 1; j < node_count; j++) {
> +            distance_matrix[i][j] =3D 1 + (rand()) / (RAND_MAX / 999);
> +            distance_matrix[j][i] =3D distance_matrix[i][j];
> +        }
> +    }
> +
> +    find_shortest_distances(shortest_distances, via_node,
> &node_eccentricity,
> +                            node_count, source_node, distance_matrix);
> +
> +    /* Control printing */
> +    printf("CONTROL RESULT:\n");
> +    printf(" Distance matrix (top left part):\n");
> +    for (size_t i =3D 0; i < 3; i++) {
> +        for (size_t j =3D 0; j < 3; j++) {
> +            printf("    %6d", distance_matrix[i][j]);
> +        }
> +        printf("\n");
> +    }
> +    printf(" Source: %d (eccentricity: %d)\n",
> +           source_node, node_eccentricity);
> +    printf(" Destination   Distance   Via Node\n");
> +    for (size_t i =3D 0; i < 3; i++) {
> +        printf("  %5d          %3d        %4d\n",
> +               i, shortest_distances[i], via_node[i]);
> +    }
> +
> +    /* Free all previously allocated space */
> +    for (size_t i =3D 0; i < node_count; i++) {
> +        free(distance_matrix[i]);
> +    }
> +    free(distance_matrix);
> +    free(shortest_distances);
> +    free(via_node);
> +}
> diff --git a/tests/performance/nightly-tests/benchmarks/source/
> matmult_double/matmult_double.c b/tests/performance/nightly-
> tests/benchmarks/source/matmult_double/matmult_double.c
> new file mode 100644
> index 0000000000..42bbb4717a
> --- /dev/null
> +++ b/tests/performance/nightly-tests/benchmarks/source/
> matmult_double/matmult_double.c
> @@ -0,0 +1,123 @@
> +/*
> + *  Source file of a benchmark program involving calculations of
> + *  a product of two matrixes nxn whose elements are "double". The
> + *  number n can be given via command line, and the default is 200.
> + *
> + *  This file is a part of the project "TCG Continuous Benchmarking".
> + *
> + *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> + *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail=
.
> com>
> + *
> + *  This program is free software: you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation, either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program. If not, see <https://www.gnu.org/licenses/>=
.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +/* Number of columns and rows in all matrixes*/
> +#define DEFAULT_MATRIX_SIZE     200
> +#define MIN_MATRIX_SIZE         2
> +#define MAX_MATRIX_SIZE         200000
> +
> +void main(int argc, char *argv[])
> +{
> +    double **matrix_a;
> +    double **matrix_b;
> +    double **matrix_res;
> +    size_t i;
> +    size_t j;
> +    size_t k;
> +    int32_t matrix_size =3D DEFAULT_MATRIX_SIZE;
> +    int32_t option;
> +    double range_factor =3D 100.0 / (double)(RAND_MAX);
> +
> +
> +    /* Parse command line options */
> +    while ((option =3D getopt(argc, argv, "n:")) !=3D -1) {
> +        if (option =3D=3D 'n') {
> +            int32_t user_matrix_size =3D atoi(optarg);
> +
> +            /* Check if the value is a string or zero */
> +            if (user_matrix_size =3D=3D 0) {
> +                fprintf(stderr, "Error ... Invalid value for option
> '-n'.\n");
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is a negative number */
> +            if (user_matrix_size < MIN_MATRIX_SIZE) {
> +                fprintf(stderr, "Error ... Value for option '-n' cannot
> be a "
> +                                "number less than %d.\n",
> MIN_MATRIX_SIZE);
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is too large */
> +            if (user_matrix_size > MAX_MATRIX_SIZE) {
> +                fprintf(stderr, "Error ... Value for option '-n' cannot
> be "
> +                                "more than %d.\n", MAX_MATRIX_SIZE);
> +                exit(EXIT_FAILURE);
> +            }
> +            matrix_size =3D user_matrix_size;
> +        } else {
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    /* Allocate the memory space for all matrixes */
> +    matrix_a =3D (double **)malloc(matrix_size * sizeof(double *));
> +    for (i =3D 0; i < matrix_size; i++) {
> +        matrix_a[i] =3D (double *)malloc(matrix_size * sizeof(double));
> +    }
> +    matrix_b =3D (double **)malloc(matrix_size * sizeof(double *));
> +    for (i =3D 0; i < matrix_size; i++) {
> +        matrix_b[i] =3D (double *)malloc(matrix_size * sizeof(double));
> +    }
> +    matrix_res =3D (double **)malloc(matrix_size * sizeof(double *));
> +    for (i =3D 0; i < matrix_size; i++) {
> +        matrix_res[i] =3D (double *)malloc(matrix_size * sizeof(double))=
;
> +    }
> +
> +    /* Populate matrix_a and matrix_b with random numbers */
> +    srand(1);
> +    for (i =3D 0; i < matrix_size; i++) {
> +        for (j =3D 0; j < matrix_size; j++) {
> +            matrix_a[i][j] =3D range_factor * (double)rand();
> +            matrix_b[i][j] =3D range_factor * (double)rand();
> +        }
> +    }
> +
> +    /* Calculate the product of two matrixes */
> +    for (i =3D 0; i < matrix_size; i++) {
> +        for (j =3D 0; j < matrix_size; j++) {
> +            matrix_res[i][j] =3D 0.0;
> +            for (k =3D 0; k < matrix_size; k++) {
> +                matrix_res[i][j] +=3D matrix_a[i][k] * matrix_b[k][j];
> +            }
> +        }
> +    }
> +
> +    /* Control printing */
> +    printf("CONTROL RESULT:\n");
> +    printf(" %f %f\n", matrix_res[0][0], matrix_res[0][1]);
> +    printf(" %f %f\n", matrix_res[1][0], matrix_res[1][1]);
> +
> +    /* Free all previously allocated space */
> +    for (i =3D 0; i < matrix_size; i++) {
> +        free(matrix_a[i]);
> +        free(matrix_b[i]);
> +        free(matrix_res[i]);
> +    }
> +    free(matrix_a);
> +    free(matrix_b);
> +    free(matrix_res);
> +}
> diff --git a/tests/performance/nightly-tests/benchmarks/source/matmult_in=
t32/matmult_int32.c
> b/tests/performance/nightly-tests/benchmarks/source/
> matmult_int32/matmult_int32.c
> new file mode 100644
> index 0000000000..29a6eb000d
> --- /dev/null
> +++ b/tests/performance/nightly-tests/benchmarks/source/
> matmult_int32/matmult_int32.c
> @@ -0,0 +1,121 @@
> +/*
> + *  Source file of a benchmark program involving calculations of
> + *  a product of two matrixes nxn whose elements are "int32_t". The
> + *  number n can be given via command line, and the default is 200.
> + *
> + *  This file is a part of the project "TCG Continuous Benchmarking".
> + *
> + *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> + *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail=
.
> com>
> + *
> + *  This program is free software: you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation, either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program. If not, see <https://www.gnu.org/licenses/>=
.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +/* Number of columns and rows in all matrixes*/
> +#define DEFAULT_MATRIX_SIZE     200
> +#define MIN_MATRIX_SIZE         2
> +#define MAX_MATRIX_SIZE         200000
> +
> +void main(int argc, char *argv[])
> +{
> +    int32_t **matrix_a;
> +    int32_t **matrix_b;
> +    int32_t **matrix_res;
> +    size_t i;
> +    size_t j;
> +    size_t k;
> +    int32_t matrix_size =3D DEFAULT_MATRIX_SIZE;
> +    int32_t option;
> +
> +    /* Parse command line options */
> +    while ((option =3D getopt(argc, argv, "n:")) !=3D -1) {
> +        if (option =3D=3D 'n') {
> +            int32_t user_matrix_size =3D atoi(optarg);
> +
> +            /* Check if the value is a string or zero */
> +            if (user_matrix_size =3D=3D 0) {
> +                fprintf(stderr, "Error ... Invalid value for option
> '-n'.\n");
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is a negative number */
> +            if (user_matrix_size < MIN_MATRIX_SIZE) {
> +                fprintf(stderr, "Error ... Value for option '-n' cannot
> be a "
> +                                "number less than %d.\n",
> MIN_MATRIX_SIZE);
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is too large */
> +            if (user_matrix_size > MAX_MATRIX_SIZE) {
> +                fprintf(stderr, "Error ... Value for option '-n' cannot
> be "
> +                                "more than %d.\n", MAX_MATRIX_SIZE);
> +                exit(EXIT_FAILURE);
> +            }
> +            matrix_size =3D user_matrix_size;
> +        } else {
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    /* Allocate the memory space for all matrixes */
> +    matrix_a =3D (int32_t **)malloc(matrix_size * sizeof(int32_t *));
> +    for (i =3D 0; i < matrix_size; i++) {
> +        matrix_a[i] =3D (int32_t *)malloc(matrix_size * sizeof(int32_t))=
;
> +    }
> +    matrix_b =3D (int32_t **)malloc(matrix_size * sizeof(int32_t *));
> +    for (i =3D 0; i < matrix_size; i++) {
> +        matrix_b[i] =3D (int32_t *)malloc(matrix_size * sizeof(int32_t))=
;
> +    }
> +    matrix_res =3D (int32_t **)malloc(matrix_size * sizeof(int32_t *));
> +    for (i =3D 0; i < matrix_size; i++) {
> +        matrix_res[i] =3D (int32_t *)malloc(matrix_size * sizeof(int32_t=
));
> +    }
> +
> +    /* Populate matrix_a and matrix_b with random numbers */
> +    srand(1);
> +    for (i =3D 0; i < matrix_size; i++) {
> +        for (j =3D 0; j < matrix_size; j++) {
> +            matrix_a[i][j] =3D (rand()) / (RAND_MAX / 100);
> +            matrix_b[i][j] =3D (rand()) / (RAND_MAX / 100);
> +        }
> +    }
> +
> +    /* Calculate the product of two matrixes */
> +    for (i =3D 0; i < matrix_size; i++) {
> +        for (j =3D 0; j < matrix_size; j++) {
> +            matrix_res[i][j] =3D 0;
> +            for (k =3D 0; k < matrix_size; k++) {
> +                matrix_res[i][j] +=3D matrix_a[i][k] * matrix_b[k][j];
> +            }
> +        }
> +    }
> +
> +    /* Control printing */
> +    printf("CONTROL RESULT:\n");
> +    printf(" %d %d\n", matrix_res[0][0], matrix_res[0][1]);
> +    printf(" %d %d\n", matrix_res[1][0], matrix_res[1][1]);
> +
> +    /* Free all previously allocated space */
> +    for (i =3D 0; i < matrix_size; i++) {
> +        free(matrix_a[i]);
> +        free(matrix_b[i]);
> +        free(matrix_res[i]);
> +    }
> +    free(matrix_a);
> +    free(matrix_b);
> +    free(matrix_res);
> +}
> diff --git a/tests/performance/nightly-tests/benchmarks/source/qsort_doub=
le/qsort_double.c
> b/tests/performance/nightly-tests/benchmarks/source/qsort_
> double/qsort_double.c
> new file mode 100644
> index 0000000000..efc1b2eee1
> --- /dev/null
> +++ b/tests/performance/nightly-tests/benchmarks/source/qsort_
> double/qsort_double.c
> @@ -0,0 +1,104 @@
> +/*
> + *  Source file of a benchmark program involving sorting of an array
> + *  of length n whose elements are "double". The default value for n
> + *  is 300000, and it can be set via command line as well.
> + *
> + *  This file is a part of the project "TCG Continuous Benchmarking".
> + *
> + *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> + *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail=
.
> com>
> + *
> + *  This program is free software: you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation, either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program. If not, see <https://www.gnu.org/licenses/>=
.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +/* Number of elements in the array to be sorted */
> +#define DEFAULT_ARRAY_LEN       300000
> +#define MIN_ARRAY_LEN           3
> +#define MAX_ARRAY_LEN           30000000
> +
> +/* Upper limit used for generation of random numbers */
> +#define UPPER_LIMIT             1000.0
> +
> +/* Comparison function passed to qsort() */
> +static int compare(const void *a, const void *b)
> +{
> +    if (*(const double *)a > *(const double *)b) {
> +        return 1;
> +    } else if (*(const double *)a < *(const double *)b) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +void main(int argc, char *argv[])
> +{
> +    double *array_to_be_sorted;
> +    int32_t array_len =3D DEFAULT_ARRAY_LEN;
> +    int32_t option;
> +    double range_factor =3D UPPER_LIMIT / (double)(RAND_MAX);
> +
> +    /* Parse command line options */
> +    while ((option =3D getopt(argc, argv, "n:")) !=3D -1) {
> +        if (option =3D=3D 'n') {
> +            int32_t user_array_len =3D atoi(optarg);
> +
> +            /* Check if the value is a string or zero */
> +            if (user_array_len =3D=3D 0) {
> +                fprintf(stderr, "Error ... Invalid value for option
> '-n'.\n");
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is a negative number */
> +            if (user_array_len < MIN_ARRAY_LEN) {
> +                fprintf(stderr, "Error ... Value for option '-n' cannot
> be a "
> +                                "number less than %d.\n", MIN_ARRAY_LEN)=
;
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is too large */
> +            if (user_array_len > MAX_ARRAY_LEN) {
> +                fprintf(stderr, "Error ... Value for option '-n' cannot
> be "
> +                                "more than %d.\n", MAX_ARRAY_LEN);
> +                exit(EXIT_FAILURE);
> +            }
> +            array_len =3D user_array_len;
> +        } else {
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    /* Allocate the memory space for the array */
> +    array_to_be_sorted =3D (double *) malloc(array_len * sizeof(double))=
;
> +
> +    /* Populate the_array with random numbers */
> +    srand(1);
> +    for (size_t i =3D 0; i < array_len; i++) {
> +        array_to_be_sorted[i] =3D range_factor * (double)rand();
> +    }
> +
> +    /* Sort the_array using qsort() */
> +    qsort(array_to_be_sorted, array_len, sizeof(array_to_be_sorted[0]),
> +          compare);
> +
> +    /* Control printing */
> +    printf("CONTROL RESULT:\n");
> +    printf("%14.10f %14.10f %14.10f\n",
> +           array_to_be_sorted[0], array_to_be_sorted[1],
> array_to_be_sorted[2]);
> +
> +    /* Free all previously allocated space */
> +    free(array_to_be_sorted);
> +}
> diff --git a/tests/performance/nightly-tests/benchmarks/source/qsort_int3=
2/qsort_int32.c
> b/tests/performance/nightly-tests/benchmarks/source/qsort_
> int32/qsort_int32.c
> new file mode 100644
> index 0000000000..76ca9c3490
> --- /dev/null
> +++ b/tests/performance/nightly-tests/benchmarks/source/qsort_
> int32/qsort_int32.c
> @@ -0,0 +1,103 @@
> +/*
> + *  Source file of a benchmark program involving sorting of an array
> + *  of length n whose elements are "int32_t". The default value for n
> + *  is 300000, and it can be set via command line as well.
> + *
> + *  This file is a part of the project "TCG Continuous Benchmarking".
> + *
> + *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> + *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail=
.
> com>
> + *
> + *  This program is free software: you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation, either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program. If not, see <https://www.gnu.org/licenses/>=
.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +/* Number of elements in the array to be sorted */
> +#define DEFAULT_ARRAY_LEN       300000
> +#define MIN_ARRAY_LEN           3
> +#define MAX_ARRAY_LEN           30000000
> +
> +/* Upper limit used for generation of random numbers */
> +#define UPPER_LIMIT             50000000
> +
> +/* Comparison function passed to qsort() */
> +static int compare(const void *a, const void *b)
> +{
> +    if (*(const int32_t *)a > *(const int32_t *)b) {
> +        return 1;
> +    } else if (*(const int32_t *)a < *(const int32_t *)b) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +void main(int argc, char *argv[])
> +{
> +    int32_t *array_to_be_sorted;
> +    int32_t array_len =3D DEFAULT_ARRAY_LEN;
> +    int32_t option;
> +
> +    /* Parse command line options */
> +    while ((option =3D getopt(argc, argv, "n:")) !=3D -1) {
> +        if (option =3D=3D 'n') {
> +            int32_t user_array_len =3D atoi(optarg);
> +
> +            /* Check if the value is a string or zero */
> +            if (user_array_len =3D=3D 0) {
> +                fprintf(stderr, "Error ... Invalid value for option
> '-n'.\n");
> +                exit(EXIT_FAILURE);
> +            }
> +            /* Check if the value is a negative number */
> +            if (user_array_len < MIN_ARRAY_LEN) {
> +

--0000000000004bc6f805ae5089d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, August 28, 2020, Ahmed Karaman &lt;<a href=3D"mailto:ahm=
edkhaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt; wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">A nightly performance testing system to monit=
or any change in QEMU<br>
performance across seventeen different targets.<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_=
blank" style=3D"font-size:14px;line-height:22.1200008392334px">aleksandar.q=
emu.devel@gmail.c<wbr>om</a><span style=3D"color:rgb(34,34,34);font-size:14=
px;line-height:22.1200008392334px">&gt;</span><br></div><div><br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
The system includes eight different benchmarks to provide a variety<br>
of testing workloads.<br>
<br>
dijkstra_double:<br>
Find the shortest path between the source node and all other nodes<br>
using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where all nx=
n<br>
distances are double values. The value of n can be specified using<br>
the -n flag. The default value is 2000.<br>
<br>
dijkstra_int32:<br>
Find the shortest path between the source node and all other nodes<br>
using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where all nx=
n<br>
distances are int32 values. The value of n can be specified using<br>
the -n flag. The default value is 2000.<br>
<br>
matmult_double:<br>
Standard matrix multiplication of an n*n matrix of randomly generated<br>
double numbers from 0 to 100. The value of n is passed as an argument<br>
with the -n flag. The default value is 200.<br>
<br>
matmult_int32:<br>
Standard matrix multiplication of an n*n matrix of randomly generated<br>
integer numbers from 0 to 100. The value of n is passed as an<br>
argument with the -n flag. The default value is 200.<br>
<br>
qsort_double:<br>
Quick sort of an array of n randomly generated double numbers from 0<br>
to 1000. The value of n is passed as an argument with the -n flag.<br>
The default value is 300000.<br>
<br>
qsort_int32:<br>
Quick sort of an array of n randomly generated integer numbers from 0<br>
to 50000000. The value of n is passed as an argument with the -n<br>
flag.The default value is 300000.<br>
<br>
qsort_string:<br>
Quick sort of an array of 10000 randomly generated strings of size 8<br>
(including null terminating character). The sort process is repeated<br>
n number of times. The value of n is passed as an argument with the<br>
-n flag. The default value is 20.<br>
<br>
search_string:<br>
Search for the occurrence of a small string in a much larger random<br>
string (=E2=80=9Cneedle in a hay=E2=80=9D). The search process is repeated =
n number<br>
of times and each time, a different large random string (=E2=80=9Chay=E2=80=
=9D) is<br>
generated. The value of n can be specified using the -n flag. The<br>
default value is 20.<br>
<br>
Syntax:<br>
=C2=A0 =C2=A0 nightly_tests_core.py [-h] [-r REF]<br>
=C2=A0 =C2=A0 Optional arguments:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -h, --help=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Show this help message and exit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -r REF, --reference REF<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Reference QEMU version - Default is v5.1.0<br>
=C2=A0 =C2=A0 Example of usage:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nightly_tests_core.py -r v5.1.0 2&gt;log.txt<br=
>
<br>
The following report includes detailed setup and execution details<br>
of the system:<br>
<a href=3D"https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Nig=
htly-Performance-Tests/" target=3D"_blank">https://ahmedkrmn.github.io/<wbr=
>TCG-Continuous-Benchmarking/<wbr>QEMU-Nightly-Performance-<wbr>Tests/</a><=
br>
<br>
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---<br>
=C2=A0tests/performance/nightly-<wbr>tests/README.md=C2=A0 =C2=A0 =C2=A0| 2=
43 +++++<br>
=C2=A0.../source/dijkstra_double/<wbr>dijkstra_double.c=C2=A0 | 194 ++++<br=
>
=C2=A0.../source/dijkstra_int32/<wbr>dijkstra_int32.c=C2=A0 =C2=A0 | 192 ++=
++<br>
=C2=A0.../source/matmult_double/<wbr>matmult_double.c=C2=A0 =C2=A0 | 123 ++=
+<br>
=C2=A0.../source/matmult_int32/<wbr>matmult_int32.c=C2=A0 =C2=A0 =C2=A0 | 1=
21 +++<br>
=C2=A0.../source/qsort_double/<wbr>qsort_double.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 104 ++<br>
=C2=A0.../source/qsort_int32/qsort_<wbr>int32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 103 ++<br>
=C2=A0.../source/qsort_string/<wbr>qsort_string.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 122 +++<br>
=C2=A0.../source/search_string/<wbr>search_string.c=C2=A0 =C2=A0 =C2=A0 | 1=
10 +++<br>
=C2=A0.../scripts/nightly_tests_<wbr>core.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 920 ++++++++++++++++++<br>
=C2=A0.../scripts/run_nightly_<wbr>tests.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 135 +++<br>
=C2=A0.../nightly-tests/scripts/<wbr>send_email.py=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 56 ++<br>
=C2=A012 files changed, 2423 insertions(+)<br>
=C2=A0create mode 100644 tests/performance/nightly-<wbr>tests/README.md<br>
=C2=A0create mode 100644 tests/performance/nightly-<wbr>tests/benchmarks/so=
urce/<wbr>dijkstra_double/dijkstra_<wbr>double.c<br>
=C2=A0create mode 100644 tests/performance/nightly-<wbr>tests/benchmarks/so=
urce/<wbr>dijkstra_int32/dijkstra_int32.<wbr>c<br>
=C2=A0create mode 100644 tests/performance/nightly-<wbr>tests/benchmarks/so=
urce/<wbr>matmult_double/matmult_double.<wbr>c<br>
=C2=A0create mode 100644 tests/performance/nightly-<wbr>tests/benchmarks/so=
urce/<wbr>matmult_int32/matmult_int32.c<br>
=C2=A0create mode 100644 tests/performance/nightly-<wbr>tests/benchmarks/so=
urce/qsort_<wbr>double/qsort_double.c<br>
=C2=A0create mode 100644 tests/performance/nightly-<wbr>tests/benchmarks/so=
urce/qsort_<wbr>int32/qsort_int32.c<br>
=C2=A0create mode 100644 tests/performance/nightly-<wbr>tests/benchmarks/so=
urce/qsort_<wbr>string/qsort_string.c<br>
=C2=A0create mode 100644 tests/performance/nightly-<wbr>tests/benchmarks/so=
urce/<wbr>search_string/search_string.c<br>
=C2=A0create mode 100755 tests/performance/nightly-<wbr>tests/scripts/night=
ly_tests_<wbr>core.py<br>
=C2=A0create mode 100755 tests/performance/nightly-<wbr>tests/scripts/run_n=
ightly_<wbr>tests.py<br>
=C2=A0create mode 100644 tests/performance/nightly-<wbr>tests/scripts/send_=
email.py<br>
<br>
diff --git a/tests/performance/nightly-<wbr>tests/README.md b/tests/perform=
ance/nightly-<wbr>tests/README.md<br>
new file mode 100644<br>
index 0000000000..6db3b351b3<br>
--- /dev/null<br>
+++ b/tests/performance/nightly-<wbr>tests/README.md<br>
@@ -0,0 +1,243 @@<br>
+### QEMU Nightly Tests<br>
+<br>
+**Required settings:**<br>
+<br>
+Update the `GMAIL_USER` object in `send_email.py` with your credentials.<b=
r>
+<br>
+For more details on how the system works, please check the [eighth report]=
(<a href=3D"https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Ni=
ghtly-Performance-Tests/" target=3D"_blank">https://ahmedkrmn.<wbr>github.i=
o/TCG-Continuous-<wbr>Benchmarking/QEMU-Nightly-<wbr>Performance-Tests/</a>=
) of the &quot;TCG Continuos Benchmarking&quot; series.<br>
+<br>
+**Running the System:**<br>
+<br>
+The default reference version is v5.1.0. To specify a custom version, plea=
se use the `-r, --reference` flag.<br>
+<br>
+```bash<br>
+./run_nightly_tests.py<br>
+```<br>
+<br>
+**Output:**<br>
+<br>
+```<br>
+Host CPU=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: Intel(R) Core(TM) i7-8750H CPU=
 @ 2.20GHz<br>
+Host Memory=C2=A0 =C2=A0 =C2=A0 : 15.49 GB<br>
+<br>
+Start Time (UTC) : 2020-08-25 21:30:01<br>
+End Time (UTC)=C2=A0 =C2=A0: 2020-08-25 22:02:37<br>
+Execution Time=C2=A0 =C2=A0: 0:32:35.896990<br>
+<br>
+Status=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: SUCCESS<br>
+<br>
+Note:<br>
+Changes denoted by &#39;-----&#39; are less than 0.01%.<br>
+<br>
+-----------------------------<wbr>---------------------------<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUMMARY REPORT - COMMIT d1a2b51f=
<br>
+-----------------------------<wbr>---------------------------<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AVER=
AGE RESULTS<br>
+-----------------------------<wbr>---------------------------<br>
+Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions=C2=A0 =
=C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
+----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----------<br=
>
+aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 158 355 274=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.693%<br>
+alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 914 967 171=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.524%<br>
+arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8 076 402 940=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.304%<br>
+hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 261 685 987=
=C2=A0 =C2=A0 =C2=A0-0.182%=C2=A0 =C2=A0 =C2=A0+3.164%<br>
+m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 690 273 044=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+7.131%<br>
+mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 862 033 667=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.494%<br>
+mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 008 211 069=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.674%<br>
+mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 918 635 565=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.818%<br>
+mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 051 565 677=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.026%<br>
+ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 480 141 217=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.107%<br>
+ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 576 713 959=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.143%<br>
+ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 558 853 539=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.173%<br>
+riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 406 704 050=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +2.65%<br>
+s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 158 140 046=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.118%<br>
+sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 364 449 748=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +3.33%<br>
+sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 318 544 783=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.851%<br>
+x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 775 844 158=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.156%<br>
+-----------------------------<wbr>---------------------------<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DETAI=
LED RESULTS<br>
+-----------------------------<wbr>---------------------------<br>
+Test Program: dijkstra_double<br>
+-----------------------------<wbr>---------------------------<br>
+Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions=C2=A0 =
=C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
+----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----------<br=
>
+aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 062 583 464=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.424%<br>
+alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 191 864 698=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.696%<br>
+arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016 357 157 526=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.347%<br>
+hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 228 376 315=
=C2=A0 =C2=A0 =C2=A0-0.139%=C2=A0 =C2=A0 =C2=A0+3.086%<br>
+m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 294 016 587=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+9.692%<br>
+mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 051 419 166=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.427%<br>
+mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 231 509 618=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.869%<br>
+mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 245 837 754=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.596%<br>
+mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 414 195 796=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.021%<br>
+ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4 914 520 972=
=C2=A0 =C2=A0 =C2=A0-0.041%=C2=A0 =C2=A0 =C2=A0 +4.74%<br>
+ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5 098 154 311=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.565%<br>
+ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5 082 419 054=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +4.58%<br>
+riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 192 294 915=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.955%<br>
+s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4 584 503 977=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.896%<br>
+sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 949 036 447=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.464%<br>
+sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4 586 203 546=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.237%<br>
+x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 484 092 105=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +1.75%<br>
+-----------------------------<wbr>---------------------------<br>
+-----------------------------<wbr>---------------------------<br>
+Test Program: dijkstra_int32<br>
+-----------------------------<wbr>---------------------------<br>
+Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions=C2=A0 =
=C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
+----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----------<br=
>
+aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 210 194 577=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.493%<br>
+alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 494 133 274=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +2.15%<br>
+arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8 262 935 967=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.665%<br>
+hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 207 318 306=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.047%<br>
+m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 725 856 962=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.527%<br>
+mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 495 227 032=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.492%<br>
+mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 497 147 869=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.479%<br>
+mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 715 388 570=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.892%<br>
+mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 695 276 864=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.913%<br>
+ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 014 557 389=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.819%<br>
+ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 206 267 901=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.139%<br>
+ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 197 998 781=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.146%<br>
+riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 354 912 745=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.396%<br>
+s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 916 247 062=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.241%<br>
+sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 990 532 533=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.669%<br>
+sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 872 231 051=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.758%<br>
+x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 553 981 241=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +2.12%<br>
+-----------------------------<wbr>---------------------------<br>
+-----------------------------<wbr>---------------------------<br>
+Test Program: matmult_double<br>
+-----------------------------<wbr>---------------------------<br>
+Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions=C2=A0 =
=C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
+----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----------<br=
>
+aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 412 273 223=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.302%<br>
+alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 233 991 649=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+7.473%<br>
+arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8 545 173 979=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.088%<br>
+hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 483 597 802=
=C2=A0 =C2=A0 =C2=A0-1.267%=C2=A0 =C2=A0 =C2=A0+4.468%<br>
+m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 919 065 529=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 +18.431%<br>
+mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 344 774 894=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.091%<br>
+mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 329 886 464=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+5.177%<br>
+mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 359 046 988=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.076%<br>
+mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 343 664 785=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+5.167%<br>
+ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 209 457 051=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.246%<br>
+ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 287 503 981=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.173%<br>
+ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 287 189 065=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.173%<br>
+riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 221 603 682=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.277%<br>
+s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 874 199 923=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+5.827%<br>
+sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 543 943 634=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+6.416%<br>
+sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 426 150 004=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+7.139%<br>
+x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 248 917 276=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.322%<br>
+-----------------------------<wbr>---------------------------<br>
+-----------------------------<wbr>---------------------------<br>
+Test Program: matmult_int32<br>
+-----------------------------<wbr>---------------------------<br>
+Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions=C2=A0 =
=C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
+----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----------<br=
>
+aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 598 681 621=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.585%<br>
+alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 372 437 418=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.677%<br>
+arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 746 583 =
193=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.462%<br>
+hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0674 278 =
359=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.183%<br>
+m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0410 495 =
553=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 =C2=A0+0.9%<br>
+mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0499 698 =
837=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.531%<br>
+mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0499 500 429=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.497%<br>
+mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0481 554 664=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.599%<br>
+mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0465 057 054=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.619%<br>
+ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 341 334 =
603=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.944%<br>
+ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 393 796 203=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.966%<br>
+ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 393 977 298=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.965%<br>
+riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 351 709 769=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.785%<br>
+s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 494 427 384=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.599%<br>
+sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 402 668 =
444=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.899%<br>
+sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 495 952 959=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.192%<br>
+x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0402 928 461=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.833%<br>
+-----------------------------<wbr>---------------------------<br>
+-----------------------------<wbr>---------------------------<br>
+Test Program: qsort_double<br>
+-----------------------------<wbr>---------------------------<br>
+Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions=C2=A0 =
=C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
+----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----------<br=
>
+aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 709 683 624=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.417%<br>
+alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 969 460 172=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +3.68%<br>
+arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8 322 998 390=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.587%<br>
+hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 188 301 995=
=C2=A0 =C2=A0 =C2=A0-0.047%=C2=A0 =C2=A0 =C2=A0 =C2=A0+2.9%<br>
+m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 953 930 065=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 +15.153%<br>
+mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 123 919 587=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.055%<br>
+mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 124 212 187=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.048%<br>
+mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 999 047 826=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.405%<br>
+mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 996 426 772=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.409%<br>
+ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 819 267 902=
=C2=A0 =C2=A0 =C2=A0-0.021%=C2=A0 =C2=A0 =C2=A0+5.435%<br>
+ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 768 186 548=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+5.513%<br>
+ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 724 803 772=C2=A0 =C2=
=A0 =C2=A0-0.011%=C2=A0 =C2=A0 =C2=A0+5.603%<br>
+riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 638 328 937=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.021%<br>
+s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 519 081 708=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.362%<br>
+sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 595 545 154=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.994%<br>
+sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 988 986 587=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.747%<br>
+x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 033 468 588=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.234%<br>
+-----------------------------<wbr>---------------------------<br>
+-----------------------------<wbr>---------------------------<br>
+Test Program: qsort_int32<br>
+-----------------------------<wbr>---------------------------<br>
+Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions=C2=A0 =
=C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
+----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----------<br=
>
+aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 193 392 565=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.916%<br>
+alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 521 291 933=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.193%<br>
+arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 465 445 043=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.756%<br>
+hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 280 034 340=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.821%<br>
+m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 843 189 041=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.583%<br>
+mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 558 024 873=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.863%<br>
+mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 560 583 980=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.846%<br>
+mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 563 415 749=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.412%<br>
+mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 542 677 320=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.474%<br>
+ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 728 698 880=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.665%<br>
+ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 842 444 545=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.555%<br>
+ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 791 822 067=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.661%<br>
+riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 348 866 430=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.654%<br>
+s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 184 073 151=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.319%<br>
+sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 946 492 539=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.624%<br>
+sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 452 215 585=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.937%<br>
+x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 813 544 414=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.537%<br>
+-----------------------------<wbr>---------------------------<br>
+-----------------------------<wbr>---------------------------<br>
+Test Program: qsort_string<br>
+-----------------------------<wbr>---------------------------<br>
+Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions=C2=A0 =
=C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
+----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----------<br=
>
+aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 592 218 418=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.468%<br>
+alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 855 834 626=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.487%<br>
+arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7 347 721 165=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.682%<br>
+hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 758 753 926=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.543%<br>
+m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 376 811 462=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.567%<br>
+mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 166 608 045=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.532%<br>
+mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 163 392 541=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.528%<br>
+mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 029 251 969=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.117%<br>
+mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 011 628 621=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.145%<br>
+ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 492 942 463=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.673%<br>
+ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 464 702 554=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.488%<br>
+ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 445 253 307=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.505%<br>
+riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 625 053 328=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.953%<br>
+s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4 194 608 798=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+6.623%<br>
+sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 164 142 539=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.166%<br>
+sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4 299 516 539=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.065%<br>
+x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 940 456 780=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.649%<br>
+-----------------------------<wbr>---------------------------<br>
+-----------------------------<wbr>---------------------------<br>
+Test Program: search_string<br>
+-----------------------------<wbr>---------------------------<br>
+Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions=C2=A0 =
=C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
+----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----------<br=
>
+aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 487 814 704=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +1.94%<br>
+alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 680 723 605=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.835%<br>
+arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011 563 208 260=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.848%<br>
+hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 272 826 858=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.263%<br>
+m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 998 819 159=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.198%<br>
+mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 656 596 909=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.959%<br>
+mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 659 455 464=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.947%<br>
+mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 955 541 001=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.447%<br>
+mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 943 598 207=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.462%<br>
+ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 320 350 477=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.332%<br>
+ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 552 655 634=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.742%<br>
+ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 547 364 971=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.748%<br>
+riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 520 862 601=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.159%<br>
+s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5 497 978 370=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+1.078%<br>
+sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 323 236 696=
=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +3.41%<br>
+sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 427 101 999=C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +4.73%<br>
+x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 729 364 402=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.806%<br>
+-----------------------------<wbr>---------------------------<br>
+```<br>
diff --git a/tests/performance/nightly-<wbr>tests/benchmarks/source/<wbr>di=
jkstra_double/dijkstra_<wbr>double.c b/tests/performance/nightly-<wbr>tests=
/benchmarks/source/<wbr>dijkstra_double/dijkstra_<wbr>double.c<br>
new file mode 100644<br>
index 0000000000..9c0bb804ac<br>
--- /dev/null<br>
+++ b/tests/performance/nightly-<wbr>tests/benchmarks/source/<wbr>dijkstra_=
double/dijkstra_<wbr>double.c<br>
@@ -0,0 +1,194 @@<br>
+/*<br>
+ *=C2=A0 Source file of a benchmark program involving calculations of the<=
br>
+ *=C2=A0 shortest distances between a source node and all other nodes in a=
<br>
+ *=C2=A0 graph of n nodes in which all nxn distances are defined as &quot;=
double&quot;.<br>
+ *=C2=A0 The number n can be given via command line, and the default is 20=
00.<br>
+ *=C2=A0 The algorithm used is Dijsktra&#39;s.<br>
+ *<br>
+ *=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmark=
ing&quot;.<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahme=
dkhaledkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a=
>&gt;<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.qemu.devel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@=
gmail.<wbr>com</a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software: you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License as published=
 by<br>
+ *=C2=A0 the Free Software Foundation, either version 2 of the License, or=
<br>
+ *=C2=A0 (at your option) any later version.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.g=
nu.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&=
gt;.<br>
+ *<br>
+ */<br>
+<br>
+#include &lt;float.h&gt;<br>
+#include &lt;limits.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+<br>
+/* Number of columns and rows in all matrixes*/<br>
+#define DEFAULT_NODE_COUNT=C2=A0 =C2=A0 =C2=A0 2000<br>
+#define MIN_NODE_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
+#define MAX_NODE_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10000<br>
+<br>
+<br>
+int32_t closest_index(int32_t count, double *distances, bool *flags)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t closest;<br>
+=C2=A0 =C2=A0 double minimum =3D DBL_MAX;<br>
+<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags[i] =3D=3D false &amp;&amp; distances=
[i] &lt;=3D minimum) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 closest =3D i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 minimum =3D distances[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return closest;<br>
+}<br>
+<br>
+/**<br>
+ * Calculate the shortest distances from the source node using Dijkstra me=
thod.<br>
+ * @param (out) distances=C2=A0 An array of shortest distances from the so=
urce node.<br>
+ * @param (out) via=C2=A0 An array of nodes needed to be taken as the the =
last<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bef=
ore destination, for each destination.<br>
+ * @param (out) eccent=C2=A0 Eccentricity of the source node.<br>
+ * @param (in) count=C2=A0 The number of nodes.<br>
+ * @param (in) source=C2=A0 Source node.<br>
+ * @param (in) matrix=C2=A0 Distance matrix.<br>
+ */<br>
+void find_shortest_distances(double *distances, int32_t *via, double *ecce=
nt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int32_t count, int32_t source, double **matr=
ix)<br>
+{<br>
+=C2=A0 =C2=A0 bool *flags;<br>
+<br>
+=C2=A0 =C2=A0 flags =3D (bool *)malloc(count * sizeof(bool));<br>
+<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 distances[i] =3D DBL_MAX;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags[i] =3D false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 distances[source] =3D 0.0;<br>
+=C2=A0 =C2=A0 via[source] =3D source;<br>
+<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; count - 1; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t closest =3D closest_index(count, dista=
nces, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags[closest] =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t j =3D 0; j &lt; count; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((!flags[j]) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (mat=
rix[closest][j]) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dis=
tances[closest] !=3D DBL_MAX) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dis=
tances[j] &gt; distances[closest] + matrix[closest][j])) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 distances[j] =3D d=
istances[closest] + matrix[closest][j];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 via[j] =3D closest=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 *eccent =3D 0;<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*eccent &lt; distances[i]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *eccent =3D distances[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free(flags);<br>
+}<br>
+<br>
+<br>
+void main(int argc, char *argv[])<br>
+{<br>
+=C2=A0 =C2=A0 double **distance_matrix;<br>
+=C2=A0 =C2=A0 double *shortest_distances;<br>
+=C2=A0 =C2=A0 int32_t *via_node;<br>
+=C2=A0 =C2=A0 int32_t node_count =3D DEFAULT_NODE_COUNT;<br>
+=C2=A0 =C2=A0 int32_t source_node =3D 0;<br>
+=C2=A0 =C2=A0 double node_eccentricity =3D 0.0;<br>
+=C2=A0 =C2=A0 double range_factor =3D 999.0 / (double)(RAND_MAX);<br>
+=C2=A0 =C2=A0 int32_t option;<br>
+<br>
+=C2=A0 =C2=A0 /* Parse command line options */<br>
+=C2=A0 =C2=A0 while ((option =3D getopt(argc, argv, &quot;n:&quot;)) !=3D =
-1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (option =3D=3D &#39;n&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t user_node_count =3D atoi=
(optarg);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a strin=
g or zero */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_node_count =3D=3D 0) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Invalid value for option &#39;-n&#39;.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a negat=
ive number */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_node_count &lt; MIN_NOD=
E_COUNT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Value for option &#39;-n&#39; cannot be a &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;number less than %d.\n&quot;, =
MIN_NODE_COUNT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is too lar=
ge */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_node_count &gt; MAX_NOD=
E_COUNT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Value for option &#39;-n&#39; cannot be &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;more than %d.\n&quot;, MAX_NOD=
E_COUNT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_count =3D user_node_count;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Allocate the memory space for all matrixes */<br>
+=C2=A0 =C2=A0 distance_matrix =3D (double **)malloc(node_count * sizeof(do=
uble *));<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; node_count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 distance_matrix[i] =3D (double *)malloc(node_c=
ount * sizeof(double));<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 shortest_distances =3D (double *)malloc(node_count * sizeof(=
double));<br>
+=C2=A0 =C2=A0 via_node =3D (int32_t *)malloc(node_count * sizeof(int32_t))=
;<br>
+<br>
+=C2=A0 =C2=A0 /* Initialize helper arrays and populate distance_matrix */<=
br>
+=C2=A0 =C2=A0 srand(1);<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; node_count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shortest_distances[i] =3D 0.0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 via_node[i] =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 distance_matrix[i][i] =3D 0.0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; node_count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t j =3D i + 1; j &lt; node_count; j+=
+) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 distance_matrix[i][j] =3D 1.0 + =
range_factor * (double)rand();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 distance_matrix[j][i] =3D distan=
ce_matrix[i][j];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 find_shortest_distances(<wbr>shortest_distances, via_node, &=
amp;node_eccentricity,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 node_count, source_node, distance_matrix);<br>
+<br>
+=C2=A0 =C2=A0 /* Control printing */<br>
+=C2=A0 =C2=A0 printf(&quot;CONTROL RESULT:\n&quot;);<br>
+=C2=A0 =C2=A0 printf(&quot; Distance matrix (top left part):\n&quot;);<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; 3; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t j =3D 0; j &lt; 3; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;=C2=A0 =C2=A0 %7.2f=
&quot;, distance_matrix[i][j]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 printf(&quot; Source: %d (eccentricity: %f)\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0source_node, node_eccentricity);<=
br>
+=C2=A0 =C2=A0 printf(&quot; Destination=C2=A0 =C2=A0Distance=C2=A0 =C2=A0V=
ia Node\n&quot;);<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; 3; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;=C2=A0 %5d=C2=A0 =C2=A0 =C2=A0 =
=C2=A0%7.2f=C2=A0 =C2=A0 =C2=A0 =C2=A0%4d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, shortest_distanc=
es[i], via_node[i]);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Free all previously allocated space */<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; node_count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(distance_matrix[i]);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 free(distance_matrix);<br>
+=C2=A0 =C2=A0 free(shortest_distances);<br>
+=C2=A0 =C2=A0 free(via_node);<br>
+}<br>
diff --git a/tests/performance/nightly-<wbr>tests/benchmarks/source/<wbr>di=
jkstra_int32/dijkstra_int32.<wbr>c b/tests/performance/nightly-<wbr>tests/b=
enchmarks/source/<wbr>dijkstra_int32/dijkstra_int32.<wbr>c<br>
new file mode 100644<br>
index 0000000000..2663cde943<br>
--- /dev/null<br>
+++ b/tests/performance/nightly-<wbr>tests/benchmarks/source/<wbr>dijkstra_=
int32/dijkstra_int32.<wbr>c<br>
@@ -0,0 +1,192 @@<br>
+/*<br>
+ *=C2=A0 Source file of a benchmark program involving calculations of the<=
br>
+ *=C2=A0 shortest distances between a source node and all other nodes in a=
<br>
+ *=C2=A0 graph of n nodes in which all nxn distances are defined as &quot;=
int32&quot;.<br>
+ *=C2=A0 The number n can be given via command line, and the default is 20=
00.<br>
+ *=C2=A0 The algorithm used is Dijsktra&#39;s.<br>
+ *<br>
+ *=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmark=
ing&quot;.<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahme=
dkhaledkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a=
>&gt;<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.qemu.devel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@=
gmail.<wbr>com</a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software: you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License as published=
 by<br>
+ *=C2=A0 the Free Software Foundation, either version 2 of the License, or=
<br>
+ *=C2=A0 (at your option) any later version.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.g=
nu.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&=
gt;.<br>
+ *<br>
+ */<br>
+<br>
+#include &lt;limits.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+<br>
+/* Number of columns and rows in all matrixes*/<br>
+#define DEFAULT_NODE_COUNT=C2=A0 =C2=A0 =C2=A0 2000<br>
+#define MIN_NODE_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
+#define MAX_NODE_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10000<br>
+<br>
+<br>
+int32_t closest_index(int32_t count, int32_t *distances, bool *flags)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t closest;<br>
+=C2=A0 =C2=A0 int32_t minimum =3D INT_MAX;<br>
+<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags[i] =3D=3D false &amp;&amp; distances=
[i] &lt;=3D minimum) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 closest =3D i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 minimum =3D distances[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return closest;<br>
+}<br>
+<br>
+/**<br>
+ * Calculate the shortest distances from the source node using Dijkstra me=
thod.<br>
+ * @param (out) distances=C2=A0 An array of shortest distances from the so=
urce node.<br>
+ * @param (out) via=C2=A0 An array of nodes needed to be taken as the the =
last<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bef=
ore destination, for each destination.<br>
+ * @param (out) eccent=C2=A0 Eccentricity of the source node.<br>
+ * @param (in) count=C2=A0 The number of nodes.<br>
+ * @param (in) source=C2=A0 Source node.<br>
+ * @param (in) matrix=C2=A0 Distance matrix.<br>
+ */<br>
+void find_shortest_distances(int32_<wbr>t *distances, int32_t *via, int32_=
t *eccent,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int32_t count, int32_t source, int32_t **mat=
rix)<br>
+{<br>
+=C2=A0 =C2=A0 bool *flags;<br>
+<br>
+=C2=A0 =C2=A0 flags =3D (bool *)malloc(count * sizeof(bool));<br>
+<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 distances[i] =3D INT_MAX;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags[i] =3D false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 distances[source] =3D 0;<br>
+=C2=A0 =C2=A0 via[source] =3D source;<br>
+<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; count - 1; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t closest =3D closest_index(count, dista=
nces, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags[closest] =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t j =3D 0; j &lt; count; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((!flags[j]) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (mat=
rix[closest][j]) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dis=
tances[closest] !=3D INT_MAX) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dis=
tances[j] &gt; distances[closest] + matrix[closest][j])) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 distances[j] =3D d=
istances[closest] + matrix[closest][j];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 via[j] =3D closest=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 *eccent =3D 0;<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*eccent &lt; distances[i]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *eccent =3D distances[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free(flags);<br>
+}<br>
+<br>
+<br>
+void main(int argc, char *argv[])<br>
+{<br>
+=C2=A0 =C2=A0 int32_t **distance_matrix;<br>
+=C2=A0 =C2=A0 int32_t *shortest_distances;<br>
+=C2=A0 =C2=A0 int32_t *via_node;<br>
+=C2=A0 =C2=A0 int32_t node_count =3D DEFAULT_NODE_COUNT;<br>
+=C2=A0 =C2=A0 int32_t source_node =3D 0;<br>
+=C2=A0 =C2=A0 int32_t node_eccentricity =3D 0;<br>
+=C2=A0 =C2=A0 int32_t option;<br>
+<br>
+=C2=A0 =C2=A0 /* Parse command line options */<br>
+=C2=A0 =C2=A0 while ((option =3D getopt(argc, argv, &quot;n:&quot;)) !=3D =
-1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (option =3D=3D &#39;n&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t user_node_count =3D atoi=
(optarg);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a strin=
g or zero */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_node_count =3D=3D 0) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Invalid value for option &#39;-n&#39;.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a negat=
ive number */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_node_count &lt; MIN_NOD=
E_COUNT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Value for option &#39;-n&#39; cannot be a &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;number less than %d.\n&quot;, =
MIN_NODE_COUNT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is too lar=
ge */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_node_count &gt; MAX_NOD=
E_COUNT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Value for option &#39;-n&#39; cannot be &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;more than %d.\n&quot;, MAX_NOD=
E_COUNT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_count =3D user_node_count;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Allocate the memory space for all matrixes */<br>
+=C2=A0 =C2=A0 distance_matrix =3D (int32_t **)malloc(node_count * sizeof(i=
nt32_t *));<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; node_count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 distance_matrix[i] =3D (int32_t *)malloc(node_=
count * sizeof(int32_t));<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 shortest_distances =3D (int32_t *)malloc(node_count * sizeof=
(int32_t));<br>
+=C2=A0 =C2=A0 via_node =3D (int32_t *)malloc(node_count * sizeof(int32_t))=
;<br>
+<br>
+=C2=A0 =C2=A0 /* Initialize helper arrays and populate distance_matrix */<=
br>
+=C2=A0 =C2=A0 srand(1);<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; node_count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shortest_distances[i] =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 via_node[i] =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 distance_matrix[i][i] =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; node_count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t j =3D i + 1; j &lt; node_count; j+=
+) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 distance_matrix[i][j] =3D 1 + (r=
and()) / (RAND_MAX / 999);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 distance_matrix[j][i] =3D distan=
ce_matrix[i][j];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 find_shortest_distances(<wbr>shortest_distances, via_node, &=
amp;node_eccentricity,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 node_count, source_node, distance_matrix);<br>
+<br>
+=C2=A0 =C2=A0 /* Control printing */<br>
+=C2=A0 =C2=A0 printf(&quot;CONTROL RESULT:\n&quot;);<br>
+=C2=A0 =C2=A0 printf(&quot; Distance matrix (top left part):\n&quot;);<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; 3; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t j =3D 0; j &lt; 3; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;=C2=A0 =C2=A0 %6d&q=
uot;, distance_matrix[i][j]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 printf(&quot; Source: %d (eccentricity: %d)\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0source_node, node_eccentricity);<=
br>
+=C2=A0 =C2=A0 printf(&quot; Destination=C2=A0 =C2=A0Distance=C2=A0 =C2=A0V=
ia Node\n&quot;);<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; 3; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;=C2=A0 %5d=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 %3d=C2=A0 =C2=A0 =C2=A0 =C2=A0 %4d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, shortest_distanc=
es[i], via_node[i]);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Free all previously allocated space */<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; node_count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(distance_matrix[i]);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 free(distance_matrix);<br>
+=C2=A0 =C2=A0 free(shortest_distances);<br>
+=C2=A0 =C2=A0 free(via_node);<br>
+}<br>
diff --git a/tests/performance/nightly-<wbr>tests/benchmarks/source/<wbr>ma=
tmult_double/matmult_double.<wbr>c b/tests/performance/nightly-<wbr>tests/b=
enchmarks/source/<wbr>matmult_double/matmult_double.<wbr>c<br>
new file mode 100644<br>
index 0000000000..42bbb4717a<br>
--- /dev/null<br>
+++ b/tests/performance/nightly-<wbr>tests/benchmarks/source/<wbr>matmult_d=
ouble/matmult_double.<wbr>c<br>
@@ -0,0 +1,123 @@<br>
+/*<br>
+ *=C2=A0 Source file of a benchmark program involving calculations of<br>
+ *=C2=A0 a product of two matrixes nxn whose elements are &quot;double&quo=
t;. The<br>
+ *=C2=A0 number n can be given via command line, and the default is 200.<b=
r>
+ *<br>
+ *=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmark=
ing&quot;.<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahme=
dkhaledkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a=
>&gt;<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.qemu.devel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@=
gmail.<wbr>com</a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software: you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License as published=
 by<br>
+ *=C2=A0 the Free Software Foundation, either version 2 of the License, or=
<br>
+ *=C2=A0 (at your option) any later version.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.g=
nu.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&=
gt;.<br>
+ *<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+<br>
+/* Number of columns and rows in all matrixes*/<br>
+#define DEFAULT_MATRIX_SIZE=C2=A0 =C2=A0 =C2=A0200<br>
+#define MIN_MATRIX_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
+#define MAX_MATRIX_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0200000<br>
+<br>
+void main(int argc, char *argv[])<br>
+{<br>
+=C2=A0 =C2=A0 double **matrix_a;<br>
+=C2=A0 =C2=A0 double **matrix_b;<br>
+=C2=A0 =C2=A0 double **matrix_res;<br>
+=C2=A0 =C2=A0 size_t i;<br>
+=C2=A0 =C2=A0 size_t j;<br>
+=C2=A0 =C2=A0 size_t k;<br>
+=C2=A0 =C2=A0 int32_t matrix_size =3D DEFAULT_MATRIX_SIZE;<br>
+=C2=A0 =C2=A0 int32_t option;<br>
+=C2=A0 =C2=A0 double range_factor =3D 100.0 / (double)(RAND_MAX);<br>
+<br>
+<br>
+=C2=A0 =C2=A0 /* Parse command line options */<br>
+=C2=A0 =C2=A0 while ((option =3D getopt(argc, argv, &quot;n:&quot;)) !=3D =
-1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (option =3D=3D &#39;n&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t user_matrix_size =3D ato=
i(optarg);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a strin=
g or zero */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_matrix_size =3D=3D 0) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Invalid value for option &#39;-n&#39;.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a negat=
ive number */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_matrix_size &lt; MIN_MA=
TRIX_SIZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Value for option &#39;-n&#39; cannot be a &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;number less than %d.\n&quot;, =
MIN_MATRIX_SIZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is too lar=
ge */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_matrix_size &gt; MAX_MA=
TRIX_SIZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Value for option &#39;-n&#39; cannot be &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;more than %d.\n&quot;, MAX_MAT=
RIX_SIZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_size =3D user_matrix_size=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Allocate the memory space for all matrixes */<br>
+=C2=A0 =C2=A0 matrix_a =3D (double **)malloc(matrix_size * sizeof(double *=
));<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_a[i] =3D (double *)malloc(matrix_size *=
 sizeof(double));<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 matrix_b =3D (double **)malloc(matrix_size * sizeof(double *=
));<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_b[i] =3D (double *)malloc(matrix_size *=
 sizeof(double));<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 matrix_res =3D (double **)malloc(matrix_size * sizeof(double=
 *));<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_res[i] =3D (double *)malloc(matrix_size=
 * sizeof(double));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Populate matrix_a and matrix_b with random numbers */<br>
+=C2=A0 =C2=A0 srand(1);<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; matrix_size; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_a[i][j] =3D range_factor =
* (double)rand();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_b[i][j] =3D range_factor =
* (double)rand();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Calculate the product of two matrixes */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; matrix_size; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_res[i][j] =3D 0.0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (k =3D 0; k &lt; matrix_size=
; k++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_res[i][j] +=
=3D matrix_a[i][k] * matrix_b[k][j];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Control printing */<br>
+=C2=A0 =C2=A0 printf(&quot;CONTROL RESULT:\n&quot;);<br>
+=C2=A0 =C2=A0 printf(&quot; %f %f\n&quot;, matrix_res[0][0], matrix_res[0]=
[1]);<br>
+=C2=A0 =C2=A0 printf(&quot; %f %f\n&quot;, matrix_res[1][0], matrix_res[1]=
[1]);<br>
+<br>
+=C2=A0 =C2=A0 /* Free all previously allocated space */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(matrix_a[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(matrix_b[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(matrix_res[i]);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 free(matrix_a);<br>
+=C2=A0 =C2=A0 free(matrix_b);<br>
+=C2=A0 =C2=A0 free(matrix_res);<br>
+}<br>
diff --git a/tests/performance/nightly-<wbr>tests/benchmarks/source/<wbr>ma=
tmult_int32/matmult_int32.c b/tests/performance/nightly-<wbr>tests/benchmar=
ks/source/<wbr>matmult_int32/matmult_int32.c<br>
new file mode 100644<br>
index 0000000000..29a6eb000d<br>
--- /dev/null<br>
+++ b/tests/performance/nightly-<wbr>tests/benchmarks/source/<wbr>matmult_i=
nt32/matmult_int32.c<br>
@@ -0,0 +1,121 @@<br>
+/*<br>
+ *=C2=A0 Source file of a benchmark program involving calculations of<br>
+ *=C2=A0 a product of two matrixes nxn whose elements are &quot;int32_t&qu=
ot;. The<br>
+ *=C2=A0 number n can be given via command line, and the default is 200.<b=
r>
+ *<br>
+ *=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmark=
ing&quot;.<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahme=
dkhaledkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a=
>&gt;<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.qemu.devel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@=
gmail.<wbr>com</a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software: you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License as published=
 by<br>
+ *=C2=A0 the Free Software Foundation, either version 2 of the License, or=
<br>
+ *=C2=A0 (at your option) any later version.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.g=
nu.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&=
gt;.<br>
+ *<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+<br>
+/* Number of columns and rows in all matrixes*/<br>
+#define DEFAULT_MATRIX_SIZE=C2=A0 =C2=A0 =C2=A0200<br>
+#define MIN_MATRIX_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
+#define MAX_MATRIX_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0200000<br>
+<br>
+void main(int argc, char *argv[])<br>
+{<br>
+=C2=A0 =C2=A0 int32_t **matrix_a;<br>
+=C2=A0 =C2=A0 int32_t **matrix_b;<br>
+=C2=A0 =C2=A0 int32_t **matrix_res;<br>
+=C2=A0 =C2=A0 size_t i;<br>
+=C2=A0 =C2=A0 size_t j;<br>
+=C2=A0 =C2=A0 size_t k;<br>
+=C2=A0 =C2=A0 int32_t matrix_size =3D DEFAULT_MATRIX_SIZE;<br>
+=C2=A0 =C2=A0 int32_t option;<br>
+<br>
+=C2=A0 =C2=A0 /* Parse command line options */<br>
+=C2=A0 =C2=A0 while ((option =3D getopt(argc, argv, &quot;n:&quot;)) !=3D =
-1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (option =3D=3D &#39;n&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t user_matrix_size =3D ato=
i(optarg);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a strin=
g or zero */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_matrix_size =3D=3D 0) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Invalid value for option &#39;-n&#39;.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a negat=
ive number */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_matrix_size &lt; MIN_MA=
TRIX_SIZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Value for option &#39;-n&#39; cannot be a &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;number less than %d.\n&quot;, =
MIN_MATRIX_SIZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is too lar=
ge */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_matrix_size &gt; MAX_MA=
TRIX_SIZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Value for option &#39;-n&#39; cannot be &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;more than %d.\n&quot;, MAX_MAT=
RIX_SIZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_size =3D user_matrix_size=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Allocate the memory space for all matrixes */<br>
+=C2=A0 =C2=A0 matrix_a =3D (int32_t **)malloc(matrix_size * sizeof(int32_t=
 *));<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_a[i] =3D (int32_t *)malloc(matrix_size =
* sizeof(int32_t));<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 matrix_b =3D (int32_t **)malloc(matrix_size * sizeof(int32_t=
 *));<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_b[i] =3D (int32_t *)malloc(matrix_size =
* sizeof(int32_t));<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 matrix_res =3D (int32_t **)malloc(matrix_size * sizeof(int32=
_t *));<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_res[i] =3D (int32_t *)malloc(matrix_siz=
e * sizeof(int32_t));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Populate matrix_a and matrix_b with random numbers */<br>
+=C2=A0 =C2=A0 srand(1);<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; matrix_size; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_a[i][j] =3D (rand()) / (R=
AND_MAX / 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_b[i][j] =3D (rand()) / (R=
AND_MAX / 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Calculate the product of two matrixes */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; matrix_size; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_res[i][j] =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (k =3D 0; k &lt; matrix_size=
; k++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix_res[i][j] +=
=3D matrix_a[i][k] * matrix_b[k][j];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Control printing */<br>
+=C2=A0 =C2=A0 printf(&quot;CONTROL RESULT:\n&quot;);<br>
+=C2=A0 =C2=A0 printf(&quot; %d %d\n&quot;, matrix_res[0][0], matrix_res[0]=
[1]);<br>
+=C2=A0 =C2=A0 printf(&quot; %d %d\n&quot;, matrix_res[1][0], matrix_res[1]=
[1]);<br>
+<br>
+=C2=A0 =C2=A0 /* Free all previously allocated space */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; matrix_size; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(matrix_a[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(matrix_b[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(matrix_res[i]);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 free(matrix_a);<br>
+=C2=A0 =C2=A0 free(matrix_b);<br>
+=C2=A0 =C2=A0 free(matrix_res);<br>
+}<br>
diff --git a/tests/performance/nightly-<wbr>tests/benchmarks/source/qsort_<=
wbr>double/qsort_double.c b/tests/performance/nightly-<wbr>tests/benchmarks=
/source/qsort_<wbr>double/qsort_double.c<br>
new file mode 100644<br>
index 0000000000..efc1b2eee1<br>
--- /dev/null<br>
+++ b/tests/performance/nightly-<wbr>tests/benchmarks/source/qsort_<wbr>dou=
ble/qsort_double.c<br>
@@ -0,0 +1,104 @@<br>
+/*<br>
+ *=C2=A0 Source file of a benchmark program involving sorting of an array<=
br>
+ *=C2=A0 of length n whose elements are &quot;double&quot;. The default va=
lue for n<br>
+ *=C2=A0 is 300000, and it can be set via command line as well.<br>
+ *<br>
+ *=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmark=
ing&quot;.<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahme=
dkhaledkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a=
>&gt;<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.qemu.devel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@=
gmail.<wbr>com</a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software: you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License as published=
 by<br>
+ *=C2=A0 the Free Software Foundation, either version 2 of the License, or=
<br>
+ *=C2=A0 (at your option) any later version.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.g=
nu.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&=
gt;.<br>
+ *<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+<br>
+/* Number of elements in the array to be sorted */<br>
+#define DEFAULT_ARRAY_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0300000<br>
+#define MIN_ARRAY_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
+#define MAX_ARRAY_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A030000000<br>
+<br>
+/* Upper limit used for generation of random numbers */<br>
+#define UPPER_LIMIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000.0<=
br>
+<br>
+/* Comparison function passed to qsort() */<br>
+static int compare(const void *a, const void *b)<br>
+{<br>
+=C2=A0 =C2=A0 if (*(const double *)a &gt; *(const double *)b) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 } else if (*(const double *)a &lt; *(const double *)b) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+void main(int argc, char *argv[])<br>
+{<br>
+=C2=A0 =C2=A0 double *array_to_be_sorted;<br>
+=C2=A0 =C2=A0 int32_t array_len =3D DEFAULT_ARRAY_LEN;<br>
+=C2=A0 =C2=A0 int32_t option;<br>
+=C2=A0 =C2=A0 double range_factor =3D UPPER_LIMIT / (double)(RAND_MAX);<br=
>
+<br>
+=C2=A0 =C2=A0 /* Parse command line options */<br>
+=C2=A0 =C2=A0 while ((option =3D getopt(argc, argv, &quot;n:&quot;)) !=3D =
-1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (option =3D=3D &#39;n&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t user_array_len =3D atoi(=
optarg);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a strin=
g or zero */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_array_len =3D=3D 0) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Invalid value for option &#39;-n&#39;.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a negat=
ive number */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_array_len &lt; MIN_ARRA=
Y_LEN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Value for option &#39;-n&#39; cannot be a &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;number less than %d.\n&quot;, =
MIN_ARRAY_LEN);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is too lar=
ge */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_array_len &gt; MAX_ARRA=
Y_LEN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Value for option &#39;-n&#39; cannot be &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;more than %d.\n&quot;, MAX_ARR=
AY_LEN);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 array_len =3D user_array_len;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Allocate the memory space for the array */<br>
+=C2=A0 =C2=A0 array_to_be_sorted =3D (double *) malloc(array_len * sizeof(=
double));<br>
+<br>
+=C2=A0 =C2=A0 /* Populate the_array with random numbers */<br>
+=C2=A0 =C2=A0 srand(1);<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; array_len; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 array_to_be_sorted[i] =3D range_factor * (doub=
le)rand();<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Sort the_array using qsort() */<br>
+=C2=A0 =C2=A0 qsort(array_to_be_sorted, array_len, sizeof(array_to_be_sort=
ed[0]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compare);<br>
+<br>
+=C2=A0 =C2=A0 /* Control printing */<br>
+=C2=A0 =C2=A0 printf(&quot;CONTROL RESULT:\n&quot;);<br>
+=C2=A0 =C2=A0 printf(&quot;%14.10f %14.10f %14.10f\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0array_to_be_sorted[0], array_to_b=
e_sorted[1], array_to_be_sorted[2]);<br>
+<br>
+=C2=A0 =C2=A0 /* Free all previously allocated space */<br>
+=C2=A0 =C2=A0 free(array_to_be_sorted);<br>
+}<br>
diff --git a/tests/performance/nightly-<wbr>tests/benchmarks/source/qsort_<=
wbr>int32/qsort_int32.c b/tests/performance/nightly-<wbr>tests/benchmarks/s=
ource/qsort_<wbr>int32/qsort_int32.c<br>
new file mode 100644<br>
index 0000000000..76ca9c3490<br>
--- /dev/null<br>
+++ b/tests/performance/nightly-<wbr>tests/benchmarks/source/qsort_<wbr>int=
32/qsort_int32.c<br>
@@ -0,0 +1,103 @@<br>
+/*<br>
+ *=C2=A0 Source file of a benchmark program involving sorting of an array<=
br>
+ *=C2=A0 of length n whose elements are &quot;int32_t&quot;. The default v=
alue for n<br>
+ *=C2=A0 is 300000, and it can be set via command line as well.<br>
+ *<br>
+ *=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmark=
ing&quot;.<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahme=
dkhaledkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a=
>&gt;<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.qemu.devel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@=
gmail.<wbr>com</a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software: you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License as published=
 by<br>
+ *=C2=A0 the Free Software Foundation, either version 2 of the License, or=
<br>
+ *=C2=A0 (at your option) any later version.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.g=
nu.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&=
gt;.<br>
+ *<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+<br>
+/* Number of elements in the array to be sorted */<br>
+#define DEFAULT_ARRAY_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0300000<br>
+#define MIN_ARRAY_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
+#define MAX_ARRAY_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A030000000<br>
+<br>
+/* Upper limit used for generation of random numbers */<br>
+#define UPPER_LIMIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05000000=
0<br>
+<br>
+/* Comparison function passed to qsort() */<br>
+static int compare(const void *a, const void *b)<br>
+{<br>
+=C2=A0 =C2=A0 if (*(const int32_t *)a &gt; *(const int32_t *)b) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 } else if (*(const int32_t *)a &lt; *(const int32_t *)b) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+void main(int argc, char *argv[])<br>
+{<br>
+=C2=A0 =C2=A0 int32_t *array_to_be_sorted;<br>
+=C2=A0 =C2=A0 int32_t array_len =3D DEFAULT_ARRAY_LEN;<br>
+=C2=A0 =C2=A0 int32_t option;<br>
+<br>
+=C2=A0 =C2=A0 /* Parse command line options */<br>
+=C2=A0 =C2=A0 while ((option =3D getopt(argc, argv, &quot;n:&quot;)) !=3D =
-1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (option =3D=3D &#39;n&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t user_array_len =3D atoi(=
optarg);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a strin=
g or zero */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_array_len =3D=3D 0) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Error ... Invalid value for option &#39;-n&#39;.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the value is a negat=
ive number */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (user_array_len &lt; MIN_ARRA=
Y_LEN) {<br>
+=C2=A0</blockquote>

--0000000000004bc6f805ae5089d5--

