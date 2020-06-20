Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08483C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 10:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD3023AF8
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 10:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rA0lQb1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD3023AF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmaMa-0005xZ-2E
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 06:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmaLo-0005XL-QY
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 06:03:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmaLm-0005Mn-HU
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 06:03:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so10566477wmj.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 03:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=SK2X9+1bH20QzGa33xTxDbaVIoN/XcEngdoMStCaKaE=;
 b=rA0lQb1OCDcUN1mepRQlDW8Uf4YoY9QKtYsZsKruKsFvn1yYAeJD11T4AMybchsuOF
 423oTz36gEyeEbySD/XLRBTGqrx6LqdLgI1WjMS9H3n7dQtKA4uz8COmh33Ehe8xEEqW
 p6EEI8kgxZHLD6JKWJNBRGFhwo4ansqs+Kb78VwER31tGxAy3J2XCCiC6Pabl6b7afFj
 sWs3ZDVUjjQZHMrKSchrB4a/SvWFSYUh4/63/CW3m3XcgBhvoMF9SdK7ARTngvyAbM51
 saMSiEJmUHDC+H0o9GB442XNnqQH0+9ew9QCIVbN0QnPEuzK/mbYmMIk9c0GIEG3Sst1
 69cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=SK2X9+1bH20QzGa33xTxDbaVIoN/XcEngdoMStCaKaE=;
 b=HPou4EKzBGL1CS9V/srkeWgBDRw895dqmhkcVXuVM7nhmCbfDdxC7+2K7QvAgF9BQ3
 YpKrykex7GU3ZRpMf5iL1fRSVT5VDFEow2kuyTuJ2s751kRRBClfOcnN9xgvm0f3XDxP
 nZcDQeUCYpT57QGBCGm5i06+3G0GHPr5OnEQcwJZjYYyEyE2va9x6YTr9jS6878KnIrk
 vT6BPzRbwxnvpo41jENJzq422ECqzKKBOJnHc8vQGckS9rW8ybOywqT9s7DmCzlrIukS
 7x+6TWaIQ2n4OutmPo47eWi1dE+vfNiyiV5AzfoDR4173kV2tebHDUAR5HEwBVW0OQGZ
 jxag==
X-Gm-Message-State: AOAM5333sMiZCZtHolVn6YsqFXAZGQrhQnV5jJgaC+wyGeY0TUVX518x
 pKSSpb4LDxUWboLfj9s40g5bxfcwHsy2F6uyYeI=
X-Google-Smtp-Source: ABdhPJyVLSBX1PFpej7BlB0Ryuu6eIBzbQG6rvlmkPq2Yc5/B7hkfcdLNFFVq3mDVdTs49od40BfywaXxQTVFEmwJb4=
X-Received: by 2002:a1c:2602:: with SMTP id m2mr8369463wmm.50.1592647429093;
 Sat, 20 Jun 2020 03:03:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Sat, 20 Jun 2020 03:03:48 -0700 (PDT)
In-Reply-To: <20200619153632.1365-3-ahmedkhaledkaraman@gmail.com>
References: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
 <20200619153632.1365-3-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 20 Jun 2020 12:03:48 +0200
Message-ID: <CAHiYmc7t9JXeXS=K4i6sw-7dkyTsk_2h_K-Kk__FdKsGanQ9oQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scripts/performance: Add topN_callgrind.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000437a0205a8812057"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, PDS_OTHER_BAD_TLD=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "crosa@redhat.com" <crosa@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000437a0205a8812057
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=B5=D1=82=D0=B0=D0=BA, 19. =D1=98=D1=83=D0=BD 2020., Ahmed Karaman=
 <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> Python script that prints the top N most executed functions in QEMU
> using callgrind.
>
> Example Usage:
> topN_callgrind.py -n 20 -- /path/to/qemu program -program -flags
>
> If '-n' is not specified, the default is 25.
>
>
Comments similar to the one for the previous patch apply here too.

Thanks, Aleksandar


> Example Output:
> No.  Percentage Name                  Source File
> ----  --------- ------------------    ------------------------------
>    1    24.577% 0x00000000082db000    ???
>    2    20.467% float64_mul           <qemu>/fpu/softfloat.c
>    3    14.720% float64_sub           <qemu>/fpu/softfloat.c
>    4    13.864% float64_add           <qemu>/fpu/softfloat.c
>    5     4.876% helper_mulsd          <qemu>/target/i386/ops_sse.h
>    6     3.767% helper_subsd          <qemu>/target/i386/ops_sse.h
>    7     3.549% helper_addsd          <qemu>/target/i386/ops_sse.h
>    8     2.185% helper_ucomisd        <qemu>/target/i386/ops_sse.h
>    9     1.667% helper_lookup_tb_ptr  <qemu>/include/exec/tb-lookup.h
>   10     1.662% f64_compare           <qemu>/fpu/softfloat.c
>   11     1.509% helper_lookup_tb_ptr  <qemu>/accel/tcg/tcg-runtime.c
>   12     0.635% helper_lookup_tb_ptr  <qemu>/include/exec/exec-all.h
>   13     0.616% float64_div           <qemu>/fpu/softfloat.c
>   14     0.502% helper_pand_xmm       <qemu>/target/i386/ops_sse.h
>   15     0.502% float64_mul           <qemu>/include/fpu/softfloat.h
>   16     0.476% helper_lookup_tb_ptr  <qemu>/target/i386/cpu.h
>   17     0.437% float64_compare_quiet <qemu>/fpu/softfloat.c
>   18     0.414% helper_pxor_xmm       <qemu>/target/i386/ops_sse.h
>   19     0.353% round_to_int          <qemu>/fpu/softfloat.c
>   20     0.347% helper_cc_compute_all <qemu>/target/i386/cc_helper.c
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  scripts/performance/topN_callgrind.py | 131 ++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100755 scripts/performance/topN_callgrind.py
>
> diff --git a/scripts/performance/topN_callgrind.py
> b/scripts/performance/topN_callgrind.py
> new file mode 100755
> index 0000000000..2cfff54c98
> --- /dev/null
> +++ b/scripts/performance/topN_callgrind.py
> @@ -0,0 +1,131 @@
> +#!/usr/bin/env python3
> +
> +#  Print the top N most executed functions in QEMU using callgrind.
> +#  Example Usage:
> +#  topN_callgrind.py -n 20 -- /path/to/qemu program -program -flags
> +#
> +#   If '-n' is not specified, the default is 25.
> +#
> +#  This file is a part of the project "TCG Continuous Benchmarking".
> +#
> +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.
> com>
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
> +parser =3D argparse.ArgumentParser(usage=3D\
> +                                'topN_callgrind.py [-h] [-n
> TOP_FUNCTIONS] --'
> +                                ' /path/to/qemu program -[flags
> PROGRAM_FLAGS]')
> +
> +parser.add_argument('-n', dest=3D'top', type=3Dint, default=3D25,
> +                    help=3D'Specify the number of top functions to print=
.')
> +
> +parser.add_argument('command', type=3Dstr, nargs=3D'+',
> help=3Dargparse.SUPPRESS)
> +
> +args =3D parser.parse_args()
> +
> +# Extract the needed variables from the args
> +command =3D args.command
> +top =3D args.top
> +
> +# Insure that valgrind is installed
> +check_valgrind =3D subprocess.run(
> +    ["which", "valgrind"], stdout=3Dsubprocess.DEVNULL)
> +if check_valgrind.returncode:
> +    sys.exit("Please install valgrind before running the script!")
> +
> +# Run callgrind
> +callgrind =3D subprocess.run((["valgrind", "--tool=3Dcallgrind",
> +                             "--callgrind-out-file=3Dcallgrind.data"] +
> command),
> +                           stdout=3Dsubprocess.DEVNULL,
> stderr=3Dsubprocess.PIPE)
> +if callgrind.returncode:
> +    sys.exit(callgrind.stderr.decode("utf-8"))
> +
> +# Save callgrind_annotate output to tmp.callgrind.data
> +with open("tmp.callgrind.data", "w") as output:
> +    callgrind_annotate =3D subprocess.run(
> +        ["callgrind_annotate", "callgrind.data"],
> +        stdout=3Doutput,
> +        stderr=3Dsubprocess.PIPE)
> +    if callgrind_annotate.returncode:
> +        os.unlink('callgrind.data')
> +        output.close()
> +        os.unlink('tmp.callgrind.data')
> +        sys.exit(callgrind_annotate.stderr.decode("utf-8"))
> +
> +
> +# Read the callgrind_annotate output to callgrind_data[]
> +callgrind_data =3D []
> +with open('tmp.callgrind.data', 'r') as data:
> +    callgrind_data =3D data.readlines()
> +
> +# Line number with the total number of instructions
> +total_instructions_line_number =3D 20
> +
> +# Get the total number of instructions
> +total_instructions_line_data =3D callgrind_data[total_
> instructions_line_number]
> +total_number_of_instructions =3D total_instructions_line_data.split(' ')=
[0]
> +total_number_of_instructions =3D int(
> +    total_number_of_instructions.replace(',', ''))
> +
> +# Line number with the top function
> +first_func_line =3D 25
> +
> +# Number of functions recorded by callgrind, last two lines are always
> empty
> +number_of_functions =3D len(callgrind_data) - first_func_line - 2
> +
> +# Limit the number of top functions to "top"
> +number_of_top_functions =3D (top if number_of_functions >
> +                           top else number_of_functions)
> +
> +# Store the data of the top functions in top_functions[]
> +top_functions =3D callgrind_data[first_func_line:
> +                               first_func_line + number_of_top_functions=
]
> +
> +# Print information headers
> +print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
> +                                                         'Percentage',
> +                                                         'Name',
> +                                                         'Source File',
> +                                                         '-' * 4,
> +                                                         '-' * 10,
> +                                                         '-' * 30,
> +                                                         '-' * 30,
> +                                                         ))
> +
> +# Print top N functions
> +for (index, function) in enumerate(top_functions, start=3D1):
> +    function_data =3D function.split()
> +    # Calculate function percentage
> +    function_instructions =3D float(function_data[0].replace(',', ''))
> +    function_percentage =3D (function_instructions /
> +                           total_number_of_instructions)*100
> +    # Get function name and source files path
> +    function_source_path, function_name =3D function_data[1].split(':')
> +    # Print extracted data
> +    print('{:>4}  {:>9.3f}%  {:<30}  {}'.format(index,
> +
> round(function_percentage, 3),
> +                                                function_name,
> +                                                function_source_path))
> +
> +# Remove intermediate files
> +os.unlink('callgrind.data')
> +os.unlink('tmp.callgrind.data')
> --
> 2.17.1
>
>

--000000000000437a0205a8812057
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=BF=D0=B5=D1=82=D0=B0=D0=BA, 19. =D1=98=D1=83=D0=BD 2020., Ahmed=
 Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhaledkar=
aman@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Python script that prin=
ts the top N most executed functions in QEMU<br>
using callgrind.<br>
<br>
Example Usage:<br>
topN_callgrind.py -n 20 -- /path/to/qemu program -program -flags<br>
<br>
If &#39;-n&#39; is not specified, the default is 25.<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Comments similar to the one for=
 the previous patch apply here too.</span><br></div><div><br></div><div>Tha=
nks, Aleksandar</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Example Output:<br>
No.=C2=A0 Percentage Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Source File<br>
----=C2=A0 --------- ------------------=C2=A0 =C2=A0 ----------------------=
--------<br>
=C2=A0 =C2=A01=C2=A0 =C2=A0 24.577% 0x00000000082db000=C2=A0 =C2=A0 ???<br>
=C2=A0 =C2=A02=C2=A0 =C2=A0 20.467% float64_mul=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&lt;qemu&gt;/fpu/softfloat.c<br>
=C2=A0 =C2=A03=C2=A0 =C2=A0 14.720% float64_sub=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&lt;qemu&gt;/fpu/softfloat.c<br>
=C2=A0 =C2=A04=C2=A0 =C2=A0 13.864% float64_add=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&lt;qemu&gt;/fpu/softfloat.c<br>
=C2=A0 =C2=A05=C2=A0 =C2=A0 =C2=A04.876% helper_mulsd=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &lt;qemu&gt;/target/i386/ops_sse.h<br>
=C2=A0 =C2=A06=C2=A0 =C2=A0 =C2=A03.767% helper_subsd=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &lt;qemu&gt;/target/i386/ops_sse.h<br>
=C2=A0 =C2=A07=C2=A0 =C2=A0 =C2=A03.549% helper_addsd=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &lt;qemu&gt;/target/i386/ops_sse.h<br>
=C2=A0 =C2=A08=C2=A0 =C2=A0 =C2=A02.185% helper_ucomisd=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &lt;qemu&gt;/target/i386/ops_sse.h<br>
=C2=A0 =C2=A09=C2=A0 =C2=A0 =C2=A01.667% helper_lookup_tb_ptr=C2=A0 &lt;qem=
u&gt;/include/exec/tb-lookup.<wbr>h<br>
=C2=A0 10=C2=A0 =C2=A0 =C2=A01.662% f64_compare=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&lt;qemu&gt;/fpu/softfloat.c<br>
=C2=A0 11=C2=A0 =C2=A0 =C2=A01.509% helper_lookup_tb_ptr=C2=A0 &lt;qemu&gt;=
/accel/tcg/tcg-runtime.c<br>
=C2=A0 12=C2=A0 =C2=A0 =C2=A00.635% helper_lookup_tb_ptr=C2=A0 &lt;qemu&gt;=
/include/exec/exec-all.h<br>
=C2=A0 13=C2=A0 =C2=A0 =C2=A00.616% float64_div=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&lt;qemu&gt;/fpu/softfloat.c<br>
=C2=A0 14=C2=A0 =C2=A0 =C2=A00.502% helper_pand_xmm=C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;qemu&gt;/target/i386/ops_sse.h<br>
=C2=A0 15=C2=A0 =C2=A0 =C2=A00.502% float64_mul=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&lt;qemu&gt;/include/fpu/softfloat.h<br>
=C2=A0 16=C2=A0 =C2=A0 =C2=A00.476% helper_lookup_tb_ptr=C2=A0 &lt;qemu&gt;=
/target/i386/cpu.h<br>
=C2=A0 17=C2=A0 =C2=A0 =C2=A00.437% float64_compare_quiet &lt;qemu&gt;/fpu/=
softfloat.c<br>
=C2=A0 18=C2=A0 =C2=A0 =C2=A00.414% helper_pxor_xmm=C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;qemu&gt;/target/i386/ops_sse.h<br>
=C2=A0 19=C2=A0 =C2=A0 =C2=A00.353% round_to_int=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &lt;qemu&gt;/fpu/softfloat.c<br>
=C2=A0 20=C2=A0 =C2=A0 =C2=A00.347% helper_cc_compute_all &lt;qemu&gt;/targ=
et/i386/cc_helper.c<br>
<br>
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---<br>
=C2=A0scripts/performance/topN_<wbr>callgrind.py | 131 ++++++++++++++++++++=
++++++<br>
=C2=A01 file changed, 131 insertions(+)<br>
=C2=A0create mode 100755 scripts/performance/topN_<wbr>callgrind.py<br>
<br>
diff --git a/scripts/performance/topN_<wbr>callgrind.py b/scripts/performan=
ce/topN_<wbr>callgrind.py<br>
new file mode 100755<br>
index 0000000000..2cfff54c98<br>
--- /dev/null<br>
+++ b/scripts/performance/topN_<wbr>callgrind.py<br>
@@ -0,0 +1,131 @@<br>
+#!/usr/bin/env python3<br>
+<br>
+#=C2=A0 Print the top N most executed functions in QEMU using callgrind.<b=
r>
+#=C2=A0 Example Usage:<br>
+#=C2=A0 topN_callgrind.py -n 20 -- /path/to/qemu program -program -flags<b=
r>
+#<br>
+#=C2=A0 =C2=A0If &#39;-n&#39; is not specified, the default is 25.<br>
+#<br>
+#=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmarki=
ng&quot;.<br>
+#<br>
+#=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahmed=
khaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
+#=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailto=
:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&=
gt;<br>
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
+<br>
+<br>
+# Parse the command line arguments<br>
+parser =3D argparse.ArgumentParser(usage=3D<wbr>\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;topN_callgrind.py [-h] [-n TOP_=
FUNCTIONS] --&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39; /path/to/qemu program -[flags =
PROGRAM_FLAGS]&#39;)<br>
+<br>
+parser.add_argument(&#39;-n&#39;, dest=3D&#39;top&#39;, type=3Dint, defaul=
t=3D25,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 help=
=3D&#39;Specify the number of top functions to print.&#39;)<br>
+<br>
+parser.add_argument(&#39;command&#39;<wbr>, type=3Dstr, nargs=3D&#39;+&#39=
;, help=3Dargparse.SUPPRESS)<br>
+<br>
+args =3D parser.parse_args()<br>
+<br>
+# Extract the needed variables from the args<br>
+command =3D args.command<br>
+top =3D args.top<br>
+<br>
+# Insure that valgrind is installed<br>
+check_valgrind =3D subprocess.run(<br>
+=C2=A0 =C2=A0 [&quot;which&quot;, &quot;valgrind&quot;], stdout=3Dsubproce=
ss.DEVNULL)<br>
+if check_valgrind.returncode:<br>
+=C2=A0 =C2=A0 sys.exit(&quot;Please install valgrind before running the sc=
ript!&quot;)<br>
+<br>
+# Run callgrind<br>
+callgrind =3D subprocess.run(([&quot;valgrind&quot;, &quot;--tool=3Dcallgr=
ind&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--callgrind-out-file=3D<wbr>callgrind.=
data&quot;] + command),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.DEVNULL, stderr=3Dsubprocess.PI=
PE)<br>
+if callgrind.returncode:<br>
+=C2=A0 =C2=A0 sys.exit(callgrind.stderr.<wbr>decode(&quot;utf-8&quot;))<br=
>
+<br>
+# Save callgrind_annotate output to tmp.callgrind.data<br>
+with open(&quot;tmp.callgrind.data&quot;, &quot;w&quot;) as output:<br>
+=C2=A0 =C2=A0 callgrind_annotate =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;callgrind_annotate&quot;, &quot;callgri=
nd.data&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Doutput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubprocess.PIPE)<br>
+=C2=A0 =C2=A0 if callgrind_annotate.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(&#39;callgrind.data&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(&#39;tmp.callgrind.data&#39;<wbr>)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(callgrind_annotate.<wbr>stderr.decode=
(&quot;utf-8&quot;))<br>
+<br>
+<br>
+# Read the callgrind_annotate output to callgrind_data[]<br>
+callgrind_data =3D []<br>
+with open(&#39;tmp.callgrind.data&#39;, &#39;r&#39;) as data:<br>
+=C2=A0 =C2=A0 callgrind_data =3D data.readlines()<br>
+<br>
+# Line number with the total number of instructions<br>
+total_instructions_line_<wbr>number =3D 20<br>
+<br>
+# Get the total number of instructions<br>
+total_instructions_line_data =3D callgrind_data[total_<wbr>instructions_li=
ne_number]<br>
+total_number_of_instructions =3D total_instructions_line_data.<wbr>split(&=
#39; &#39;)[0]<br>
+total_number_of_instructions =3D int(<br>
+=C2=A0 =C2=A0 total_number_of_instructions.<wbr>replace(&#39;,&#39;, &#39;=
&#39;))<br>
+<br>
+# Line number with the top function<br>
+first_func_line =3D 25<br>
+<br>
+# Number of functions recorded by callgrind, last two lines are always emp=
ty<br>
+number_of_functions =3D len(callgrind_data) - first_func_line - 2<br>
+<br>
+# Limit the number of top functions to &quot;top&quot;<br>
+number_of_top_functions =3D (top if number_of_functions &gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0top else number_of_functions)<br>
+<br>
+# Store the data of the top functions in top_functions[]<br>
+top_functions =3D callgrind_data[first_func_<wbr>line:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0first_func_line + number_of_top_funct=
ions]<br>
+<br>
+# Print information headers<br>
+print(&#39;{:&gt;4}=C2=A0 {:&gt;10}=C2=A0 {:&lt;30}=C2=A0 {}\n{}=C2=A0 {}=
=C2=A0 {}=C2=A0 {}&#39;.format(&#39;No.&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Percentage&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Name&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Source File&#39=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 10,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 30,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 30,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0))<br>
+<br>
+# Print top N functions<br>
+for (index, function) in enumerate(top_functions, start=3D1):<br>
+=C2=A0 =C2=A0 function_data =3D function.split()<br>
+=C2=A0 =C2=A0 # Calculate function percentage<br>
+=C2=A0 =C2=A0 function_instructions =3D float(function_data[0].<wbr>replac=
e(&#39;,&#39;, &#39;&#39;))<br>
+=C2=A0 =C2=A0 function_percentage =3D (function_instructions /<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0total_number_of_instructions)*<wbr>100<br>
+=C2=A0 =C2=A0 # Get function name and source files path<br>
+=C2=A0 =C2=A0 function_source_path, function_name =3D function_data[1].spl=
it(&#39;:&#39;)<br>
+=C2=A0 =C2=A0 # Print extracted data<br>
+=C2=A0 =C2=A0 print(&#39;{:&gt;4}=C2=A0 {:&gt;9.3f}%=C2=A0 {:&lt;30}=C2=A0=
 {}&#39;.format(index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 round(function_percentage, 3),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 function_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 function_source_path))<br>
+<br>
+# Remove intermediate files<br>
+os.unlink(&#39;callgrind.data&#39;)<br>
+os.unlink(&#39;tmp.callgrind.<wbr>data&#39;)<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--000000000000437a0205a8812057--

