Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28CAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A272920885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErPZR74r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A272920885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Qz-0006iJ-Vg
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jr1PN-0004xy-MV
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:45:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jr1PL-0003Iq-4B
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:45:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id a6so29096022wrm.4
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=4jzIBdNgvLoVTU365NzNp5g263u74lsJnL9oZUAuKqU=;
 b=ErPZR74rOeNIDFT7EYaDKlkxNrKaABBQk+ogtgzwJsRnOBtaq4SpRgZownhZ7EcyPy
 pvgrcvbvAy5P2yYXD+ESs/TsZ8+fQIwl3muo6X2cscLO7QnnOsO0jvDf27nSYXXnpcO6
 u1u86ucbLb7fkLCd8QZgBoIx4TRHqDwaoI3goL8i+VxUGx0qaOT9Hf65TwuO9Zc2wiSE
 E1aTN8/nNlwmfmH5sPzlZkY3RhJ36AMkcDxQMaLYwcPORB0pZspCZv6+iFpIZ4WAhglb
 NHUO4rAyMG76LAV6nta496kexGpnX+HXB+78NZg4oKilzLubcOMjPLa3XBorhjxp0jo8
 GteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=4jzIBdNgvLoVTU365NzNp5g263u74lsJnL9oZUAuKqU=;
 b=B/R23zNtDdAsI0zRwzWaj7H6Mt+rrGp6ECAbKF++Vq9fTwvOoUCl649oSbhr5H6TqJ
 5YzTViLFL/ylAwPeAUYobX2DkZ/1Wec80EQ/DQ6BLmQI6d2sC4pAPKT62XjE0tcwB8pO
 YR7jqGJkM+/HKkvNMOJ2nXcDr7yeukqSFlXzN23B1IlvO8Z7VOewR1JVLr4MHQNvlBMA
 T3FrupP/LFdJnHmBSOqkC1h7fhxjootXf14iV/jeJKaKOod0SelrTB5Rztai8hi/HdOD
 WurvxOQV6/0QIkKYMRcNkaYQW4Te2OhyHszpO7UHHtmOhgtP2AVTLYWi2Btfk+9Mm9cL
 /6zg==
X-Gm-Message-State: AOAM530Lg3Myq/Ojg86uCVpcz83IWBPQJ04eUsgGd+KBaXJgY1PXp453
 B7U1IO6BoMypNzNXn7v2C85k93Zxv0QqWn8cXQI=
X-Google-Smtp-Source: ABdhPJxOtuiUCMsUAzGty6gDHiJssxGSYAZbpySnEoQvhfHkQ4gQ9RMF1LnLExkB8KjWhpnuPay+8f3uQy9JUKIf/qY=
X-Received: by 2002:adf:8462:: with SMTP id 89mr31622816wrf.420.1593704749199; 
 Thu, 02 Jul 2020 08:45:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP;
 Thu, 2 Jul 2020 08:45:48 -0700 (PDT)
In-Reply-To: <20200702142942.4887-2-ahmedkhaledkaraman@gmail.com>
References: <20200702142942.4887-1-ahmedkhaledkaraman@gmail.com>
 <20200702142942.4887-2-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 2 Jul 2020 17:45:48 +0200
Message-ID: <CAHiYmc65CbVoQrMTmK9hxjaC4ESBMQjSP8EO=HaqCKCMv9=ZKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] scripts/performance: Add dissect.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000073f51f05a9774d6e"
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "crosa@redhat.com" <crosa@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000073f51f05a9774d6e
Content-Type: text/plain; charset="UTF-8"

On Thursday, July 2, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
wrote:

> Python script that dissects QEMU execution into three main phases:
> code generation, JIT execution and helpers execution.
>
> Syntax:
> dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
>                  <target executable> [<target executable options>]
>
> [-h] - Print the script arguments help message.
>
> Example of usage:
> dissect.py -- qemu-arm coulomb_double-arm
>
> Example output:
> Total Instructions:        4,702,865,362
>
> Code Generation:             115,819,309         2.463%
> JIT Execution:             1,081,980,528        23.007%
> Helpers:                   3,505,065,525        74.530%
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---


A very good script! Hopefully there will be some script in near future that
will, for example, list all hepers used in the test program.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>



>  scripts/performance/dissect.py | 165 +++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100755 scripts/performance/dissect.py
>
> diff --git a/scripts/performance/dissect.py b/scripts/performance/dissect.
> py
> new file mode 100755
> index 0000000000..8c2967d082
> --- /dev/null
> +++ b/scripts/performance/dissect.py
> @@ -0,0 +1,165 @@
> +#!/usr/bin/env python3
> +
> +#  Print the percentage of instructions spent in each phase of QEMU
> +#  execution.
> +#
> +#  Syntax:
> +#  dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
> +#                   <target executable> [<target executable options>]
> +#
> +#  [-h] - Print the script arguments help message.
> +#
> +#  Example of usage:
> +#  dissect.py -- qemu-arm coulomb_double-arm
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
> +def get_JIT_line(callgrind_data):
> +    """
> +    Search for the first instance of the JIT call in
> +    the callgrind_annotate output when ran using --tree=caller
> +    This is equivalent to the self number of instructions of JIT.
> +
> +    Parameters:
> +    callgrind_data (list): callgrind_annotate output
> +
> +    Returns:
> +    (int): Line number
> +   """
> +    line = -1
> +    for i in range(len(callgrind_data)):
> +        if callgrind_data[i].strip('\n') and \
> +                callgrind_data[i].split()[-1] == "[???]":
> +            line = i
> +            break
> +    if line == -1:
> +        sys.exit("Couldn't locate the JIT call ... Exiting.")
> +    return line
> +
> +
> +def main():
> +    # Parse the command line arguments
> +    parser = argparse.ArgumentParser(
> +        usage='dissect.py [-h] -- '
> +        '<qemu executable> [<qemu executable options>] '
> +        '<target executable> [<target executable options>]')
> +
> +    parser.add_argument('command', type=str, nargs='+',
> help=argparse.SUPPRESS)
> +
> +    args = parser.parse_args()
> +
> +    # Extract the needed variables from the args
> +    command = args.command
> +
> +    # Insure that valgrind is installed
> +    check_valgrind = subprocess.run(
> +        ["which", "valgrind"], stdout=subprocess.DEVNULL)
> +    if check_valgrind.returncode:
> +        sys.exit("Please install valgrind before running the script.")
> +
> +    # Run callgrind
> +    callgrind = subprocess.run((["valgrind",
> +                                 "--tool=callgrind",
> +                                 "--callgrind-out-file=/tmp/
> callgrind.data"]
> +                                + command),
> +                               stdout=subprocess.DEVNULL,
> +                               stderr=subprocess.PIPE)
> +    if callgrind.returncode:
> +        sys.exit(callgrind.stderr.decode("utf-8"))
> +
> +    # Save callgrind_annotate output to /tmp/callgrind_annotate.out
> +    with open("/tmp/callgrind_annotate.out", "w") as output:
> +        callgrind_annotate = subprocess.run(
> +            ["callgrind_annotate", "/tmp/callgrind.data",
> "--tree=caller"],
> +            stdout=output,
> +            stderr=subprocess.PIPE)
> +        if callgrind_annotate.returncode:
> +            os.unlink('/tmp/callgrind.data')
> +            output.close()
> +            os.unlink('/tmp/callgrind_annotate.out')
> +            sys.exit(callgrind_annotate.stderr.decode("utf-8"))
> +
> +    # Read the callgrind_annotate output to callgrind_data[]
> +    callgrind_data = []
> +    with open('/tmp/callgrind_annotate.out', 'r') as data:
> +        callgrind_data = data.readlines()
> +
> +    # Line number with the total number of instructions
> +    total_instructions_line_number = 20
> +    # Get the total number of instructions
> +    total_instructions_line_data = \
> +        callgrind_data[total_instructions_line_number]
> +    total_instructions = total_instructions_line_data.split()[0]
> +    total_instructions = int(total_instructions.replace(',', ''))
> +
> +    # Line number with the JIT self number of instructions
> +    JIT_self_instructions_line_number = get_JIT_line(callgrind_data)
> +    # Get the JIT self number of instructions
> +    JIT_self_instructions_line_data = \
> +        callgrind_data[JIT_self_instructions_line_number]
> +    JIT_self_instructions = JIT_self_instructions_line_data.split()[0]
> +    JIT_self_instructions = int(JIT_self_instructions.replace(',', ''))
> +
> +    # Line number with the JIT self + inclusive number of instructions
> +    # It's the line above the first JIT call when running with
> --tree=caller
> +    JIT_total_instructions_line_number = JIT_self_instructions_line_number
> - 1
> +    # Get the JIT self + inclusive number of instructions
> +    JIT_total_instructions_line_data = \
> +        callgrind_data[JIT_total_instructions_line_number]
> +    JIT_total_instructions = JIT_total_instructions_line_data.split()[0]
> +    JIT_total_instructions = int(JIT_total_instructions.replace(',', ''))
> +
> +    # Calculate number of instructions in helpers and code generation
> +    helpers_instructions = JIT_total_instructions - JIT_self_instructions
> +    code_generation_instructions = total_instructions -
> JIT_total_instructions
> +
> +    # Print results (Insert commas in large numbers)
> +    # Print total number of instructions
> +    print('{:<20}{:>20}\n'.
> +          format("Total Instructions:",
> +                 format(total_instructions, ',')))
> +    # Print code generation instructions and percentage
> +    print('{:<20}{:>20}\t{:>6.3f}%'.
> +          format("Code Generation:",
> +                 format(code_generation_instructions, ","),
> +                 (code_generation_instructions / total_instructions) *
> 100))
> +    # Print JIT instructions and percentage
> +    print('{:<20}{:>20}\t{:>6.3f}%'.
> +          format("JIT Execution:",
> +                 format(JIT_self_instructions, ","),
> +                 (JIT_self_instructions / total_instructions) * 100))
> +    # Print helpers instructions and percentage
> +    print('{:<20}{:>20}\t{:>6.3f}%'.
> +          format("Helpers:",
> +                 format(helpers_instructions, ","),
> +                 (helpers_instructions/total_instructions)*100))
> +
> +    # Remove intermediate files
> +    os.unlink('/tmp/callgrind.data')
> +    os.unlink('/tmp/callgrind_annotate.out')
> +
> +
> +if __name__ == "__main__":
> +    main()
> --
> 2.17.1
>
>

--00000000000073f51f05a9774d6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, July 2, 2020, Ahmed Karaman &lt;<a href=3D"mailto:ahme=
dkhaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt; wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">Python script that dissects QEMU execution int=
o three main phases:<br>
code generation, JIT execution and helpers execution.<br>
<br>
Syntax:<br>
dissect.py [-h] -- &lt;qemu executable&gt; [&lt;qemu executable options&gt;=
] \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;target ex=
ecutable&gt; [&lt;target executable options&gt;]<br>
<br>
[-h] - Print the script arguments help message.<br>
<br>
Example of usage:<br>
dissect.py -- qemu-arm coulomb_double-arm<br>
<br>
Example output:<br>
Total Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 4,702,865,362<br>
<br>
Code Generation:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0115,819,309=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02.463%<br>
JIT Execution:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01,081,980,528=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 23.007%<br>
Helpers:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A03,505,065,525=C2=A0 =C2=A0 =C2=A0 =C2=A0 74.530%<br>
<br>
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---</blockquote><div><br></div><div>A very good script! Hopefully there wil=
l be some script in near future that will, for example, list all hepers use=
d in the test program.</div><div><br></div><div>Reviewed-by: Aleksandar Mar=
kovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qem=
u.devel@gmail.com</a>&gt;</div><div><br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
=C2=A0scripts/performance/dissect.py | 165 ++++++++++++++++++++++++++++++<w=
br>+++<br>
=C2=A01 file changed, 165 insertions(+)<br>
=C2=A0create mode 100755 scripts/performance/dissect.py<br>
<br>
diff --git a/scripts/performance/dissect.<wbr>py b/scripts/performance/diss=
ect.<wbr>py<br>
new file mode 100755<br>
index 0000000000..8c2967d082<br>
--- /dev/null<br>
+++ b/scripts/performance/dissect.<wbr>py<br>
@@ -0,0 +1,165 @@<br>
+#!/usr/bin/env python3<br>
+<br>
+#=C2=A0 Print the percentage of instructions spent in each phase of QEMU<b=
r>
+#=C2=A0 execution.<br>
+#<br>
+#=C2=A0 Syntax:<br>
+#=C2=A0 dissect.py [-h] -- &lt;qemu executable&gt; [&lt;qemu executable op=
tions&gt;] \<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;=
target executable&gt; [&lt;target executable options&gt;]<br>
+#<br>
+#=C2=A0 [-h] - Print the script arguments help message.<br>
+#<br>
+#=C2=A0 Example of usage:<br>
+#=C2=A0 dissect.py -- qemu-arm coulomb_double-arm<br>
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
+def get_JIT_line(callgrind_data):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Search for the first instance of the JIT call in<br>
+=C2=A0 =C2=A0 the callgrind_annotate output when ran using --tree=3Dcaller=
<br>
+=C2=A0 =C2=A0 This is equivalent to the self number of instructions of JIT=
.<br>
+<br>
+=C2=A0 =C2=A0 Parameters:<br>
+=C2=A0 =C2=A0 callgrind_data (list): callgrind_annotate output<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 (int): Line number<br>
+=C2=A0 =C2=A0&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 line =3D -1<br>
+=C2=A0 =C2=A0 for i in range(len(callgrind_data)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if callgrind_data[i].strip(&#39;\n&#39;) and \=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data[i].=
split()[-1] =3D=3D &quot;[???]&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D i<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
+=C2=A0 =C2=A0 if line =3D=3D -1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(&quot;Couldn&#39;t locate the JIT cal=
l ... Exiting.&quot;)<br>
+=C2=A0 =C2=A0 return line<br>
+<br>
+<br>
+def main():<br>
+=C2=A0 =C2=A0 # Parse the command line arguments<br>
+=C2=A0 =C2=A0 parser =3D argparse.ArgumentParser(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 usage=3D&#39;dissect.py [-h] -- &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&lt;qemu executable&gt; [&lt;qemu executa=
ble options&gt;] &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&lt;target executable&gt; [&lt;target exe=
cutable options&gt;]&#39;)<br>
+<br>
+=C2=A0 =C2=A0 parser.add_argument(&#39;command&#39;, type=3Dstr, nargs=3D&=
#39;+&#39;, help=3Dargparse.SUPPRESS)<br>
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
+=C2=A0 =C2=A0 # Run callgrind<br>
+=C2=A0 =C2=A0 callgrind =3D subprocess.run(([&quot;valgrind&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--tool=3Dcallgrind&quot;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--callgrind-out-file=3D/=
tmp/<wbr>callgrind.data&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + command),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stderr=3Dsubprocess.PIPE)<br>
+=C2=A0 =C2=A0 if callgrind.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(callgrind.stderr.<wbr>decode(&quot;ut=
f-8&quot;))<br>
+<br>
+=C2=A0 =C2=A0 # Save callgrind_annotate output to /tmp/callgrind_annotate.=
out<br>
+=C2=A0 =C2=A0 with open(&quot;/tmp/callgrind_annotate.<wbr>out&quot;, &quo=
t;w&quot;) as output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_annotate =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;callgrind_annotate&quot;,=
 &quot;/tmp/callgrind.data&quot;, &quot;--tree=3Dcaller&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Doutput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubprocess.PIPE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if callgrind_annotate.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(&#39;/tmp/callgrind.<w=
br>data&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(&#39;/tmp/callgrind_<w=
br>annotate.out&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(callgrind_annotate.<wbr=
>stderr.decode(&quot;utf-8&quot;))<br>
+<br>
+=C2=A0 =C2=A0 # Read the callgrind_annotate output to callgrind_data[]<br>
+=C2=A0 =C2=A0 callgrind_data =3D []<br>
+=C2=A0 =C2=A0 with open(&#39;/tmp/callgrind_annotate.<wbr>out&#39;, &#39;r=
&#39;) as data:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data =3D data.readlines()<br>
+<br>
+=C2=A0 =C2=A0 # Line number with the total number of instructions<br>
+=C2=A0 =C2=A0 total_instructions_line_number =3D 20<br>
+=C2=A0 =C2=A0 # Get the total number of instructions<br>
+=C2=A0 =C2=A0 total_instructions_line_data =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data[total_<wbr>instructions_line_nu=
mber]<br>
+=C2=A0 =C2=A0 total_instructions =3D total_instructions_line_data.<wbr>spl=
it()[0]<br>
+=C2=A0 =C2=A0 total_instructions =3D int(total_instructions.<wbr>replace(&=
#39;,&#39;, &#39;&#39;))<br>
+<br>
+=C2=A0 =C2=A0 # Line number with the JIT self number of instructions<br>
+=C2=A0 =C2=A0 JIT_self_instructions_line_<wbr>number =3D get_JIT_line(call=
grind_data)<br>
+=C2=A0 =C2=A0 # Get the JIT self number of instructions<br>
+=C2=A0 =C2=A0 JIT_self_instructions_line_<wbr>data =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data[JIT_self_<wbr>instructions_line=
_number]<br>
+=C2=A0 =C2=A0 JIT_self_instructions =3D JIT_self_instructions_line_<wbr>da=
ta.split()[0]<br>
+=C2=A0 =C2=A0 JIT_self_instructions =3D int(JIT_self_instructions.<wbr>rep=
lace(&#39;,&#39;, &#39;&#39;))<br>
+<br>
+=C2=A0 =C2=A0 # Line number with the JIT self + inclusive number of instru=
ctions<br>
+=C2=A0 =C2=A0 # It&#39;s the line above the first JIT call when running wi=
th --tree=3Dcaller<br>
+=C2=A0 =C2=A0 JIT_total_instructions_line_<wbr>number =3D JIT_self_instruc=
tions_line_<wbr>number - 1<br>
+=C2=A0 =C2=A0 # Get the JIT self + inclusive number of instructions<br>
+=C2=A0 =C2=A0 JIT_total_instructions_line_<wbr>data =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data[JIT_total_<wbr>instructions_lin=
e_number]<br>
+=C2=A0 =C2=A0 JIT_total_instructions =3D JIT_total_instructions_line_<wbr>=
data.split()[0]<br>
+=C2=A0 =C2=A0 JIT_total_instructions =3D int(JIT_total_instructions.<wbr>r=
eplace(&#39;,&#39;, &#39;&#39;))<br>
+<br>
+=C2=A0 =C2=A0 # Calculate number of instructions in helpers and code gener=
ation<br>
+=C2=A0 =C2=A0 helpers_instructions =3D JIT_total_instructions - JIT_self_i=
nstructions<br>
+=C2=A0 =C2=A0 code_generation_instructions =3D total_instructions - JIT_to=
tal_instructions<br>
+<br>
+=C2=A0 =C2=A0 # Print results (Insert commas in large numbers)<br>
+=C2=A0 =C2=A0 # Print total number of instructions<br>
+=C2=A0 =C2=A0 print(&#39;{:&lt;20}{:&gt;20}\n&#39;.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format(&quot;Total Instructions:&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format(total=
_instructions, &#39;,&#39;)))<br>
+=C2=A0 =C2=A0 # Print code generation instructions and percentage<br>
+=C2=A0 =C2=A0 print(&#39;{:&lt;20}{:&gt;20}\t{:&gt;6.3f}%<wbr>&#39;.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format(&quot;Code Generation:&quot;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format(code_=
generation_<wbr>instructions, &quot;,&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(code_genera=
tion_instructions / total_instructions) * 100))<br>
+=C2=A0 =C2=A0 # Print JIT instructions and percentage<br>
+=C2=A0 =C2=A0 print(&#39;{:&lt;20}{:&gt;20}\t{:&gt;6.3f}%<wbr>&#39;.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format(&quot;JIT Execution:&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format(JIT_s=
elf_instructions, &quot;,&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(JIT_self_in=
structions / total_instructions) * 100))<br>
+=C2=A0 =C2=A0 # Print helpers instructions and percentage<br>
+=C2=A0 =C2=A0 print(&#39;{:&lt;20}{:&gt;20}\t{:&gt;6.3f}%<wbr>&#39;.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format(&quot;Helpers:&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format(helpe=
rs_instructions, &quot;,&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(helpers_ins=
tructions/total_<wbr>instructions)*100))<br>
+<br>
+=C2=A0 =C2=A0 # Remove intermediate files<br>
+=C2=A0 =C2=A0 os.unlink(&#39;/tmp/callgrind.<wbr>data&#39;)<br>
+=C2=A0 =C2=A0 os.unlink(&#39;/tmp/callgrind_<wbr>annotate.out&#39;)<br>
+<br>
+<br>
+if __name__ =3D=3D &quot;__main__&quot;:<br>
+=C2=A0 =C2=A0 main()<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--00000000000073f51f05a9774d6e--

