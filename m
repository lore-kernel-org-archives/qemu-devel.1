Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965DCC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683B3207FC
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOfuHFLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683B3207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpF6j-0002AH-M6
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jpF5q-000170-QL
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:58:23 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:41829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jpF5o-0004vq-Om
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:58:22 -0400
Received: by mail-ej1-x643.google.com with SMTP id dp18so12314258ejc.8
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MRiEY6cvaWy49thDl9t7kIwltWHAk95KipkwHJw5uEA=;
 b=GOfuHFLxtJuMHHkQySqfEui359ODz6Ar/va/oYpIimtdq1K8gyb0SfQZfJr5BHFeQk
 bwKu9B6D9cEgjUW7QT3sQPivkWt44jIFhAYYPgE8ECvapxiChzx7wSNa+fowavae0eHt
 AG7ZgQpsZd10a0GIsQXSCyHiSCshqsR7e+EUsdXsnRCoL0pSveRRUPaiRKt2dWMReMHj
 4ykJtM61Y9eJQ0adQETm1aJ0et0hJl+HS4p+b1TUQt/dwKgBUl/fzQruZ4Kyn7gVJT98
 OGyNw9C77DQoeJlWX7W4FjAMAE/Tupkr2VpOV+T2MW7ZhuNRu9vvKyOtX3IyxfjNDQJN
 50EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MRiEY6cvaWy49thDl9t7kIwltWHAk95KipkwHJw5uEA=;
 b=ckD09a1pycKqVJtTLEDTuxq68HTgikBUn5nG1btNYmi5ruDxau/tidXNjxUopVPQEW
 J+EQnVolUnLcNPenqAtCbWAOK6q6PyQdp1KIxU4QWGBTKjU2t4EYBbvd9bDAUq/p/sCp
 2+5uAajmiflTTQTNwsUMt5ZRW9vIvineiCUe0uxoH/cvS5EE8dQDNj7j09mWAxKN0c2A
 CjhG+wDA+osTqFvdHe67kAzBsRIo4klvw6z9k5X8cOPxkiZezP0QmCnLlpxgLRYpRr4H
 DL+/hLsXQjKXOT0ttnexYbdEYvVHZJdi8zrxm0vdXfO8aaZbm5Ff52fgMqkKwtoXkm+R
 vQeA==
X-Gm-Message-State: AOAM531wx9ZR9jEvjfY0+K3gEh5boWUI0p0JxLBlHqG8HKgb6TU+Nc+n
 tM07fN2EnMeAvpTf0SD6gm5wIcaupX3XJk2MQxI=
X-Google-Smtp-Source: ABdhPJwNTtIuckixFiuYsgiI97Gocft2NO/Lvjbt9UTZWEgUo6fzbs6Vwc/fADqJlRWkfP/89B6cAbiVm0P8Blp3c6E=
X-Received: by 2002:a17:906:1c4b:: with SMTP id
 l11mr7253335ejg.307.1593280699220; 
 Sat, 27 Jun 2020 10:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200626164546.22102-1-ahmedkhaledkaraman@gmail.com>
 <20200626164546.22102-2-ahmedkhaledkaraman@gmail.com>
In-Reply-To: <20200626164546.22102-2-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 27 Jun 2020 19:58:08 +0200
Message-ID: <CAL1e-=hCMJzCeX9pAOa_vX+GUegZ4gKyQSL8zf96qK+bcPBNxA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] scripts/performance: Add topN_perf.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PDS_OTHER_BAD_TLD=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 7:00 PM Ahmed Karaman
<ahmedkhaledkaraman@gmail.com> wrote:
>
> Syntax:
> topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
>                  <qemu executable> [<qemu executable options>] \
>                  <target executable> [<target execurable options>]
>
> [-h] - Print the script arguments help message.
> [-n] - Specify the number of top functions to print.
>      - If this flag is not specified, the tool defaults to 25.
>
> Example of usage:
> topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
>
> Example Output:
>  No.  Percentage  Name                       Invoked by
> ----  ----------  -------------------------  -------------------------
>    1      16.25%  float64_mul                qemu-x86_64
>    2      12.01%  float64_sub                qemu-x86_64
>    3      11.99%  float64_add                qemu-x86_64
>    4       5.69%  helper_mulsd               qemu-x86_64
>    5       4.68%  helper_addsd               qemu-x86_64
>    6       4.43%  helper_lookup_tb_ptr       qemu-x86_64
>    7       4.28%  helper_subsd               qemu-x86_64
>    8       2.71%  f64_compare                qemu-x86_64
>    9       2.71%  helper_ucomisd             qemu-x86_64
>   10       1.04%  helper_pand_xmm            qemu-x86_64
>   11       0.71%  float64_div                qemu-x86_64
>   12       0.63%  helper_pxor_xmm            qemu-x86_64
>   13       0.50%  0x00007f7b7004ef95         [JIT] tid 491
>   14       0.50%  0x00007f7b70044e83         [JIT] tid 491
>   15       0.36%  helper_por_xmm             qemu-x86_64
>   16       0.32%  helper_cc_compute_all      qemu-x86_64
>   17       0.30%  0x00007f7b700433f0         [JIT] tid 491
>   18       0.30%  float64_compare_quiet      qemu-x86_64
>   19       0.27%  soft_f64_addsub            qemu-x86_64
>   20       0.26%  round_to_int               qemu-x86_64
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Applied to "TCG Continuous Benchmarking" queue.

>  scripts/performance/topN_perf.py | 149 +++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100755 scripts/performance/topN_perf.py
>
> diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_perf.py
> new file mode 100755
> index 0000000000..07be195fc8
> --- /dev/null
> +++ b/scripts/performance/topN_perf.py
> @@ -0,0 +1,149 @@
> +#!/usr/bin/env python3
> +
> +#  Print the top N most executed functions in QEMU using perf.
> +#  Syntax:
> +#  topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
> +#           <qemu executable> [<qemu executable options>] \
> +#           <target executable> [<target execurable options>]
> +#
> +#  [-h] - Print the script arguments help message.
> +#  [-n] - Specify the number of top functions to print.
> +#       - If this flag is not specified, the tool defaults to 25.
> +#
> +#  Example of usage:
> +#  topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
> +#
> +#  This file is a part of the project "TCG Continuous Benchmarking".
> +#
> +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +#
> +#  This program is free software: you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation, either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +#  GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program. If not, see <https://www.gnu.org/licenses/>.
> +
> +import argparse
> +import os
> +import subprocess
> +import sys
> +
> +
> +# Parse the command line arguments
> +parser = argparse.ArgumentParser(
> +    usage='topN_perf.py [-h] [-n] <number of displayed top functions >  -- '
> +          '<qemu executable> [<qemu executable options>] '
> +          '<target executable> [<target executable options>]')
> +
> +parser.add_argument('-n', dest='top', type=int, default=25,
> +                    help='Specify the number of top functions to print.')
> +
> +parser.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
> +
> +args = parser.parse_args()
> +
> +# Extract the needed variables from the args
> +command = args.command
> +top = args.top
> +
> +# Insure that perf is installed
> +check_perf_presence = subprocess.run(["which", "perf"],
> +                                     stdout=subprocess.DEVNULL)
> +if check_perf_presence.returncode:
> +    sys.exit("Please install perf before running the script!")
> +
> +# Insure user has previllage to run perf
> +check_perf_executability = subprocess.run(["perf", "stat", "ls", "/"],
> +                                          stdout=subprocess.DEVNULL,
> +                                          stderr=subprocess.DEVNULL)
> +if check_perf_executability.returncode:
> +    sys.exit(
> +"""
> +Error:
> +You may not have permission to collect stats.
> +
> +Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> +which controls use of the performance events system by
> +unprivileged users (without CAP_SYS_ADMIN).
> +
> +  -1: Allow use of (almost) all events by all users
> +      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> +   0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
> +      Disallow raw tracepoint access by users without CAP_SYS_ADMIN
> +   1: Disallow CPU event access by users without CAP_SYS_ADMIN
> +   2: Disallow kernel profiling by users without CAP_SYS_ADMIN
> +
> +To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
> +   kernel.perf_event_paranoid = -1
> +
> +* Alternatively, you can run this script under sudo privileges.
> +"""
> +)
> +
> +# Run perf record
> +perf_record = subprocess.run((["perf", "record", "--output=/tmp/perf.data"] +
> +                              command),
> +                             stdout=subprocess.DEVNULL,
> +                             stderr=subprocess.PIPE)
> +if perf_record.returncode:
> +    os.unlink('/tmp/perf.data')
> +    sys.exit(perf_record.stderr.decode("utf-8"))
> +
> +# Save perf report output to /tmp/perf_report.out
> +with open("/tmp/perf_report.out", "w") as output:
> +    perf_report = subprocess.run(
> +        ["perf", "report", "--input=/tmp/perf.data", "--stdio"],
> +        stdout=output,
> +        stderr=subprocess.PIPE)
> +    if perf_report.returncode:
> +        os.unlink('/tmp/perf.data')
> +        output.close()
> +        os.unlink('/tmp/perf_report.out')
> +        sys.exit(perf_report.stderr.decode("utf-8"))
> +
> +# Read the reported data to functions[]
> +functions = []
> +with open("/tmp/perf_report.out", "r") as data:
> +    # Only read lines that are not comments (comments start with #)
> +    # Only read lines that are not empty
> +    functions = [line for line in data.readlines() if line and line[0]
> +                 != '#' and line[0] != "\n"]
> +
> +# Limit the number of top functions to "top"
> +number_of_top_functions = top if len(functions) > top else len(functions)
> +
> +# Store the data of the top functions in top_functions[]
> +top_functions = functions[:number_of_top_functions]
> +
> +# Print table header
> +print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
> +                                                         'Percentage',
> +                                                         'Name',
> +                                                         'Invoked by',
> +                                                         '-' * 4,
> +                                                         '-' * 10,
> +                                                         '-' * 30,
> +                                                         '-' * 25))
> +
> +# Print top N functions
> +for (index, function) in enumerate(top_functions, start=1):
> +    function_data = function.split()
> +    function_percentage = function_data[0]
> +    function_name = function_data[-1]
> +    function_invoker = ' '.join(function_data[2:-2])
> +    print('{:>4}  {:>10}  {:<30}  {}'.format(index,
> +                                             function_percentage,
> +                                             function_name,
> +                                             function_invoker))
> +
> +# Remove intermediate files
> +os.unlink('/tmp/perf.data')
> +os.unlink('/tmp/perf_report.out')
> --
> 2.17.1
>
>

