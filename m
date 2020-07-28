Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197D3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F3E20656
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZj4lwY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F3E20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0NDt-0007uJ-0U
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1k0ND5-000791-Lz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:51:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1k0ND2-0004m2-L0
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:51:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id f18so17727044wml.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=LRsZyLoE7q/WE/hyTrFBvlsbQ9NNb/4lej2tNR3tEOI=;
 b=fZj4lwY8ixPiHgWRL79Yvuyr4c1621QNFkNoe4qjin/3rJt7s8knGJMfwbLMaqx/M2
 tD9gko+SRNyW7cFhYkTF2eGE5NGjYSaE9CXOoVxdDv0URWfY187QfgMZTrIeCy12UbSy
 a7jrqoSVNtV7LmA/1glAwjS9UjX6BPIO6MwpEx5baMEgm/+94OuUnjIu3LynxnMgwtPn
 QRZzSHTTrILfxRC91hLwEeYwYMMHGRoY34OZpMFiZ7lTURSgXViE7F4qk3vWiGvmkuKz
 JqFn56fyraMa3SVqNeg+Y6clczUboFgx3TQNl/Noh38Ife1jMp95HGf+XJoyjT9GdCJM
 Cadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=LRsZyLoE7q/WE/hyTrFBvlsbQ9NNb/4lej2tNR3tEOI=;
 b=DHUvirKd54xzT2xr640gzT4wXA1j231kDGN9A2EidBJchYT9vJy+tl+w97M4sPhhQ4
 h+lGcMnezG7/AZnOJ8SIjIXArGVGIGm7Ku4pAwdVv22DOl6gOI5EOZBQysZn6/czBJJI
 +2+itmt/vwK1We2UfhvrqrKObSrHB60lnfsQ8qVq/KAwejQXicNh2hW7eITAgOd4350v
 FjUu+lggcFTQPzMMlo+lspz4L+zaum/5N2jF+ji0zxllYbEogE+FKXnCKjXmKEKXcCnt
 rRylDwsqSJlEOL8mDeFlf2BEHRmNIQC8rH2Mjpk6C3PoXXjjsmxwN7ypf++g1TZX2Huh
 yeVg==
X-Gm-Message-State: AOAM532TVD/dAOF3NbqDNmv6BOUejTDHWosC37Z1f+UI24yfkcInLLYD
 +E7XvhYlZBWDYkoDrpo5EiA2lpYm/TPD13Ljq60=
X-Google-Smtp-Source: ABdhPJyFrxZf56yKaPrWyT4F0pKgqh9oDsjV1kV3wO5ZpYnlg7Ugxtz+RJIYJKSaCHb0bNgsHCGrYs2zXRYvkkPZd6E=
X-Received: by 2002:a1c:c343:: with SMTP id t64mr3782063wmf.168.1595933506903; 
 Tue, 28 Jul 2020 03:51:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:1bca:0:0:0:0:0 with HTTP; Tue, 28 Jul 2020 03:51:46
 -0700 (PDT)
In-Reply-To: <CAHiYmc6=eGwe4YQ7umPiE83FVSOayXf2L2XKJ3hO0MyRQEi+2g@mail.gmail.com>
References: <20200716103921.6605-1-ahmedkhaledkaraman@gmail.com>
 <20200716103921.6605-3-ahmedkhaledkaraman@gmail.com>
 <CAHiYmc7fWTVv7jvF6716nuXzHZ+BrSQS+eQAemoCg=1T2h_9Xw@mail.gmail.com>
 <CAHiYmc6=eGwe4YQ7umPiE83FVSOayXf2L2XKJ3hO0MyRQEi+2g@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 28 Jul 2020 12:51:46 +0200
Message-ID: <CAHiYmc7En9hQ6B13seWW-ip6DiJ2Bz79TY4k33hgGkEoEO7hdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] scripts/performance: Add list_helpers.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c3da4905ab7e39bc"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
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

--000000000000c3da4905ab7e39bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, July 28, 2020, Aleksandar Markovic <
aleksandar.qemu.devel@gmail.com> wrote:

>
>
> On Tuesday, July 28, 2020, Aleksandar Markovic <
> aleksandar.qemu.devel@gmail.com> wrote:
>
>>
>>
>> On Thursday, July 16, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>> wrote:
>>
>>> Python script that prints executed helpers of a QEMU invocation.
>>>
>>>
>> Hi, Ahmed.
>>
>> You outlined the envisioned user workflow regarding this script in your
>> report. As I understand it, it generally goes like this:
>>
>> 1) The user first discovers helpers, and their performance data.
>> 2) The user examines the callees of a particular helper of choice
>> (usually, the most instruction-consuming helper).
>> 3) The user perhaps further examines a callee of a particular callee of
>> the particular helper.
>> 4) The user continues this way until the conclusion can be drawn, or
>> maximal depth is reached.
>>
>> The procedure might be time consuming since each step requires running a=
n
>> emulation of the test program.
>>
>> This makes me think that the faster and easier tool for the user (but, t=
o
>> some, not that great, extent, harder for you) would be improved
>> list_helpers.py (and list_fn_calees.py) that provides list of all callee=
s
>> for all helpers, in the tree form (so, callees of callees, callees of
>> callees of callees, etc.), rather than providing just a list of immediat=
e
>> callees, like it currently does.
>>
>> I think you can provide such functionality relatively easily using
>> recursion. See, let's say:
>>
>> https://realpython.com/python-thinking-recursively/
>>
>>
> For printing trees like this:
>
> foo
> =E2=94=9C=E2=94=80=E2=94=80 bar
> =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 a
> =E2=94=82 =E2=94=94=E2=94=80=E2=94=80 b
> =E2=94=9C=E2=94=80=E2=94=80 baz
> =E2=94=94=E2=94=80=E2=94=80 qux
> =E2=94=94=E2=94=80=E2=94=80 c=E2=8F=8E
> d
>
> you can potentialy use tree-format library:
>
> https://pypi.org/project/tree-format/ .
>
>

Aah, probably you can't - license incompatibility.

However, you can write your own function for tree-like outputing, it is
really not that difficult - and, in that case, you have the full output
control, maybe that is the best approach.

Thanks,
Aleksandar



> Perhaps you can have a switch (let's say, --tree <yes|no>) that specifies
>> whether the script outputs just immediate callee list, or entire callee
>> tree.
>>
>> Thanks,
>> Aleksandar
>>
>>
>>> Syntax:
>>> list_helpers.py [-h] -- \
>>>                <qemu executable> [<qemu executable options>] \
>>>                <target executable> [<target executable options>]
>>>
>>> [-h] - Print the script arguments help message.
>>>
>>> Example of usage:
>>> list_helpers.py -- qemu-mips coulomb_double-mips -n10
>>>
>>> Example output:
>>>  Total number of instructions: 108,933,695
>>>
>>>  Executed QEMU Helpers:
>>>
>>>  No. Ins     Percent  Calls Ins/Call Helper Name             Source Fil=
e
>>>  --- ------- ------- ------ -------- --------------------
>>> ---------------
>>>    1 183,021  0.168%  1,305      140 helper_float_sub_d
>>> <qemu>/target/mips/fpu_helper.c
>>>    2 177,111  0.163%    770      230 helper_float_madd_d
>>>  <qemu>/target/mips/fpu_helper.c
>>>    3 171,537  0.157%  1,014      169 helper_float_mul_d
>>> <qemu>/target/mips/fpu_helper.c
>>>    4 157,298  0.144%  2,443       64 helper_lookup_tb_ptr
>>> <qemu>/accel/tcg/tcg-runtime.c
>>>    5 138,123  0.127%    897      153 helper_float_add_d
>>> <qemu>/target/mips/fpu_helper.c
>>>    6  47,083  0.043%    207      227 helper_float_msub_d
>>>  <qemu>/target/mips/fpu_helper.c
>>>    7  24,062  0.022%    487       49 helper_cmp_d_lt
>>>  <qemu>/target/mips/fpu_helper.c
>>>    8  22,910  0.021%    150      152 helper_float_div_d
>>> <qemu>/target/mips/fpu_helper.c
>>>    9  15,497  0.014%    321       48 helper_cmp_d_eq
>>>  <qemu>/target/mips/fpu_helper.c
>>>   10   9,100  0.008%     52      175 helper_float_trunc_w_d
>>> <qemu>/target/mips/fpu_helper.c
>>>   11   7,059  0.006%     10      705 helper_float_sqrt_d
>>>  <qemu>/target/mips/fpu_helper.c
>>>   12   3,000  0.003%     40       75 helper_cmp_d_ule
>>> <qemu>/target/mips/fpu_helper.c
>>>   13   2,720  0.002%     20      136 helper_float_cvtd_w
>>>  <qemu>/target/mips/fpu_helper.c
>>>   14   2,477  0.002%     27       91 helper_swl
>>> <qemu>/target/mips/op_helper.c
>>>   15   2,000  0.002%     40       50 helper_cmp_d_le
>>>  <qemu>/target/mips/fpu_helper.c
>>>   16   1,800  0.002%     40       45 helper_cmp_d_un
>>>  <qemu>/target/mips/fpu_helper.c
>>>   17   1,164  0.001%     12       97 helper_raise_exception_
>>> <qemu>/target/mips/op_helper.c
>>>   18     720  0.001%     10       72 helper_cmp_d_ult
>>> <qemu>/target/mips/fpu_helper.c
>>>   19     560  0.001%    140        4 helper_cfc1
>>>  <qemu>/target/mips/fpu_helper.c
>>>
>>> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>>> ---
>>>  scripts/performance/list_helpers.py | 207 ++++++++++++++++++++++++++++
>>>  1 file changed, 207 insertions(+)
>>>  create mode 100755 scripts/performance/list_helpers.py
>>>
>>> diff --git a/scripts/performance/list_helpers.py
>>> b/scripts/performance/list_helpers.py
>>> new file mode 100755
>>> index 0000000000..a97c7ed4fe
>>> --- /dev/null
>>> +++ b/scripts/performance/list_helpers.py
>>> @@ -0,0 +1,207 @@
>>> +#!/usr/bin/env python3
>>> +
>>> +#  Print the executed helpers of a QEMU invocation.
>>> +#
>>> +#  Syntax:
>>> +#  list_helpers.py [-h] -- \
>>> +#                 <qemu executable> [<qemu executable options>] \
>>> +#                 <target executable> [<target executable options>]
>>> +#
>>> +#  [-h] - Print the script arguments help message.
>>> +#
>>> +#  Example of usage:
>>> +#  list_helpers.py -- qemu-mips coulomb_double-mips
>>> +#
>>> +#  This file is a part of the project "TCG Continuous Benchmarking".
>>> +#
>>> +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>>> +#  Copyright (C) 2020  Aleksandar Markovic <
>>> aleksandar.qemu.devel@gmail.com>
>>> +#
>>> +#  This program is free software: you can redistribute it and/or modif=
y
>>> +#  it under the terms of the GNU General Public License as published b=
y
>>> +#  the Free Software Foundation, either version 2 of the License, or
>>> +#  (at your option) any later version.
>>> +#
>>> +#  This program is distributed in the hope that it will be useful,
>>> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> +#  GNU General Public License for more details.
>>> +#
>>> +#  You should have received a copy of the GNU General Public License
>>> +#  along with this program. If not, see <https://www.gnu.org/licenses/
>>> >.
>>> +
>>> +import argparse
>>> +import os
>>> +import subprocess
>>> +import sys
>>> +import tempfile
>>> +
>>> +
>>> +def find_JIT_line(callgrind_data):
>>> +    """
>>> +    Search for the line with the JIT call in the callgrind_annotate
>>> +    output when ran using --tre=3Dcalling.
>>> +    All the helpers should be listed after that line.
>>> +
>>> +    Parameters:
>>> +    callgrind_data (list): callgrind_annotate output
>>> +
>>> +    Returns:
>>> +    (int): Line number of JIT call
>>> +    """
>>> +    line =3D -1
>>> +    for i in range(len(callgrind_data)):
>>> +        split_line =3D callgrind_data[i].split()
>>> +        if len(split_line) > 2 and \
>>> +                split_line[1] =3D=3D "*" and \
>>> +                split_line[-1] =3D=3D "[???]":
>>> +            line =3D i
>>> +            break
>>> +    return line
>>> +
>>> +
>>> +def get_helpers(JIT_line, callgrind_data):
>>> +    """
>>> +    Get all helpers data given the line number of the JIT call.
>>> +
>>> +    Parameters:
>>> +    JIT_line (int): Line number of the JIT call
>>> +    callgrind_data (list): callgrind_annotate output
>>> +
>>> +    Returns:
>>> +    (list):[[number_of_instructions(int), helper_name(str),
>>> +             number_of_calls(int), source_file(str)]]
>>> +    """
>>> +    helpers =3D []
>>> +    next_helper =3D JIT_line + 1
>>> +    while (callgrind_data[next_helper] !=3D "\n"):
>>> +        split_line =3D callgrind_data[next_helper].split()
>>> +        number_of_instructions =3D int(split_line[0].replace(",", ""))
>>> +        source_file =3D split_line[2].split(":")[0]
>>> +        callee_name =3D split_line[2].split(":")[1]
>>> +        number_of_calls =3D int(split_line[3][1:-2])
>>> +        helpers.append([number_of_instructions, callee_name,
>>> +                        number_of_calls, source_file])
>>> +        next_helper +=3D 1
>>> +    return sorted(helpers, reverse=3DTrue)
>>> +
>>> +
>>> +def main():
>>> +    # Parse the command line arguments
>>> +    parser =3D argparse.ArgumentParser(
>>> +        usage=3D"list_helpers.py [-h] -- "
>>> +        "<qemu executable> [<qemu executable options>] "
>>> +        "<target executable> [<target executable options>]")
>>> +
>>> +    parser.add_argument("command", type=3Dstr, nargs=3D"+",
>>> help=3Dargparse.SUPPRESS)
>>> +
>>> +    args =3D parser.parse_args()
>>> +
>>> +    # Extract the needed variables from the args
>>> +    command =3D args.command
>>> +
>>> +    # Insure that valgrind is installed
>>> +    check_valgrind =3D subprocess.run(
>>> +        ["which", "valgrind"], stdout=3Dsubprocess.DEVNULL)
>>> +    if check_valgrind.returncode:
>>> +        sys.exit("Please install valgrind before running the script.")
>>> +
>>> +    # Save all intermediate files in a temporary directory
>>> +    with tempfile.TemporaryDirectory() as tmpdirname:
>>> +        # callgrind output file path
>>> +        data_path =3D os.path.join(tmpdirname, "callgrind.data")
>>> +        # callgrind_annotate output file path
>>> +        annotate_out_path =3D os.path.join(tmpdirname,
>>> "callgrind_annotate.out")
>>> +
>>> +        # Run callgrind
>>> +        callgrind =3D subprocess.run((["valgrind",
>>> +                                     "--tool=3Dcallgrind",
>>> +                                     "--callgrind-out-file=3D" +
>>> data_path]
>>> +                                    + command),
>>> +                                   stdout=3Dsubprocess.DEVNULL,
>>> +                                   stderr=3Dsubprocess.PIPE)
>>> +        if callgrind.returncode:
>>> +            sys.exit(callgrind.stderr.decode("utf-8"))
>>> +
>>> +        # Save callgrind_annotate output
>>> +        with open(annotate_out_path, "w") as output:
>>> +            callgrind_annotate =3D subprocess.run(
>>> +                ["callgrind_annotate", data_path,
>>> +                    "--threshold=3D100", "--tree=3Dcalling"],
>>> +                stdout=3Doutput,
>>> +                stderr=3Dsubprocess.PIPE)
>>> +            if callgrind_annotate.returncode:
>>> +                sys.exit(callgrind_annotate.stderr.decode("utf-8"))
>>> +
>>> +        # Read the callgrind_annotate output to callgrind_data[]
>>> +        callgrind_data =3D []
>>> +        with open(annotate_out_path, "r") as data:
>>> +            callgrind_data =3D data.readlines()
>>> +
>>> +        # Line number with the total number of instructions
>>> +        total_instructions_line_number =3D 20
>>> +        # Get the total number of instructions
>>> +        total_instructions_line_data =3D \
>>> +            callgrind_data[total_instructions_line_number]
>>> +        total_instructions =3D total_instructions_line_data.split()[0]
>>> +
>>> +        print("Total number of instructions:
>>> {}\n".format(total_instructions))
>>> +
>>> +        # Remove commas and convert to int
>>> +        total_instructions =3D int(total_instructions.replace(",", "")=
)
>>> +
>>> +        # Line number with the JIT call
>>> +        JIT_line =3D find_JIT_line(callgrind_data)
>>> +        if JIT_line =3D=3D -1:
>>> +            sys.exit("Couldn't locate the JIT call ... Exiting")
>>> +
>>> +        # Get helpers
>>> +        helpers =3D get_helpers(JIT_line, callgrind_data)
>>> +
>>> +        print("Executed QEMU Helpers:\n")
>>> +
>>> +        # Print table header
>>> +        print("{:>4}  {:>15}  {:>10}  {:>15}  {:>10}  {:<25}  {}".
>>> +              format(
>>> +                  "No.",
>>> +                  "Instructions",
>>> +                  "Percentage",
>>> +                  "Calls",
>>> +                  "Ins/Call",
>>> +                  "Helper Name",
>>> +                  "Source File")
>>> +              )
>>> +
>>> +        print("{:>4}  {:>15}  {:>10}  {:>15}  {:>10}  {:<25}  {}".
>>> +              format(
>>> +                  "-" * 4,
>>> +                  "-" * 15,
>>> +                  "-" * 10,
>>> +                  "-" * 15,
>>> +                  "-" * 10,
>>> +                  "-" * 25,
>>> +                  "-" * 30)
>>> +              )
>>> +
>>> +        for (index, callee) in enumerate(helpers, start=3D1):
>>> +            instructions =3D callee[0]
>>> +            percentage =3D (callee[0] / total_instructions) * 100
>>> +            calls =3D callee[2]
>>> +            instruction_per_call =3D int(callee[0] / callee[2])
>>> +            helper_name =3D callee[1]
>>> +            source_file =3D callee[3]
>>> +            # Print extracted data
>>> +            print("{:>4}  {:>15}  {:>9.3f}%  {:>15}  {:>10}  {:<25}
>>> {}".
>>> +                  format(
>>> +                      index,
>>> +                      format(instructions, ","),
>>> +                      round(percentage, 3),
>>> +                      format(calls, ","),
>>> +                      format(instruction_per_call, ","),
>>> +                      helper_name,
>>> +                      source_file)
>>> +                  )
>>> +
>>> +
>>> +if __name__ =3D=3D "__main__":
>>> +    main()
>>> --
>>> 2.17.1
>>>
>>>

--000000000000c3da4905ab7e39bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, July 28, 2020, Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt; =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><br><br>On Tuesday, July 28, 2020,=
 Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com"=
 target=3D"_blank">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt; wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex"><br><br>On Thursday, July 16, 2020, Ahmed Kar=
aman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com" target=3D"_blank">=
ahmedkhaledkaraman@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Python script that prints executed helpers of a QEMU invocation.<br>
<br></blockquote><div><br></div><div>Hi, Ahmed.</div><div><br></div><div>Yo=
u outlined the envisioned user workflow regarding this script in your repor=
t. As I understand it, it generally goes like this:</div><div><br></div><di=
v>1) The user first discovers helpers, and their performance data.</div><di=
v>2) The user examines the callees of a particular helper of choice (usuall=
y, the most instruction-consuming helper).</div><div>3) The user perhaps fu=
rther examines a callee of a particular callee of the particular helper.</d=
iv><div>4) The user continues this way until the conclusion can be drawn, o=
r maximal depth is reached.</div><div><br></div><div>The procedure might be=
 time consuming since each step requires running an emulation of the test p=
rogram.</div><div><br></div><div>This makes me think that the faster and ea=
sier tool for the user (but, to some, not that great, extent, harder for yo=
u) would be improved list_helpers.py (and list_fn_calees.py) that provides =
list of all callees for all helpers, in the tree form (so, callees of calle=
es, callees of callees of callees, etc.),=C2=A0rather than providing just a=
 list of immediate callees, like it currently does.</div><div><br></div><di=
v>I think you can provide such functionality relatively easily using recurs=
ion. See, let&#39;s say:</div><div><br></div><div><a href=3D"https://realpy=
thon.com/python-thinking-recursively/" target=3D"_blank">https://realpython=
.com/python-<wbr>thinking-recursively/</a><br></div><div><br></div></blockq=
uote><div><br></div><div>For printing trees like this:</div><div><br></div>=
<div><span style=3D"color:rgb(70,70,70);font-family:&#39;Source Sans Pro&#3=
9;,Helvetica,Arial,sans-serif;font-size:15.1999998092651px;line-height:22.7=
999992370605px;background-color:rgb(253,253,253)">foo</span><br style=3D"co=
lor:rgb(70,70,70);font-family:&#39;Source Sans Pro&#39;,Helvetica,Arial,san=
s-serif;font-size:15.1999998092651px;line-height:22.7999992370605px;backgro=
und-color:rgb(253,253,253)"><span style=3D"color:rgb(70,70,70);font-family:=
&#39;Source Sans Pro&#39;,Helvetica,Arial,sans-serif;font-size:15.199999809=
2651px;line-height:22.7999992370605px;background-color:rgb(253,253,253)">=
=E2=94=9C=E2=94=80=E2=94=80 bar</span><br style=3D"color:rgb(70,70,70);font=
-family:&#39;Source Sans Pro&#39;,Helvetica,Arial,sans-serif;font-size:15.1=
999998092651px;line-height:22.7999992370605px;background-color:rgb(253,253,=
253)"><span style=3D"color:rgb(70,70,70);font-family:&#39;Source Sans Pro&#=
39;,Helvetica,Arial,sans-serif;font-size:15.1999998092651px;line-height:22.=
7999992370605px;background-color:rgb(253,253,253)">=E2=94=82 =E2=94=9C=E2=
=94=80=E2=94=80 a</span><br style=3D"color:rgb(70,70,70);font-family:&#39;S=
ource Sans Pro&#39;,Helvetica,Arial,sans-serif;font-size:15.1999998092651px=
;line-height:22.7999992370605px;background-color:rgb(253,253,253)"><span st=
yle=3D"color:rgb(70,70,70);font-family:&#39;Source Sans Pro&#39;,Helvetica,=
Arial,sans-serif;font-size:15.1999998092651px;line-height:22.7999992370605p=
x;background-color:rgb(253,253,253)">=E2=94=82 =E2=94=94=E2=94=80=E2=94=80 =
b</span><br style=3D"color:rgb(70,70,70);font-family:&#39;Source Sans Pro&#=
39;,Helvetica,Arial,sans-serif;font-size:15.1999998092651px;line-height:22.=
7999992370605px;background-color:rgb(253,253,253)"><span style=3D"color:rgb=
(70,70,70);font-family:&#39;Source Sans Pro&#39;,Helvetica,Arial,sans-serif=
;font-size:15.1999998092651px;line-height:22.7999992370605px;background-col=
or:rgb(253,253,253)">=E2=94=9C=E2=94=80=E2=94=80 baz</span><br style=3D"col=
or:rgb(70,70,70);font-family:&#39;Source Sans Pro&#39;,Helvetica,Arial,sans=
-serif;font-size:15.1999998092651px;line-height:22.7999992370605px;backgrou=
nd-color:rgb(253,253,253)"><span style=3D"color:rgb(70,70,70);font-family:&=
#39;Source Sans Pro&#39;,Helvetica,Arial,sans-serif;font-size:15.1999998092=
651px;line-height:22.7999992370605px;background-color:rgb(253,253,253)">=E2=
=94=94=E2=94=80=E2=94=80 qux</span><br style=3D"color:rgb(70,70,70);font-fa=
mily:&#39;Source Sans Pro&#39;,Helvetica,Arial,sans-serif;font-size:15.1999=
998092651px;line-height:22.7999992370605px;background-color:rgb(253,253,253=
)"><span style=3D"color:rgb(70,70,70);font-family:&#39;Source Sans Pro&#39;=
,Helvetica,Arial,sans-serif;font-size:15.1999998092651px;line-height:22.799=
9992370605px;background-color:rgb(253,253,253)">=E2=94=94=E2=94=80=E2=94=80=
 c=E2=8F=8E</span><br style=3D"color:rgb(70,70,70);font-family:&#39;Source =
Sans Pro&#39;,Helvetica,Arial,sans-serif;font-size:15.1999998092651px;line-=
height:22.7999992370605px;background-color:rgb(253,253,253)"><span style=3D=
"color:rgb(70,70,70);font-family:&#39;Source Sans Pro&#39;,Helvetica,Arial,=
sans-serif;font-size:15.1999998092651px;line-height:22.7999992370605px;back=
ground-color:rgb(253,253,253)">d</span><br></div><div><span style=3D"color:=
rgb(70,70,70);font-family:&#39;Source Sans Pro&#39;,Helvetica,Arial,sans-se=
rif;font-size:15.1999998092651px;line-height:22.7999992370605px;background-=
color:rgb(253,253,253)"><br></span></div><div><span style=3D"color:rgb(70,7=
0,70);font-family:&#39;Source Sans Pro&#39;,Helvetica,Arial,sans-serif;font=
-size:15.1999998092651px;line-height:22.7999992370605px;background-color:rg=
b(253,253,253)">you can potentialy use tree-format library:</span></div><di=
v><span style=3D"color:rgb(70,70,70);font-family:&#39;Source Sans Pro&#39;,=
Helvetica,Arial,sans-serif;font-size:15.1999998092651px;line-height:22.7999=
992370605px;background-color:rgb(253,253,253)"><br></span></div><div><font =
color=3D"#464646" face=3D"Source Sans Pro, Helvetica, Arial, sans-serif"><s=
pan style=3D"font-size:15.1999998092651px;line-height:22.7999992370605px"><=
a href=3D"https://pypi.org/project/tree-format/" target=3D"_blank">https://=
pypi.org/project/tree-<wbr>format/</a> .</span></font><br></div><div>=C2=A0=
</div></blockquote><div><br></div><div>Aah, probably you can&#39;t - licens=
e incompatibility.</div><div><br></div><div>However, you can write your own=
 function for tree-like outputing, it is really not that difficult - and, i=
n that case, you have the full output control, maybe that is the best appro=
ach.</div><div><br></div><div>Thanks,</div><div>Aleksandar</div><div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div>Perhaps you can have a switch (let&#39;s say, --tree &lt;yes|n=
o&gt;) that specifies whether the script outputs just immediate callee list=
, or entire callee tree.</div><div><br></div><div>Thanks,</div><div>Aleksan=
dar</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Syntax:<br>
list_helpers.py [-h] -- \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;qemu executable&=
gt; [&lt;qemu executable options&gt;] \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;target executabl=
e&gt; [&lt;target executable options&gt;]<br>
<br>
[-h] - Print the script arguments help message.<br>
<br>
Example of usage:<br>
list_helpers.py -- qemu-mips coulomb_double-mips -n10<br>
<br>
Example output:<br>
=C2=A0Total number of instructions: 108,933,695<br>
<br>
=C2=A0Executed QEMU Helpers:<br>
<br>
=C2=A0No. Ins=C2=A0 =C2=A0 =C2=A0Percent=C2=A0 Calls Ins/Call Helper Name=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Source File<br>
=C2=A0--- ------- ------- ------ -------- --------------------=C2=A0 =C2=A0=
 ---------------<br>
=C2=A0 =C2=A01 183,021=C2=A0 0.168%=C2=A0 1,305=C2=A0 =C2=A0 =C2=A0 140 hel=
per_float_sub_d=C2=A0 =C2=A0 =C2=A0 &lt;qemu&gt;/target/mips/fpu_helper.<wb=
r>c<br>
=C2=A0 =C2=A02 177,111=C2=A0 0.163%=C2=A0 =C2=A0 770=C2=A0 =C2=A0 =C2=A0 23=
0 helper_float_madd_d=C2=A0 =C2=A0 =C2=A0&lt;qemu&gt;/target/mips/fpu_helpe=
r<wbr>.c<br>
=C2=A0 =C2=A03 171,537=C2=A0 0.157%=C2=A0 1,014=C2=A0 =C2=A0 =C2=A0 169 hel=
per_float_mul_d=C2=A0 =C2=A0 =C2=A0 &lt;qemu&gt;/target/mips/fpu_helper.<wb=
r>c<br>
=C2=A0 =C2=A04 157,298=C2=A0 0.144%=C2=A0 2,443=C2=A0 =C2=A0 =C2=A0 =C2=A06=
4 helper_lookup_tb_ptr=C2=A0 =C2=A0 &lt;qemu&gt;/accel/tcg/tcg-runtime.c<br=
>
=C2=A0 =C2=A05 138,123=C2=A0 0.127%=C2=A0 =C2=A0 897=C2=A0 =C2=A0 =C2=A0 15=
3 helper_float_add_d=C2=A0 =C2=A0 =C2=A0 &lt;qemu&gt;/target/mips/fpu_helpe=
r.<wbr>c<br>
=C2=A0 =C2=A06=C2=A0 47,083=C2=A0 0.043%=C2=A0 =C2=A0 207=C2=A0 =C2=A0 =C2=
=A0 227 helper_float_msub_d=C2=A0 =C2=A0 =C2=A0&lt;qemu&gt;/target/mips/fpu=
_helper<wbr>.c<br>
=C2=A0 =C2=A07=C2=A0 24,062=C2=A0 0.022%=C2=A0 =C2=A0 487=C2=A0 =C2=A0 =C2=
=A0 =C2=A049 helper_cmp_d_lt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;qemu&gt;/=
target/mips/fpu_helper<wbr>.c<br>
=C2=A0 =C2=A08=C2=A0 22,910=C2=A0 0.021%=C2=A0 =C2=A0 150=C2=A0 =C2=A0 =C2=
=A0 152 helper_float_div_d=C2=A0 =C2=A0 =C2=A0 &lt;qemu&gt;/target/mips/fpu=
_helper.<wbr>c<br>
=C2=A0 =C2=A09=C2=A0 15,497=C2=A0 0.014%=C2=A0 =C2=A0 321=C2=A0 =C2=A0 =C2=
=A0 =C2=A048 helper_cmp_d_eq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;qemu&gt;/=
target/mips/fpu_helper<wbr>.c<br>
=C2=A0 10=C2=A0 =C2=A09,100=C2=A0 0.008%=C2=A0 =C2=A0 =C2=A052=C2=A0 =C2=A0=
 =C2=A0 175 helper_float_trunc_w_d=C2=A0 &lt;qemu&gt;/target/mips/fpu_helpe=
r.<wbr>c<br>
=C2=A0 11=C2=A0 =C2=A07,059=C2=A0 0.006%=C2=A0 =C2=A0 =C2=A010=C2=A0 =C2=A0=
 =C2=A0 705 helper_float_sqrt_d=C2=A0 =C2=A0 =C2=A0&lt;qemu&gt;/target/mips=
/fpu_helper<wbr>.c<br>
=C2=A0 12=C2=A0 =C2=A03,000=C2=A0 0.003%=C2=A0 =C2=A0 =C2=A040=C2=A0 =C2=A0=
 =C2=A0 =C2=A075 helper_cmp_d_ule=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;qemu&gt;/t=
arget/mips/fpu_helper.<wbr>c<br>
=C2=A0 13=C2=A0 =C2=A02,720=C2=A0 0.002%=C2=A0 =C2=A0 =C2=A020=C2=A0 =C2=A0=
 =C2=A0 136 helper_float_cvtd_w=C2=A0 =C2=A0 =C2=A0&lt;qemu&gt;/target/mips=
/fpu_helper<wbr>.c<br>
=C2=A0 14=C2=A0 =C2=A02,477=C2=A0 0.002%=C2=A0 =C2=A0 =C2=A027=C2=A0 =C2=A0=
 =C2=A0 =C2=A091 helper_swl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &lt;qemu&gt;/target/mips/op_helper.c<br>
=C2=A0 15=C2=A0 =C2=A02,000=C2=A0 0.002%=C2=A0 =C2=A0 =C2=A040=C2=A0 =C2=A0=
 =C2=A0 =C2=A050 helper_cmp_d_le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;qemu&=
gt;/target/mips/fpu_helper<wbr>.c<br>
=C2=A0 16=C2=A0 =C2=A01,800=C2=A0 0.002%=C2=A0 =C2=A0 =C2=A040=C2=A0 =C2=A0=
 =C2=A0 =C2=A045 helper_cmp_d_un=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;qemu&=
gt;/target/mips/fpu_helper<wbr>.c<br>
=C2=A0 17=C2=A0 =C2=A01,164=C2=A0 0.001%=C2=A0 =C2=A0 =C2=A012=C2=A0 =C2=A0=
 =C2=A0 =C2=A097 helper_raise_exception_ &lt;qemu&gt;/target/mips/op_helper=
.c<br>
=C2=A0 18=C2=A0 =C2=A0 =C2=A0720=C2=A0 0.001%=C2=A0 =C2=A0 =C2=A010=C2=A0 =
=C2=A0 =C2=A0 =C2=A072 helper_cmp_d_ult=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;qemu=
&gt;/target/mips/fpu_helper.<wbr>c<br>
=C2=A0 19=C2=A0 =C2=A0 =C2=A0560=C2=A0 0.001%=C2=A0 =C2=A0 140=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 4 helper_cfc1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;qemu&gt;/target/mips/fpu_helper<wbr>.c<br>
<br>
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---<br>
=C2=A0scripts/performance/list_help<wbr>ers.py | 207 ++++++++++++++++++++++=
++++++<br>
=C2=A01 file changed, 207 insertions(+)<br>
=C2=A0create mode 100755 scripts/performance/list_helpe<wbr>rs.py<br>
<br>
diff --git a/scripts/performance/list_hel<wbr>pers.py b/scripts/performance=
/list_hel<wbr>pers.py<br>
new file mode 100755<br>
index 0000000000..a97c7ed4fe<br>
--- /dev/null<br>
+++ b/scripts/performance/list_hel<wbr>pers.py<br>
@@ -0,0 +1,207 @@<br>
+#!/usr/bin/env python3<br>
+<br>
+#=C2=A0 Print the executed helpers of a QEMU invocation.<br>
+#<br>
+#=C2=A0 Syntax:<br>
+#=C2=A0 list_helpers.py [-h] -- \<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;qemu ex=
ecutable&gt; [&lt;qemu executable options&gt;] \<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;target =
executable&gt; [&lt;target executable options&gt;]<br>
+#<br>
+#=C2=A0 [-h] - Print the script arguments help message.<br>
+#<br>
+#=C2=A0 Example of usage:<br>
+#=C2=A0 list_helpers.py -- qemu-mips coulomb_double-mips<br>
+#<br>
+#=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmarki=
ng&quot;.<br>
+#<br>
+#=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahmed=
khaledkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a>=
&gt;<br>
+#=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailto=
:aleksandar.qemu.devel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@g=
mail.c<wbr>om</a>&gt;<br>
+#<br>
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
+import os<br>
+import subprocess<br>
+import sys<br>
+import tempfile<br>
+<br>
+<br>
+def find_JIT_line(callgrind_data):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Search for the line with the JIT call in the callgrind_annot=
ate<br>
+=C2=A0 =C2=A0 output when ran using --tre=3Dcalling.<br>
+=C2=A0 =C2=A0 All the helpers should be listed after that line.<br>
+<br>
+=C2=A0 =C2=A0 Parameters:<br>
+=C2=A0 =C2=A0 callgrind_data (list): callgrind_annotate output<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 (int): Line number of JIT call<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 line =3D -1<br>
+=C2=A0 =C2=A0 for i in range(len(callgrind_data)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 split_line =3D callgrind_data[i].split()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(split_line) &gt; 2 and \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 split_line[1] =3D=
=3D &quot;*&quot; and \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 split_line[-1] =3D=
=3D &quot;[???]&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D i<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
+=C2=A0 =C2=A0 return line<br>
+<br>
+<br>
+def get_helpers(JIT_line, callgrind_data):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Get all helpers data given the line number of the JIT call.<=
br>
+<br>
+=C2=A0 =C2=A0 Parameters:<br>
+=C2=A0 =C2=A0 JIT_line (int): Line number of the JIT call<br>
+=C2=A0 =C2=A0 callgrind_data (list): callgrind_annotate output<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 (list):[[number_of_instruction<wbr>s(int), helper_name(str),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0number_of_calls(int), sour=
ce_file(str)]]<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 helpers =3D []<br>
+=C2=A0 =C2=A0 next_helper =3D JIT_line + 1<br>
+=C2=A0 =C2=A0 while (callgrind_data[next_helper] !=3D &quot;\n&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 split_line =3D callgrind_data[next_helper].sp<=
wbr>lit()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 number_of_instructions =3D int(split_line[0].r=
eplace(&quot;,&quot;, &quot;&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 source_file =3D split_line[2].split(&quot;:&qu=
ot;)[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 callee_name =3D split_line[2].split(&quot;:&qu=
ot;)[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 number_of_calls =3D int(split_line[3][1:-2])<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 helpers.append([number_of_inst<wbr>ructions, c=
allee_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 number_of_calls, source_file])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 next_helper +=3D 1<br>
+=C2=A0 =C2=A0 return sorted(helpers, reverse=3DTrue)<br>
+<br>
+<br>
+def main():<br>
+=C2=A0 =C2=A0 # Parse the command line arguments<br>
+=C2=A0 =C2=A0 parser =3D argparse.ArgumentParser(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 usage=3D&quot;list_helpers.py [-h] -- &quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&lt;qemu executable&gt; [&lt;qemu execut=
able options&gt;] &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&lt;target executable&gt; [&lt;target ex=
ecutable options&gt;]&quot;)<br>
+<br>
+=C2=A0 =C2=A0 parser.add_argument(&quot;command&quot;, type=3Dstr, nargs=
=3D&quot;+&quot;, help=3Dargparse.SUPPRESS)<br>
+<br>
+=C2=A0 =C2=A0 args =3D parser.parse_args()<br>
+<br>
+=C2=A0 =C2=A0 # Extract the needed variables from the args<br>
+=C2=A0 =C2=A0 command =3D args.command<br>
+<br>
+=C2=A0 =C2=A0 # Insure that valgrind is installed<br>
+=C2=A0 =C2=A0 check_valgrind =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;which&quot;, &quot;valgrind&quot;], std=
out=3Dsubprocess.DEVNULL)<br>
+=C2=A0 =C2=A0 if check_valgrind.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(&quot;Please install valgrind before =
running the script.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 # Save all intermediate files in a temporary directory<br>
+=C2=A0 =C2=A0 with tempfile.TemporaryDirectory() as tmpdirname:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # callgrind output file path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_path =3D os.path.join(tmpdirname, &quot;c=
allgrind.data&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # callgrind_annotate output file path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 annotate_out_path =3D os.path.join(tmpdirname,=
 &quot;callgrind_annotate.out&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run callgrind<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind =3D subprocess.run(([&quot;valgrind&=
quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--tool=3Dc=
allgrind&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--callgrin=
d-out-file=3D&quot; + data_path]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + command),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.DEV=
NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stderr=3Dsubprocess.PIP=
E)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if callgrind.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(callgrind.stderr.deco<w=
br>de(&quot;utf-8&quot;))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Save callgrind_annotate output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(annotate_out_path, &quot;w&quot;) as=
 output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_annotate =3D subproces=
s.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;callgrind_a=
nnotate&quot;, data_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;--threshold=3D100&quot;, &quot;--tree=3Dcalling&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Doutput,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubproces=
s.PIPE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if callgrind_annotate.returncode=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(<a href=
=3D"http://callgrind_annotate.st" target=3D"_blank">callgrind_annotate.st</=
a><wbr>derr.decode(&quot;utf-8&quot;))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Read the callgrind_annotate output to callgr=
ind_data[]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(annotate_out_path, &quot;r&quot;) as=
 data:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data =3D data.readline=
s()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Line number with the total number of instruc=
tions<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 total_instructions_line_number =3D 20<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Get the total number of instructions<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 total_instructions_line_data =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data[total_instructi<w=
br>ons_line_number]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 total_instructions =3D total_instructions_line=
_data.s<wbr>plit()[0]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Total number of instructions: {}\n=
&quot;.format(total_instruction<wbr>s))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Remove commas and convert to int<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 total_instructions =3D int(total_instructions.=
replace<wbr>(&quot;,&quot;, &quot;&quot;))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Line number with the JIT call<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 JIT_line =3D find_JIT_line(callgrind_data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if JIT_line =3D=3D -1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(&quot;Couldn&#39;t loca=
te the JIT call ... Exiting&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Get helpers<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 helpers =3D get_helpers(JIT_line, callgrind_da=
ta)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Executed QEMU Helpers:\n&quot;)<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Print table header<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;{:&gt;4}=C2=A0 {:&gt;15}=C2=A0 {:&=
gt;10}=C2=A0 {:&gt;15}=C2=A0 {:&gt;10}=C2=A0 {:&lt;25}=C2=A0 {}&quot;.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;No.&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Instr=
uctions&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Perce=
ntage&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Calls=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Ins/C=
all&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Helpe=
r Name&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Sourc=
e File&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;{:&gt;4}=C2=A0 {:&gt;15}=C2=A0 {:&=
gt;10}=C2=A0 {:&gt;15}=C2=A0 {:&gt;10}=C2=A0 {:&lt;25}=C2=A0 {}&quot;.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-&quo=
t; * 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-&quo=
t; * 15,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-&quo=
t; * 10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-&quo=
t; * 15,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-&quo=
t; * 10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-&quo=
t; * 25,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-&quo=
t; * 30)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (index, callee) in enumerate(helpers, star=
t=3D1):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 instructions =3D callee[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 percentage =3D (callee[0] / tota=
l_instructions) * 100<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 calls =3D callee[2]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 instruction_per_call =3D int(cal=
lee[0] / callee[2])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_name =3D callee[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 source_file =3D callee[3]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Print extracted data<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;{:&gt;4}=C2=A0 {:&gt=
;15}=C2=A0 {:&gt;9.3f}%=C2=A0 {:&gt;15}=C2=A0 {:&gt;10}=C2=A0 {:&lt;25}=C2=
=A0 {}&quot;.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 format(instructions, &quot;,&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 round(percentage, 3),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 format(calls, &quot;,&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 format(instruction_per_call, &quot;,&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 helper_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 source_file)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+<br>
+if __name__ =3D=3D &quot;__main__&quot;:<br>
+=C2=A0 =C2=A0 main()<br>
-- <br>
2.17.1<br>
<br>
</blockquote>
</blockquote>
</blockquote>

--000000000000c3da4905ab7e39bc--

