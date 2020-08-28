Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CD3C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE812086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX41ymz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE812086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbva-0003qb-Gj
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpU-0003rt-Tz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:56 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:34674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpP-0005jN-Rs
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id f7so857616wrw.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ztdp06tHpUTupGG5kZnKkBKNJQ2GBi6jOrEePLCl0Kw=;
 b=dX41ymz9tc93PMf0ZRirpDHXn9NI60cKLfOFjuDhBM1gUH6SuQItoBy6JDX/CJOvk6
 bDz6/aq3ZOE1IxebLaizUmTQkWn7Mz5zHGHn+HrNOhHXjjGoeVdPGn+5PoPp6HRUwEfp
 FTV+fQ+S9yrf7NDm0zHDjoGsJACo53WQDRRCEIDKIhvrv/aWtZl+w1PJinQyqz1z+gh9
 M79aCKCCrSWxwJA6/g2LHsSvIXFrDCu3Tnu0TlZ1ieQV3oyVWhj0HmDcOh7sqeqlGpCk
 fKYMHuC2qqtaF4h4gvEzINeRW9s6JlztrNEID7Gjo8L/Uw84Mc3tfOZCi0zDSdCUd0rp
 ABAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ztdp06tHpUTupGG5kZnKkBKNJQ2GBi6jOrEePLCl0Kw=;
 b=mb1l57QQfTdbklIqsDkSWNR77EcX+iAQSb3xsZd+/RZUBx4PY0mxygyGjRHAUYIZKG
 wY0fJbM065LqBCBI8VGSAn7g6Pk83rxyhdi75dAbgfvPthAzh4KUovl7B2OC9934c1N2
 pCvnP5GlX+jfeljiqgKlmownBCdrJ0CmIJorDl1OOif0JRfSWnmHOUAwkOObP5dSsw2Z
 BfXn2MYH+gUUVIZmJ1xB5LaCgejcJuMzgUssWN1GQK4pax4EGLhsO3sMF2NSW+x7k532
 HUjy3XViWHJfNTsSoAQ4d5EuZN+3o6jDAb1KL5ztdSy60T5r2LEAOEyT7yK4GVlRMfZr
 6Ofg==
X-Gm-Message-State: AOAM531X5tgLPxIq1FUHahh1HI+Ptk03nI1WDbyHLPkJLviYBMkh1W8j
 Xc4C27V5KgC0IjvJwaFFHYnnNjQeIFtW8g==
X-Google-Smtp-Source: ABdhPJxZOldAOxbmDbmBbcG+/cHy/Z3PNSWRU55JhPE+ZYjn/P9C2pkVeNhEcVnBDOtvT5yTaUrhXA==
X-Received: by 2002:a5d:4145:: with SMTP id c5mr986131wrq.18.1598611306982;
 Fri, 28 Aug 2020 03:41:46 -0700 (PDT)
Received: from localhost.localdomain ([197.58.77.158])
 by smtp.gmail.com with ESMTPSA id e18sm1307453wrx.50.2020.08.28.03.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:41:46 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 7/9] tests/performance: Add nightly tests
Date: Fri, 28 Aug 2020 12:41:00 +0200
Message-Id: <20200828104102.4490-8-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A nightly performance testing system to monitor any change in QEMU
performance across seventeen different targets.

The system includes eight different benchmarks to provide a variety
of testing workloads.

dijkstra_double:
Find the shortest path between the source node and all other nodes
using Dijkstra’s algorithm. The graph contains n nodes where all nxn
distances are double values. The value of n can be specified using
the -n flag. The default value is 2000.

dijkstra_int32:
Find the shortest path between the source node and all other nodes
using Dijkstra’s algorithm. The graph contains n nodes where all nxn
distances are int32 values. The value of n can be specified using
the -n flag. The default value is 2000.

matmult_double:
Standard matrix multiplication of an n*n matrix of randomly generated
double numbers from 0 to 100. The value of n is passed as an argument
with the -n flag. The default value is 200.

matmult_int32:
Standard matrix multiplication of an n*n matrix of randomly generated
integer numbers from 0 to 100. The value of n is passed as an
argument with the -n flag. The default value is 200.

qsort_double:
Quick sort of an array of n randomly generated double numbers from 0
to 1000. The value of n is passed as an argument with the -n flag.
The default value is 300000.

qsort_int32:
Quick sort of an array of n randomly generated integer numbers from 0
to 50000000. The value of n is passed as an argument with the -n
flag.The default value is 300000.

qsort_string:
Quick sort of an array of 10000 randomly generated strings of size 8
(including null terminating character). The sort process is repeated
n number of times. The value of n is passed as an argument with the
-n flag. The default value is 20.

search_string:
Search for the occurrence of a small string in a much larger random
string (“needle in a hay”). The search process is repeated n number
of times and each time, a different large random string (“hay”) is
generated. The value of n can be specified using the -n flag. The
default value is 20.

Syntax:
    nightly_tests_core.py [-h] [-r REF]
    Optional arguments:
        -h, --help            Show this help message and exit
        -r REF, --reference REF
                        Reference QEMU version - Default is v5.1.0
    Example of usage:
        nightly_tests_core.py -r v5.1.0 2>log.txt

The following report includes detailed setup and execution details
of the system:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Nightly-Performance-Tests/

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 tests/performance/nightly-tests/README.md     | 243 +++++
 .../source/dijkstra_double/dijkstra_double.c  | 194 ++++
 .../source/dijkstra_int32/dijkstra_int32.c    | 192 ++++
 .../source/matmult_double/matmult_double.c    | 123 +++
 .../source/matmult_int32/matmult_int32.c      | 121 +++
 .../source/qsort_double/qsort_double.c        | 104 ++
 .../source/qsort_int32/qsort_int32.c          | 103 ++
 .../source/qsort_string/qsort_string.c        | 122 +++
 .../source/search_string/search_string.c      | 110 +++
 .../scripts/nightly_tests_core.py             | 920 ++++++++++++++++++
 .../scripts/run_nightly_tests.py              | 135 +++
 .../nightly-tests/scripts/send_email.py       |  56 ++
 12 files changed, 2423 insertions(+)
 create mode 100644 tests/performance/nightly-tests/README.md
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/dijkstra_double/dijkstra_double.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/dijkstra_int32/dijkstra_int32.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/matmult_double/matmult_double.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/matmult_int32/matmult_int32.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/qsort_double/qsort_double.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/qsort_int32/qsort_int32.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/qsort_string/qsort_string.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/search_string/search_string.c
 create mode 100755 tests/performance/nightly-tests/scripts/nightly_tests_core.py
 create mode 100755 tests/performance/nightly-tests/scripts/run_nightly_tests.py
 create mode 100644 tests/performance/nightly-tests/scripts/send_email.py

diff --git a/tests/performance/nightly-tests/README.md b/tests/performance/nightly-tests/README.md
new file mode 100644
index 0000000000..6db3b351b3
--- /dev/null
+++ b/tests/performance/nightly-tests/README.md
@@ -0,0 +1,243 @@
+### QEMU Nightly Tests
+
+**Required settings:**
+
+Update the `GMAIL_USER` object in `send_email.py` with your credentials.
+
+For more details on how the system works, please check the [eighth report](https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Nightly-Performance-Tests/) of the "TCG Continuos Benchmarking" series.
+
+**Running the System:**
+
+The default reference version is v5.1.0. To specify a custom version, please use the `-r, --reference` flag.
+
+```bash
+./run_nightly_tests.py
+```
+
+**Output:**
+
+```
+Host CPU         : Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
+Host Memory      : 15.49 GB
+
+Start Time (UTC) : 2020-08-25 21:30:01
+End Time (UTC)   : 2020-08-25 22:02:37
+Execution Time   : 0:32:35.896990
+
+Status           : SUCCESS
+
+Note:
+Changes denoted by '-----' are less than 0.01%.
+
+--------------------------------------------------------
+            SUMMARY REPORT - COMMIT d1a2b51f
+--------------------------------------------------------
+                    AVERAGE RESULTS
+--------------------------------------------------------
+Target              Instructions      Latest      v5.1.0
+----------  --------------------  ----------  ----------
+aarch64            2 158 355 274       -----     +1.693%
+alpha              1 914 967 171       -----     +3.524%
+arm                8 076 402 940       -----     +2.304%
+hppa               4 261 685 987     -0.182%     +3.164%
+m68k               2 690 273 044       -----     +7.131%
+mips               1 862 033 667       -----     +2.494%
+mipsel             2 008 211 069       -----     +2.674%
+mips64             1 918 635 565       -----     +2.818%
+mips64el           2 051 565 677       -----     +3.026%
+ppc                2 480 141 217       -----     +3.107%
+ppc64              2 576 713 959       -----     +3.143%
+ppc64le            2 558 853 539       -----     +3.173%
+riscv64            1 406 704 050       -----      +2.65%
+s390x              3 158 140 046       -----     +3.118%
+sh4                2 364 449 748       -----      +3.33%
+sparc64            3 318 544 783       -----     +3.851%
+x86_64             1 775 844 158       -----     +2.156%
+--------------------------------------------------------
+
+                   DETAILED RESULTS
+--------------------------------------------------------
+Test Program: dijkstra_double
+--------------------------------------------------------
+Target              Instructions      Latest      v5.1.0
+----------  --------------------  ----------  ----------
+aarch64            3 062 583 464       -----     +1.424%
+alpha              3 191 864 698       -----     +3.696%
+arm               16 357 157 526       -----     +2.347%
+hppa               7 228 376 315     -0.139%     +3.086%
+m68k               4 294 016 587       -----     +9.692%
+mips               3 051 419 166       -----     +2.427%
+mipsel             3 231 509 618       -----     +2.869%
+mips64             3 245 837 754       -----     +2.596%
+mips64el           3 414 195 796       -----     +3.021%
+ppc                4 914 520 972     -0.041%      +4.74%
+ppc64              5 098 154 311       -----     +4.565%
+ppc64le            5 082 419 054       -----      +4.58%
+riscv64            2 192 294 915       -----     +1.955%
+s390x              4 584 503 977       -----     +2.896%
+sh4                3 949 036 447       -----     +3.464%
+sparc64            4 586 203 546       -----     +4.237%
+x86_64             2 484 092 105       -----      +1.75%
+--------------------------------------------------------
+--------------------------------------------------------
+Test Program: dijkstra_int32
+--------------------------------------------------------
+Target              Instructions      Latest      v5.1.0
+----------  --------------------  ----------  ----------
+aarch64            2 210 194 577       -----     +1.493%
+alpha              1 494 133 274       -----      +2.15%
+arm                8 262 935 967       -----     +2.665%
+hppa               5 207 318 306       -----     +3.047%
+m68k               1 725 856 962       -----     +2.527%
+mips               1 495 227 032       -----     +1.492%
+mipsel             1 497 147 869       -----     +1.479%
+mips64             1 715 388 570       -----     +1.892%
+mips64el           1 695 276 864       -----     +1.913%
+ppc                2 014 557 389       -----     +1.819%
+ppc64              2 206 267 901       -----     +2.139%
+ppc64le            2 197 998 781       -----     +2.146%
+riscv64            1 354 912 745       -----     +2.396%
+s390x              2 916 247 062       -----     +1.241%
+sh4                1 990 532 533       -----     +2.669%
+sparc64            2 872 231 051       -----     +3.758%
+x86_64             1 553 981 241       -----      +2.12%
+--------------------------------------------------------
+--------------------------------------------------------
+Test Program: matmult_double
+--------------------------------------------------------
+Target              Instructions      Latest      v5.1.0
+----------  --------------------  ----------  ----------
+aarch64            1 412 273 223       -----     +0.302%
+alpha              3 233 991 649       -----     +7.473%
+arm                8 545 173 979       -----     +1.088%
+hppa               3 483 597 802     -1.267%     +4.468%
+m68k               3 919 065 529       -----    +18.431%
+mips               2 344 774 894       -----     +4.091%
+mipsel             3 329 886 464       -----     +5.177%
+mips64             2 359 046 988       -----     +4.076%
+mips64el           3 343 664 785       -----     +5.167%
+ppc                3 209 457 051       -----     +3.246%
+ppc64              3 287 503 981       -----     +3.173%
+ppc64le            3 287 189 065       -----     +3.173%
+riscv64            1 221 603 682       -----     +0.277%
+s390x              2 874 199 923       -----     +5.827%
+sh4                3 543 943 634       -----     +6.416%
+sparc64            3 426 150 004       -----     +7.139%
+x86_64             1 248 917 276       -----     +0.322%
+--------------------------------------------------------
+--------------------------------------------------------
+Test Program: matmult_int32
+--------------------------------------------------------
+Target              Instructions      Latest      v5.1.0
+----------  --------------------  ----------  ----------
+aarch64              598 681 621       -----     +0.585%
+alpha                372 437 418       -----     +0.677%
+arm                  746 583 193       -----     +1.462%
+hppa                 674 278 359       -----     +1.183%
+m68k                 410 495 553       -----       +0.9%
+mips                 499 698 837       -----     +0.531%
+mipsel               499 500 429       -----     +0.497%
+mips64               481 554 664       -----     +0.599%
+mips64el             465 057 054       -----     +0.619%
+ppc                  341 334 603       -----     +0.944%
+ppc64                393 796 203       -----     +0.966%
+ppc64le              393 977 298       -----     +0.965%
+riscv64              351 709 769       -----     +0.785%
+s390x                494 427 384       -----     +0.599%
+sh4                  402 668 444       -----     +0.899%
+sparc64              495 952 959       -----     +1.192%
+x86_64               402 928 461       -----     +0.833%
+--------------------------------------------------------
+--------------------------------------------------------
+Test Program: qsort_double
+--------------------------------------------------------
+Target              Instructions      Latest      v5.1.0
+----------  --------------------  ----------  ----------
+aarch64            2 709 683 624       -----     +2.417%
+alpha              1 969 460 172       -----      +3.68%
+arm                8 322 998 390       -----     +2.587%
+hppa               3 188 301 995     -0.047%       +2.9%
+m68k               4 953 930 065       -----    +15.153%
+mips               2 123 919 587       -----     +3.055%
+mipsel             2 124 212 187       -----     +3.048%
+mips64             1 999 047 826       -----     +3.405%
+mips64el           1 996 426 772       -----     +3.409%
+ppc                2 819 267 902     -0.021%     +5.435%
+ppc64              2 768 186 548       -----     +5.513%
+ppc64le            2 724 803 772     -0.011%     +5.603%
+riscv64            1 638 328 937       -----     +4.021%
+s390x              2 519 081 708       -----     +3.362%
+sh4                2 595 545 154       -----     +2.994%
+sparc64            3 988 986 587       -----     +2.747%
+x86_64             2 033 468 588       -----     +3.234%
+--------------------------------------------------------
+--------------------------------------------------------
+Test Program: qsort_int32
+--------------------------------------------------------
+Target              Instructions      Latest      v5.1.0
+----------  --------------------  ----------  ----------
+aarch64            2 193 392 565       -----     +2.916%
+alpha              1 521 291 933       -----     +4.193%
+arm                3 465 445 043       -----     +2.756%
+hppa               2 280 034 340       -----     +3.821%
+m68k               1 843 189 041       -----     +3.583%
+mips               1 558 024 873       -----     +3.863%
+mipsel             1 560 583 980       -----     +3.846%
+mips64             1 563 415 749       -----     +4.412%
+mips64el           1 542 677 320       -----     +4.474%
+ppc                1 728 698 880       -----     +3.665%
+ppc64              1 842 444 545       -----     +3.555%
+ppc64le            1 791 822 067       -----     +3.661%
+riscv64            1 348 866 430       -----     +4.654%
+s390x              2 184 073 151       -----     +3.319%
+sh4                1 946 492 539       -----     +3.624%
+sparc64            3 452 215 585       -----     +2.937%
+x86_64             1 813 544 414       -----     +3.537%
+--------------------------------------------------------
+--------------------------------------------------------
+Test Program: qsort_string
+--------------------------------------------------------
+Target              Instructions      Latest      v5.1.0
+----------  --------------------  ----------  ----------
+aarch64            2 592 218 418       -----     +2.468%
+alpha              1 855 834 626       -----     +3.487%
+arm                7 347 721 165       -----     +2.682%
+hppa               4 758 753 926       -----     +3.543%
+m68k               2 376 811 462       -----     +3.567%
+mips               2 166 608 045       -----     +2.532%
+mipsel             2 163 392 541       -----     +2.528%
+mips64             2 029 251 969       -----     +3.117%
+mips64el           2 011 628 621       -----     +3.145%
+ppc                2 492 942 463       -----     +2.673%
+ppc64              2 464 702 554       -----     +2.488%
+ppc64le            2 445 253 307       -----     +2.505%
+riscv64            1 625 053 328       -----     +3.953%
+s390x              4 194 608 798       -----     +6.623%
+sh4                2 164 142 539       -----     +3.166%
+sparc64            4 299 516 539       -----     +4.065%
+x86_64             2 940 456 780       -----     +2.649%
+--------------------------------------------------------
+--------------------------------------------------------
+Test Program: search_string
+--------------------------------------------------------
+Target              Instructions      Latest      v5.1.0
+----------  --------------------  ----------  ----------
+aarch64            2 487 814 704       -----      +1.94%
+alpha              1 680 723 605       -----     +2.835%
+arm               11 563 208 260       -----     +2.848%
+hppa               7 272 826 858       -----     +3.263%
+m68k               1 998 819 159       -----     +3.198%
+mips               1 656 596 909       -----     +1.959%
+mipsel             1 659 455 464       -----     +1.947%
+mips64             1 955 541 001       -----     +2.447%
+mips64el           1 943 598 207       -----     +2.462%
+ppc                2 320 350 477       -----     +2.332%
+ppc64              2 552 655 634       -----     +2.742%
+ppc64le            2 547 364 971       -----     +2.748%
+riscv64            1 520 862 601       -----     +3.159%
+s390x              5 497 978 370       -----     +1.078%
+sh4                2 323 236 696       -----      +3.41%
+sparc64            3 427 101 999       -----      +4.73%
+x86_64             1 729 364 402       -----     +2.806%
+--------------------------------------------------------
+```
diff --git a/tests/performance/nightly-tests/benchmarks/source/dijkstra_double/dijkstra_double.c b/tests/performance/nightly-tests/benchmarks/source/dijkstra_double/dijkstra_double.c
new file mode 100644
index 0000000000..9c0bb804ac
--- /dev/null
+++ b/tests/performance/nightly-tests/benchmarks/source/dijkstra_double/dijkstra_double.c
@@ -0,0 +1,194 @@
+/*
+ *  Source file of a benchmark program involving calculations of the
+ *  shortest distances between a source node and all other nodes in a
+ *  graph of n nodes in which all nxn distances are defined as "double".
+ *  The number n can be given via command line, and the default is 2000.
+ *  The algorithm used is Dijsktra's.
+ *
+ *  This file is a part of the project "TCG Continuous Benchmarking".
+ *
+ *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+ *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program. If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <float.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+/* Number of columns and rows in all matrixes*/
+#define DEFAULT_NODE_COUNT      2000
+#define MIN_NODE_COUNT          3
+#define MAX_NODE_COUNT          10000
+
+
+int32_t closest_index(int32_t count, double *distances, bool *flags)
+{
+    int32_t closest;
+    double minimum = DBL_MAX;
+
+    for (size_t i = 0; i < count; i++) {
+        if (flags[i] == false && distances[i] <= minimum) {
+            closest = i;
+            minimum = distances[i];
+        }
+    }
+
+    return closest;
+}
+
+/**
+ * Calculate the shortest distances from the source node using Dijkstra method.
+ * @param (out) distances  An array of shortest distances from the source node.
+ * @param (out) via  An array of nodes needed to be taken as the the last
+ *                   before destination, for each destination.
+ * @param (out) eccent  Eccentricity of the source node.
+ * @param (in) count  The number of nodes.
+ * @param (in) source  Source node.
+ * @param (in) matrix  Distance matrix.
+ */
+void find_shortest_distances(double *distances, int32_t *via, double *eccent,
+                             int32_t count, int32_t source, double **matrix)
+{
+    bool *flags;
+
+    flags = (bool *)malloc(count * sizeof(bool));
+
+    for (size_t i = 0; i < count; i++) {
+        distances[i] = DBL_MAX;
+        flags[i] = false;
+    }
+
+    distances[source] = 0.0;
+    via[source] = source;
+
+    for (size_t i = 0; i < count - 1; i++) {
+        int32_t closest = closest_index(count, distances, flags);
+        flags[closest] = true;
+        for (size_t j = 0; j < count; j++) {
+            if ((!flags[j]) &&
+                    (matrix[closest][j]) &&
+                    (distances[closest] != DBL_MAX) &&
+                    (distances[j] > distances[closest] + matrix[closest][j])) {
+                distances[j] = distances[closest] + matrix[closest][j];
+                via[j] = closest;
+            }
+        }
+    }
+
+    *eccent = 0;
+    for (size_t i = 0; i < count; i++) {
+        if (*eccent < distances[i]) {
+            *eccent = distances[i];
+        }
+    }
+
+    free(flags);
+}
+
+
+void main(int argc, char *argv[])
+{
+    double **distance_matrix;
+    double *shortest_distances;
+    int32_t *via_node;
+    int32_t node_count = DEFAULT_NODE_COUNT;
+    int32_t source_node = 0;
+    double node_eccentricity = 0.0;
+    double range_factor = 999.0 / (double)(RAND_MAX);
+    int32_t option;
+
+    /* Parse command line options */
+    while ((option = getopt(argc, argv, "n:")) != -1) {
+        if (option == 'n') {
+            int32_t user_node_count = atoi(optarg);
+
+            /* Check if the value is a string or zero */
+            if (user_node_count == 0) {
+                fprintf(stderr, "Error ... Invalid value for option '-n'.\n");
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is a negative number */
+            if (user_node_count < MIN_NODE_COUNT) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be a "
+                                "number less than %d.\n", MIN_NODE_COUNT);
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is too large */
+            if (user_node_count > MAX_NODE_COUNT) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be "
+                                "more than %d.\n", MAX_NODE_COUNT);
+                exit(EXIT_FAILURE);
+            }
+            node_count = user_node_count;
+        } else {
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    /* Allocate the memory space for all matrixes */
+    distance_matrix = (double **)malloc(node_count * sizeof(double *));
+    for (size_t i = 0; i < node_count; i++) {
+        distance_matrix[i] = (double *)malloc(node_count * sizeof(double));
+    }
+    shortest_distances = (double *)malloc(node_count * sizeof(double));
+    via_node = (int32_t *)malloc(node_count * sizeof(int32_t));
+
+    /* Initialize helper arrays and populate distance_matrix */
+    srand(1);
+    for (size_t i = 0; i < node_count; i++) {
+        shortest_distances[i] = 0.0;
+        via_node[i] = -1;
+        distance_matrix[i][i] = 0.0;
+    }
+    for (size_t i = 0; i < node_count; i++) {
+        for (size_t j = i + 1; j < node_count; j++) {
+            distance_matrix[i][j] = 1.0 + range_factor * (double)rand();
+            distance_matrix[j][i] = distance_matrix[i][j];
+        }
+    }
+
+    find_shortest_distances(shortest_distances, via_node, &node_eccentricity,
+                            node_count, source_node, distance_matrix);
+
+    /* Control printing */
+    printf("CONTROL RESULT:\n");
+    printf(" Distance matrix (top left part):\n");
+    for (size_t i = 0; i < 3; i++) {
+        for (size_t j = 0; j < 3; j++) {
+            printf("    %7.2f", distance_matrix[i][j]);
+        }
+        printf("\n");
+    }
+    printf(" Source: %d (eccentricity: %f)\n",
+           source_node, node_eccentricity);
+    printf(" Destination   Distance   Via Node\n");
+    for (size_t i = 0; i < 3; i++) {
+        printf("  %5d       %7.2f       %4d\n",
+               i, shortest_distances[i], via_node[i]);
+    }
+
+    /* Free all previously allocated space */
+    for (size_t i = 0; i < node_count; i++) {
+        free(distance_matrix[i]);
+    }
+    free(distance_matrix);
+    free(shortest_distances);
+    free(via_node);
+}
diff --git a/tests/performance/nightly-tests/benchmarks/source/dijkstra_int32/dijkstra_int32.c b/tests/performance/nightly-tests/benchmarks/source/dijkstra_int32/dijkstra_int32.c
new file mode 100644
index 0000000000..2663cde943
--- /dev/null
+++ b/tests/performance/nightly-tests/benchmarks/source/dijkstra_int32/dijkstra_int32.c
@@ -0,0 +1,192 @@
+/*
+ *  Source file of a benchmark program involving calculations of the
+ *  shortest distances between a source node and all other nodes in a
+ *  graph of n nodes in which all nxn distances are defined as "int32".
+ *  The number n can be given via command line, and the default is 2000.
+ *  The algorithm used is Dijsktra's.
+ *
+ *  This file is a part of the project "TCG Continuous Benchmarking".
+ *
+ *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+ *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program. If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+/* Number of columns and rows in all matrixes*/
+#define DEFAULT_NODE_COUNT      2000
+#define MIN_NODE_COUNT          3
+#define MAX_NODE_COUNT          10000
+
+
+int32_t closest_index(int32_t count, int32_t *distances, bool *flags)
+{
+    int32_t closest;
+    int32_t minimum = INT_MAX;
+
+    for (size_t i = 0; i < count; i++) {
+        if (flags[i] == false && distances[i] <= minimum) {
+            closest = i;
+            minimum = distances[i];
+        }
+    }
+
+    return closest;
+}
+
+/**
+ * Calculate the shortest distances from the source node using Dijkstra method.
+ * @param (out) distances  An array of shortest distances from the source node.
+ * @param (out) via  An array of nodes needed to be taken as the the last
+ *                   before destination, for each destination.
+ * @param (out) eccent  Eccentricity of the source node.
+ * @param (in) count  The number of nodes.
+ * @param (in) source  Source node.
+ * @param (in) matrix  Distance matrix.
+ */
+void find_shortest_distances(int32_t *distances, int32_t *via, int32_t *eccent,
+                             int32_t count, int32_t source, int32_t **matrix)
+{
+    bool *flags;
+
+    flags = (bool *)malloc(count * sizeof(bool));
+
+    for (size_t i = 0; i < count; i++) {
+        distances[i] = INT_MAX;
+        flags[i] = false;
+    }
+
+    distances[source] = 0;
+    via[source] = source;
+
+    for (size_t i = 0; i < count - 1; i++) {
+        int32_t closest = closest_index(count, distances, flags);
+        flags[closest] = true;
+        for (size_t j = 0; j < count; j++) {
+            if ((!flags[j]) &&
+                    (matrix[closest][j]) &&
+                    (distances[closest] != INT_MAX) &&
+                    (distances[j] > distances[closest] + matrix[closest][j])) {
+                distances[j] = distances[closest] + matrix[closest][j];
+                via[j] = closest;
+            }
+        }
+    }
+
+    *eccent = 0;
+    for (size_t i = 0; i < count; i++) {
+        if (*eccent < distances[i]) {
+            *eccent = distances[i];
+        }
+    }
+
+    free(flags);
+}
+
+
+void main(int argc, char *argv[])
+{
+    int32_t **distance_matrix;
+    int32_t *shortest_distances;
+    int32_t *via_node;
+    int32_t node_count = DEFAULT_NODE_COUNT;
+    int32_t source_node = 0;
+    int32_t node_eccentricity = 0;
+    int32_t option;
+
+    /* Parse command line options */
+    while ((option = getopt(argc, argv, "n:")) != -1) {
+        if (option == 'n') {
+            int32_t user_node_count = atoi(optarg);
+
+            /* Check if the value is a string or zero */
+            if (user_node_count == 0) {
+                fprintf(stderr, "Error ... Invalid value for option '-n'.\n");
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is a negative number */
+            if (user_node_count < MIN_NODE_COUNT) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be a "
+                                "number less than %d.\n", MIN_NODE_COUNT);
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is too large */
+            if (user_node_count > MAX_NODE_COUNT) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be "
+                                "more than %d.\n", MAX_NODE_COUNT);
+                exit(EXIT_FAILURE);
+            }
+            node_count = user_node_count;
+        } else {
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    /* Allocate the memory space for all matrixes */
+    distance_matrix = (int32_t **)malloc(node_count * sizeof(int32_t *));
+    for (size_t i = 0; i < node_count; i++) {
+        distance_matrix[i] = (int32_t *)malloc(node_count * sizeof(int32_t));
+    }
+    shortest_distances = (int32_t *)malloc(node_count * sizeof(int32_t));
+    via_node = (int32_t *)malloc(node_count * sizeof(int32_t));
+
+    /* Initialize helper arrays and populate distance_matrix */
+    srand(1);
+    for (size_t i = 0; i < node_count; i++) {
+        shortest_distances[i] = 0;
+        via_node[i] = -1;
+        distance_matrix[i][i] = 0;
+    }
+    for (size_t i = 0; i < node_count; i++) {
+        for (size_t j = i + 1; j < node_count; j++) {
+            distance_matrix[i][j] = 1 + (rand()) / (RAND_MAX / 999);
+            distance_matrix[j][i] = distance_matrix[i][j];
+        }
+    }
+
+    find_shortest_distances(shortest_distances, via_node, &node_eccentricity,
+                            node_count, source_node, distance_matrix);
+
+    /* Control printing */
+    printf("CONTROL RESULT:\n");
+    printf(" Distance matrix (top left part):\n");
+    for (size_t i = 0; i < 3; i++) {
+        for (size_t j = 0; j < 3; j++) {
+            printf("    %6d", distance_matrix[i][j]);
+        }
+        printf("\n");
+    }
+    printf(" Source: %d (eccentricity: %d)\n",
+           source_node, node_eccentricity);
+    printf(" Destination   Distance   Via Node\n");
+    for (size_t i = 0; i < 3; i++) {
+        printf("  %5d          %3d        %4d\n",
+               i, shortest_distances[i], via_node[i]);
+    }
+
+    /* Free all previously allocated space */
+    for (size_t i = 0; i < node_count; i++) {
+        free(distance_matrix[i]);
+    }
+    free(distance_matrix);
+    free(shortest_distances);
+    free(via_node);
+}
diff --git a/tests/performance/nightly-tests/benchmarks/source/matmult_double/matmult_double.c b/tests/performance/nightly-tests/benchmarks/source/matmult_double/matmult_double.c
new file mode 100644
index 0000000000..42bbb4717a
--- /dev/null
+++ b/tests/performance/nightly-tests/benchmarks/source/matmult_double/matmult_double.c
@@ -0,0 +1,123 @@
+/*
+ *  Source file of a benchmark program involving calculations of
+ *  a product of two matrixes nxn whose elements are "double". The
+ *  number n can be given via command line, and the default is 200.
+ *
+ *  This file is a part of the project "TCG Continuous Benchmarking".
+ *
+ *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+ *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program. If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+/* Number of columns and rows in all matrixes*/
+#define DEFAULT_MATRIX_SIZE     200
+#define MIN_MATRIX_SIZE         2
+#define MAX_MATRIX_SIZE         200000
+
+void main(int argc, char *argv[])
+{
+    double **matrix_a;
+    double **matrix_b;
+    double **matrix_res;
+    size_t i;
+    size_t j;
+    size_t k;
+    int32_t matrix_size = DEFAULT_MATRIX_SIZE;
+    int32_t option;
+    double range_factor = 100.0 / (double)(RAND_MAX);
+
+
+    /* Parse command line options */
+    while ((option = getopt(argc, argv, "n:")) != -1) {
+        if (option == 'n') {
+            int32_t user_matrix_size = atoi(optarg);
+
+            /* Check if the value is a string or zero */
+            if (user_matrix_size == 0) {
+                fprintf(stderr, "Error ... Invalid value for option '-n'.\n");
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is a negative number */
+            if (user_matrix_size < MIN_MATRIX_SIZE) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be a "
+                                "number less than %d.\n", MIN_MATRIX_SIZE);
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is too large */
+            if (user_matrix_size > MAX_MATRIX_SIZE) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be "
+                                "more than %d.\n", MAX_MATRIX_SIZE);
+                exit(EXIT_FAILURE);
+            }
+            matrix_size = user_matrix_size;
+        } else {
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    /* Allocate the memory space for all matrixes */
+    matrix_a = (double **)malloc(matrix_size * sizeof(double *));
+    for (i = 0; i < matrix_size; i++) {
+        matrix_a[i] = (double *)malloc(matrix_size * sizeof(double));
+    }
+    matrix_b = (double **)malloc(matrix_size * sizeof(double *));
+    for (i = 0; i < matrix_size; i++) {
+        matrix_b[i] = (double *)malloc(matrix_size * sizeof(double));
+    }
+    matrix_res = (double **)malloc(matrix_size * sizeof(double *));
+    for (i = 0; i < matrix_size; i++) {
+        matrix_res[i] = (double *)malloc(matrix_size * sizeof(double));
+    }
+
+    /* Populate matrix_a and matrix_b with random numbers */
+    srand(1);
+    for (i = 0; i < matrix_size; i++) {
+        for (j = 0; j < matrix_size; j++) {
+            matrix_a[i][j] = range_factor * (double)rand();
+            matrix_b[i][j] = range_factor * (double)rand();
+        }
+    }
+
+    /* Calculate the product of two matrixes */
+    for (i = 0; i < matrix_size; i++) {
+        for (j = 0; j < matrix_size; j++) {
+            matrix_res[i][j] = 0.0;
+            for (k = 0; k < matrix_size; k++) {
+                matrix_res[i][j] += matrix_a[i][k] * matrix_b[k][j];
+            }
+        }
+    }
+
+    /* Control printing */
+    printf("CONTROL RESULT:\n");
+    printf(" %f %f\n", matrix_res[0][0], matrix_res[0][1]);
+    printf(" %f %f\n", matrix_res[1][0], matrix_res[1][1]);
+
+    /* Free all previously allocated space */
+    for (i = 0; i < matrix_size; i++) {
+        free(matrix_a[i]);
+        free(matrix_b[i]);
+        free(matrix_res[i]);
+    }
+    free(matrix_a);
+    free(matrix_b);
+    free(matrix_res);
+}
diff --git a/tests/performance/nightly-tests/benchmarks/source/matmult_int32/matmult_int32.c b/tests/performance/nightly-tests/benchmarks/source/matmult_int32/matmult_int32.c
new file mode 100644
index 0000000000..29a6eb000d
--- /dev/null
+++ b/tests/performance/nightly-tests/benchmarks/source/matmult_int32/matmult_int32.c
@@ -0,0 +1,121 @@
+/*
+ *  Source file of a benchmark program involving calculations of
+ *  a product of two matrixes nxn whose elements are "int32_t". The
+ *  number n can be given via command line, and the default is 200.
+ *
+ *  This file is a part of the project "TCG Continuous Benchmarking".
+ *
+ *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+ *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program. If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+/* Number of columns and rows in all matrixes*/
+#define DEFAULT_MATRIX_SIZE     200
+#define MIN_MATRIX_SIZE         2
+#define MAX_MATRIX_SIZE         200000
+
+void main(int argc, char *argv[])
+{
+    int32_t **matrix_a;
+    int32_t **matrix_b;
+    int32_t **matrix_res;
+    size_t i;
+    size_t j;
+    size_t k;
+    int32_t matrix_size = DEFAULT_MATRIX_SIZE;
+    int32_t option;
+
+    /* Parse command line options */
+    while ((option = getopt(argc, argv, "n:")) != -1) {
+        if (option == 'n') {
+            int32_t user_matrix_size = atoi(optarg);
+
+            /* Check if the value is a string or zero */
+            if (user_matrix_size == 0) {
+                fprintf(stderr, "Error ... Invalid value for option '-n'.\n");
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is a negative number */
+            if (user_matrix_size < MIN_MATRIX_SIZE) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be a "
+                                "number less than %d.\n", MIN_MATRIX_SIZE);
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is too large */
+            if (user_matrix_size > MAX_MATRIX_SIZE) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be "
+                                "more than %d.\n", MAX_MATRIX_SIZE);
+                exit(EXIT_FAILURE);
+            }
+            matrix_size = user_matrix_size;
+        } else {
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    /* Allocate the memory space for all matrixes */
+    matrix_a = (int32_t **)malloc(matrix_size * sizeof(int32_t *));
+    for (i = 0; i < matrix_size; i++) {
+        matrix_a[i] = (int32_t *)malloc(matrix_size * sizeof(int32_t));
+    }
+    matrix_b = (int32_t **)malloc(matrix_size * sizeof(int32_t *));
+    for (i = 0; i < matrix_size; i++) {
+        matrix_b[i] = (int32_t *)malloc(matrix_size * sizeof(int32_t));
+    }
+    matrix_res = (int32_t **)malloc(matrix_size * sizeof(int32_t *));
+    for (i = 0; i < matrix_size; i++) {
+        matrix_res[i] = (int32_t *)malloc(matrix_size * sizeof(int32_t));
+    }
+
+    /* Populate matrix_a and matrix_b with random numbers */
+    srand(1);
+    for (i = 0; i < matrix_size; i++) {
+        for (j = 0; j < matrix_size; j++) {
+            matrix_a[i][j] = (rand()) / (RAND_MAX / 100);
+            matrix_b[i][j] = (rand()) / (RAND_MAX / 100);
+        }
+    }
+
+    /* Calculate the product of two matrixes */
+    for (i = 0; i < matrix_size; i++) {
+        for (j = 0; j < matrix_size; j++) {
+            matrix_res[i][j] = 0;
+            for (k = 0; k < matrix_size; k++) {
+                matrix_res[i][j] += matrix_a[i][k] * matrix_b[k][j];
+            }
+        }
+    }
+
+    /* Control printing */
+    printf("CONTROL RESULT:\n");
+    printf(" %d %d\n", matrix_res[0][0], matrix_res[0][1]);
+    printf(" %d %d\n", matrix_res[1][0], matrix_res[1][1]);
+
+    /* Free all previously allocated space */
+    for (i = 0; i < matrix_size; i++) {
+        free(matrix_a[i]);
+        free(matrix_b[i]);
+        free(matrix_res[i]);
+    }
+    free(matrix_a);
+    free(matrix_b);
+    free(matrix_res);
+}
diff --git a/tests/performance/nightly-tests/benchmarks/source/qsort_double/qsort_double.c b/tests/performance/nightly-tests/benchmarks/source/qsort_double/qsort_double.c
new file mode 100644
index 0000000000..efc1b2eee1
--- /dev/null
+++ b/tests/performance/nightly-tests/benchmarks/source/qsort_double/qsort_double.c
@@ -0,0 +1,104 @@
+/*
+ *  Source file of a benchmark program involving sorting of an array
+ *  of length n whose elements are "double". The default value for n
+ *  is 300000, and it can be set via command line as well.
+ *
+ *  This file is a part of the project "TCG Continuous Benchmarking".
+ *
+ *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+ *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program. If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+/* Number of elements in the array to be sorted */
+#define DEFAULT_ARRAY_LEN       300000
+#define MIN_ARRAY_LEN           3
+#define MAX_ARRAY_LEN           30000000
+
+/* Upper limit used for generation of random numbers */
+#define UPPER_LIMIT             1000.0
+
+/* Comparison function passed to qsort() */
+static int compare(const void *a, const void *b)
+{
+    if (*(const double *)a > *(const double *)b) {
+        return 1;
+    } else if (*(const double *)a < *(const double *)b) {
+        return -1;
+    }
+    return 0;
+}
+
+void main(int argc, char *argv[])
+{
+    double *array_to_be_sorted;
+    int32_t array_len = DEFAULT_ARRAY_LEN;
+    int32_t option;
+    double range_factor = UPPER_LIMIT / (double)(RAND_MAX);
+
+    /* Parse command line options */
+    while ((option = getopt(argc, argv, "n:")) != -1) {
+        if (option == 'n') {
+            int32_t user_array_len = atoi(optarg);
+
+            /* Check if the value is a string or zero */
+            if (user_array_len == 0) {
+                fprintf(stderr, "Error ... Invalid value for option '-n'.\n");
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is a negative number */
+            if (user_array_len < MIN_ARRAY_LEN) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be a "
+                                "number less than %d.\n", MIN_ARRAY_LEN);
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is too large */
+            if (user_array_len > MAX_ARRAY_LEN) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be "
+                                "more than %d.\n", MAX_ARRAY_LEN);
+                exit(EXIT_FAILURE);
+            }
+            array_len = user_array_len;
+        } else {
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    /* Allocate the memory space for the array */
+    array_to_be_sorted = (double *) malloc(array_len * sizeof(double));
+
+    /* Populate the_array with random numbers */
+    srand(1);
+    for (size_t i = 0; i < array_len; i++) {
+        array_to_be_sorted[i] = range_factor * (double)rand();
+    }
+
+    /* Sort the_array using qsort() */
+    qsort(array_to_be_sorted, array_len, sizeof(array_to_be_sorted[0]),
+          compare);
+
+    /* Control printing */
+    printf("CONTROL RESULT:\n");
+    printf("%14.10f %14.10f %14.10f\n",
+           array_to_be_sorted[0], array_to_be_sorted[1], array_to_be_sorted[2]);
+
+    /* Free all previously allocated space */
+    free(array_to_be_sorted);
+}
diff --git a/tests/performance/nightly-tests/benchmarks/source/qsort_int32/qsort_int32.c b/tests/performance/nightly-tests/benchmarks/source/qsort_int32/qsort_int32.c
new file mode 100644
index 0000000000..76ca9c3490
--- /dev/null
+++ b/tests/performance/nightly-tests/benchmarks/source/qsort_int32/qsort_int32.c
@@ -0,0 +1,103 @@
+/*
+ *  Source file of a benchmark program involving sorting of an array
+ *  of length n whose elements are "int32_t". The default value for n
+ *  is 300000, and it can be set via command line as well.
+ *
+ *  This file is a part of the project "TCG Continuous Benchmarking".
+ *
+ *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+ *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program. If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+/* Number of elements in the array to be sorted */
+#define DEFAULT_ARRAY_LEN       300000
+#define MIN_ARRAY_LEN           3
+#define MAX_ARRAY_LEN           30000000
+
+/* Upper limit used for generation of random numbers */
+#define UPPER_LIMIT             50000000
+
+/* Comparison function passed to qsort() */
+static int compare(const void *a, const void *b)
+{
+    if (*(const int32_t *)a > *(const int32_t *)b) {
+        return 1;
+    } else if (*(const int32_t *)a < *(const int32_t *)b) {
+        return -1;
+    }
+    return 0;
+}
+
+void main(int argc, char *argv[])
+{
+    int32_t *array_to_be_sorted;
+    int32_t array_len = DEFAULT_ARRAY_LEN;
+    int32_t option;
+
+    /* Parse command line options */
+    while ((option = getopt(argc, argv, "n:")) != -1) {
+        if (option == 'n') {
+            int32_t user_array_len = atoi(optarg);
+
+            /* Check if the value is a string or zero */
+            if (user_array_len == 0) {
+                fprintf(stderr, "Error ... Invalid value for option '-n'.\n");
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is a negative number */
+            if (user_array_len < MIN_ARRAY_LEN) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be a "
+                                "number less than %d.\n", MIN_ARRAY_LEN);
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is too large */
+            if (user_array_len > MAX_ARRAY_LEN) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be "
+                                "more than %d.\n", MAX_ARRAY_LEN);
+                exit(EXIT_FAILURE);
+            }
+            array_len = user_array_len;
+        } else {
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    /* Allocate the memory space for the array */
+    array_to_be_sorted = (int32_t *) malloc(array_len * sizeof(int32_t));
+
+    /* Populate the_array with random numbers */
+    srand(1);
+    for (size_t i = 0; i < array_len; i++) {
+        array_to_be_sorted[i] = (rand()) / (RAND_MAX / UPPER_LIMIT);
+    }
+
+    /* Sort the_array using qsort() */
+    qsort(array_to_be_sorted, array_len, sizeof(array_to_be_sorted[0]),
+          compare);
+
+    /* Control printing */
+    printf("CONTROL RESULT:\n");
+    printf("%d %d %d\n",
+           array_to_be_sorted[0], array_to_be_sorted[1], array_to_be_sorted[2]);
+
+    /* Free all previously allocated space */
+    free(array_to_be_sorted);
+}
diff --git a/tests/performance/nightly-tests/benchmarks/source/qsort_string/qsort_string.c b/tests/performance/nightly-tests/benchmarks/source/qsort_string/qsort_string.c
new file mode 100644
index 0000000000..7d582b2dd0
--- /dev/null
+++ b/tests/performance/nightly-tests/benchmarks/source/qsort_string/qsort_string.c
@@ -0,0 +1,122 @@
+/*
+ *  Source file of a benchmark program involving sorting of an array
+ *  of 10000 random strings of length 8 (including terminating zero).
+ *  That sorting is repeated a number of times (default is 20 times),
+ *  and each time a different array of random strings is generated.
+ *  The number of repetitions can be set via command line.
+ *
+ *  This file is a part of the project "TCG Continuous Benchmarking".
+ *
+ *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+ *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program. If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+
+/* Length of an individual random string (including terminating zero) */
+#define RANDOM_STRING_LEN             8
+/* Number of elements of the array of random strings */
+#define NUMBER_OF_RANDOM_STRINGS      10000
+
+/* Number of repetitions to be performed each with different input */
+#define DEFAULT_REPETITION_COUNT      20
+#define MIN_REPETITION_COUNT          1
+#define MAX_REPETITION_COUNT          1000
+
+/* Structure that keeps an array of random strings to be sorted */
+struct StringStruct {
+    char chars[RANDOM_STRING_LEN];
+};
+
+/* Comparison function passed to qsort() */
+int compare_strings(const void *element1, const void *element2)
+{
+    int result;
+
+    result = strcmp((*((struct StringStruct *)element1)).chars,
+                    (*((struct StringStruct *)element2)).chars);
+
+    return (result < 0) ? -1 : ((result == 0) ? 0 : 1);
+}
+
+/* Generate a random string of given length and containing only small letters */
+static void gen_random_string(char *s, const int len)
+{
+    static const char letters[] = "abcdefghijklmnopqrstuvwxyz";
+
+    for (size_t i = 0; i < (len - 1); i++) {
+        s[i] = letters[rand() % (sizeof(letters) - 1)];
+    }
+
+    s[len - 1] = 0;
+}
+
+void main(int argc, char *argv[])
+{
+    struct StringStruct strings_to_be_sorted[NUMBER_OF_RANDOM_STRINGS];
+    int32_t repetition_count = DEFAULT_REPETITION_COUNT;
+    int32_t option;
+
+    /* Parse command line options */
+    while ((option = getopt(argc, argv, "n:")) != -1) {
+        if (option == 'n') {
+            int32_t user_repetition_count = atoi(optarg);
+
+            /* Check if the value is a string or zero */
+            if (user_repetition_count == 0) {
+                fprintf(stderr, "Error ... Invalid value for option '-n'.\n");
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is a negative number */
+            if (user_repetition_count < MIN_REPETITION_COUNT) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be a "
+                                "number less than %d.\n", MIN_REPETITION_COUNT);
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is too large */
+            if (user_repetition_count > MAX_REPETITION_COUNT) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be "
+                                "more than %d.\n", MAX_REPETITION_COUNT);
+                exit(EXIT_FAILURE);
+            }
+            repetition_count = user_repetition_count;
+        } else {
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    srand(1);
+
+    for (size_t i = 0; i < repetition_count; ++i) {
+        /* Generate random strings, and, in turn, sort them */
+        for (size_t i = 0; i < NUMBER_OF_RANDOM_STRINGS; ++i) {
+            gen_random_string(strings_to_be_sorted[i].chars, RANDOM_STRING_LEN);
+        }
+        qsort(strings_to_be_sorted, NUMBER_OF_RANDOM_STRINGS,
+              sizeof(struct StringStruct), compare_strings);
+    }
+
+    /* Control printing */
+    printf("CONTROL RESULT:\n");
+    for (size_t i = 0; i < 2; ++i) {
+        printf(" %s", strings_to_be_sorted[i].chars);
+    }
+    printf("\n");
+}
diff --git a/tests/performance/nightly-tests/benchmarks/source/search_string/search_string.c b/tests/performance/nightly-tests/benchmarks/source/search_string/search_string.c
new file mode 100644
index 0000000000..2827ea032e
--- /dev/null
+++ b/tests/performance/nightly-tests/benchmarks/source/search_string/search_string.c
@@ -0,0 +1,110 @@
+/*
+ *  Source file of a benchmark program that searches for the occurrence
+ *  of a small string in a much larger random string ("needle in a hay").
+ *  That searching is repeated a number of times (default is 20 times),
+ *  and each time a different large random string ("hay") is generated.
+ *  The number of repetitions can be set via command line.
+ *
+ *  This file is a part of the project "TCG Continuous Benchmarking".
+ *
+ *  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+ *  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program. If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+
+/* Length of a long string to be searched (including terminating zero) */
+#define HAYSTACK_LEN                  30000
+
+/* Number of repetitions to be performed each with different input */
+#define DEFAULT_REPETITION_COUNT      100
+#define MIN_REPETITION_COUNT          1
+#define MAX_REPETITION_COUNT          10000
+
+
+/* Generate a random string of given length and containing only small letters */
+static void gen_random_string(char *s, const int len)
+{
+    static const char letters[] = "abcdefghijklmnopqrstuvwxyz";
+
+    for (size_t i = 0; i < (len - 1); i++) {
+        s[i] = letters[rand() % (sizeof(letters) - 1)];
+    }
+
+    s[len - 1] = 0;
+}
+
+void main(int argc, char *argv[])
+{
+    char haystack[HAYSTACK_LEN];
+    const char needle[] = "aaa ";
+    char *found_needle;
+    int32_t found_cnt = 0;
+    int32_t not_found_cnt = 0;
+    int32_t repetition_count = DEFAULT_REPETITION_COUNT;
+    int32_t option;
+
+    printf("needle is %s, size %d\n", needle, sizeof(needle));
+
+    /* Parse command line options */
+    while ((option = getopt(argc, argv, "n:")) != -1) {
+        if (option == 'n') {
+            int32_t user_repetition_count = atoi(optarg);
+
+            /* Check if the value is a string or zero */
+            if (user_repetition_count == 0) {
+                fprintf(stderr, "Error ... Invalid value for option '-n'.\n");
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is a negative number */
+            if (user_repetition_count < MIN_REPETITION_COUNT) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be a "
+                                "number less than %d.\n", MIN_REPETITION_COUNT);
+                exit(EXIT_FAILURE);
+            }
+            /* Check if the value is too large */
+            if (user_repetition_count > MAX_REPETITION_COUNT) {
+                fprintf(stderr, "Error ... Value for option '-n' cannot be "
+                                "more than %d.\n", MAX_REPETITION_COUNT);
+                exit(EXIT_FAILURE);
+            }
+            repetition_count = user_repetition_count;
+        } else {
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    srand(1);
+
+    for (size_t i = 0; i < repetition_count; ++i) {
+        /* Generate random hay, and, in turn, find a needle */
+        gen_random_string(haystack, HAYSTACK_LEN);
+        found_needle = strstr(haystack, needle);
+        if (found_needle != NULL) {
+            found_cnt++;
+        } else {
+            not_found_cnt++;
+        }
+    }
+
+    /* Control printing */
+    printf("CONTROL RESULT:\n");
+    printf(" Found %d times. Not found %d times.\n", found_cnt, not_found_cnt);
+}
diff --git a/tests/performance/nightly-tests/scripts/nightly_tests_core.py b/tests/performance/nightly-tests/scripts/nightly_tests_core.py
new file mode 100755
index 0000000000..da192c704a
--- /dev/null
+++ b/tests/performance/nightly-tests/scripts/nightly_tests_core.py
@@ -0,0 +1,920 @@
+#!/usr/bin/env python3
+
+"""
+Core script for performing nightly performance tests on QEMU.
+
+This file is a part of the project "TCG Continuous Benchmarking".
+
+Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+
+This program is free software: you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation, either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program. If not, see <https://www.gnu.org/licenses/>.
+"""
+
+import argparse
+import csv
+import datetime
+import glob
+import multiprocessing
+import os
+import pathlib
+import shutil
+import subprocess
+import sys
+import tempfile
+import time
+from typing import Dict, List, Optional, Union
+
+
+def get_benchmark_name(benchmark_path: str) -> str:
+    """
+    Return the benchmark name given its path.
+
+    Parameters:
+    benchmarks_path (str): Absolute path to benchmark
+
+    Return:
+    (str): Benchmark name
+    """
+    benchmark_source_file = os.path.split(benchmark_path)[1]
+    return os.path.splitext(benchmark_source_file)[0]
+
+
+def get_benchmark_parent_dir(benchmark_path: str) -> str:
+    """
+    Return the benchmark parent directory name given the benchmark path.
+
+    Parameters:
+    benchmarks_path (str): Absolute path to benchmark
+
+    Return:
+    (str): Benchmark parent directory name
+    """
+    benchmark_parent_dir_path = os.path.split(benchmark_path)[0]
+    benchmark_parent_dir = os.path.split(benchmark_parent_dir_path)[1]
+
+    return benchmark_parent_dir
+
+
+def get_executable_parent_dir_path(
+        benchmark_path: str, benchmarks_executables_dir_path: str) -> str:
+    """
+    Return the executables parent directory of a benchmark given its path.
+    This is the directory that includes all compiled executables for the
+    benchmark.
+
+    Parameters:
+    benchmarks_path (str): Absolute path to benchmark
+    benchmarks_executables_dir_path (str): Absolute path to the executables
+
+    Return:
+    (str): Executables parent directory path
+    """
+    benchmark_parent_dir_path = os.path.split(benchmark_path)[0]
+    benchmark_parent_dir = os.path.split(benchmark_parent_dir_path)[1]
+    executable_parent_dir_path = os.path.join(benchmarks_executables_dir_path,
+                                              benchmark_parent_dir)
+
+    return executable_parent_dir_path
+
+
+def get_commit_hash(commit_tag: str, qemu_path: str) -> str:
+    """
+    Find commit hash given the Git commit tag.
+
+    Parameters:
+    commit_tag (str): Commit tag
+    qemu_path (str): Absolute path to QEMU
+
+    Returns:
+    (str): 8 digit commit hash
+    """
+
+    commit_hash = subprocess.run(["git",
+                                  "rev-parse",
+                                  commit_tag],
+                                 cwd=qemu_path,
+                                 stdout=subprocess.PIPE,
+                                 check=False)
+    if commit_hash.returncode:
+        clean_exit(qemu_path,
+                   "Failed to find the commit hash of {}.".format(commit_tag))
+
+    return commit_hash.stdout.decode("utf-8")[:8]
+
+
+def git_checkout(commit: str, qemu_path: str) -> None:
+    """
+    Checkout a given Git commit.
+    Also pull the latest changes from origin/master if the commit is "master".
+
+    Parameters:
+    commit (str): Commit hash or tag
+    qemu_path (str): Absolute path to QEMU
+    """
+    print(datetime.datetime.utcnow().isoformat(),
+          "- Checking out {}".format(commit), file=sys.stderr, flush=True)
+
+    checkout_commit = subprocess.run(["git",
+                                      "checkout",
+                                      commit],
+                                     cwd=qemu_path,
+                                     stdout=subprocess.DEVNULL,
+                                     stderr=subprocess.PIPE,
+                                     check=False)
+    if checkout_commit.returncode:
+        clean_exit(qemu_path, checkout_commit.stderr.decode("utf-8"))
+
+    if commit == "master":
+        print(datetime.datetime.utcnow().isoformat(),
+              "- Pulling the latest changes from QEMU master",
+              file=sys.stderr, flush=True)
+        # Try pulling the latest changes.
+        # Limit the number of failed trials to 10.
+        failure_count, failure_limit = 0, 10
+        while True:
+            pull_latest = subprocess.run(["git",
+                                          "pull",
+                                          "origin",
+                                          "master"],
+                                         cwd=qemu_path,
+                                         stdout=subprocess.DEVNULL,
+                                         check=False)
+            if pull_latest.returncode:
+                failure_count += 1
+                if failure_count == failure_limit:
+                    print(datetime.datetime.utcnow().isoformat(),
+                          "- Trial {}/{}: Failed to pull QEMU".format(
+                              failure_count, failure_limit),
+                          file=sys.stderr, flush=True)
+                    clean_exit(qemu_path, "")
+                else:
+                    print(datetime.datetime.utcnow().isoformat(),
+                          "- Trial {}/{}: Failed to pull QEMU"
+                          " ... retrying again in a minute!".format(
+                              failure_count, failure_limit),
+                          file=sys.stderr, flush=True)
+                    time.sleep(60)
+            else:
+                break
+
+
+def git_clone(qemu_path: str) -> None:
+    """
+    Clone QEMU from Git.
+
+    Parameters:
+    qemu_path (str): Absolute path to clone the QEMU repo to
+    """
+    # Try cloning QEMU.
+    # Limit the number of failed trials to 10.
+    failure_count, failure_limit = 0, 10
+    while True:
+        clone_qemu = subprocess.run(["git",
+                                     "clone",
+                                     "https://git.qemu.org/git/qemu.git",
+                                     qemu_path],
+                                    check=False)
+        if clone_qemu.returncode:
+            failure_count += 1
+            if failure_count == failure_limit:
+                print(datetime.datetime.utcnow().isoformat(),
+                      "- Trial {}/{}: Failed to clone QEMU".format(
+                          failure_count, failure_limit),
+                      file=sys.stderr, flush=True)
+                clean_exit(qemu_path, "")
+            else:
+                print(datetime.datetime.utcnow().isoformat(),
+                      "- Trial {}/{}: Failed to clone QEMU"
+                      " ... retrying again in a minute!".format(
+                          failure_count, failure_limit),
+                      file=sys.stderr, flush=True)
+                time.sleep(60)
+        else:
+            break
+
+
+def build_qemu(qemu_path: str, git_tag: str, targets: List[str]) -> None:
+    """
+    Checkout the Git tag then configure and build QEMU.
+
+    Parameters:
+    qemu_path (str): Absolute path to QEMU
+    git_tag (str): Git tag to checkout before building
+    targets (List[str]): List of targets to configure QEMU for
+    """
+
+    # Clean the QEMU build path
+    qemu_build_path = os.path.join(qemu_path, "build-gcc")
+    if os.path.isdir(qemu_build_path):
+        shutil.rmtree(qemu_build_path)
+    os.mkdir(qemu_build_path)
+
+    git_checkout(git_tag, qemu_path)
+
+    # Specify target list for configuring QEMU
+    target_list = ["{}-linux-user".format(target) for target in targets]
+
+    # Configure QEMU
+    print(datetime.datetime.utcnow().isoformat(),
+          "- Running 'configure' for {}".format(git_tag),
+          file=sys.stderr, flush=True)
+    configure = subprocess.run(["../configure",
+                                "--disable-system",
+                                "--disable-tools",
+                                "--target-list={}".
+                                format(",".join(target_list))],
+                               cwd=qemu_build_path,
+                               stdout=subprocess.DEVNULL,
+                               stderr=subprocess.PIPE,
+                               check=False)
+    if configure.returncode:
+        clean_exit(qemu_path, configure.stderr.decode("utf-8"))
+
+    # Run "make -j$(nproc)"
+    print(datetime.datetime.utcnow().isoformat(),
+          "- Running 'make' for {}".format(git_tag), file=sys.stderr,
+          flush=True)
+    make = subprocess.run(["make",
+                           "-j",
+                           str(multiprocessing.cpu_count())],
+                          cwd=qemu_build_path,
+                          stdout=subprocess.DEVNULL,
+                          stderr=subprocess.PIPE,
+                          check=False)
+    if make.returncode:
+        clean_exit(qemu_path, make.stderr.decode("utf-8"))
+
+
+def compile_target(benchmark_path: str, compiled_benchmark_path: str,
+                   target_compiler: str) -> None:
+    """
+    Compile a benchmark using the provided cross compiler.
+
+    Parameters:
+    benchmarks_path (str): Absolute path to benchmark
+    compiled_benchmark_path (str): Path to the output executable
+    target_compiler (str): Cross compiler
+    """
+    compile_benchmark = subprocess.run([target_compiler,
+                                        "-O2",
+                                        "-static",
+                                        "-w",
+                                        benchmark_path,
+                                        "-o",
+                                        compiled_benchmark_path],
+                                       check=False)
+    if compile_benchmark.returncode:
+        sys.exit("Compilation of {} failed".format(
+            os.path.split(compiled_benchmark_path)[1]))
+
+
+def measure_instructions(
+        benchmark_path: str, benchmarks_executables_dir_path: str,
+        qemu_path: str, targets: List[str]) -> List[List[Union[str, int]]]:
+    """
+    Measure the number of instructions when running an program with QEMU.
+
+    Parameters:
+    benchmarks_path (str): Absolute path to benchmark
+    benchmarks_executables_dir_path (str): Absolute path to the executables
+    qemu_path (str): Absolute path to QEMU
+    targets (List[str]): List of QEMU targets
+
+    Returns:
+    (List[List[Union[str, int]]]): [[target_name, instructions],[...],...]
+    """
+
+    benchmark_name = get_benchmark_name(benchmark_path)
+    executable_parent_dir_path = get_executable_parent_dir_path(
+        benchmark_path, benchmarks_executables_dir_path)
+    qemu_build_path = os.path.join(qemu_path, "build-gcc")
+
+    instructions: List[List[Union[str, int]]] = []
+
+    for target in targets:
+        executable_path = os.path.join(
+            executable_parent_dir_path, "{}-{}".format(benchmark_name, target))
+
+        qemu_exe_path = os.path.join(qemu_build_path,
+                                     "{}-linux-user".format(target),
+                                     "qemu-{}".format(target))
+
+        with tempfile.NamedTemporaryFile() as tmpfile:
+            run_callgrind = subprocess.run(["valgrind",
+                                            "--tool=callgrind",
+                                            "--callgrind-out-file={}".format(
+                                                tmpfile.name),
+                                            qemu_exe_path,
+                                            executable_path],
+                                           stdout=subprocess.DEVNULL,
+                                           stderr=subprocess.PIPE,
+                                           check=False)
+        if run_callgrind.returncode == 1:
+            clean_exit(qemu_path, run_callgrind.stderr.decode("utf-8"))
+
+        callgrind_output = run_callgrind.stderr.decode("utf-8").split("\n")
+        instructions.append([target, int(callgrind_output[8].split(" ")[-1])])
+
+    return instructions
+
+
+def measure_master_instructions(
+        reference_version_path: str, reference_commit_hash: str,
+        latest_version_path: str, benchmark_path: str,
+        benchmarks_executables_dir_path: str, qemu_path: str,
+        targets: List[str]) -> List[List[Union[str, int]]]:
+    """
+    Measure the latest QEMU "master" instructions and also append the latest
+    instructions and reference version instructions to the instructions list.
+
+    Parameters:
+    reference_version_path (str): Absolute path to reference version results
+    reference_commit_hash (str): Git hash of the reference version
+    latest_version_path (str): Absolute path to the latest version results
+    benchmark_path (str): Absolute path to benchmark
+    benchmarks_executables_dir_path (str):
+                            Absolute path to the executables of the benchmark
+    qemu_path (str): Absolute path to QEMU
+    targets (List[str]): List of QEMU targets
+
+
+    Return:
+    (List[List[Union[str, int]]]):
+            [[target_name, instructions, comparison_instructions],[...],...]
+            comparsion_instructions: *[latest, reference]
+            If latest is not available,
+            then comparsion_instructions = reference
+    """
+    benchmark_name = get_benchmark_name(benchmark_path)
+
+    print(datetime.datetime.utcnow().isoformat(),
+          "- Measuring instructions for master - {}".format(benchmark_name),
+          file=sys.stderr, flush=True)
+
+    instructions = measure_instructions(
+        benchmark_path, benchmarks_executables_dir_path, qemu_path, targets)
+
+    reference_result = "{}-{}-results.csv".format(
+        reference_commit_hash, benchmark_name)
+    reference_result_path = os.path.join(
+        reference_version_path, reference_result)
+
+    # Find if this benchmark has a record in the latest results
+    latest_result = ""
+    latest_results = os.listdir(latest_version_path)
+    for result in latest_results:
+        if result.split("-")[1] == benchmark_name:
+            latest_result = result
+            break
+
+    # Append instructions from latest version if available
+    if latest_result != "":
+        latest_result_path = os.path.join(latest_version_path, latest_result)
+        with open(latest_result_path, "r") as file:
+            file.readline()
+            for target_instructions in instructions:
+                target_instructions.append(
+                    int(file.readline().split('"')[1].replace(",", "")))
+        # Delete the latest results. The directory will contain the new latest
+        # when the new "master" results are stored later.
+        os.unlink(latest_result_path)
+
+    # Append instructions from reference version
+    with open(reference_result_path, "r") as file:
+        file.readline()
+        for target_instructions in instructions:
+            target_instructions.append(
+                int(file.readline().split('"')[1].replace(",", "")))
+
+    return instructions
+
+
+def calculate_percentage(old_instructions: int, new_instructions: int) -> str:
+    """
+    Calculate the change in percentage between two instruction counts
+
+    Parameters:
+    old_instructions (int): Old number
+    new_instructions (int): New number
+
+    Return:
+    (str): [+|-][change][%] or "-----" in case of 0.01% change
+    """
+    percentage = round(((new_instructions - old_instructions) /
+                        old_instructions) * 100, 3)
+    return format_percentage(percentage)
+
+
+def format_percentage(percentage: float) -> str:
+    """
+    Format the percentage value to add +|- and %.
+
+    Parameters:
+    percentage (float): Percentage
+
+    Returns:
+    (str): Formatted percentage string
+    """
+    if abs(percentage) <= 0.01:
+        return "-----"
+    return "+" + str(percentage) + "%" if percentage > 0 \
+        else str(percentage) + "%"
+
+
+def calculate_change(instructions: List[List[Union[str, int]]]) -> None:
+    """
+    Calculate the change in the recorded instructions for master compared to
+    latest results and reference version results.
+
+    Parameters:
+    instructions (List[List[Union[str, int]]]):
+            [[target_name, instructions, comparison_instructions],[...],...]
+            comparsion_instructions: *[latest, reference]
+            If latest is not available,
+            then comparsion_instructions = reference
+    """
+    for target_instructions in instructions:
+        target_instructions[-1] = calculate_percentage(
+            int(target_instructions[-1]), int(target_instructions[1]))
+        # If latest instructions exists
+        if len(target_instructions) == 4:
+            target_instructions[-2] = calculate_percentage(
+                int(target_instructions[-2]), int(target_instructions[1]))
+
+
+def calculate_average(results: List[List[List[Union[str, int]]]],
+                      targets: List[str],
+                      num_benchmarks: int) -> List[List[Union[str, int]]]:
+    """
+    Calculate the average results for each target for all benchmarks.
+
+    Parameters:
+    results (List[List[List[Union[str, int]]]]):
+            [[target_name, instructions, comparison_instructions],[...],...]
+            comparsion_instructions: *[latest, reference]
+            If latest is not available,
+            then comparsion_instructions = reference
+    targets (List[str]): List of target names
+    num_benchmarks (int): Number of benchmarks
+
+    Return:
+    (List[List[Union[str, int]]]):
+            [[target_name, average_instructions, \
+                comparison_instructions],[...],...]
+            comparsion_instructions: *[average_latest, average_reference]
+            If latest is not available,
+            then comparsion_instructions = reference
+    """
+    average_instructions: List[List[Union[str, int]]] = []
+
+    for i, target in enumerate(targets):
+        average_instructions.append([target])
+
+        total_instructions = 0
+        total_latest_percentages: Optional[float] = 0.0
+        total_reference_percentages = 0.0
+
+        for instructions in results:
+            total_instructions += int(instructions[i][1])
+            if instructions[i][3] != "-----":
+                total_reference_percentages += float(
+                    str(instructions[i][3])[:-1])
+            if total_latest_percentages is not None:
+                if instructions[i][2] != "N/A":
+                    if instructions[i][2] != "-----":
+                        total_latest_percentages += float(
+                            str(instructions[i][2])[:-1])
+                else:
+                    total_latest_percentages = None
+
+        avg_instructions = total_instructions // num_benchmarks
+        avg_reference_percentages = format_percentage(
+            round(total_reference_percentages / num_benchmarks, 3))
+        avg_latest_percentages = format_percentage(
+            round(total_latest_percentages / num_benchmarks, 3)) \
+            if total_latest_percentages is not None else "N/A"
+
+        average_instructions[-1].extend([avg_instructions,
+                                         avg_latest_percentages,
+                                         avg_reference_percentages])
+
+    return average_instructions
+
+
+def write_to_csv(instructions: List[List[Union[str, int]]],
+                 output_csv_path: str, percentages: bool = False,
+                 reference_version: str = "") -> None:
+    """
+    Write the [Target, Instructions] for each target in a CSV file.
+    comparison_instructions are ignored.
+
+    Parameters:
+    instructions (List[List[Union[str, int]]]):
+            [[target_name, instructions, comparison_instructions],[...],...]
+            comparsion_instructions: *[latest, reference]
+            If latest is not available,
+            then comparsion_instructions = reference
+    output_csv_path (str): Absolute path to output CSV file
+    percentages (bool): Add percentages to the output CSV file
+    """
+    with open(output_csv_path, "w") as file:
+        writer = csv.writer(file)
+        header = ["Target", "Instructions"]
+        if percentages:
+            header.extend(["Latest", reference_version])
+        writer.writerow(header)
+        for target_instructions in instructions:
+            row = []
+            row.extend([target_instructions[0], format(
+                target_instructions[1], ",")])
+            if percentages:
+                row.extend(target_instructions[2:])
+            writer.writerow(row)
+
+
+def print_table(instructions: str, text: str, reference_version: str) -> None:
+    """
+    Print the results in a tabular form
+
+    Parameters:
+    instructions (List[List[Union[str, int]]]):
+            [[target_name, instructions, comparison_instructions],[...],...]
+            comparsion_instructions: *[latest, reference]
+            If latest is not available,
+            then comparsion_instructions = reference
+    text (str): Text be added to the table header
+    reference_version (str): Reference version used in these results
+    """
+    print("{}\n{}\n{}".
+          format("-" * 56, text, "-" * 56))
+
+    print('{:<10}  {:>20}  {:>10}  {:>10}\n{}  {}  {}  {}'.
+          format('Target',
+                 'Instructions',
+                 'Latest',
+                 reference_version,
+                 '-' * 10,
+                 '-' * 20,
+                 '-' * 10,
+                 '-' * 10))
+
+    for target_change in instructions:
+        # Replace commas with spaces in instruction count
+        # for easier readability.
+        formatted_instructions = format(
+            target_change[1], ",").replace(",", " ")
+        print('{:<10}  {:>20}  {:>10}  {:>10}'.format(
+            target_change[0], formatted_instructions, *target_change[2:]))
+
+    print("-" * 56)
+
+
+def clean_exit(qemu_path: str, error_message: str) -> None:
+    """
+    Clean up intermediate files and exit.
+
+    Parameters:
+    qemu_path (str): Absolute path to QEMU
+    error_message (str): Error message to display after exiting
+    """
+    # Clean the QEMU build path
+    qemu_build_path = os.path.join(qemu_path, "build-gcc")
+    if os.path.isdir(qemu_build_path):
+        shutil.rmtree(qemu_build_path)
+    sys.exit(error_message)
+
+
+def verify_executables(benchmark_paths: List[str], targets: Dict[str, str],
+                       benchmarks: List[Dict[str, str]],
+                       benchmarks_executables_dir_path: str) -> None:
+    """
+    Verify that all executables exist for each benchmark.
+
+    Parameters:
+    benchmark_paths (List[str]): List of all paths to benchmarks
+    targets (Dict[str, str]): Dictionary the contains for each target,
+                              target_name: target_compiler
+    benchmarks (List[Dict[str, str]]): Benchmarks data (name, parent_dir, path)
+    benchmarks_executables_dir_path (str): Absolute path to the executables dir
+    """
+    print(datetime.datetime.utcnow().isoformat(),
+          "- Verifying executables of {} benchmarks for {} targets".
+          format(len(benchmark_paths), len(targets)),
+          file=sys.stderr, flush=True)
+
+    for benchmark in benchmarks:
+        executable_parent_dir_path = get_executable_parent_dir_path(
+            benchmark["path"], benchmarks_executables_dir_path)
+
+        # Verify that the exists for this benchmark executables, if not,
+        # create it
+        if not os.path.isdir(executable_parent_dir_path):
+            os.mkdir(executable_parent_dir_path)
+
+        for target_name, target_compiler in targets.items():
+            compiled_benchmark = "{}-{}".format(
+                benchmark["name"], target_name)
+            compiled_benchmark_path = os.path.join(
+                executable_parent_dir_path, compiled_benchmark)
+            # Verify that the the executable for this target is available,
+            # if not, compile it
+            if not os.path.isfile(compiled_benchmark_path):
+                compile_target(benchmark["path"],
+                               compiled_benchmark_path,
+                               target_compiler)
+
+
+def verify_reference_results(reference_version: str, qemu_path: str,
+                             benchmarks: List[Dict[str, str]],
+                             reference_version_results_dir_path: str,
+                             targets: List[str],
+                             benchmarks_executables_dir_path: str) -> None:
+    """
+    Verify that results are available for reference version.
+    If results are missing, build QEMU for the reference version then perform
+    the measurements.
+
+    Paramters:
+    reference_version (str): Reference QEMU version
+    qemu_path (str): Absolute path to QEMU
+    benchmark_paths (List[str]): List of all paths to benchmarks
+    reference_version_results_dir_path (str): Absolute path to the reference
+                                              version results dir
+    targets (List[str]): Target names
+    benchmarks (List[Dict[str, str]]): Benchmarks data (name, parent_dir, path)
+    benchmarks_executables_dir_path (str): Path to the root executables dir
+    """
+    print(datetime.datetime.utcnow().isoformat(),
+          "- Verifying results of reference version {}".
+          format(reference_version), file=sys.stderr, flush=True)
+
+    # Set flag to know if QEMU was built for reference version before
+    did_build_reference = False
+
+    latest_commit_hash = get_commit_hash(reference_version, qemu_path)
+
+    for benchmark in benchmarks:
+        benchmark_results_dir_path = os.path.join(
+            reference_version_results_dir_path, benchmark["parent_dir"])
+
+        # Verify that the results directory for the benchmark exists, if not,
+        # create it
+        if not os.path.isdir(benchmark_results_dir_path):
+            os.mkdir(benchmark_results_dir_path)
+
+        # Verify that the the results.csv file for the benchmark exits, if not,
+        # create it
+        results_path = os.path.join(benchmark_results_dir_path,
+                                    "{}-{}-results.csv".
+                                    format(latest_commit_hash,
+                                           benchmark["name"]))
+        if not os.path.isfile(results_path):
+            # Only build qemu if reference version wasn't built before
+            if not did_build_reference:
+                build_qemu(qemu_path, reference_version, targets)
+                did_build_reference = True
+            print(datetime.datetime.utcnow().isoformat(),
+                  "- Measuring instructions for reference version {} - {}".
+                  format(reference_version, benchmark["name"]),
+                  file=sys.stderr, flush=True)
+            instructions = measure_instructions(
+                benchmark["path"],
+                benchmarks_executables_dir_path,
+                qemu_path,
+                targets)
+            write_to_csv(instructions, results_path)
+
+
+def verify_requirements() -> None:
+    """
+    Verify that all script requirements are installed (valgrind & git).
+    """
+    # Insure that valgrind is installed
+    check_valgrind_installation = subprocess.run(["which", "valgrind"],
+                                                 stdout=subprocess.DEVNULL,
+                                                 check=False)
+    if check_valgrind_installation.returncode:
+        sys.exit("Please install valgrind before running the script.")
+
+    # Insure that git is installed
+    check_git_installation = subprocess.run(["which", "git"],
+                                            stdout=subprocess.DEVNULL,
+                                            check=False)
+    if check_git_installation.returncode:
+        sys.exit("Please install git before running the script.")
+
+
+def main():
+    """
+    Parse the command line arguments then start the execution.
+    Output on STDOUT represents the nightly test results.
+    Output on STDERR represents the execution log and errors if any.
+    Output on STDERR must be redirected to either /dev/null or to a log file.
+
+    Syntax:
+        nightly_tests_core.py [-h] [-r REF]
+    Optional arguments:
+        -h, --help            Show this help message and exit
+        -r REF, --reference REF
+                            Reference QEMU version - Default is v5.1.0
+    Example of usage:
+        nightly_tests_core.py -r v5.1.0 2>log.txt
+    """
+    parser = argparse.ArgumentParser()
+    parser.add_argument("-r", "--reference", dest="ref",
+                        default="v5.1.0",
+                        help="Reference QEMU version - Default is v5.1.0")
+    reference_version = parser.parse_args().ref
+
+    targets = {
+        "aarch64":  "aarch64-linux-gnu-gcc",
+        "alpha":    "alpha-linux-gnu-gcc",
+        "arm":      "arm-linux-gnueabi-gcc",
+        "hppa":     "hppa-linux-gnu-gcc",
+        "m68k":     "m68k-linux-gnu-gcc",
+        "mips":     "mips-linux-gnu-gcc",
+        "mipsel":   "mipsel-linux-gnu-gcc",
+        "mips64":   "mips64-linux-gnuabi64-gcc",
+        "mips64el": "mips64el-linux-gnuabi64-gcc",
+        "ppc":      "powerpc-linux-gnu-gcc",
+        "ppc64":    "powerpc64-linux-gnu-gcc",
+        "ppc64le":  "powerpc64le-linux-gnu-gcc",
+        "riscv64":  "riscv64-linux-gnu-gcc",
+        "s390x":    "s390x-linux-gnu-gcc",
+        "sh4":      "sh4-linux-gnu-gcc",
+        "sparc64":  "sparc64-linux-gnu-gcc",
+        "x86_64":   "gcc"
+    }
+
+    # Verify that the script requirements are installed
+    verify_requirements()
+
+    # Get required paths
+    nightly_tests_dir_path = pathlib.Path(__file__).parent.parent.absolute()
+    benchmarks_dir_path = os.path.join(nightly_tests_dir_path, "benchmarks")
+    benchmarks_source_dir_path = os.path.join(benchmarks_dir_path, "source")
+    benchmarks_executables_dir_path = os.path.join(
+        benchmarks_dir_path, "executables")
+
+    # Verify that If the executables directory exists, if not, create it
+    if not os.path.isdir(benchmarks_executables_dir_path):
+        os.mkdir(benchmarks_executables_dir_path)
+
+    # Get absolute path to all available benchmarks
+    benchmark_paths = sorted([y for x in os.walk(benchmarks_source_dir_path)
+                              for y in glob.glob(os.path.join(x[0], '*.c'))])
+
+    benchmarks = [{
+        "name": get_benchmark_name(benchmark_path),
+        "parent_dir": get_benchmark_parent_dir(benchmark_path),
+        "path": benchmark_path} for benchmark_path in benchmark_paths]
+
+    # Verify that all executables exist for each benchmark
+    verify_executables(benchmark_paths, targets, benchmarks,
+                       benchmarks_executables_dir_path)
+
+    # Set QEMU path and clone from Git if the path doesn't exist
+    qemu_path = os.path.join(nightly_tests_dir_path, "qemu-nightly")
+    if not os.path.isdir(qemu_path):
+        # Clone QEMU into the temporary directory
+        print(datetime.datetime.utcnow().isoformat(),
+              "- Fetching QEMU: ", end="", flush=True, file=sys.stderr)
+        git_clone(qemu_path)
+        print("\n", file=sys.stderr, flush=True)
+
+    # Verify that the results directory exists, if not, create it
+    results_dir_path = os.path.join(nightly_tests_dir_path, "results")
+    if not os.path.isdir(results_dir_path):
+        os.mkdir(results_dir_path)
+
+    # Verify that the reference version results directory exists, if not,
+    # create it
+    reference_version_results_dir_path = os.path.join(
+        results_dir_path, reference_version)
+    if not os.path.isdir(reference_version_results_dir_path):
+        os.mkdir(reference_version_results_dir_path)
+
+    # Verify that previous results are available for reference version
+    verify_reference_results(reference_version, qemu_path, benchmarks,
+                             reference_version_results_dir_path,
+                             targets.keys(), benchmarks_executables_dir_path)
+
+    # Compare results with the latest QEMU master
+    # -------------------------------------------------------------------------
+    # Verify that the "latest" results directory exists, if not,
+    # create it
+    latest_version_results_dir_path = os.path.join(results_dir_path, "latest")
+    if not os.path.isdir(latest_version_results_dir_path):
+        os.mkdir(latest_version_results_dir_path)
+
+    # Verify that the "history" results directory exists, if not, create it
+    history_results_dir_path = os.path.join(results_dir_path, "history")
+    if not os.path.isdir(history_results_dir_path):
+        os.mkdir(history_results_dir_path)
+
+    # Build QEMU for master
+    build_qemu(qemu_path, "master", targets.keys())
+
+    # Get the commit hash for the top commit at master
+    master_commit_hash = get_commit_hash("master", qemu_path)
+
+    # Print report summary header
+    print("{}\n{}".format("-" * 56, "{} SUMMARY REPORT - COMMIT {}".
+                          format(" "*11, master_commit_hash)))
+
+    # For each benchmark, compare the current master results with
+    # latest and reference version
+    results = []
+    for benchmark in benchmarks:
+        reference_version_benchmark_results_dir_path = os.path.join(
+            reference_version_results_dir_path, benchmark["parent_dir"])
+        latest_version_benchmark_results_dir_path = os.path.join(
+            latest_version_results_dir_path, benchmark["parent_dir"])
+        history_benchmark_results_dir_path = os.path.join(
+            history_results_dir_path, benchmark["parent_dir"])
+
+        # Verify that the the benchmark directory exists in the "latest"
+        # directory, if not, create it
+        if not os.path.isdir(latest_version_benchmark_results_dir_path):
+            os.mkdir(latest_version_benchmark_results_dir_path)
+
+        # Verify that the the benchmark directory exists in the "history"
+        # directory, if not, create it
+        if not os.path.isdir(history_benchmark_results_dir_path):
+            os.mkdir(history_benchmark_results_dir_path)
+
+        # Obtain the instructions array which will contain for each target,
+        # the target name, the number of "master" instructions,
+        # "latest" instructions if available,
+        # and "reference version" instructions
+        instructions = measure_master_instructions(
+            reference_version_benchmark_results_dir_path,
+            get_commit_hash(reference_version, qemu_path),
+            latest_version_benchmark_results_dir_path,
+            benchmark["path"],
+            benchmarks_executables_dir_path,
+            qemu_path,
+            targets.keys())
+
+        # Update the "latest" directory with the new results form master
+        updated_latest_version_benchmark_results = os.path.join(
+            latest_version_benchmark_results_dir_path,
+            "{}-{}-results.csv".format(master_commit_hash, benchmark["name"]))
+        write_to_csv(instructions, updated_latest_version_benchmark_results)
+
+        calculate_change(instructions)
+
+        # Insert "N/A" for targets that don't have "latest" instructions
+        for target_instructions in instructions:
+            if len(target_instructions) == 3:
+                target_instructions.insert(2, "N/A")
+
+        history_benchmark_results = os.path.join(
+            history_benchmark_results_dir_path,
+            "{}-{}-results.csv".format(master_commit_hash, benchmark["name"]))
+        write_to_csv(instructions, history_benchmark_results,
+                     True, reference_version)
+
+        # Store the results
+        results.append([benchmark["name"], instructions])
+
+    # Calculate the average instructions for each target
+    # Only send the instructions as results without the benchmark names
+    average_instructions = calculate_average(
+        [result[1] for result in results], targets.keys(), len(benchmarks))
+
+    # Save average results to results/history directory
+    average_results = os.path.join(
+        history_results_dir_path,
+        "{}-average-results.csv".format(master_commit_hash))
+    write_to_csv(average_instructions, average_results,
+                 True, reference_version)
+
+    # Print results
+    print_table(average_instructions, " "*20 +
+                "AVERAGE RESULTS", reference_version)
+    print("\n", " "*17, "DETAILED RESULTS")
+    for [benchmark_name, instructions] in results:
+        print_table(instructions,
+                    "Test Program: " + benchmark_name,
+                    reference_version)
+
+    # Cleanup (delete the build directory)
+    shutil.rmtree(os.path.join(qemu_path, "build-gcc"))
+    # -------------------------------------------------------------------------
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tests/performance/nightly-tests/scripts/run_nightly_tests.py b/tests/performance/nightly-tests/scripts/run_nightly_tests.py
new file mode 100755
index 0000000000..ea65be60dc
--- /dev/null
+++ b/tests/performance/nightly-tests/scripts/run_nightly_tests.py
@@ -0,0 +1,135 @@
+#!/usr/bin/env python3
+
+"""
+Entry point script for running nightly performance tests on QEMU.
+
+This file is a part of the project "TCG Continuous Benchmarking".
+
+Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+
+This program is free software: you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation, either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program. If not, see <https://www.gnu.org/licenses/>.
+"""
+
+
+import datetime
+import io
+import os
+import subprocess
+import time
+import sys
+from send_email import send_email
+
+
+# Record system hardware information
+with open('/proc/cpuinfo', 'r') as cpuinfo:
+    for line in cpuinfo:
+        if line.startswith('model name'):
+            HOST_CPU = line.rstrip('\n').split(':')[1].strip()
+            break
+with open('/proc/meminfo', 'r') as meminfo:
+    for line in meminfo:
+        if line.startswith('MemTotal'):
+            HOST_MEMORY_KB = int(line.rstrip('\n').split(':')[1].
+                                 strip().split(' ')[0])
+            HOST_MEMORY = str(round(HOST_MEMORY_KB / (1024 * 1024), 2)) + " GB"
+            break
+
+# Find path for the "nightly_tests_core.py" script
+NIGHTLY_TESTS_CORE_PATH = os.path.join(
+    os.path.dirname(os.path.abspath(__file__)),
+    "nightly_tests_core.py")
+
+NIGHTLY_TESTS_ARGUMENTS = sys.argv[1:]
+
+# Start the nightly test
+START_EPOCH = time.time()
+RUN_NIGHTLY_TESTS = subprocess.run([NIGHTLY_TESTS_CORE_PATH,
+                                    *NIGHTLY_TESTS_ARGUMENTS],
+                                   stdout=subprocess.PIPE,
+                                   stderr=subprocess.PIPE,
+                                   check=False)
+END_EPOCH = time.time()
+
+# Perform time calculations
+EXECUTION_TIME = datetime.timedelta(seconds=END_EPOCH - START_EPOCH)
+TEST_DATE = datetime.datetime.utcfromtimestamp(
+    START_EPOCH).strftime('%A, %B %-d, %Y')
+START_TIME = datetime.datetime.utcfromtimestamp(
+    START_EPOCH).strftime('%Y-%m-%d %H:%M:%S')
+END_TIME = datetime.datetime.utcfromtimestamp(
+    END_EPOCH).strftime('%Y-%m-%d %H:%M:%S')
+
+# Get nightly test status
+if RUN_NIGHTLY_TESTS.returncode:
+    STATUS = "FAILURE"
+else:
+    STATUS = "SUCCESS"
+
+# Initialize a StringIO to print all the output into
+OUTPUT = io.StringIO()
+
+# Print the nightly test statistical information
+print("{:<17}: {}\n{:<17}: {}\n".
+      format("Host CPU",
+             HOST_CPU,
+             "Host Memory",
+             HOST_MEMORY), file=OUTPUT)
+print("{:<17}: {}\n{:<17}: {}\n{:<17}: {}\n".
+      format("Start Time (UTC)",
+             START_TIME,
+             "End Time (UTC)",
+             END_TIME,
+             "Execution Time",
+             EXECUTION_TIME), file=OUTPUT)
+print("{:<17}: {}\n".format("Status", STATUS), file=OUTPUT)
+
+if STATUS == "SUCCESS":
+    print("Note:\nChanges denoted by '-----' are less than 0.01%.\n",
+          file=OUTPUT)
+
+# Print the nightly test stdout (main output)
+print(RUN_NIGHTLY_TESTS.stdout.decode("utf-8"), file=OUTPUT)
+
+# If the nightly test failed, print the stderr (error logs)
+if STATUS == "FAILURE":
+    print("{}\n{}\n{}".format("-" * 56,
+                              " " * 18 + "ERROR LOGS",
+                              "-" * 56), file=OUTPUT)
+    print(RUN_NIGHTLY_TESTS.stderr.decode("utf-8"), file=OUTPUT)
+
+
+# Temp file to store the output in case sending the email failed
+# with open("temp.txt", "w") as file:
+#     file.write(OUTPUT.getvalue())
+
+# Use an HTML message to preserve monospace formatting
+HTML_MESSAGE = """\
+<html><body><pre>
+{body}
+</pre></body></html>
+""".format(body=OUTPUT.getvalue())
+OUTPUT.close()
+
+# Send the nightly test results email to the QEMU mailing list
+while True:
+    try:
+        send_email("[REPORT] Nightly Performance Tests - {}".format(TEST_DATE),
+                   ["qemu-devel@nongnu.org"], HTML_MESSAGE)
+    except Exception:  # pylint: disable=W0703
+        # Wait for a minute then retry sending
+        time.sleep(60)
+        continue
+    else:
+        break
diff --git a/tests/performance/nightly-tests/scripts/send_email.py b/tests/performance/nightly-tests/scripts/send_email.py
new file mode 100644
index 0000000000..e24e244f51
--- /dev/null
+++ b/tests/performance/nightly-tests/scripts/send_email.py
@@ -0,0 +1,56 @@
+"""
+Helper script for sending emails with the nightly performance test results.
+
+This file is a part of the project "TCG Continuous Benchmarking".
+
+Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+
+This program is free software: you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation, either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program. If not, see <https://www.gnu.org/licenses/>.
+"""
+
+
+import smtplib
+from typing import List
+from email.mime.multipart import MIMEMultipart
+from email.mime.text import MIMEText
+from email.utils import COMMASPACE, formatdate
+
+
+GMAIL_USER = {"name": "",
+              "email": "",
+              "pass": ""}
+
+
+def send_email(subject: str, send_to: List[str], html: str) -> None:
+    """
+    Send an HTML email.
+
+    Parameters:
+    subject (str): Email subject
+    send_to (List(str)): List of recipients
+    html (str): HTML message
+    """
+    msg = MIMEMultipart('alternative')
+    msg['From'] = "{} <{}>".format(GMAIL_USER["name"], GMAIL_USER["email"])
+    msg['To'] = COMMASPACE.join(send_to)
+    msg['Date'] = formatdate(localtime=True)
+    msg['Subject'] = subject
+
+    msg.attach(MIMEText(html, 'html'))
+
+    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
+    server.login(GMAIL_USER["email"], GMAIL_USER["pass"])
+    server.sendmail(msg['From'], send_to, msg.as_string())
+    server.quit()
-- 
2.17.1


