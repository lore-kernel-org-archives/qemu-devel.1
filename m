Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F77C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1E1206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOFhtpaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1E1206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtOnF-0007AR-ST
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 01:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jtOlL-0006RK-8s
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:06:23 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jtOlI-0007du-TI
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:06:22 -0400
Received: by mail-lf1-x144.google.com with SMTP id k17so414587lfg.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 22:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SJ9XKz9K7FpYxN6pR5YcjXOJ3qPChp2Qz90OdLbbd1c=;
 b=fOFhtpaUTfFkg82XXzpV1OX62QOKX0KjzlJTWjOgAp0/tepghpm47mI2JoR/qdcJT1
 4gazfsjyu4FO6lkq7Q5L1vYWaZ8RZtRnj5br1pCULFfO/deOK9M5HENc/yFgulL99SPb
 GVD9O8YOj77VX5JuVDJCPvu9r9DNV/mHKzIFKxgG+73gohV312ciC/XwIFO/kV6NGcl5
 XHdBPqg1Gw4KhWehIVBvZnUpFltK0uMXeRA9YuYj2xv4WHIZzDU+iHjf6GsVNQDrMwXu
 Me94TJVsQXFszhLqfdCHOKXimW5wJ7vPezrqrwpzly/wvVq8CuKxQksTxCXiL2apjERk
 FLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SJ9XKz9K7FpYxN6pR5YcjXOJ3qPChp2Qz90OdLbbd1c=;
 b=Rti/K2OHeL35zb2NKUFjbEOCpVpqW3LA4uXddtlZXAEyOPV5OK58X4XSaW3W2uAcIp
 FodGFajbfnmoLqaAGpfWRFGeXpAgmV8GO1iRigV2wWTsFrCf5HEAmd6xQvJUNbWDHGDI
 X9LYiagX8xz9gsN2gef0DP04y9qScstkP23S++h8eYeX/vgxlXcqcqAXMFQHHzW+FzO3
 7a1ZL5kDgq+PucEe7fgTcDLj7OoZAkld9RmwNNeuKei4MhK9N+bTQdhtIcgwFBLyMCUR
 2avvEHkrfBfK0cR9lXw/CYR+ionyMUaRJjpbSxmsYuJhz+3d2BceF7v92xYJ7+uxvPP4
 JpvQ==
X-Gm-Message-State: AOAM531JUVI8bJK7DhdZqPn7//qmAKuL1d8vIKwyRXb2iTz2Epb82DCv
 t3tT0jhLvD483Wa5wIy9zVvGbJVx6bFPTd/zunY=
X-Google-Smtp-Source: ABdhPJzt5kgsg4ZV9+wiHWVp17S8DNzkH9OeeEgcpe5WZh4CURkGYwajTmQ3fJWJdTQUbOXgUip/ohBPIyzbisVyAts=
X-Received: by 2002:a19:f20a:: with SMTP id q10mr39089995lfh.89.1594271178153; 
 Wed, 08 Jul 2020 22:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200702142942.4887-1-ahmedkhaledkaraman@gmail.com>
 <20200702142942.4887-2-ahmedkhaledkaraman@gmail.com>
 <1d5cb8cc-888a-8d12-739d-e4f162fbbc31@redhat.com>
In-Reply-To: <1d5cb8cc-888a-8d12-739d-e4f162fbbc31@redhat.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Thu, 9 Jul 2020 07:05:42 +0200
Message-ID: <CALTWKrVs6wYccbmmqG3ONL6gZ=OrqVJvEEJr_=7Naoq5sMqTrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] scripts/performance: Add dissect.py script
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x144.google.com
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 5:41 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Hi Ahmed,
>
> On 7/2/20 4:29 PM, Ahmed Karaman wrote:
> > Python script that dissects QEMU execution into three main phases:
> > code generation, JIT execution and helpers execution.
> >
> > Syntax:
> > dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
> >                  <target executable> [<target executable options>]
> >
> > [-h] - Print the script arguments help message.
> >
> > Example of usage:
> > dissect.py -- qemu-arm coulomb_double-arm
> >
> > Example output:
> > Total Instructions:        4,702,865,362
> >
> > Code Generation:             115,819,309       2.463%
> > JIT Execution:             1,081,980,528      23.007%
> > Helpers:                   3,505,065,525      74.530%
> >
> > Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> > ---
> >  scripts/performance/dissect.py | 165 +++++++++++++++++++++++++++++++++
> >  1 file changed, 165 insertions(+)
> >  create mode 100755 scripts/performance/dissect.py
> >
> > diff --git a/scripts/performance/dissect.py b/scripts/performance/disse=
ct.py
> > new file mode 100755
> > index 0000000000..8c2967d082
> > --- /dev/null
> > +++ b/scripts/performance/dissect.py
> > @@ -0,0 +1,165 @@
> > +#!/usr/bin/env python3
> > +
> > +#  Print the percentage of instructions spent in each phase of QEMU
> > +#  execution.
> > +#
> > +#  Syntax:
> > +#  dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
> > +#                   <target executable> [<target executable options>]
> > +#
> > +#  [-h] - Print the script arguments help message.
> > +#
> > +#  Example of usage:
> > +#  dissect.py -- qemu-arm coulomb_double-arm
> > +#
> > +#  This file is a part of the project "TCG Continuous Benchmarking".
> > +#
> > +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> > +#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmai=
l.com>
> > +#
> > +#  This program is free software: you can redistribute it and/or modif=
y
> > +#  it under the terms of the GNU General Public License as published b=
y
> > +#  the Free Software Foundation, either version 2 of the License, or
> > +#  (at your option) any later version.
> > +#
> > +#  This program is distributed in the hope that it will be useful,
> > +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > +#  GNU General Public License for more details.
> > +#
> > +#  You should have received a copy of the GNU General Public License
> > +#  along with this program. If not, see <https://www.gnu.org/licenses/=
>.
> > +
> > +import argparse
> > +import os
> > +import subprocess
> > +import sys
> > +
> > +
> > +def get_JIT_line(callgrind_data):
> > +    """
> > +    Search for the first instance of the JIT call in
> > +    the callgrind_annotate output when ran using --tree=3Dcaller
> > +    This is equivalent to the self number of instructions of JIT.
> > +
> > +    Parameters:
> > +    callgrind_data (list): callgrind_annotate output
> > +
> > +    Returns:
> > +    (int): Line number
> > +   """
>
> Alignment off by 1 ;)

Thanks, didn't notice that!

>
> > +    line =3D -1
> > +    for i in range(len(callgrind_data)):
> > +        if callgrind_data[i].strip('\n') and \
> > +                callgrind_data[i].split()[-1] =3D=3D "[???]":
> > +            line =3D i
> > +            break
> > +    if line =3D=3D -1:
> > +        sys.exit("Couldn't locate the JIT call ... Exiting.")
> > +    return line
> > +
> > +
> > +def main():
> > +    # Parse the command line arguments
> > +    parser =3D argparse.ArgumentParser(
> > +        usage=3D'dissect.py [-h] -- '
> > +        '<qemu executable> [<qemu executable options>] '
> > +        '<target executable> [<target executable options>]')
> > +
> > +    parser.add_argument('command', type=3Dstr, nargs=3D'+', help=3Darg=
parse.SUPPRESS)
> > +
> > +    args =3D parser.parse_args()
> > +
> > +    # Extract the needed variables from the args
> > +    command =3D args.command
> > +
> > +    # Insure that valgrind is installed
> > +    check_valgrind =3D subprocess.run(
> > +        ["which", "valgrind"], stdout=3Dsubprocess.DEVNULL)
> > +    if check_valgrind.returncode:
> > +        sys.exit("Please install valgrind before running the script.")
> > +
> > +    # Run callgrind
> > +    callgrind =3D subprocess.run((["valgrind",
> > +                                 "--tool=3Dcallgrind",
> > +                                 "--callgrind-out-file=3D/tmp/callgrin=
d.data"]
>
> Maybe "/path/to/callgrind.data" in the help?

The user doesn't need to provide this path to the script. Callgrind
output is generated automatically for them.

>
> > +                                + command),
> > +                               stdout=3Dsubprocess.DEVNULL,
> > +                               stderr=3Dsubprocess.PIPE)
> > +    if callgrind.returncode:
> > +        sys.exit(callgrind.stderr.decode("utf-8"))
> > +
> > +    # Save callgrind_annotate output to /tmp/callgrind_annotate.out
>
> 1/ You use these files multiples time, please use a variable for each.
> 2/ This won't work on Windows
> 3/ This bypass the TMPDIR envirnoment variable
>   a/ Darwin sets it to /var/folders/$user/$random/
>   b/ Some users prefer to set TMPDIR on dedicated fast memory support
>
> This is more portable:
>
>   import tempfile
>
>   annotated_path =3D os.path.join(tempfile.gettempdir(),
>                                 "callgrind_annotate.out")
>   data_path =3D os.path.join(tempfile.gettempdir(), "callgrind.data")
>
> Now, apparently both are temporary, so you can use a context manager
> to get a temporary directory, and the context manager will remove it
> when you are done.
>
> Something like:
>
>        with tempfile.TemporaryDirectory() as tmpdirname:
>            annotated_path =3D os.path.join(tmpdirname,
>                                          "callgrind_annotate.out")
>            data_path =3D os.path.join(tmpdirname, "callgrind.data")
>
>            with open(annotated_path, "w") as output:
>                 ....
>
> No need to unlink/rmdir.

This is a very nice trick! Thanks for the suggestion.

>
> > +    with open("/tmp/callgrind_annotate.out", "w") as output:
> > +        callgrind_annotate =3D subprocess.run(
> > +            ["callgrind_annotate", "/tmp/callgrind.data", "--tree=3Dca=
ller"],
> > +            stdout=3Doutput,
> > +            stderr=3Dsubprocess.PIPE)
> > +        if callgrind_annotate.returncode:
> > +            os.unlink('/tmp/callgrind.data')
>
> Maybe display a hint to the user? "Something went wrong. Is
> callgrind_annotate installed?"

callgrind_annotate is already installed by default with Valgrind. An
error happening here might be because of an empty callgrind output.

>
> > +            output.close()
>
> You used a context manager (with open ...) so no need to call close(),
> it will be called when you are done with the context.
>
> > +            os.unlink('/tmp/callgrind_annotate.out')
> > +            sys.exit(callgrind_annotate.stderr.decode("utf-8"))
> > +
> > +    # Read the callgrind_annotate output to callgrind_data[]
> > +    callgrind_data =3D []
> > +    with open('/tmp/callgrind_annotate.out', 'r') as data:
> > +        callgrind_data =3D data.readlines()
>
> Here you didn't call close(), good :)
>
> > +
> > +    # Line number with the total number of instructions
> > +    total_instructions_line_number =3D 20
> > +    # Get the total number of instructions
> > +    total_instructions_line_data =3D \
> > +        callgrind_data[total_instructions_line_number]
> > +    total_instructions =3D total_instructions_line_data.split()[0]
> > +    total_instructions =3D int(total_instructions.replace(',', ''))
> > +
> > +    # Line number with the JIT self number of instructions
> > +    JIT_self_instructions_line_number =3D get_JIT_line(callgrind_data)
> > +    # Get the JIT self number of instructions
> > +    JIT_self_instructions_line_data =3D \
> > +        callgrind_data[JIT_self_instructions_line_number]
> > +    JIT_self_instructions =3D JIT_self_instructions_line_data.split()[=
0]
> > +    JIT_self_instructions =3D int(JIT_self_instructions.replace(',', '=
'))
> > +
> > +    # Line number with the JIT self + inclusive number of instructions
> > +    # It's the line above the first JIT call when running with --tree=
=3Dcaller
> > +    JIT_total_instructions_line_number =3D JIT_self_instructions_line_=
number - 1
> > +    # Get the JIT self + inclusive number of instructions
> > +    JIT_total_instructions_line_data =3D \
> > +        callgrind_data[JIT_total_instructions_line_number]
> > +    JIT_total_instructions =3D JIT_total_instructions_line_data.split(=
)[0]
> > +    JIT_total_instructions =3D int(JIT_total_instructions.replace(',',=
 ''))
> > +
> > +    # Calculate number of instructions in helpers and code generation
> > +    helpers_instructions =3D JIT_total_instructions - JIT_self_instruc=
tions
> > +    code_generation_instructions =3D total_instructions - JIT_total_in=
structions
> > +
> > +    # Print results (Insert commas in large numbers)
> > +    # Print total number of instructions
> > +    print('{:<20}{:>20}\n'.
> > +          format("Total Instructions:",
> > +                 format(total_instructions, ',')))
> > +    # Print code generation instructions and percentage
> > +    print('{:<20}{:>20}\t{:>6.3f}%'.
> > +          format("Code Generation:",
> > +                 format(code_generation_instructions, ","),
> > +                 (code_generation_instructions / total_instructions) *=
 100))
> > +    # Print JIT instructions and percentage
> > +    print('{:<20}{:>20}\t{:>6.3f}%'.
> > +          format("JIT Execution:",
> > +                 format(JIT_self_instructions, ","),
> > +                 (JIT_self_instructions / total_instructions) * 100))
> > +    # Print helpers instructions and percentage
> > +    print('{:<20}{:>20}\t{:>6.3f}%'.
> > +          format("Helpers:",
> > +                 format(helpers_instructions, ","),
> > +                 (helpers_instructions/total_instructions)*100))
> > +
> > +    # Remove intermediate files
> > +    os.unlink('/tmp/callgrind.data')
> > +    os.unlink('/tmp/callgrind_annotate.out')
>
> No need for these unlink if using tempfile.TemporaryDirectory().
>
> Regards,
>
> Phil.
>
> > +
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main()
> >
>

Thanks a lot Mr. Philippe for your feedback. I'll post a v3 with the update=
s.

Best regards,
Ahmed Karaman

