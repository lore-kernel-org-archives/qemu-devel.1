Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66227C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 20:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DF2206D7
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 20:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO5CYAwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DF2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzR7B-0003sb-C8
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 16:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jzR6V-0003TS-A6
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 16:49:11 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jzR6S-0003uA-Lx
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 16:49:11 -0400
Received: by mail-lj1-x242.google.com with SMTP id d17so13357168ljl.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rIYKgic6Jpfun3iaGLdG6yWYjQc2CzpCTwdY8cQWRlA=;
 b=jO5CYAwfOZQaD9U19p//vM+VvUhzrnEGQ8pj1/RY2/M/Q08uVG0Eva+/g6uLhtIl2z
 QpG1Og68WiIqMnJPDgLkA/ci6HqNy/EJUb5TN5N152IrAVC+z33ByYBPwNiVLCmwqeW4
 X46SB3IjbJTSGJtVXfyRRy0Rdx/T8RY2qJPqgbdpRUHW9FyhOjxopa3eCNAXtgwAuXef
 v/vqENPTe3rj23f0SexCTRdKHSzS3wvem2+jJHd3apdZVOm3qF8v6ZvwC5m5W5P1lOsM
 D9z3eeWODwhvz2zeCHtnzn00lH1X2G59HoqH+xFtYYItgK45fUXA5him/5odlHVRYkVi
 CrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rIYKgic6Jpfun3iaGLdG6yWYjQc2CzpCTwdY8cQWRlA=;
 b=JaYOhsy++OMKRH1aW6nJY95HPBziP2qyi83yeul7B3psKxA+10/poArlGrQChd3+Nz
 7lOLt81m4rsV+LLtRchThdkELY3iBQr5sALb/EnlG+NdQ6s4MSVaMcQ9los8ebL4F+Xb
 yYxY95nixs2U/UpNwGqAFvxcEQrvE2M5LEak2iBTDbG9ysugjetjoDyUGtj42LC/2XNY
 oOlT6Vzzn3nkF7Atg8KZ95KFahMjsuSKZq4vsf84UkbZT66zxe1qvBfEHuK4n7Twle9J
 Fz2FC7WCpGIPdWt9J3BhRFeGIzcY1Pex0YMcJCjmlLyni84DV1hxHkZ8wM0u/NcENBSq
 XVNw==
X-Gm-Message-State: AOAM530KFs7bDXxoTmt+34K7M3YCs3SmQ2d92bKTFfHjkFPY2Op4ZCRL
 TbXjUUakv0peb/XLvyorx1AwcygL8Dc0YssV7Hs=
X-Google-Smtp-Source: ABdhPJyDtOqeJ+Y7W4i+BxSniQRjKKrdymS37bWjqo349F4vilxl0RYJRz59BJbX+zCsaEzuRd6Cp0bYGRDWkhxct5w=
X-Received: by 2002:a2e:88c3:: with SMTP id a3mr6604056ljk.112.1595710146298; 
 Sat, 25 Jul 2020 13:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200721231536.21604-1-ahmedkhaledkaraman@gmail.com>
 <20200721231536.21604-2-ahmedkhaledkaraman@gmail.com>
 <CAHiYmc4e=8cb4q1Gn5i=Jx=coPQBozXHT=7kK+gKeA=vi16-7g@mail.gmail.com>
 <CALTWKrVXZ82BP1rornpd8-uUtZqCUmGhCw4zb5r4kyxtawJx9g@mail.gmail.com>
 <CAHiYmc5zcg7BkYN_GQdXSN88yd0bu6wyeoJ-Knn0O2K2ptebfg@mail.gmail.com>
In-Reply-To: <CAHiYmc5zcg7BkYN_GQdXSN88yd0bu6wyeoJ-Knn0O2K2ptebfg@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Sat, 25 Jul 2020 22:48:30 +0200
Message-ID: <CALTWKrXHzWHxXcvibohfW7yFfnvXgpSFk2kNvbSTB+GRoNMkmg@mail.gmail.com>
Subject: Re: [PATCH 1/1] scripts/performance: Add bisect.py script
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "jsnow@redhat.com" <jsnow@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 25, 2020 at 9:48 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
>
>
> On Saturday, July 25, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com> =
wrote:
>>
>> On Sat, Jul 25, 2020 at 2:31 PM Aleksandar Markovic <aleksandar.qemu.dev=
el@gmail.com> wrote:
>>>
>>>
>>> Hi, Ahmed.
>>>
>>> Yes, somewhat related to John's hints on these comments, it is customar=
y to have just a brief description before "Copyright" lines. This means one=
 sentence, or a short paragraph (3-4 sentences max). The lenghty syntax com=
memt should be, in my opinion, moved after the license preamble, just befor=
e the start of real Python code.
>>
>>
>> Thanks Mr. John and Aleksandar for your feedback. I will update the scri=
pt accordingly.
>>
>>>
>>>
>>> One question:
>>>
>>> What is the behavior in case of the executable architecture and "target=
" command line option mismatch (for example, one specifies m68k target, but=
 passes hppa executable? Would that be detected before bisect search, or th=
e bisect procedure will be applied even though such cases do not make sense=
?
>>
>>
>> The script will exit with an error of something along the lines of "Inva=
lid ELF image for this architecture".
>> This is done before starting "bisect" and after the initial "configure" =
and "make".
>>
>
> This is good enough (the moment of detection). However, are all cleanups =
done? Is temporary directory deleted?

This is a thing I missed, I will add a clean_up() function to be
called before any exit.

>
> The same questions for the scenario where the user specifies non-existant=
 commit ID as the start or the end commit.
>

The script will exit with a message from "git" saying that this ID
doesn't exist. This will be done during the initial measurements of
the two boundary commits which is also before the bisect process.

> Does the script work if user specifies a tag, instead of commit ID? I thi=
nk it should work. For example, can the user specify v3.1.0 as start commit=
, and v4.2.0 as the end commit, in order to detect degradation/improvement =
between QEMU 3.1 and QEMU 4.2? Please test if such scenario works. If it wo=
rks, I think you should insert "commit ID or tag ID" instead of "commit" on=
ly in the commit massage and applicable code comments (including also the u=
ser-visible help outputed on "-h").

Yes, tags also work. Basically, anything that works with "git bisect"
as "start" and "end" values works with the script.

>
> Lastly, what happens if specified start and end commits are existant, but=
 in the wrong order (end is "before" start)?

The script will also exit with an error before starting the bisect
process. The error would say:
"Some slow revs are not ancestors of the fast rev.
git bisect cannot work properly in this case.
Maybe you mistook slow and fast revs?"


>
> Thanks,
> Aleksandar
>
>
>
>
>>>
>>>
>>> Yours, Aleksandar
>>>
>>>
>>>>
>>>> +#  This program is free software: you can redistribute it and/or modi=
fy
>>>> +#  it under the terms of the GNU General Public License as published =
by
>>>> +#  the Free Software Foundation, either version 2 of the License, or
>>>> +#  (at your option) any later version.
>>>> +#
>>>> +#  This program is distributed in the hope that it will be useful,
>>>> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>>> +#  GNU General Public License for more details.
>>>> +#
>>>> +#  You should have received a copy of the GNU General Public License
>>>> +#  along with this program. If not, see <https://www.gnu.org/licenses=
/>.
>>>> +
>>>> +import argparse
>>>> +import multiprocessing
>>>> +import tempfile
>>>> +import os
>>>> +import shutil
>>>> +import subprocess
>>>> +import sys
>>>> +
>>>> +
>>>> +############################ GIT WRAPPERS ###########################=
#
>>>> +def git_bisect(qemu_path, command, args=3DNone):
>>>> +    """
>>>> +    Wrapper function for running git bisect.
>>>> +
>>>> +    Parameters:
>>>> +    qemu_path (str): QEMU path.
>>>> +    command (str):   bisect command (start|fast|slow|reset).
>>>> +    args (list):     Optional arguments.
>>>> +
>>>> +    Returns:
>>>> +    (str):           git bisect stdout.
>>>> +    """
>>>> +    process =3D ["git", "bisect", command]
>>>> +    if args:
>>>> +        process +=3D args
>>>> +    bisect =3D subprocess.run(process,
>>>> +                            cwd=3Dqemu_path,
>>>> +                            stdout=3Dsubprocess.PIPE,
>>>> +                            stderr=3Dsubprocess.PIPE)
>>>> +    if bisect.returncode:
>>>> +        sys.exit(bisect.stderr.decode("utf-8"))
>>>> +    return bisect.stdout.decode("utf-8")
>>>> +
>>>> +
>>>> +def git_checkout(commit, qemu_path):
>>>> +    """
>>>> +    Wrapper function for checking out a given git commit.
>>>> +
>>>> +    Parameters:
>>>> +    commit (str):    Commit hash of a git commit.
>>>> +    qemu_path (str): QEMU path.
>>>> +    """
>>>> +    checkout_commit =3D subprocess.run(["git",
>>>> +                                      "checkout",
>>>> +                                      commit],
>>>> +                                     cwd=3Dqemu_path,
>>>> +                                     stdout=3Dsubprocess.DEVNULL,
>>>> +                                     stderr=3Dsubprocess.PIPE)
>>>> +    if checkout_commit.returncode:
>>>> +        sys.exit(checkout_commit.stderr.decode("utf-8"))
>>>> +
>>>> +
>>>> +def git_clone(qemu_path):
>>>> +    """
>>>> +    Wrapper function for cloning QEMU git repo from GitHub.
>>>> +
>>>> +    Parameters:
>>>> +    qemu_path (str): Path to clone the QEMU repo to.
>>>> +    """
>>>> +    clone_qemu =3D subprocess.run(["git",
>>>> +                                 "clone",
>>>> +                                 "https://github.com/qemu/qemu.git",
>>>> +                                 qemu_path],
>>>> +                                stderr=3Dsubprocess.STDOUT)
>>>> +    if clone_qemu.returncode:
>>>> +        sys.exit("Failed to clone QEMU!")
>>>> +#####################################################################=
#
>>>> +
>>>> +
>>>> +def check_requirements(tool):
>>>> +    """
>>>> +    Verify that all script requirements are installed (perf|callgrind=
 & git).
>>>> +
>>>> +    Parameters:
>>>> +    tool (str): Tool used for the measurement (perf or callgrind).
>>>> +    """
>>>> +    if tool =3D=3D "perf":
>>>> +        check_perf_installation =3D subprocess.run(["which", "perf"],
>>>> +                                                 stdout=3Dsubprocess.=
DEVNULL)
>>>> +        if check_perf_installation.returncode:
>>>> +            sys.exit("Please install perf before running the script."=
)
>>>> +
>>>> +        # Insure user has previllage to run perf
>>>> +        check_perf_executability =3D subprocess.run(["perf", "stat", =
"ls", "/"],
>>>> +                                                  stdout=3Dsubprocess=
.DEVNULL,
>>>> +                                                  stderr=3Dsubprocess=
.DEVNULL)
>>>> +        if check_perf_executability.returncode:
>>>> +            sys.exit("""
>>>> +        Error:
>>>> +        You may not have permission to collect stats.
>>>> +        Consider tweaking /proc/sys/kernel/perf_event_paranoid,
>>>> +        which controls use of the performance events system by
>>>> +        unprivileged users (without CAP_SYS_ADMIN).
>>>> +        -1: Allow use of (almost) all events by all users
>>>> +            Ignore mlock limit after perf_event_mlock_kb without CAP_=
IPC_LOCK
>>>> +        0: Disallow ftrace function tracepoint by users without CAP_S=
YS_ADMIN
>>>> +            Disallow raw tracepoint access by users without CAP_SYS_A=
DMIN
>>>> +        1: Disallow CPU event access by users without CAP_SYS_ADMIN
>>>> +        2: Disallow kernel profiling by users without CAP_SYS_ADMIN
>>>> +        To make this setting permanent, edit /etc/sysctl.conf too, e.=
g.:
>>>> +        kernel.perf_event_paranoid =3D -1
>>>> +
>>>> +        *Alternatively, you can run this script under sudo privileges=
.
>>>> +        """)
>>>> +    elif tool =3D=3D "callgrind":
>>>> +        check_valgrind_installation =3D subprocess.run(["which", "val=
grind"],
>>>> +                                                     stdout=3Dsubproc=
ess.DEVNULL)
>>>> +        if check_valgrind_installation.returncode:
>>>> +            sys.exit("Please install valgrind before running the scri=
pt.")
>>>> +
>>>> +    # Insure that git is installed
>>>> +    check_git_installation =3D subprocess.run(["which", "git"],
>>>> +                                            stdout=3Dsubprocess.DEVNU=
LL)
>>>> +    if check_git_installation.returncode:
>>>> +        sys.exit("Please install git before running the script.")
>>>> +
>>>> +
>>>> +def make(qemu_build_path):
>>>> +    """
>>>> +    Build QEMU by running the Makefile.
>>>> +
>>>> +    Parameters:
>>>> +    qemu_build_path (str): Path to the build directory with configura=
tion files.
>>>> +    """
>>>> +    run_make =3D subprocess.run(["make",
>>>> +                               "-j",
>>>> +                               str(multiprocessing.cpu_count())],
>>>> +                              cwd=3Dqemu_build_path,
>>>> +                              stdout=3Dsubprocess.DEVNULL,
>>>> +                              stderr=3Dsubprocess.PIPE)
>>>> +    if run_make.returncode:
>>>> +        sys.exit(run_make.stderr.decode("utf-8"))
>>>> +
>>>> +
>>>> +def measure_instructions(tool, qemu_exe_path, command):
>>>> +    """
>>>> +    Measure the number of instructions when running an program with Q=
EMU.
>>>> +
>>>> +    Parameters:
>>>> +    tool (str):          Tool used for the measurement (perf|callgrin=
d).
>>>> +    qemu_exe_path (str): Path to the QEMU executable of the equivalen=
t target.
>>>> +    command (list):      Program path and arguments.
>>>> +
>>>> +    Returns:
>>>> +    (int):               Number of instructions.
>>>> +    """
>>>> +    if tool =3D=3D "perf":
>>>> +        run_perf =3D subprocess.run((["perf",
>>>> +                                    "stat",
>>>> +                                    "-x",
>>>> +                                    " ",
>>>> +                                    "-e",
>>>> +                                    "instructions",
>>>> +                                    qemu_exe_path]
>>>> +                                   + command),
>>>> +                                  stdout=3Dsubprocess.DEVNULL,
>>>> +                                  stderr=3Dsubprocess.PIPE)
>>>> +        if run_perf.returncode:
>>>> +            sys.exit(run_perf.stderr.decode("utf-8"))
>>>> +        else:
>>>> +            perf_output =3D run_perf.stderr.decode("utf-8").split(" "=
)
>>>> +            return int(perf_output[0])
>>>> +
>>>> +    elif tool =3D=3D "callgrind":
>>>> +        with tempfile.NamedTemporaryFile() as tmpfile:
>>>> +            run_callgrind =3D subprocess.run((["valgrind",
>>>> +                                             "--tool=3Dcallgrind",
>>>> +                                             "--callgrind-out-file=3D=
{}".format(
>>>> +                                                 tmpfile.name),
>>>> +                                             qemu_exe_path]
>>>> +                                            + command),
>>>> +                                           stdout=3Dsubprocess.DEVNUL=
L,
>>>> +                                           stderr=3Dsubprocess.PIPE)
>>>> +        if run_callgrind.returncode:
>>>> +            sys.exit(run_callgrind.stderr.decode("utf-8"))
>>>> +        else:
>>>> +            callgrind_output =3D run_callgrind.stderr.decode("utf-8")=
.split("\n")
>>>> +            return int(callgrind_output[8].split(" ")[-1])
>>>> +
>>>> +
>>>> +def main():
>>>> +    # Parse the command line arguments
>>>> +    parser =3D argparse.ArgumentParser(
>>>> +        usage=3D"bisect.py [-h] -s,--start START [-e,--end END] [-q,-=
-qemu QEMU] "
>>>> +        "--target TARGET --tool {perf,callgrind} -- "
>>>> +        "<target executable> [<target executable options>]")
>>>> +
>>>> +    parser.add_argument("-s", "--start", dest=3D"start", type=3Dstr, =
required=3DTrue,
>>>> +                        help=3D"First commit hash in the search range=
")
>>>> +    parser.add_argument("-e", "--end", dest=3D"end", type=3Dstr, defa=
ult=3D"master",
>>>> +                        help=3D"Last commit hash in the search range"=
)
>>>> +    parser.add_argument("-q", "--qemu", dest=3D"qemu", type=3Dstr, de=
fault=3D"",
>>>> +                        help=3D"QEMU path")
>>>> +    parser.add_argument("--target", dest=3D"target", type=3Dstr, requ=
ired=3DTrue,
>>>> +                        help=3D"QEMU target")
>>>> +    parser.add_argument("--tool", dest=3D"tool", choices=3D["perf", "=
callgrind"],
>>>> +                        required=3DTrue, help=3D"Tool used for measur=
ements")
>>>> +
>>>> +    parser.add_argument("command", type=3Dstr, nargs=3D"+", help=3Dar=
gparse.SUPPRESS)
>>>> +
>>>> +    args =3D parser.parse_args()
>>>> +
>>>> +    # Extract the needed variables from the args
>>>> +    start_commit =3D args.start
>>>> +    end_commit =3D args.end
>>>> +    qemu =3D args.qemu
>>>> +    target =3D args.target
>>>> +    tool =3D args.tool
>>>> +    command =3D args.command
>>>> +
>>>> +    # Set QEMU path
>>>> +    if qemu =3D=3D "":
>>>> +        # Create a temp directory for cloning QEMU
>>>> +        tmpdir =3D tempfile.TemporaryDirectory()
>>>> +        qemu_path =3D os.path.join(tmpdir.name, "qemu")
>>>> +
>>>> +        # Clone QEMU into the temporary directory
>>>> +        print("Fetching QEMU: ", end=3D"", flush=3DTrue)
>>>> +        git_clone(qemu_path)
>>>> +        print()
>>>> +    else:
>>>> +        qemu_path =3D qemu
>>>> +
>>>> +    # Create the build directory
>>>> +    qemu_build_path =3D os.path.join(qemu_path, "tmp-build-gcc")
>>>> +    if not os.path.exists(qemu_build_path):
>>>> +        os.mkdir(qemu_build_path)
>>>> +    else:
>>>> +        sys.exit("A build directory with the same name (tmp-build-gcc=
) used in "
>>>> +                 "the script is already in the provided QEMU path.")
>>>> +
>>>> +    qemu_exe_path =3D os.path.join(qemu_build_path,
>>>> +                                 "{}-linux-user".format(target),
>>>> +                                 "qemu-{}".format(target))
>>>> +
>>>> +    # Configure QEMU
>>>> +    configure =3D subprocess.run(["../configure",
>>>> +                                "--target-list=3D{}-linux-user".forma=
t(target)],
>>>> +                               cwd=3Dqemu_build_path,
>>>> +                               stdout=3Dsubprocess.DEVNULL,
>>>> +                               stderr=3Dsubprocess.PIPE)
>>>> +    if configure.returncode:
>>>> +        sys.exit(configure.stderr.decode("utf-8"))
>>>> +
>>>> +    # Do performance measurements for the start commit
>>>> +    git_checkout(start_commit, qemu_path)
>>>> +    make(qemu_build_path)
>>>> +    start_commit_instructions =3D measure_instructions(tool,
>>>> +                                                     qemu_exe_path,
>>>> +                                                     command)
>>>> +    print("{:<30} {}".format("Start Commit Instructions:",
>>>> +                             format(start_commit_instructions, ",")))
>>>> +
>>>> +    # Do performance measurements for the end commit
>>>> +    git_checkout(end_commit, qemu_path)
>>>> +    make(qemu_build_path)
>>>> +    end_commit_instructions =3D measure_instructions(tool,
>>>> +                                                   qemu_exe_path,
>>>> +                                                   command)
>>>> +    print("{:<30} {}".format("End Commit Instructions:",
>>>> +                             format(end_commit_instructions, ",")))
>>>> +
>>>> +    # Calculate performance difference between start and end commits
>>>> +    performance_difference =3D \
>>>> +        (start_commit_instructions - end_commit_instructions) / \
>>>> +        max(end_commit_instructions, start_commit_instructions) * 100
>>>> +    performance_change =3D "+" if performance_difference > 0 else "-"
>>>> +    print("{:<30} {}".format("Performance Change:",
>>>> +                             performance_change +
>>>> +                             str(round(abs(performance_difference), 3=
))+"%"))
>>>> +
>>>> +    # Set the custom terms used for progressing in "git bisect"
>>>> +    term_old =3D "fast" if performance_difference < 0 else "slow"
>>>> +    term_new =3D "slow" if term_old =3D=3D "fast" else "fast"
>>>> +
>>>> +    # Start git bisect
>>>> +    git_bisect(qemu_path, "start", [
>>>> +               "--term-old", term_old, "--term-new", term_new])
>>>> +    # Set start commit state
>>>> +    git_bisect(qemu_path, term_old, [start_commit])
>>>> +    # Set end commit state
>>>> +    bisect_output =3D git_bisect(qemu_path, term_new, [end_commit])
>>>> +    # Print estimated bisect steps
>>>> +    print("\n{:<30} {}\n".format(
>>>> +        "Estimated Number of Steps:", bisect_output.split()[9]))
>>>> +
>>>> +    # Initialize bisect_count to track the number of performed
>>>> +    bisect_count =3D 1
>>>> +
>>>> +    while True:
>>>> +        print("**************BISECT STEP {}**************".format(bis=
ect_count))
>>>> +
>>>> +        make(qemu_build_path)
>>>> +
>>>> +        instructions =3D measure_instructions(tool, qemu_exe_path, co=
mmand)
>>>> +        # Find the difference between the current instructions and st=
art/end
>>>> +        # instructions.
>>>> +        diff_end =3D abs(instructions - end_commit_instructions)
>>>> +        diff_start =3D abs(instructions - start_commit_instructions)
>>>> +
>>>> +        # If current number of insructions is closer to that of start=
,
>>>> +        # set current commit as term_old.
>>>> +        # Else, set current commit as term_new.
>>>> +        if diff_end > diff_start:
>>>> +            bisect_command =3D term_old
>>>> +        else:
>>>> +            bisect_command =3D term_new
>>>> +
>>>> +        print("{:<20} {}".format("Instructions:", format(instructions=
, ",")))
>>>> +        print("{:<20} {}".format("Status:", "{} commit".format(bisect=
_command)))
>>>> +
>>>> +        bisect_output =3D git_bisect(qemu_path, bisect_command)
>>>> +
>>>> +        # Continue if still bisecting,
>>>> +        # else, print result and break.
>>>> +        if not bisect_output.split(" ")[0] =3D=3D "Bisecting:":
>>>> +            print("\n*****************BISECT RESULT*****************"=
)
>>>> +            commit_message_start =3D bisect_output.find("commit\n") +=
 7
>>>> +            commit_message_end =3D bisect_output.find(":040000") - 1
>>>> +            print(bisect_output[commit_message_start:commit_message_e=
nd])
>>>> +            break
>>>> +
>>>> +        bisect_count +=3D 1
>>>> +
>>>> +    # Reset git bisect
>>>> +    git_bisect(qemu_path, "reset")
>>>> +
>>>> +    # Delete temp build directory
>>>> +    shutil.rmtree(qemu_build_path)
>>>> +
>>>> +
>>>> +if __name__ =3D=3D "__main__":
>>>> +    main()
>>>> --
>>>> 2.17.1
>>>>

Best regards,
Ahmed Karaman

