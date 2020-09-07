Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A6CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0D4215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEZUlVcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0D4215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFO8c-0002vQ-SB
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFO7w-0002Vb-Dg
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:52:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFO7t-0005zF-Go
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:52:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id e11so13015756wme.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=8k3hNuOvCKxkiLvebs/i9xjFCjigeYM/uMxZiMh6mkY=;
 b=MEZUlVcG0Igsckm5CYSHx2dvQdKtMeQEfhfIAjNY9mkglHTh0/OtTZI7pACt5m8Uhj
 OqnO0XiHuOqlYsHYtuJHrhdq0G20ui7XmUDxO99HJW6030t7L9aCRPt3pWLzVNqIkn0e
 +2VEtrQFPWO4IIPpDRosrq1L+Ocf+Wa862WhBZ50IdCA2pZCYFifyy5cIJ1r5YhKnWeL
 H/971MCr4zGPpF/7Fa9tv6UxL+5DDKt+n7Pc8gsKGRmM7AEXn9KLudXzIkVof2mjdY3l
 FCXyplr1zVFxneA0pcSpWRPrubLhV8Xneqs2g/0KJQdl7s61D97ZmSz1UOfkIrmPcePr
 2rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=8k3hNuOvCKxkiLvebs/i9xjFCjigeYM/uMxZiMh6mkY=;
 b=EB8zUKpXYUTQyvo4lmFTvWF1XSMiz9sjjooaK1YK8ehBFTmnHgSmwqRvRrn1lUpxUx
 pGNftcfwKF4T/TkZZGfPwe9VNLvidGL7ZZ1pIB34ItWRvCZEaKelibdx/4zF5x0GfK5x
 W7lgsMB8zZQJcBYVr7eyot6RnQZUjJ5/2CCaPKOUSV/4zzp5rnYt44u4lAV4RNVM6sqw
 +eqR8kh1oFmyNduzCqf/eD8ficmloXRvrpTNdDB79GcVFXtsWGaafIV61nfas7j2lGtc
 NjcPt/Qxjl/WiArdZyX1msh4rrxSvK8qyGiXMS+8/rRAWmcXOoxCiiUGX/VUBksTsP8u
 gNzg==
X-Gm-Message-State: AOAM533dqJvO0+4CRtqPGfb+bHnBMYvS+NbrcGNc8iVqFrdj/F2FpuLX
 dKrNRBoLPsXbzvABwhaHM01fyJus++r0o0yNyQWDTnGp
X-Google-Smtp-Source: ABdhPJxCGDI6r7Zqg9hZEqXuftD7kcZWi5WGQEMFQ309GC4evJ0+KFkNWourSyaUxRbV8MdbyXzg9mLHGC8/+rXKWmY=
X-Received: by 2002:a05:600c:4104:: with SMTP id
 j4mr1029945wmi.36.1599511951561; 
 Mon, 07 Sep 2020 13:52:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c351:0:0:0:0:0 with HTTP;
 Mon, 7 Sep 2020 13:52:31 -0700 (PDT)
In-Reply-To: <20200828104102.4490-2-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-2-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 7 Sep 2020 22:52:31 +0200
Message-ID: <CAHiYmc7LUENGpK3jBia06nJZDnqT09JJar7619gApNyC-Cvt3A@mail.gmail.com>
Subject: Re: [PATCH 1/9] scripts/performance: Refactor topN_perf.py
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000afdbe605aebf6523"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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

--000000000000afdbe605aebf6523
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, August 28, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
wrote:

> - Apply pylint and flake8 formatting rules to the script.
> - Use 'tempfile' instead of '/tmp' for creating temporary files.
>
>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reply
Reply all
Forward
View Gmail in: *Mobile* | Older version
<https://mail.google.com/mail/mu/mp/966/#> | Desktop
<https://mail.google.com/mail/mu/mp/966/#>
=C2=A9 2020 Google


> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  scripts/performance/topN_perf.py | 174 +++++++++++++++----------------
>  1 file changed, 87 insertions(+), 87 deletions(-)
>
> diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_
> perf.py
> index 07be195fc8..56b100da87 100755
> --- a/scripts/performance/topN_perf.py
> +++ b/scripts/performance/topN_perf.py
> @@ -1,72 +1,77 @@
>  #!/usr/bin/env python3
>
> -#  Print the top N most executed functions in QEMU using perf.
> -#  Syntax:
> -#  topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
> -#           <qemu executable> [<qemu executable options>] \
> -#           <target executable> [<target execurable options>]
> -#
> -#  [-h] - Print the script arguments help message.
> -#  [-n] - Specify the number of top functions to print.
> -#       - If this flag is not specified, the tool defaults to 25.
> -#
> -#  Example of usage:
> -#  topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
> -#
> -#  This file is a part of the project "TCG Continuous Benchmarking".
> -#
> -#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> -#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.
> com>
> -#
> -#  This program is free software: you can redistribute it and/or modify
> -#  it under the terms of the GNU General Public License as published by
> -#  the Free Software Foundation, either version 2 of the License, or
> -#  (at your option) any later version.
> -#
> -#  This program is distributed in the hope that it will be useful,
> -#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> -#  GNU General Public License for more details.
> -#
> -#  You should have received a copy of the GNU General Public License
> -#  along with this program. If not, see <https://www.gnu.org/licenses/>.
> +"""
> +Print the top N most executed functions in QEMU using perf.
> +
> +Syntax:
> +topN_perf.py [-h] [-n <number of displayed top functions>] -- \
> +         <qemu executable> [<qemu executable options>] \
> +         <target executable> [<target execurable options>]
> +
> +[-h] - Print the script arguments help message.
> +[-n] - Specify the number of top functions to print.
> +     - If this flag is not specified, the tool defaults to 25.
> +
> +Example of usage:
> +topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
> +
> +This file is a part of the project "TCG Continuous Benchmarking".
> +
> +Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com=
>
> +
> +This program is free software: you can redistribute it and/or modify
> +it under the terms of the GNU General Public License as published by
> +the Free Software Foundation, either version 2 of the License, or
> +(at your option) any later version.
> +
> +This program is distributed in the hope that it will be useful,
> +but WITHOUT ANY WARRANTY; without even the implied warranty of
> +MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +GNU General Public License for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with this program. If not, see <https://www.gnu.org/licenses/>.
> +"""
>
>  import argparse
>  import os
>  import subprocess
>  import sys
> +import tempfile
>
>
>  # Parse the command line arguments
> -parser =3D argparse.ArgumentParser(
> -    usage=3D'topN_perf.py [-h] [-n] <number of displayed top functions >
> -- '
> +PARSER =3D argparse.ArgumentParser(
> +    usage=3D'topN_perf.py [-h] [-n <number of displayed top functions>] =
-- '
>            '<qemu executable> [<qemu executable options>] '
>            '<target executable> [<target executable options>]')
>
> -parser.add_argument('-n', dest=3D'top', type=3Dint, default=3D25,
> +PARSER.add_argument('-n', dest=3D'top', type=3Dint, default=3D25,
>                      help=3D'Specify the number of top functions to print=
.')
>
> -parser.add_argument('command', type=3Dstr, nargs=3D'+',
> help=3Dargparse.SUPPRESS)
> +PARSER.add_argument('command', type=3Dstr, nargs=3D'+',
> help=3Dargparse.SUPPRESS)
>
> -args =3D parser.parse_args()
> +ARGS =3D PARSER.parse_args()
>
>  # Extract the needed variables from the args
> -command =3D args.command
> -top =3D args.top
> +COMMAND =3D ARGS.command
> +TOP =3D ARGS.top
>
>  # Insure that perf is installed
> -check_perf_presence =3D subprocess.run(["which", "perf"],
> -                                     stdout=3Dsubprocess.DEVNULL)
> -if check_perf_presence.returncode:
> +CHECK_PERF_PRESENCE =3D subprocess.run(["which", "perf"],
> +                                     stdout=3Dsubprocess.DEVNULL,
> +                                     check=3DFalse)
> +if CHECK_PERF_PRESENCE.returncode:
>      sys.exit("Please install perf before running the script!")
>
>  # Insure user has previllage to run perf
> -check_perf_executability =3D subprocess.run(["perf", "stat", "ls", "/"],
> +CHECK_PERF_EXECUTABILITY =3D subprocess.run(["perf", "stat", "ls", "/"],
>                                            stdout=3Dsubprocess.DEVNULL,
> -                                          stderr=3Dsubprocess.DEVNULL)
> -if check_perf_executability.returncode:
> -    sys.exit(
> -"""
> +                                          stderr=3Dsubprocess.DEVNULL,
> +                                          check=3DFalse)
> +if CHECK_PERF_EXECUTABILITY.returncode:
> +    sys.exit("""
>  Error:
>  You may not have permission to collect stats.
>
> @@ -85,43 +90,42 @@ To make this setting permanent, edit /etc/sysctl.conf
> too, e.g.:
>     kernel.perf_event_paranoid =3D -1
>
>  * Alternatively, you can run this script under sudo privileges.
> -"""
> -)
> -
> -# Run perf record
> -perf_record =3D subprocess.run((["perf", "record",
> "--output=3D/tmp/perf.data"] +
> -                              command),
> -                             stdout=3Dsubprocess.DEVNULL,
> -                             stderr=3Dsubprocess.PIPE)
> -if perf_record.returncode:
> -    os.unlink('/tmp/perf.data')
> -    sys.exit(perf_record.stderr.decode("utf-8"))
> -
> -# Save perf report output to /tmp/perf_report.out
> -with open("/tmp/perf_report.out", "w") as output:
> -    perf_report =3D subprocess.run(
> -        ["perf", "report", "--input=3D/tmp/perf.data", "--stdio"],
> -        stdout=3Doutput,
> -        stderr=3Dsubprocess.PIPE)
> -    if perf_report.returncode:
> -        os.unlink('/tmp/perf.data')
> -        output.close()
> -        os.unlink('/tmp/perf_report.out')
> -        sys.exit(perf_report.stderr.decode("utf-8"))
> -
> -# Read the reported data to functions[]
> -functions =3D []
> -with open("/tmp/perf_report.out", "r") as data:
> -    # Only read lines that are not comments (comments start with #)
> -    # Only read lines that are not empty
> -    functions =3D [line for line in data.readlines() if line and line[0]
> -                 !=3D '#' and line[0] !=3D "\n"]
> -
> -# Limit the number of top functions to "top"
> -number_of_top_functions =3D top if len(functions) > top else len(functio=
ns)
> -
> -# Store the data of the top functions in top_functions[]
> -top_functions =3D functions[:number_of_top_functions]
> +""")
> +
> +# Run perf and save all intermediate files in a temporary directory
> +with tempfile.TemporaryDirectory() as tmpdir:
> +    RECORD_PATH =3D os.path.join(tmpdir, "record.data")
> +    REPORT_PATH =3D os.path.join(tmpdir, "report.txt")
> +
> +    PERF_RECORD =3D subprocess.run((["perf", "record",
> "--output=3D"+RECORD_PATH] +
> +                                  COMMAND),
> +                                 stdout=3Dsubprocess.DEVNULL,
> +                                 stderr=3Dsubprocess.PIPE,
> +                                 check=3DFalse)
> +    if PERF_RECORD.returncode:
> +        sys.exit(PERF_RECORD.stderr.decode("utf-8"))
> +
> +    with open(REPORT_PATH, "w") as output:
> +        PERF_REPORT =3D subprocess.run(
> +            ["perf", "report", "--input=3D"+RECORD_PATH, "--stdio"],
> +            stdout=3Doutput,
> +            stderr=3Dsubprocess.PIPE,
> +            check=3DFalse)
> +        if PERF_REPORT.returncode:
> +            sys.exit(PERF_REPORT.stderr.decode("utf-8"))
> +
> +    # Save the reported data to FUNCTIONS[]
> +    with open(REPORT_PATH, "r") as data:
> +        # Only read lines that are not comments (comments start with #)
> +        # Only read lines that are not empty
> +        FUNCTIONS =3D [line for line in data.readlines() if line and
> +                     line[0] !=3D '#' and line[0] !=3D "\n"]
> +
> +# Limit the number of top functions to "TOP"
> +NO_TOP_FUNCTIONS =3D TOP if len(FUNCTIONS) > TOP else len(FUNCTIONS)
> +
> +# Store the data of the top functions in TOP_FUNCTIONS[]
> +TOP_FUNCTIONS =3D FUNCTIONS[:NO_TOP_FUNCTIONS]
>
>  # Print table header
>  print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
> @@ -134,7 +138,7 @@ print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}
> {}'.format('No.',
>                                                           '-' * 25))
>
>  # Print top N functions
> -for (index, function) in enumerate(top_functions, start=3D1):
> +for (index, function) in enumerate(TOP_FUNCTIONS, start=3D1):
>      function_data =3D function.split()
>      function_percentage =3D function_data[0]
>      function_name =3D function_data[-1]
> @@ -143,7 +147,3 @@ for (index, function) in enumerate(top_functions,
> start=3D1):
>                                               function_percentage,
>                                               function_name,
>                                               function_invoker))
> -
> -# Remove intermediate files
> -os.unlink('/tmp/perf.data')
> -os.unlink('/tmp/perf_report.out')
> --
> 2.17.1
>
>

--000000000000afdbe605aebf6523
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, August 28, 2020, Ahmed Karaman &lt;<a href=3D"mailto:ahm=
edkhaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt; wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">- Apply pylint and flake8 formatting rules to=
 the script.<br>
- Use &#39;tempfile&#39; instead of &#39;/tmp&#39; for creating temporary f=
iles.<br>
<br></blockquote><div><br></div><div><div id=3D"cv_" class=3D" Xg  " style=
=3D"width:320px;height:auto"><div class=3D"Zg" style=3D"width:320px;overflo=
w-y:auto"><div class=3D"Rg"><div class=3D"Li"><div class=3D"yj"><div class=
=3D"Ph"><div id=3D"cvcmsg_1744e012f27314c1" class=3D"yh" style=3D"border-to=
p-left-radius:0px;border-top-right-radius:0px;margin-bottom:11px"><div clas=
s=3D"Vh" id=3D"cvcfullmsg_1744e012f27314c1"><div id=3D"cvcmsgbod_1744e012f2=
7314c1" class=3D"aj"><div class=3D"Ni"><div class=3D"ni pi " dir=3D"ltr"><d=
iv>Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.d=
evel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@gmail.c<wbr>om</a>&=
gt;<br></div><div style=3D"clear:both"></div></div><div style=3D"clear:both=
"></div><div><div class=3D"M j T b hc Aj S" tabindex=3D"0"><div class=3D"V =
j hf"></div></div></div><div style=3D"clear:both"></div></div></div></div><=
/div></div><div class=3D"Pj"></div><div id=3D"cvcfb" class=3D"Cj"><div clas=
s=3D"Dj" style=3D"width:300px"><div class=3D"Ej"><div class=3D"M j T b hc F=
j Mi S" tabindex=3D"0"><div class=3D"V j vd Hj"></div><div class=3D"V j Y L=
j">Reply</div></div></div><div class=3D"Gj" style=3D"background-size:initia=
l"></div><div id=3D"cvcfra" class=3D"Ej"><div class=3D"M j T b hc Fj Mi S" =
tabindex=3D"0"><div class=3D"V j ud Hj"></div><div class=3D"V j Y Lj">Reply=
 all</div></div></div><div id=3D"cvcfrab" class=3D"Gj" style=3D"background-=
size:initial"></div><div class=3D"Ej"><div class=3D"M j T b hc Fj Mi S" tab=
index=3D"0"><div class=3D"V j sd Hj"></div><div class=3D"V j Y Lj">Forward<=
/div></div></div></div></div></div></div><div class=3D"Og"><div class=3D"dh=
"><div class=3D"Nh"><div class=3D"Nh">View Gmail in:=C2=A0<b>Mobile</b>=C2=
=A0|=C2=A0<a href=3D"https://mail.google.com/mail/mu/mp/966/#">Older versio=
n</a>=C2=A0|=C2=A0<a href=3D"https://mail.google.com/mail/mu/mp/966/#">Desk=
top</a></div><div class=3D"Nh Oh"><span dir=3D"ltr">=C2=A9 2020 Google</spa=
n></div></div></div></div></div></div><div class=3D"ah" style=3D"width:320p=
x"></div></div><div class=3D"Ls" style=3D"display:block"><div class=3D"As">=
<div class=3D"Bs"><div class=3D"Gs  " style=3D"font-size:13px"><div class=
=3D"Is Hs"></div></div></div></div></div></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---<br>
=C2=A0scripts/performance/topN_perf.<wbr>py | 174 +++++++++++++++----------=
-----<wbr>-<br>
=C2=A01 file changed, 87 insertions(+), 87 deletions(-)<br>
<br>
diff --git a/scripts/performance/topN_<wbr>perf.py b/scripts/performance/to=
pN_<wbr>perf.py<br>
index 07be195fc8..56b100da87 100755<br>
--- a/scripts/performance/topN_<wbr>perf.py<br>
+++ b/scripts/performance/topN_<wbr>perf.py<br>
@@ -1,72 +1,77 @@<br>
=C2=A0#!/usr/bin/env python3<br>
<br>
-#=C2=A0 Print the top N most executed functions in QEMU using perf.<br>
-#=C2=A0 Syntax:<br>
-#=C2=A0 topN_perf.py [-h] [-n] &lt;number of displayed top functions&gt;=
=C2=A0 -- \<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;qemu executable&gt; [&lt;qem=
u executable options&gt;] \<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;target executable&gt; [&lt;t=
arget execurable options&gt;]<br>
-#<br>
-#=C2=A0 [-h] - Print the script arguments help message.<br>
-#=C2=A0 [-n] - Specify the number of top functions to print.<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0- If this flag is not specified, the tool defa=
ults to 25.<br>
-#<br>
-#=C2=A0 Example of usage:<br>
-#=C2=A0 topN_perf.py -n 20 -- qemu-arm coulomb_double-arm<br>
-#<br>
-#=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmarki=
ng&quot;.<br>
-#<br>
-#=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahmed=
khaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
-#=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailto=
:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&=
gt;<br>
-#<br>
-#=C2=A0 This program is free software: you can redistribute it and/or modi=
fy<br>
-#=C2=A0 it under the terms of the GNU General Public License as published =
by<br>
-#=C2=A0 the Free Software Foundation, either version 2 of the License, or<=
br>
-#=C2=A0 (at your option) any later version.<br>
-#<br>
-#=C2=A0 This program is distributed in the hope that it will be useful,<br=
>
-#=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
-#=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
-#=C2=A0 GNU General Public License for more details.<br>
-#<br>
-#=C2=A0 You should have received a copy of the GNU General Public License<=
br>
-#=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.gn=
u.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&g=
t;.<br>
+&quot;&quot;&quot;<br>
+Print the top N most executed functions in QEMU using perf.<br>
+<br>
+Syntax:<br>
+topN_perf.py [-h] [-n &lt;number of displayed top functions&gt;] -- \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;qemu executable&gt; [&lt;qemu execut=
able options&gt;] \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;target executable&gt; [&lt;target ex=
ecurable options&gt;]<br>
+<br>
+[-h] - Print the script arguments help message.<br>
+[-n] - Specify the number of top functions to print.<br>
+=C2=A0 =C2=A0 =C2=A0- If this flag is not specified, the tool defaults to =
25.<br>
+<br>
+Example of usage:<br>
+topN_perf.py -n 20 -- qemu-arm coulomb_double-arm<br>
+<br>
+This file is a part of the project &quot;TCG Continuous Benchmarking&quot;=
.<br>
+<br>
+Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledka=
raman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
+Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailto:aleksan=
dar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
+<br>
+This program is free software: you can redistribute it and/or modify<br>
+it under the terms of the GNU General Public License as published by<br>
+the Free Software Foundation, either version 2 of the License, or<br>
+(at your option) any later version.<br>
+<br>
+This program is distributed in the hope that it will be useful,<br>
+but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+GNU General Public License for more details.<br>
+<br>
+You should have received a copy of the GNU General Public License<br>
+along with this program. If not, see &lt;<a href=3D"https://www.gnu.org/li=
censes/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&gt;.<br>
+&quot;&quot;&quot;<br>
<br>
=C2=A0import argparse<br>
=C2=A0import os<br>
=C2=A0import subprocess<br>
=C2=A0import sys<br>
+import tempfile<br>
<br>
<br>
=C2=A0# Parse the command line arguments<br>
-parser =3D argparse.ArgumentParser(<br>
-=C2=A0 =C2=A0 usage=3D&#39;topN_perf.py [-h] [-n] &lt;number of displayed =
top functions &gt;=C2=A0 -- &#39;<br>
+PARSER =3D argparse.ArgumentParser(<br>
+=C2=A0 =C2=A0 usage=3D&#39;topN_perf.py [-h] [-n &lt;number of displayed t=
op functions&gt;] -- &#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;&lt;qemu executable&gt; [&lt;=
qemu executable options&gt;] &#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;&lt;target executable&gt; [&l=
t;target executable options&gt;]&#39;)<br>
<br>
-parser.add_argument(&#39;-n&#39;, dest=3D&#39;top&#39;, type=3Dint, defaul=
t=3D25,<br>
+PARSER.add_argument(&#39;-n&#39;, dest=3D&#39;top&#39;, type=3Dint, defaul=
t=3D25,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0help=3D&#39;Specify the number of top functions to print.&#39;)<br>
<br>
-parser.add_argument(&#39;command&#39;<wbr>, type=3Dstr, nargs=3D&#39;+&#39=
;, help=3Dargparse.SUPPRESS)<br>
+PARSER.add_argument(&#39;command&#39;<wbr>, type=3Dstr, nargs=3D&#39;+&#39=
;, help=3Dargparse.SUPPRESS)<br>
<br>
-args =3D parser.parse_args()<br>
+ARGS =3D PARSER.parse_args()<br>
<br>
=C2=A0# Extract the needed variables from the args<br>
-command =3D args.command<br>
-top =3D args.top<br>
+COMMAND =3D ARGS.command<br>
+TOP =3D ARGS.top<br>
<br>
=C2=A0# Insure that perf is installed<br>
-check_perf_presence =3D subprocess.run([&quot;which&quot;, &quot;perf&quot=
;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubproc=
ess.DEVNULL)<br>
-if check_perf_presence.<wbr>returncode:<br>
+CHECK_PERF_PRESENCE =3D subprocess.run([&quot;which&quot;, &quot;perf&quot=
;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubproc=
ess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0check=3DFalse)<b=
r>
+if CHECK_PERF_PRESENCE.<wbr>returncode:<br>
=C2=A0 =C2=A0 =C2=A0sys.exit(&quot;Please install perf before running the s=
cript!&quot;)<br>
<br>
=C2=A0# Insure user has previllage to run perf<br>
-check_perf_executability =3D subprocess.run([&quot;perf&quot;, &quot;stat&=
quot;, &quot;ls&quot;, &quot;/&quot;],<br>
+CHECK_PERF_EXECUTABILITY =3D subprocess.run([&quot;perf&quot;, &quot;stat&=
quot;, &quot;ls&quot;, &quot;/&quot;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0stdout=3Dsubprocess.DEVNULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
tderr=3Dsubprocess.DEVNULL)<br>
-if check_perf_executability.<wbr>returncode:<br>
-=C2=A0 =C2=A0 sys.exit(<br>
-&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
tderr=3Dsubprocess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
heck=3DFalse)<br>
+if CHECK_PERF_EXECUTABILITY.<wbr>returncode:<br>
+=C2=A0 =C2=A0 sys.exit(&quot;&quot;&quot;<br>
=C2=A0Error:<br>
=C2=A0You may not have permission to collect stats.<br>
<br>
@@ -85,43 +90,42 @@ To make this setting permanent, edit /etc/sysctl.conf t=
oo, e.g.:<br>
=C2=A0 =C2=A0 kernel.perf_event_paranoid =3D -1<br>
<br>
=C2=A0* Alternatively, you can run this script under sudo privileges.<br>
-&quot;&quot;&quot;<br>
-)<br>
-<br>
-# Run perf record<br>
-perf_record =3D subprocess.run(([&quot;perf&quot;, &quot;record&quot;, &qu=
ot;--output=3D/tmp/perf.data&quot;] +<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.DEVNULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stderr=3Dsubprocess.PIPE)<br>
-if perf_record.returncode:<br>
-=C2=A0 =C2=A0 os.unlink(&#39;/tmp/perf.data&#39;)<br>
-=C2=A0 =C2=A0 sys.exit(perf_record.stderr.<wbr>decode(&quot;utf-8&quot;))<=
br>
-<br>
-# Save perf report output to /tmp/perf_report.out<br>
-with open(&quot;/tmp/perf_report.out&quot;, &quot;w&quot;) as output:<br>
-=C2=A0 =C2=A0 perf_report =3D subprocess.run(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;perf&quot;, &quot;report&quot;, &quot;-=
-input=3D/tmp/perf.data&quot;, &quot;--stdio&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Doutput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubprocess.PIPE)<br>
-=C2=A0 =C2=A0 if perf_report.returncode:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(&#39;/tmp/perf.data&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output.close()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(&#39;/tmp/perf_report.<wbr>out&#39;)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(perf_report.stderr.<wbr>decode(&quot;=
utf-8&quot;))<br>
-<br>
-# Read the reported data to functions[]<br>
-functions =3D []<br>
-with open(&quot;/tmp/perf_report.out&quot;, &quot;r&quot;) as data:<br>
-=C2=A0 =C2=A0 # Only read lines that are not comments (comments start with=
 #)<br>
-=C2=A0 =C2=A0 # Only read lines that are not empty<br>
-=C2=A0 =C2=A0 functions =3D [line for line in data.readlines() if line and=
 line[0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!=3D &#39;#&=
#39; and line[0] !=3D &quot;\n&quot;]<br>
-<br>
-# Limit the number of top functions to &quot;top&quot;<br>
-number_of_top_functions =3D top if len(functions) &gt; top else len(functi=
ons)<br>
-<br>
-# Store the data of the top functions in top_functions[]<br>
-top_functions =3D functions[:number_of_top_<wbr>functions]<br>
+&quot;&quot;&quot;)<br>
+<br>
+# Run perf and save all intermediate files in a temporary directory<br>
+with tempfile.TemporaryDirectory() as tmpdir:<br>
+=C2=A0 =C2=A0 RECORD_PATH =3D os.path.join(tmpdir, &quot;record.data&quot;=
)<br>
+=C2=A0 =C2=A0 REPORT_PATH =3D os.path.join(tmpdir, &quot;report.txt&quot;)=
<br>
+<br>
+=C2=A0 =C2=A0 PERF_RECORD =3D subprocess.run(([&quot;perf&quot;, &quot;rec=
ord&quot;, &quot;--output=3D&quot;+RECORD_PATH] +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMAND),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.DEVNULL,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stderr=3Dsubprocess.PIPE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0check=3DFalse)<br>
+=C2=A0 =C2=A0 if PERF_RECORD.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(PERF_RECORD.stderr.<wbr>decode(&quot;=
utf-8&quot;))<br>
+<br>
+=C2=A0 =C2=A0 with open(REPORT_PATH, &quot;w&quot;) as output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PERF_REPORT =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;perf&quot;, &quot;report&=
quot;, &quot;--input=3D&quot;+RECORD_PATH, &quot;--stdio&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Doutput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubprocess.PIPE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check=3DFalse)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if PERF_REPORT.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(PERF_REPORT.stderr.<wbr=
>decode(&quot;utf-8&quot;))<br>
+<br>
+=C2=A0 =C2=A0 # Save the reported data to FUNCTIONS[]<br>
+=C2=A0 =C2=A0 with open(REPORT_PATH, &quot;r&quot;) as data:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Only read lines that are not comments (comme=
nts start with #)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Only read lines that are not empty<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 FUNCTIONS =3D [line for line in data.readlines=
() if line and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0line[0] !=3D &#39;#&#39; and line[0] !=3D &quot;\n&quot;]<br>
+<br>
+# Limit the number of top functions to &quot;TOP&quot;<br>
+NO_TOP_FUNCTIONS =3D TOP if len(FUNCTIONS) &gt; TOP else len(FUNCTIONS)<br=
>
+<br>
+# Store the data of the top functions in TOP_FUNCTIONS[]<br>
+TOP_FUNCTIONS =3D FUNCTIONS[:NO_TOP_FUNCTIONS]<br>
<br>
=C2=A0# Print table header<br>
=C2=A0print(&#39;{:&gt;4}=C2=A0 {:&gt;10}=C2=A0 {:&lt;30}=C2=A0 {}\n{}=C2=
=A0 {}=C2=A0 {}=C2=A0 {}&#39;.format(&#39;No.&#39;,<br>
@@ -134,7 +138,7 @@ print(&#39;{:&gt;4}=C2=A0 {:&gt;10}=C2=A0 {:&lt;30}=C2=
=A0 {}\n{}=C2=A0 {}=C2=A0 {}=C2=A0 {}&#39;.format(&#39;No.&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-&#39; * 25))<=
br>
<br>
=C2=A0# Print top N functions<br>
-for (index, function) in enumerate(top_functions, start=3D1):<br>
+for (index, function) in enumerate(TOP_FUNCTIONS, start=3D1):<br>
=C2=A0 =C2=A0 =C2=A0function_data =3D function.split()<br>
=C2=A0 =C2=A0 =C2=A0function_percentage =3D function_data[0]<br>
=C2=A0 =C2=A0 =C2=A0function_name =3D function_data[-1]<br>
@@ -143,7 +147,3 @@ for (index, function) in enumerate(top_functions, start=
=3D1):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 function_percentage,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 function_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 function_invoker))<br>
-<br>
-# Remove intermediate files<br>
-os.unlink(&#39;/tmp/perf.data&#39;)<br>
-os.unlink(&#39;/tmp/perf_report.<wbr>out&#39;)<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--000000000000afdbe605aebf6523--

