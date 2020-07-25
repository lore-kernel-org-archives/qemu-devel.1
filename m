Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B29C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 12:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152E3206F6
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 12:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfSeiPa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152E3206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzJM1-0007Fl-9t
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 08:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jzJKf-0006mX-SH
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 08:31:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jzJKc-0003ok-51
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 08:31:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so10576187wrs.11
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=MZCrkqhONFIC61ruVm1ba9x4nZeqazjKiKVmfHp+PcA=;
 b=mfSeiPa14OeYBx0dimFzmcnom0/G+gFRW0AWnTDWtNuADmDM2sriMzfpO4/VbYDpRs
 yhDVhAFmrgKwKAJr84q848BR8ZmxRpQXOKzxxlah4PZdKfWzkhqH5ECQg+SGUxklJiig
 GNuG0zPT/HjX4A+SrT5TVFW7EcrLIjaQtXnb/XCk5hleqy+7YH+/7gjoj3JFfjf5D90g
 J2zE6IRtAey5Tt72EhBZw2W1hxCCKai0PGdkyjutrKTrovoBCt08vhcOD8UOEcs/w/jc
 9dS007+5ReAsYIMVX7wHd5q3HNDedEMc7CqnkQbgwSCCs2sIxKAGkC8haj5o0yA4kv5K
 LSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=MZCrkqhONFIC61ruVm1ba9x4nZeqazjKiKVmfHp+PcA=;
 b=jAQ6XQrHorxaeobbPmlH9b3JOn7QpyFk2v7uchw/hgESLF2/tI4YTmwJR6cfXOHnrW
 Rfctjr/vesCAaDUb0vzmylH4VwfHCJ791AiRWvV0iMDdFbdrNntz1sYZMwj5HQ6WanB3
 rVbpAuCa4noBElezto+EXrSP7/2X7L/fmdr3u3TGln7B97y24xMTopgUogbJwkWN2kKG
 mVvPN2mD7PNqpvj3VQWl9kN7Tqy+COg+21braJ9Xp7IBciCWbz4f/ZaQ/QenSpHSjNtt
 Kr7wxIXAxfOIhfCwqiqxPthSnM2tu39n9HmtSAD57wFWIQkxTQfV3aj+VEFy95xbxBpK
 0UNQ==
X-Gm-Message-State: AOAM533Y62na0D3gmlfLJU7aTosJyTCw245C0y9YEQRl2cSdn/iBUZVy
 oSPpl9ov3QpGMvMNMq6hlRZxolVbcqdigGyit+U=
X-Google-Smtp-Source: ABdhPJyMKGbwN0tcCSsPTUzufuRUMuZPTWVnxIHxbfAEEDKElcto6HCop6GWhjwj3YMx6OzXgB581Sz/30kYwyvzZOo=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr12246093wrv.162.1595680272465; 
 Sat, 25 Jul 2020 05:31:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP; Sat, 25 Jul 2020 05:31:12
 -0700 (PDT)
In-Reply-To: <20200721231536.21604-2-ahmedkhaledkaraman@gmail.com>
References: <20200721231536.21604-1-ahmedkhaledkaraman@gmail.com>
 <20200721231536.21604-2-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 25 Jul 2020 14:31:12 +0200
Message-ID: <CAHiYmc4e=8cb4q1Gn5i=Jx=coPQBozXHT=7kK+gKeA=vi16-7g@mail.gmail.com>
Subject: Re: [PATCH 1/1] scripts/performance: Add bisect.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d0c21805ab43431e"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "crosa@redhat.com" <crosa@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d0c21805ab43431e
Content-Type: text/plain; charset="UTF-8"

On Wednesday, July 22, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
wrote:

> Python script that locates the commit that caused a performance
> degradation or improvement in QEMU using the git bisect command
> (binary search).
>
> Syntax:
> bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] \
> --target TARGET --tool {perf,callgrind} -- \
> <target executable> [<target executable options>]
>
> [-h] - Print the script arguments help message
> -s,--start START - First commit hash in the search range
> [-e,--end END] - Last commit hash in the search range
>                 (default: Latest commit)
> [-q,--qemu QEMU] - QEMU path.
>                 (default: Path to a GitHub QEMU clone)
> --target TARGET - QEMU target name
> --tool {perf,callgrind} - Underlying tool used for measurements
>
> Example of usage:
> bisect.py --start=fdd76fecdd --qemu=/path/to/qemu --target=ppc \
> --tool=perf -- coulomb_double-ppc -n 1000
>
> Example output:
> Start Commit Instructions:     12,710,790,060
> End Commit Instructions:       13,031,083,512
> Performance Change:            -2.458%
>
> Estimated Number of Steps:     10
>
> *****************BISECT STEP 1*****************
> Instructions:        13,031,097,790
> Status:              slow commit
> *****************BISECT STEP 2*****************
> Instructions:        12,710,805,265
> Status:              fast commit
> *****************BISECT STEP 3*****************
> Instructions:        13,031,028,053
> Status:              slow commit
> *****************BISECT STEP 4*****************
> Instructions:        12,711,763,211
> Status:              fast commit
> *****************BISECT STEP 5*****************
> Instructions:        13,031,027,292
> Status:              slow commit
> *****************BISECT STEP 6*****************
> Instructions:        12,711,748,738
> Status:              fast commit
> *****************BISECT STEP 7*****************
> Instructions:        12,711,748,788
> Status:              fast commit
> *****************BISECT STEP 8*****************
> Instructions:        13,031,100,493
> Status:              slow commit
> *****************BISECT STEP 9*****************
> Instructions:        12,714,472,954
> Status:              fast commit
> ****************BISECT STEP 10*****************
> Instructions:        12,715,409,153
> Status:              fast commit
> ****************BISECT STEP 11*****************
> Instructions:        12,715,394,739
> Status:              fast commit
>
> *****************BISECT RESULT*****************
> commit 0673ecdf6cb2b1445a85283db8cbacb251c46516
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Tue May 5 10:40:23 2020 -0700
>
>     softfloat: Inline float64 compare specializations
>
>     Replace the float64 compare specializations with inline functions
>     that call the standard float64_compare{,_quiet} functions.
>     Use bool as the return type.
> ***********************************************
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  scripts/performance/bisect.py | 374 ++++++++++++++++++++++++++++++++++
>  1 file changed, 374 insertions(+)
>  create mode 100755 scripts/performance/bisect.py
>
> diff --git a/scripts/performance/bisect.py b/scripts/performance/bisect.py
> new file mode 100755
> index 0000000000..869cc69ef4
> --- /dev/null
> +++ b/scripts/performance/bisect.py
> @@ -0,0 +1,374 @@
> +#!/usr/bin/env python3
> +
> +#  Locate the commit that caused a performance degradation or improvement
> in
> +#  QEMU using the git bisect command (binary search).
> +#
> +#  Syntax:
> +#  bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] \
> +#  --target TARGET --tool {perf,callgrind} -- \
> +#  <target executable> [<target executable options>]
> +#
> +#  [-h] - Print the script arguments help message
> +#  -s,--start START - First commit hash in the search range
> +#  [-e,--end END] - Last commit hash in the search range
> +#             (default: Latest commit)
> +#  [-q,--qemu QEMU] - QEMU path.
> +#              (default: Path to a GitHub QEMU clone)
> +#  --target TARGET - QEMU target name
> +#  --tool {perf,callgrind} - Underlying tool used for measurements
> +
> +#  Example of usage:
> +#  bisect.py --start=fdd76fecdd --qemu=/path/to/qemu --target=ppc
> --tool=perf \
> +#  -- coulomb_double-ppc -n 1000
> +#
> +#  This file is a part of the project "TCG Continuous Benchmarking".
> +#
> +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.
> com>
> +#


Hi, Ahmed.

Yes, somewhat related to John's hints on these comments, it is customary to
have just a brief description before "Copyright" lines. This means one
sentence, or a short paragraph (3-4 sentences max). The lenghty syntax
commemt should be, in my opinion, moved after the license preamble, just
before the start of real Python code.

One question:

What is the behavior in case of the executable architecture and "target"
command line option mismatch (for example, one specifies m68k target, but
passes hppa executable? Would that be detected before bisect search, or the
bisect procedure will be applied even though such cases do not make sense?

Yours, Aleksandar



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
> +import multiprocessing
> +import tempfile
> +import os
> +import shutil
> +import subprocess
> +import sys
> +
> +
> +############################ GIT WRAPPERS ############################
> +def git_bisect(qemu_path, command, args=None):
> +    """
> +    Wrapper function for running git bisect.
> +
> +    Parameters:
> +    qemu_path (str): QEMU path.
> +    command (str):   bisect command (start|fast|slow|reset).
> +    args (list):     Optional arguments.
> +
> +    Returns:
> +    (str):           git bisect stdout.
> +    """
> +    process = ["git", "bisect", command]
> +    if args:
> +        process += args
> +    bisect = subprocess.run(process,
> +                            cwd=qemu_path,
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.PIPE)
> +    if bisect.returncode:
> +        sys.exit(bisect.stderr.decode("utf-8"))
> +    return bisect.stdout.decode("utf-8")
> +
> +
> +def git_checkout(commit, qemu_path):
> +    """
> +    Wrapper function for checking out a given git commit.
> +
> +    Parameters:
> +    commit (str):    Commit hash of a git commit.
> +    qemu_path (str): QEMU path.
> +    """
> +    checkout_commit = subprocess.run(["git",
> +                                      "checkout",
> +                                      commit],
> +                                     cwd=qemu_path,
> +                                     stdout=subprocess.DEVNULL,
> +                                     stderr=subprocess.PIPE)
> +    if checkout_commit.returncode:
> +        sys.exit(checkout_commit.stderr.decode("utf-8"))
> +
> +
> +def git_clone(qemu_path):
> +    """
> +    Wrapper function for cloning QEMU git repo from GitHub.
> +
> +    Parameters:
> +    qemu_path (str): Path to clone the QEMU repo to.
> +    """
> +    clone_qemu = subprocess.run(["git",
> +                                 "clone",
> +                                 "https://github.com/qemu/qemu.git",
> +                                 qemu_path],
> +                                stderr=subprocess.STDOUT)
> +    if clone_qemu.returncode:
> +        sys.exit("Failed to clone QEMU!")
> +######################################################################
> +
> +
> +def check_requirements(tool):
> +    """
> +    Verify that all script requirements are installed (perf|callgrind &
> git).
> +
> +    Parameters:
> +    tool (str): Tool used for the measurement (perf or callgrind).
> +    """
> +    if tool == "perf":
> +        check_perf_installation = subprocess.run(["which", "perf"],
> +
>  stdout=subprocess.DEVNULL)
> +        if check_perf_installation.returncode:
> +            sys.exit("Please install perf before running the script.")
> +
> +        # Insure user has previllage to run perf
> +        check_perf_executability = subprocess.run(["perf", "stat", "ls",
> "/"],
> +
> stdout=subprocess.DEVNULL,
> +
> stderr=subprocess.DEVNULL)
> +        if check_perf_executability.returncode:
> +            sys.exit("""
> +        Error:
> +        You may not have permission to collect stats.
> +        Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> +        which controls use of the performance events system by
> +        unprivileged users (without CAP_SYS_ADMIN).
> +        -1: Allow use of (almost) all events by all users
> +            Ignore mlock limit after perf_event_mlock_kb without
> CAP_IPC_LOCK
> +        0: Disallow ftrace function tracepoint by users without
> CAP_SYS_ADMIN
> +            Disallow raw tracepoint access by users without CAP_SYS_ADMIN
> +        1: Disallow CPU event access by users without CAP_SYS_ADMIN
> +        2: Disallow kernel profiling by users without CAP_SYS_ADMIN
> +        To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
> +        kernel.perf_event_paranoid = -1
> +
> +        *Alternatively, you can run this script under sudo privileges.
> +        """)
> +    elif tool == "callgrind":
> +        check_valgrind_installation = subprocess.run(["which",
> "valgrind"],
> +
>  stdout=subprocess.DEVNULL)
> +        if check_valgrind_installation.returncode:
> +            sys.exit("Please install valgrind before running the script.")
> +
> +    # Insure that git is installed
> +    check_git_installation = subprocess.run(["which", "git"],
> +                                            stdout=subprocess.DEVNULL)
> +    if check_git_installation.returncode:
> +        sys.exit("Please install git before running the script.")
> +
> +
> +def make(qemu_build_path):
> +    """
> +    Build QEMU by running the Makefile.
> +
> +    Parameters:
> +    qemu_build_path (str): Path to the build directory with configuration
> files.
> +    """
> +    run_make = subprocess.run(["make",
> +                               "-j",
> +                               str(multiprocessing.cpu_count())],
> +                              cwd=qemu_build_path,
> +                              stdout=subprocess.DEVNULL,
> +                              stderr=subprocess.PIPE)
> +    if run_make.returncode:
> +        sys.exit(run_make.stderr.decode("utf-8"))
> +
> +
> +def measure_instructions(tool, qemu_exe_path, command):
> +    """
> +    Measure the number of instructions when running an program with QEMU.
> +
> +    Parameters:
> +    tool (str):          Tool used for the measurement (perf|callgrind).
> +    qemu_exe_path (str): Path to the QEMU executable of the equivalent
> target.
> +    command (list):      Program path and arguments.
> +
> +    Returns:
> +    (int):               Number of instructions.
> +    """
> +    if tool == "perf":
> +        run_perf = subprocess.run((["perf",
> +                                    "stat",
> +                                    "-x",
> +                                    " ",
> +                                    "-e",
> +                                    "instructions",
> +                                    qemu_exe_path]
> +                                   + command),
> +                                  stdout=subprocess.DEVNULL,
> +                                  stderr=subprocess.PIPE)
> +        if run_perf.returncode:
> +            sys.exit(run_perf.stderr.decode("utf-8"))
> +        else:
> +            perf_output = run_perf.stderr.decode("utf-8").split(" ")
> +            return int(perf_output[0])
> +
> +    elif tool == "callgrind":
> +        with tempfile.NamedTemporaryFile() as tmpfile:
> +            run_callgrind = subprocess.run((["valgrind",
> +                                             "--tool=callgrind",
> +                                             "--callgrind-out-file={}".
> format(
> +                                                 tmpfile.name),
> +                                             qemu_exe_path]
> +                                            + command),
> +                                           stdout=subprocess.DEVNULL,
> +                                           stderr=subprocess.PIPE)
> +        if run_callgrind.returncode:
> +            sys.exit(run_callgrind.stderr.decode("utf-8"))
> +        else:
> +            callgrind_output = run_callgrind.stderr.decode("
> utf-8").split("\n")
> +            return int(callgrind_output[8].split(" ")[-1])
> +
> +
> +def main():
> +    # Parse the command line arguments
> +    parser = argparse.ArgumentParser(
> +        usage="bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu
> QEMU] "
> +        "--target TARGET --tool {perf,callgrind} -- "
> +        "<target executable> [<target executable options>]")
> +
> +    parser.add_argument("-s", "--start", dest="start", type=str,
> required=True,
> +                        help="First commit hash in the search range")
> +    parser.add_argument("-e", "--end", dest="end", type=str,
> default="master",
> +                        help="Last commit hash in the search range")
> +    parser.add_argument("-q", "--qemu", dest="qemu", type=str, default="",
> +                        help="QEMU path")
> +    parser.add_argument("--target", dest="target", type=str,
> required=True,
> +                        help="QEMU target")
> +    parser.add_argument("--tool", dest="tool", choices=["perf",
> "callgrind"],
> +                        required=True, help="Tool used for measurements")
> +
> +    parser.add_argument("command", type=str, nargs="+",
> help=argparse.SUPPRESS)
> +
> +    args = parser.parse_args()
> +
> +    # Extract the needed variables from the args
> +    start_commit = args.start
> +    end_commit = args.end
> +    qemu = args.qemu
> +    target = args.target
> +    tool = args.tool
> +    command = args.command
> +
> +    # Set QEMU path
> +    if qemu == "":
> +        # Create a temp directory for cloning QEMU
> +        tmpdir = tempfile.TemporaryDirectory()
> +        qemu_path = os.path.join(tmpdir.name, "qemu")
> +
> +        # Clone QEMU into the temporary directory
> +        print("Fetching QEMU: ", end="", flush=True)
> +        git_clone(qemu_path)
> +        print()
> +    else:
> +        qemu_path = qemu
> +
> +    # Create the build directory
> +    qemu_build_path = os.path.join(qemu_path, "tmp-build-gcc")
> +    if not os.path.exists(qemu_build_path):
> +        os.mkdir(qemu_build_path)
> +    else:
> +        sys.exit("A build directory with the same name (tmp-build-gcc)
> used in "
> +                 "the script is already in the provided QEMU path.")
> +
> +    qemu_exe_path = os.path.join(qemu_build_path,
> +                                 "{}-linux-user".format(target),
> +                                 "qemu-{}".format(target))
> +
> +    # Configure QEMU
> +    configure = subprocess.run(["../configure",
> +                                "--target-list={}-linux-user".
> format(target)],
> +                               cwd=qemu_build_path,
> +                               stdout=subprocess.DEVNULL,
> +                               stderr=subprocess.PIPE)
> +    if configure.returncode:
> +        sys.exit(configure.stderr.decode("utf-8"))
> +
> +    # Do performance measurements for the start commit
> +    git_checkout(start_commit, qemu_path)
> +    make(qemu_build_path)
> +    start_commit_instructions = measure_instructions(tool,
> +                                                     qemu_exe_path,
> +                                                     command)
> +    print("{:<30} {}".format("Start Commit Instructions:",
> +                             format(start_commit_instructions, ",")))
> +
> +    # Do performance measurements for the end commit
> +    git_checkout(end_commit, qemu_path)
> +    make(qemu_build_path)
> +    end_commit_instructions = measure_instructions(tool,
> +                                                   qemu_exe_path,
> +                                                   command)
> +    print("{:<30} {}".format("End Commit Instructions:",
> +                             format(end_commit_instructions, ",")))
> +
> +    # Calculate performance difference between start and end commits
> +    performance_difference = \
> +        (start_commit_instructions - end_commit_instructions) / \
> +        max(end_commit_instructions, start_commit_instructions) * 100
> +    performance_change = "+" if performance_difference > 0 else "-"
> +    print("{:<30} {}".format("Performance Change:",
> +                             performance_change +
> +                             str(round(abs(performance_difference),
> 3))+"%"))
> +
> +    # Set the custom terms used for progressing in "git bisect"
> +    term_old = "fast" if performance_difference < 0 else "slow"
> +    term_new = "slow" if term_old == "fast" else "fast"
> +
> +    # Start git bisect
> +    git_bisect(qemu_path, "start", [
> +               "--term-old", term_old, "--term-new", term_new])
> +    # Set start commit state
> +    git_bisect(qemu_path, term_old, [start_commit])
> +    # Set end commit state
> +    bisect_output = git_bisect(qemu_path, term_new, [end_commit])
> +    # Print estimated bisect steps
> +    print("\n{:<30} {}\n".format(
> +        "Estimated Number of Steps:", bisect_output.split()[9]))
> +
> +    # Initialize bisect_count to track the number of performed
> +    bisect_count = 1
> +
> +    while True:
> +        print("**************BISECT STEP {}**************".format(
> bisect_count))
> +
> +        make(qemu_build_path)
> +
> +        instructions = measure_instructions(tool, qemu_exe_path, command)
> +        # Find the difference between the current instructions and
> start/end
> +        # instructions.
> +        diff_end = abs(instructions - end_commit_instructions)
> +        diff_start = abs(instructions - start_commit_instructions)
> +
> +        # If current number of insructions is closer to that of start,
> +        # set current commit as term_old.
> +        # Else, set current commit as term_new.
> +        if diff_end > diff_start:
> +            bisect_command = term_old
> +        else:
> +            bisect_command = term_new
> +
> +        print("{:<20} {}".format("Instructions:", format(instructions,
> ",")))
> +        print("{:<20} {}".format("Status:", "{}
> commit".format(bisect_command)))
> +
> +        bisect_output = git_bisect(qemu_path, bisect_command)
> +
> +        # Continue if still bisecting,
> +        # else, print result and break.
> +        if not bisect_output.split(" ")[0] == "Bisecting:":
> +            print("\n*****************BISECT RESULT*****************")
> +            commit_message_start = bisect_output.find("commit\n") + 7
> +            commit_message_end = bisect_output.find(":040000") - 1
> +            print(bisect_output[commit_message_start:commit_message_end])
> +            break
> +
> +        bisect_count += 1
> +
> +    # Reset git bisect
> +    git_bisect(qemu_path, "reset")
> +
> +    # Delete temp build directory
> +    shutil.rmtree(qemu_build_path)
> +
> +
> +if __name__ == "__main__":
> +    main()
> --
> 2.17.1
>
>

--000000000000d0c21805ab43431e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, July 22, 2020, Ahmed Karaman &lt;<a href=3D"mailto:ah=
medkhaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt; wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Python script that locates the commit that c=
aused a performance<br>
degradation or improvement in QEMU using the git bisect command<br>
(binary search).<br>
<br>
Syntax:<br>
bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] \<br>
--target TARGET --tool {perf,callgrind} -- \<br>
&lt;target executable&gt; [&lt;target executable options&gt;]<br>
<br>
[-h] - Print the script arguments help message<br>
-s,--start START - First commit hash in the search range<br>
[-e,--end END] - Last commit hash in the search range<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (default: Latest co=
mmit)<br>
[-q,--qemu QEMU] - QEMU path.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (default: Path to a=
 GitHub QEMU clone)<br>
--target TARGET - QEMU target name<br>
--tool {perf,callgrind} - Underlying tool used for measurements<br>
<br>
Example of usage:<br>
bisect.py --start=3Dfdd76fecdd --qemu=3D/path/to/qemu --target=3Dppc \<br>
--tool=3Dperf -- coulomb_double-ppc -n 1000<br>
<br>
Example output:<br>
Start Commit Instructions:=C2=A0 =C2=A0 =C2=A012,710,790,060<br>
End Commit Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A013,031,083,512<br>
Performance Change:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -2.458%<br>
<br>
Estimated Number of Steps:=C2=A0 =C2=A0 =C2=A010<br>
<br>
*****************BISECT STEP 1*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 13,031,097,790<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slow commit<br>
*****************BISECT STEP 2*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,710,805,265<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast commit<br>
*****************BISECT STEP 3*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 13,031,028,053<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slow commit<br>
*****************BISECT STEP 4*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,711,763,211<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast commit<br>
*****************BISECT STEP 5*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 13,031,027,292<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slow commit<br>
*****************BISECT STEP 6*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,711,748,738<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast commit<br>
*****************BISECT STEP 7*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,711,748,788<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast commit<br>
*****************BISECT STEP 8*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 13,031,100,493<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slow commit<br>
*****************BISECT STEP 9*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,714,472,954<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast commit<br>
****************BISECT STEP 10*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,715,409,153<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast commit<br>
****************BISECT STEP 11*****************<br>
Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,715,394,739<br>
Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast commit<br>
<br>
*****************BISECT RESULT*****************<br>
commit 0673ecdf6cb2b1445a85283db8cbac<wbr>b251c46516<br>
Author: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.or=
g">richard.henderson@linaro.org</a>&gt;<br>
Date:=C2=A0 =C2=A0Tue May 5 10:40:23 2020 -0700<br>
<br>
=C2=A0 =C2=A0 softfloat: Inline float64 compare specializations<br>
<br>
=C2=A0 =C2=A0 Replace the float64 compare specializations with inline funct=
ions<br>
=C2=A0 =C2=A0 that call the standard float64_compare{,_quiet} functions.<br=
>
=C2=A0 =C2=A0 Use bool as the return type.<br>
******************************<wbr>*****************<br>
<br>
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---<br>
=C2=A0scripts/performance/bisect.py | 374 ++++++++++++++++++++++++++++++<wb=
r>++++<br>
=C2=A01 file changed, 374 insertions(+)<br>
=C2=A0create mode 100755 scripts/performance/bisect.py<br>
<br>
diff --git a/scripts/performance/bisect.<wbr>py b/scripts/performance/bisec=
t.<wbr>py<br>
new file mode 100755<br>
index 0000000000..869cc69ef4<br>
--- /dev/null<br>
+++ b/scripts/performance/bisect.<wbr>py<br>
@@ -0,0 +1,374 @@<br>
+#!/usr/bin/env python3<br>
+<br>
+#=C2=A0 Locate the commit that caused a performance degradation or improve=
ment in<br>
+#=C2=A0 QEMU using the git bisect command (binary search).<br>
+#<br>
+#=C2=A0 Syntax:<br>
+#=C2=A0 bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] \<=
br>
+#=C2=A0 --target TARGET --tool {perf,callgrind} -- \<br>
+#=C2=A0 &lt;target executable&gt; [&lt;target executable options&gt;]<br>
+#<br>
+#=C2=A0 [-h] - Print the script arguments help message<br>
+#=C2=A0 -s,--start START - First commit hash in the search range<br>
+#=C2=A0 [-e,--end END] - Last commit hash in the search range<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(default: Latest commit)<=
br>
+#=C2=A0 [-q,--qemu QEMU] - QEMU path.<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (default: Path to a GitH=
ub QEMU clone)<br>
+#=C2=A0 --target TARGET - QEMU target name<br>
+#=C2=A0 --tool {perf,callgrind} - Underlying tool used for measurements<br=
>
+<br>
+#=C2=A0 Example of usage:<br>
+#=C2=A0 bisect.py --start=3Dfdd76fecdd --qemu=3D/path/to/qemu --target=3Dp=
pc --tool=3Dperf \<br>
+#=C2=A0 -- coulomb_double-ppc -n 1000<br>
+#<br>
+#=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmarki=
ng&quot;.<br>
+#<br>
+#=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahmed=
khaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
+#=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailto=
:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&=
gt;<br>
+#</blockquote><div><br></div><div>Hi, Ahmed.</div><div><br></div><div>Yes,=
 somewhat related to John&#39;s hints on these comments, it is customary to=
 have just a brief description before &quot;Copyright&quot; lines. This mea=
ns one sentence, or a short paragraph (3-4 sentences max). The lenghty synt=
ax commemt should be, in my opinion, moved after the license preamble, just=
 before the start of real Python code.</div><div><br></div><div>One questio=
n:</div><div><br></div><div>What is the behavior in case of the executable =
architecture and &quot;target&quot; command line option mismatch (for examp=
le, one specifies m68k target, but passes hppa executable? Would that be de=
tected before bisect search, or the bisect procedure will be applied even t=
hough such cases do not make sense?</div><div><br></div><div>Yours, Aleksan=
dar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+#=C2=A0 This program is free software: you can redistribute it and/or modi=
fy<br>
+#=C2=A0 it under the terms of the GNU General Public License as published =
by<br>
+#=C2=A0 the Free Software Foundation, either version 2 of the License, or<=
br>
+#=C2=A0 (at your option) any later version.<br>
+#<br>
+#=C2=A0 This program is distributed in the hope that it will be useful,<br=
>
+#=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+#=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+#=C2=A0 GNU General Public License for more details.<br>
+#<br>
+#=C2=A0 You should have received a copy of the GNU General Public License<=
br>
+#=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.gn=
u.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&g=
t;.<br>
+<br>
+import argparse<br>
+import multiprocessing<br>
+import tempfile<br>
+import os<br>
+import shutil<br>
+import subprocess<br>
+import sys<br>
+<br>
+<br>
+############################ GIT WRAPPERS ############################<br>
+def git_bisect(qemu_path, command, args=3DNone):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Wrapper function for running git bisect.<br>
+<br>
+=C2=A0 =C2=A0 Parameters:<br>
+=C2=A0 =C2=A0 qemu_path (str): QEMU path.<br>
+=C2=A0 =C2=A0 command (str):=C2=A0 =C2=A0bisect command (start|fast|slow|r=
eset).<br>
+=C2=A0 =C2=A0 args (list):=C2=A0 =C2=A0 =C2=A0Optional arguments.<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 (str):=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git bisect st=
dout.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 process =3D [&quot;git&quot;, &quot;bisect&quot;, command]<b=
r>
+=C2=A0 =C2=A0 if args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 process +=3D args<br>
+=C2=A0 =C2=A0 bisect =3D subprocess.run(process,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 cwd=3Dqemu_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Dsubprocess.PIPE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubprocess.PIPE)<br>
+=C2=A0 =C2=A0 if bisect.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(bisect.stderr.decode(<wbr>&quot;utf-8=
&quot;))<br>
+=C2=A0 =C2=A0 return bisect.stdout.decode(&quot;utf-8&quot;)<br>
+<br>
+<br>
+def git_checkout(commit, qemu_path):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Wrapper function for checking out a given git commit.<br>
+<br>
+=C2=A0 =C2=A0 Parameters:<br>
+=C2=A0 =C2=A0 commit (str):=C2=A0 =C2=A0 Commit hash of a git commit.<br>
+=C2=A0 =C2=A0 qemu_path (str): QEMU path.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 checkout_commit =3D subprocess.run([&quot;git&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;checkout&=
quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commit],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cwd=3Dqemu_path,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubproc=
ess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stderr=3Dsubproc=
ess.PIPE)<br>
+=C2=A0 =C2=A0 if checkout_commit.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(checkout_commit.<wbr>stderr.decode(&q=
uot;utf-8&quot;))<br>
+<br>
+<br>
+def git_clone(qemu_path):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Wrapper function for cloning QEMU git repo from GitHub.<br>
+<br>
+=C2=A0 =C2=A0 Parameters:<br>
+=C2=A0 =C2=A0 qemu_path (str): Path to clone the QEMU repo to.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 clone_qemu =3D subprocess.run([&quot;git&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;clone&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;<a href=3D"https://githu=
b.com/qemu/qemu.git" target=3D"_blank">https://github.com/qemu/qemu.<wbr>gi=
t</a>&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_path],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubprocess.STDOUT)<br>
+=C2=A0 =C2=A0 if clone_qemu.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(&quot;Failed to clone QEMU!&quot;)<br=
>
+#############################<wbr>##############################<wbr>#####=
######<br>
+<br>
+<br>
+def check_requirements(tool):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Verify that all script requirements are installed (perf|call=
grind &amp; git).<br>
+<br>
+=C2=A0 =C2=A0 Parameters:<br>
+=C2=A0 =C2=A0 tool (str): Tool used for the measurement (perf or callgrind=
).<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if tool =3D=3D &quot;perf&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_perf_installation =3D subprocess.run([&q=
uot;which&quot;, &quot;perf&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.DEVNULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if check_perf_installation.<wbr>returncode:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(&quot;Please install pe=
rf before running the script.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Insure user has previllage to run perf<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_perf_executability =3D subprocess.run([&=
quot;perf&quot;, &quot;stat&quot;, &quot;ls&quot;, &quot;/&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Dsubprocess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubprocess.DEVNULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if check_perf_executability.<wbr>returncode:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Error:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 You may not have permission to collect stats.<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Consider tweaking /proc/sys/kernel/perf_event_=
<wbr>paranoid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 which controls use of the performance events s=
ystem by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unprivileged users (without CAP_SYS_ADMIN).<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 -1: Allow use of (almost) all events by all us=
ers<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ignore mlock limit after perf_ev=
ent_mlock_kb without CAP_IPC_LOCK<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0: Disallow ftrace function tracepoint by user=
s without CAP_SYS_ADMIN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Disallow raw tracepoint access b=
y users without CAP_SYS_ADMIN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 1: Disallow CPU event access by users without =
CAP_SYS_ADMIN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 2: Disallow kernel profiling by users without =
CAP_SYS_ADMIN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 To make this setting permanent, edit /etc/sysc=
tl.conf too, e.g.:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel.perf_event_paranoid =3D -1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *Alternatively, you can run this script under =
sudo privileges.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;)<br>
+=C2=A0 =C2=A0 elif tool =3D=3D &quot;callgrind&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_valgrind_installation =3D subprocess.run=
([&quot;which&quot;, &quot;valgrind&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.DEVNULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if check_valgrind_installation.<wbr>returncode=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(&quot;Please install va=
lgrind before running the script.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 # Insure that git is installed<br>
+=C2=A0 =C2=A0 check_git_installation =3D subprocess.run([&quot;which&quot;=
, &quot;git&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stdout=3Dsubprocess.DEVNULL)<br>
+=C2=A0 =C2=A0 if check_git_installation.<wbr>returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(&quot;Please install git before runni=
ng the script.&quot;)<br>
+<br>
+<br>
+def make(qemu_build_path):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Build QEMU by running the Makefile.<br>
+<br>
+=C2=A0 =C2=A0 Parameters:<br>
+=C2=A0 =C2=A0 qemu_build_path (str): Path to the build directory with conf=
iguration files.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 run_make =3D subprocess.run([&quot;make&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-j&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0str(multiprocessing.cpu_count(<wbr>))=
],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cwd=3Dqemu_build_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Dsubprocess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubprocess.PIPE)<br>
+=C2=A0 =C2=A0 if run_make.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(run_make.stderr.<wbr>decode(&quot;utf=
-8&quot;))<br>
+<br>
+<br>
+def measure_instructions(tool, qemu_exe_path, command):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Measure the number of instructions when running an program w=
ith QEMU.<br>
+<br>
+=C2=A0 =C2=A0 Parameters:<br>
+=C2=A0 =C2=A0 tool (str):=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tool used for =
the measurement (perf|callgrind).<br>
+=C2=A0 =C2=A0 qemu_exe_path (str): Path to the QEMU executable of the equi=
valent target.<br>
+=C2=A0 =C2=A0 command (list):=C2=A0 =C2=A0 =C2=A0 Program path and argumen=
ts.<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 (int):=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Number of instructions.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if tool =3D=3D &quot;perf&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run_perf =3D subprocess.run(([&quot;perf&quot;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;stat&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-x&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; &quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-e&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;instructions&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_exe_path]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ command),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Dsubprocess.DEVNULL,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubprocess.PIPE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if run_perf.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(run_perf.stderr.<wbr>de=
code(&quot;utf-8&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 perf_output =3D run_perf.stderr.=
decode(&quot;utf-8&quot;<wbr>).split(&quot; &quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return int(perf_output[0])<br>
+<br>
+=C2=A0 =C2=A0 elif tool =3D=3D &quot;callgrind&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with tempfile.NamedTemporaryFile() as tmpfile:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run_callgrind =3D subprocess.run=
(([&quot;valgrind&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&quot;--tool=3Dcallgrind&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&quot;--callgrind-out-file=3D{}&quot;.<wbr>format(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://tmpfile.name" target=3D"_blank=
">tmpfile.name</a>),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0qemu_exe_path]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 + command),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0stdout=3Dsubprocess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0stderr=3Dsubprocess.PIPE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if run_callgrind.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(run_callgrind.stderr.<w=
br>decode(&quot;utf-8&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_output =3D run_callgri=
nd.stderr.decode(&quot;<wbr>utf-8&quot;).split(&quot;\n&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return int(callgrind_output[8].s=
plit(<wbr>&quot; &quot;)[-1])<br>
+<br>
+<br>
+def main():<br>
+=C2=A0 =C2=A0 # Parse the command line arguments<br>
+=C2=A0 =C2=A0 parser =3D argparse.ArgumentParser(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 usage=3D&quot;bisect.py [-h] -s,--start START =
[-e,--end END] [-q,--qemu QEMU] &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--target TARGET --tool {perf,callgrind} =
-- &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&lt;target executable&gt; [&lt;target ex=
ecutable options&gt;]&quot;)<br>
+<br>
+=C2=A0 =C2=A0 parser.add_argument(&quot;-s&quot;, &quot;--start&quot;, des=
t=3D&quot;start&quot;, type=3Dstr, required=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;First commit hash in the search range&quot;)<br>
+=C2=A0 =C2=A0 parser.add_argument(&quot;-e&quot;, &quot;--end&quot;, dest=
=3D&quot;end&quot;, type=3Dstr, default=3D&quot;master&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;Last commit hash in the search range&quot;)<br>
+=C2=A0 =C2=A0 parser.add_argument(&quot;-q&quot;, &quot;--qemu&quot;, dest=
=3D&quot;qemu&quot;, type=3Dstr, default=3D&quot;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;QEMU path&quot;)<br>
+=C2=A0 =C2=A0 parser.add_argument(&quot;--target&quot;<wbr>, dest=3D&quot;=
target&quot;, type=3Dstr, required=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;QEMU target&quot;)<br>
+=C2=A0 =C2=A0 parser.add_argument(&quot;--tool&quot;, dest=3D&quot;tool&qu=
ot;, choices=3D[&quot;perf&quot;, &quot;callgrind&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 required=3DTrue, help=3D&quot;Tool used for measurements&quot;)<=
br>
+<br>
+=C2=A0 =C2=A0 parser.add_argument(&quot;command&quot;, type=3Dstr, nargs=
=3D&quot;+&quot;, help=3Dargparse.SUPPRESS)<br>
+<br>
+=C2=A0 =C2=A0 args =3D parser.parse_args()<br>
+<br>
+=C2=A0 =C2=A0 # Extract the needed variables from the args<br>
+=C2=A0 =C2=A0 start_commit =3D args.start<br>
+=C2=A0 =C2=A0 end_commit =3D args.end<br>
+=C2=A0 =C2=A0 qemu =3D args.qemu<br>
+=C2=A0 =C2=A0 target =3D args.target<br>
+=C2=A0 =C2=A0 tool =3D args.tool<br>
+=C2=A0 =C2=A0 command =3D args.command<br>
+<br>
+=C2=A0 =C2=A0 # Set QEMU path<br>
+=C2=A0 =C2=A0 if qemu =3D=3D &quot;&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Create a temp directory for cloning QEMU<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmpdir =3D tempfile.TemporaryDirectory()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_path =3D os.path.join(<a href=3D"http://t=
mpdir.name" target=3D"_blank">tmpdir.name</a>, &quot;qemu&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Clone QEMU into the temporary directory<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Fetching QEMU: &quot;, end=3D&quot=
;&quot;, flush=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 git_clone(qemu_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print()<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_path =3D qemu<br>
+<br>
+=C2=A0 =C2=A0 # Create the build directory<br>
+=C2=A0 =C2=A0 qemu_build_path =3D os.path.join(qemu_path, &quot;tmp-build-=
gcc&quot;)<br>
+=C2=A0 =C2=A0 if not os.path.exists(qemu_build_<wbr>path):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.mkdir(qemu_build_path)<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(&quot;A build directory with the same=
 name (tmp-build-gcc) used in &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;the sc=
ript is already in the provided QEMU path.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 qemu_exe_path =3D os.path.join(qemu_build_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;{}-linux-user&quot;.form=
at(target)<wbr>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;qemu-{}&quot;.format(tar=
get))<br>
+<br>
+=C2=A0 =C2=A0 # Configure QEMU<br>
+=C2=A0 =C2=A0 configure =3D subprocess.run([&quot;../configure&quot;<wbr>,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--target-list=3D{}-linux-user&=
quot;.<wbr>format(target)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cwd=3Dqemu_build_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stderr=3Dsubprocess.PIPE)<br>
+=C2=A0 =C2=A0 if configure.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(configure.stderr.<wbr>decode(&quot;ut=
f-8&quot;))<br>
+<br>
+=C2=A0 =C2=A0 # Do performance measurements for the start commit<br>
+=C2=A0 =C2=A0 git_checkout(start_commit, qemu_path)<br>
+=C2=A0 =C2=A0 make(qemu_build_path)<br>
+=C2=A0 =C2=A0 start_commit_instructions =3D measure_instructions(tool,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_exe_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command)<br>
+=C2=A0 =C2=A0 print(&quot;{:&lt;30} {}&quot;.format(&quot;Start Commit Ins=
tructions:&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format(start_commit_<wbr>instructions, &quot=
;,&quot;)))<br>
+<br>
+=C2=A0 =C2=A0 # Do performance measurements for the end commit<br>
+=C2=A0 =C2=A0 git_checkout(end_commit, qemu_path)<br>
+=C2=A0 =C2=A0 make(qemu_build_path)<br>
+=C2=A0 =C2=A0 end_commit_instructions =3D measure_instructions(tool,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_exe_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command)<br>
+=C2=A0 =C2=A0 print(&quot;{:&lt;30} {}&quot;.format(&quot;End Commit Instr=
uctions:&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format(end_commit_<wbr>instructions, &quot;,=
&quot;)))<br>
+<br>
+=C2=A0 =C2=A0 # Calculate performance difference between start and end com=
mits<br>
+=C2=A0 =C2=A0 performance_difference =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (start_commit_instructions - end_commit_instru=
ctions) / \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 max(end_commit_instructions, start_commit_inst=
ructions) * 100<br>
+=C2=A0 =C2=A0 performance_change =3D &quot;+&quot; if performance_differen=
ce &gt; 0 else &quot;-&quot;<br>
+=C2=A0 =C2=A0 print(&quot;{:&lt;30} {}&quot;.format(&quot;Performance Chan=
ge:&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0performance_change +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0str(round(abs(performance_<wbr>difference), =
3))+&quot;%&quot;))<br>
+<br>
+=C2=A0 =C2=A0 # Set the custom terms used for progressing in &quot;git bis=
ect&quot;<br>
+=C2=A0 =C2=A0 term_old =3D &quot;fast&quot; if performance_difference &lt;=
 0 else &quot;slow&quot;<br>
+=C2=A0 =C2=A0 term_new =3D &quot;slow&quot; if term_old =3D=3D &quot;fast&=
quot; else &quot;fast&quot;<br>
+<br>
+=C2=A0 =C2=A0 # Start git bisect<br>
+=C2=A0 =C2=A0 git_bisect(qemu_path, &quot;start&quot;, [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--term-old&qu=
ot;, term_old, &quot;--term-new&quot;, term_new])<br>
+=C2=A0 =C2=A0 # Set start commit state<br>
+=C2=A0 =C2=A0 git_bisect(qemu_path, term_old, [start_commit])<br>
+=C2=A0 =C2=A0 # Set end commit state<br>
+=C2=A0 =C2=A0 bisect_output =3D git_bisect(qemu_path, term_new, [end_commi=
t])<br>
+=C2=A0 =C2=A0 # Print estimated bisect steps<br>
+=C2=A0 =C2=A0 print(&quot;\n{:&lt;30} {}\n&quot;.format(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Estimated Number of Steps:&quot;, bisect=
_output.split()[9]))<br>
+<br>
+=C2=A0 =C2=A0 # Initialize bisect_count to track the number of performed<b=
r>
+=C2=A0 =C2=A0 bisect_count =3D 1<br>
+<br>
+=C2=A0 =C2=A0 while True:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;**************BISECT STEP {}******=
********&quot;.format(<wbr>bisect_count))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 make(qemu_build_path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 instructions =3D measure_instructions(tool, qe=
mu_exe_path, command)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Find the difference between the current inst=
ructions and start/end<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # instructions.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_end =3D abs(instructions - end_commit_ins=
tructions)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_start =3D abs(instructions - start_commit=
_instructions)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If current number of insructions is closer t=
o that of start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # set current commit as term_old.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Else, set current commit as term_new.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if diff_end &gt; diff_start:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bisect_command =3D term_old<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bisect_command =3D term_new<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;{:&lt;20} {}&quot;.format(&quot;In=
structions:&quot;, format(instructions, &quot;,&quot;)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;{:&lt;20} {}&quot;.format(&quot;St=
atus:&quot;, &quot;{} commit&quot;.format(bisect_command)<wbr>))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bisect_output =3D git_bisect(qemu_path, bisect=
_command)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Continue if still bisecting,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # else, print result and break.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not bisect_output.split(&quot; &quot;)[0] =
=3D=3D &quot;Bisecting:&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;\n*****************<=
wbr>BISECT RESULT*****************&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commit_message_start =3D bisect_=
output.find(&quot;commit\n&quot;) + 7<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commit_message_end =3D bisect_ou=
tput.find(&quot;:040000&quot;) - 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(bisect_output[commit_<wbr>=
message_start:commit_message_<wbr>end])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bisect_count +=3D 1<br>
+<br>
+=C2=A0 =C2=A0 # Reset git bisect<br>
+=C2=A0 =C2=A0 git_bisect(qemu_path, &quot;reset&quot;)<br>
+<br>
+=C2=A0 =C2=A0 # Delete temp build directory<br>
+=C2=A0 =C2=A0 shutil.rmtree(qemu_build_path)<br>
+<br>
+<br>
+if __name__ =3D=3D &quot;__main__&quot;:<br>
+=C2=A0 =C2=A0 main()<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--000000000000d0c21805ab43431e--

