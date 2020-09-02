Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19A8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692212078B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juqBb8Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692212078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOSU-0004Ip-JT
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kDORu-0003tQ-OH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:48:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kDORs-0007WO-70
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:48:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id z9so3659236wmk.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=u2VtHphaFsSm//4yelTGSORK3W/Qaf758kOYXhE15R4=;
 b=juqBb8PtyYBq/6bua0jJSZR9lKd5UdWgkAhRaWvlV+gNFXBoHGZMUVHE4duT7fgXq4
 aUr6rxBsXonfQVVarZ7PEthSwQgdbvcPVz3vie6Iz8npPVyQw3BTOHIucMgxS/Bwnf7m
 fIogw2R8oz/cxfNOCkCc7WD11Ap8Hso+ATSqaBDS3unuf7Na3PF+tMQLo2Xt7yPbWPUJ
 U29nl5t2n29vnd3uiYU/sUMQS1N6ur7W8NIfe2/n6CItJSocFrxdJnVuiJBqfWkjIVmI
 Eiv5Y/mdRMrXBXdNJYy0L4IHYv0Vgo6kJiIP3CYHpCPFrOI554UkYGZT2CCzEsch0wg6
 KkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=u2VtHphaFsSm//4yelTGSORK3W/Qaf758kOYXhE15R4=;
 b=r+78iQ/KTokAO/1f813EKFKnzPfBFwbOOiP+ueDp71lSBd18oGW0CksFv5UE2CqQSa
 YH2fHsNsvmHUbL9pZnoTyHPyMyl0gcKSQwLMjWLXcuILQQzZh/7bKUFQOdcqGTy80Gv4
 ZoT7ll7XG+zQdAK0aANFQKQYpOLZBjQb9Ye1sht5zUZOPLU9Y1lQ5i+YhbLuyBJBobIu
 TYr3lZtYzHXYH0couaeo/Y6MGlMfFDP0uBP9ZmoCYuBuAA+kDWmAWHXnewbmmvN+1jYC
 DaVocBBTVodw5PgrQQUrjMt+PhQ511QX09LcQsopbpQ3ESHE1AyPrNWFaCM8ucvKfqfG
 BqVA==
X-Gm-Message-State: AOAM530fhwwf2xh5ngfw+DsWbPyu1j7L7P0gIb2ZFmB8XzRlTmf64TBU
 DVRDbZQEgcsO7YrxpkXnh2qzLnOrW/6Jk3AZZqM=
X-Google-Smtp-Source: ABdhPJxXwZ0W+mdqwewqyEYCjodkMeu7eAH8Mmua2uoy1CxqVeCVSedbZkdec82LNMvNJgLzDT7zdUD4wjfcdRQ3v28=
X-Received: by 2002:a7b:c958:: with SMTP id i24mr6036543wml.50.1599036534799; 
 Wed, 02 Sep 2020 01:48:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c351:0:0:0:0:0 with HTTP;
 Wed, 2 Sep 2020 01:48:54 -0700 (PDT)
In-Reply-To: <20200828104102.4490-4-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-4-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 2 Sep 2020 10:48:54 +0200
Message-ID: <CAHiYmc6YHNGrdx4vE9ng5Js5ndtVjADXy5TbLqjZFsGO1SiKdQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] scripts/performance: Refactor dissect.py
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a3c13b05ae50b4a3"
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
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

--000000000000a3c13b05ae50b4a3
Content-Type: text/plain; charset="UTF-8"

On Friday, August 28, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
wrote:

> - Apply pylint and flake8 formatting rules to the script.
> - Move syntax and usage exmaple to main() docstring.
> - Update get_jit_line() to only detect the main jit call.
> - Use mypy for specifying parameters and return types in functions.
>
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>


> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  scripts/performance/dissect.py | 123 ++++++++++++++++++---------------
>  1 file changed, 68 insertions(+), 55 deletions(-)
>
> diff --git a/scripts/performance/dissect.py b/scripts/performance/dissect.
> py
> index bf24f50922..d4df884b75 100755
> --- a/scripts/performance/dissect.py
> +++ b/scripts/performance/dissect.py
> @@ -1,34 +1,27 @@
>  #!/usr/bin/env python3
>
> -#  Print the percentage of instructions spent in each phase of QEMU
> -#  execution.
> -#
> -#  Syntax:
> -#  dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
> -#                   <target executable> [<target executable options>]
> -#
> -#  [-h] - Print the script arguments help message.
> -#
> -#  Example of usage:
> -#  dissect.py -- qemu-arm coulomb_double-arm
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
> +Print the percentage of instructions spent in each phase of QEMU
> +execution.
> +
> +This file is a part of the project "TCG Continuous Benchmarking".
> +
> +Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
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
> @@ -36,23 +29,26 @@ import subprocess
>  import sys
>  import tempfile
>
> +from typing import List
> +
>
> -def get_JIT_line(callgrind_data):
> +def get_jit_line(callgrind_data: List[str]) -> int:
>      """
>      Search for the first instance of the JIT call in
>      the callgrind_annotate output when ran using --tree=caller
>      This is equivalent to the self number of instructions of JIT.
>
>      Parameters:
> -    callgrind_data (list): callgrind_annotate output
> +    callgrind_data (List[str]): callgrind_annotate output
>
>      Returns:
>      (int): Line number
>      """
>      line = -1
> -    for i in range(len(callgrind_data)):
> -        if callgrind_data[i].strip('\n') and \
> -                callgrind_data[i].split()[-1] == "[???]":
> +    for (i, callgrind_datum) in enumerate(callgrind_data):
> +        if callgrind_datum.strip('\n') and \
> +                callgrind_datum.split()[-1] == "[???]" and \
> +                callgrind_datum.split()[1] == "*":
>              line = i
>              break
>      if line == -1:
> @@ -61,6 +57,18 @@ def get_JIT_line(callgrind_data):
>
>
>  def main():
> +    """
> +    Parse the command line arguments then start the execution.
> +    Syntax:
> +    dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
> +                 <target executable> [<target executable options>]
> +
> +    [-h] - Print the script arguments help message.
> +
> +    Example of usage:
> +    dissect.py -- qemu-arm coulomb_double-arm
> +    """
> +
>      # Parse the command line arguments
>      parser = argparse.ArgumentParser(
>          usage='dissect.py [-h] -- '
> @@ -76,7 +84,7 @@ def main():
>
>      # Insure that valgrind is installed
>      check_valgrind = subprocess.run(
> -        ["which", "valgrind"], stdout=subprocess.DEVNULL)
> +        ["which", "valgrind"], stdout=subprocess.DEVNULL, check=False)
>      if check_valgrind.returncode:
>          sys.exit("Please install valgrind before running the script.")
>
> @@ -93,7 +101,8 @@ def main():
>                                       "--callgrind-out-file=" + data_path]
>                                      + command),
>                                     stdout=subprocess.DEVNULL,
> -                                   stderr=subprocess.PIPE)
> +                                   stderr=subprocess.PIPE,
> +                                   check=False)
>          if callgrind.returncode:
>              sys.exit(callgrind.stderr.decode("utf-8"))
>
> @@ -102,7 +111,8 @@ def main():
>              callgrind_annotate = subprocess.run(
>                  ["callgrind_annotate", data_path, "--tree=caller"],
>                  stdout=output,
> -                stderr=subprocess.PIPE)
> +                stderr=subprocess.PIPE,
> +                check=False)
>              if callgrind_annotate.returncode:
>                  sys.exit(callgrind_annotate.stderr.decode("utf-8"))
>
> @@ -120,25 +130,28 @@ def main():
>          total_instructions = int(total_instructions.replace(',', ''))
>
>          # Line number with the JIT self number of instructions
> -        JIT_self_instructions_line_number = get_JIT_line(callgrind_data)
> +        jit_self_instructions_line_number = get_jit_line(callgrind_data)
>          # Get the JIT self number of instructions
> -        JIT_self_instructions_line_data = \
> -            callgrind_data[JIT_self_instructions_line_number]
> -        JIT_self_instructions = JIT_self_instructions_line_
> data.split()[0]
> -        JIT_self_instructions = int(JIT_self_instructions.replace(',',
> ''))
> +        jit_self_instructions_line_data = \
> +            callgrind_data[jit_self_instructions_line_number]
> +        jit_self_instructions = jit_self_instructions_line_
> data.split()[0]
> +        jit_self_instructions = int(jit_self_instructions.replace(',',
> ''))
>
>          # Line number with the JIT self + inclusive number of instructions
> -        # It's the line above the first JIT call when running with
> --tree=caller
> -        JIT_total_instructions_line_number = JIT_self_instructions_line_
> number-1
> +        # It's the line above the first JIT call when running with
> +        # --tree=caller
> +        jit_total_instructions_line_number = \
> +            jit_self_instructions_line_number-1
>          # Get the JIT self + inclusive number of instructions
> -        JIT_total_instructions_line_data = \
> -            callgrind_data[JIT_total_instructions_line_number]
> -        JIT_total_instructions = JIT_total_instructions_line_
> data.split()[0]
> -        JIT_total_instructions = int(JIT_total_instructions.replace(',',
> ''))
> +        jit_total_instructions_line_data = \
> +            callgrind_data[jit_total_instructions_line_number]
> +        jit_total_instructions = jit_total_instructions_line_
> data.split()[0]
> +        jit_total_instructions = int(jit_total_instructions.replace(',',
> ''))
>
>          # Calculate number of instructions in helpers and code generation
> -        helpers_instructions = JIT_total_instructions-JIT_
> self_instructions
> -        code_generation_instructions = total_instructions-JIT_total_
> instructions
> +        helpers_instructions = jit_total_instructions-jit_
> self_instructions
> +        code_generation_instructions = \
> +            total_instructions-jit_total_instructions
>
>          # Print results (Insert commas in large numbers)
>          # Print total number of instructions
> @@ -149,12 +162,12 @@ def main():
>          print('{:<20}{:>20}\t{:>6.3f}%'.
>                format("Code Generation:",
>                       format(code_generation_instructions, ","),
> -                     (code_generation_instructions / total_instructions)
> * 100))
> -        # Print JIT instructions and percentage
> +                     (code_generation_instructions/
> total_instructions)*100))
> +        # Print jit instructions and percentage
>          print('{:<20}{:>20}\t{:>6.3f}%'.
> -              format("JIT Execution:",
> -                     format(JIT_self_instructions, ","),
> -                     (JIT_self_instructions / total_instructions) * 100))
> +              format("jit Execution:",
> +                     format(jit_self_instructions, ","),
> +                     (jit_self_instructions / total_instructions) * 100))
>          # Print helpers instructions and percentage
>          print('{:<20}{:>20}\t{:>6.3f}%'.
>                format("Helpers:",
> --
> 2.17.1
>
>

--000000000000a3c13b05ae50b4a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, August 28, 2020, Ahmed Karaman &lt;<a href=3D"mailto:ahm=
edkhaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt; wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">- Apply pylint and flake8 formatting rules to=
 the script.<br>
- Move syntax and usage exmaple to main() docstring.<br>
- Update get_jit_line() to only detect the main jit call.<br>
- Use mypy for specifying parameters and return types in functions.<br>
<br></blockquote><div><br></div><div><br></div><div><span style=3D"color:rg=
b(34,34,34);font-size:14px;line-height:22.1200008392334px">Reviewed-by: Ale=
ksandar Markovic &lt;</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.c=
om" target=3D"_blank" style=3D"font-size:14px;line-height:22.1200008392334p=
x">aleksandar.qemu.devel@gmail.c<wbr>om</a><span style=3D"color:rgb(34,34,3=
4);font-size:14px;line-height:22.1200008392334px">&gt;</span><br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---<br>
=C2=A0scripts/performance/dissect.py | 123 ++++++++++++++++++------------<w=
br>---<br>
=C2=A01 file changed, 68 insertions(+), 55 deletions(-)<br>
<br>
diff --git a/scripts/performance/dissect.<wbr>py b/scripts/performance/diss=
ect.<wbr>py<br>
index bf24f50922..d4df884b75 100755<br>
--- a/scripts/performance/dissect.<wbr>py<br>
+++ b/scripts/performance/dissect.<wbr>py<br>
@@ -1,34 +1,27 @@<br>
=C2=A0#!/usr/bin/env python3<br>
<br>
-#=C2=A0 Print the percentage of instructions spent in each phase of QEMU<b=
r>
-#=C2=A0 execution.<br>
-#<br>
-#=C2=A0 Syntax:<br>
-#=C2=A0 dissect.py [-h] -- &lt;qemu executable&gt; [&lt;qemu executable op=
tions&gt;] \<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;=
target executable&gt; [&lt;target executable options&gt;]<br>
-#<br>
-#=C2=A0 [-h] - Print the script arguments help message.<br>
-#<br>
-#=C2=A0 Example of usage:<br>
-#=C2=A0 dissect.py -- qemu-arm coulomb_double-arm<br>
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
+Print the percentage of instructions spent in each phase of QEMU<br>
+execution.<br>
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
@@ -36,23 +29,26 @@ import subprocess<br>
=C2=A0import sys<br>
=C2=A0import tempfile<br>
<br>
+from typing import List<br>
+<br>
<br>
-def get_JIT_line(callgrind_data):<br>
+def get_jit_line(callgrind_data: List[str]) -&gt; int:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0Search for the first instance of the JIT call in<br>
=C2=A0 =C2=A0 =C2=A0the callgrind_annotate output when ran using --tree=3Dc=
aller<br>
=C2=A0 =C2=A0 =C2=A0This is equivalent to the self number of instructions o=
f JIT.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Parameters:<br>
-=C2=A0 =C2=A0 callgrind_data (list): callgrind_annotate output<br>
+=C2=A0 =C2=A0 callgrind_data (List[str]): callgrind_annotate output<br>
<br>
=C2=A0 =C2=A0 =C2=A0Returns:<br>
=C2=A0 =C2=A0 =C2=A0(int): Line number<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0line =3D -1<br>
-=C2=A0 =C2=A0 for i in range(len(callgrind_data)):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if callgrind_data[i].strip(&#39;\n&#39;) and \=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data[i].=
split()[-1] =3D=3D &quot;[???]&quot;:<br>
+=C2=A0 =C2=A0 for (i, callgrind_datum) in enumerate(callgrind_data):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if callgrind_datum.strip(&#39;\n&#39;) and \<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_datum.sp=
lit()[-1] =3D=3D &quot;[???]&quot; and \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_datum.sp=
lit()[1] =3D=3D &quot;*&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0line =3D i<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>
=C2=A0 =C2=A0 =C2=A0if line =3D=3D -1:<br>
@@ -61,6 +57,18 @@ def get_JIT_line(callgrind_data):<br>
<br>
<br>
=C2=A0def main():<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Parse the command line arguments then start the execution.<b=
r>
+=C2=A0 =C2=A0 Syntax:<br>
+=C2=A0 =C2=A0 dissect.py [-h] -- &lt;qemu executable&gt; [&lt;qemu executa=
ble options&gt;] \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;target e=
xecutable&gt; [&lt;target executable options&gt;]<br>
+<br>
+=C2=A0 =C2=A0 [-h] - Print the script arguments help message.<br>
+<br>
+=C2=A0 =C2=A0 Example of usage:<br>
+=C2=A0 =C2=A0 dissect.py -- qemu-arm coulomb_double-arm<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0# Parse the command line arguments<br>
=C2=A0 =C2=A0 =C2=A0parser =3D argparse.ArgumentParser(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage=3D&#39;dissect.py [-h] -- &#39;<br>
@@ -76,7 +84,7 @@ def main():<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Insure that valgrind is installed<br>
=C2=A0 =C2=A0 =C2=A0check_valgrind =3D subprocess.run(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;which&quot;, &quot;valgrind&quot;], std=
out=3Dsubprocess.DEVNULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;which&quot;, &quot;valgrind&quot;], std=
out=3Dsubprocess.DEVNULL, check=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0if check_valgrind.returncode:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(&quot;Please install valgrind be=
fore running the script.&quot;)<br>
<br>
@@ -93,7 +101,8 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--callgri=
nd-out-file=3D&quot; + data_path]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ command),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Dsubprocess.DE=
VNULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stderr=3Dsubprocess.PIP=
E)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stderr=3Dsubprocess.PIP=
E,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0check=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if callgrind.returncode:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(callgrind.stderr.<=
wbr>decode(&quot;utf-8&quot;))<br>
<br>
@@ -102,7 +111,8 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0callgrind_annotate =3D subp=
rocess.run(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[&quot;callgr=
ind_annotate&quot;, data_path, &quot;--tree=3Dcaller&quot;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Doutp=
ut,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubproces=
s.PIPE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=3Dsubproces=
s.PIPE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if callgrind_annotate.retur=
ncode:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(call=
grind_annotate.<wbr>stderr.decode(&quot;utf-8&quot;))<br>
<br>
@@ -120,25 +130,28 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_instructions =3D int(total_instruct=
ions.<wbr>replace(&#39;,&#39;, &#39;&#39;))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Line number with the JIT self number of=
 instructions<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 JIT_self_instructions_line_<wbr>number =3D get=
_JIT_line(callgrind_data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jit_self_instructions_line_<wbr>number =3D get=
_jit_line(callgrind_data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Get the JIT self number of instructions=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 JIT_self_instructions_line_<wbr>data =3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data[JIT_self_<wbr>ins=
tructions_line_number]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 JIT_self_instructions =3D JIT_self_instruction=
s_line_<wbr>data.split()[0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 JIT_self_instructions =3D int(JIT_self_instruc=
tions.<wbr>replace(&#39;,&#39;, &#39;&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jit_self_instructions_line_<wbr>data =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data[jit_self_<wbr>ins=
tructions_line_number]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jit_self_instructions =3D jit_self_instruction=
s_line_<wbr>data.split()[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jit_self_instructions =3D int(jit_self_instruc=
tions.<wbr>replace(&#39;,&#39;, &#39;&#39;))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Line number with the JIT self + inclusi=
ve number of instructions<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # It&#39;s the line above the first JIT call w=
hen running with --tree=3Dcaller<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 JIT_total_instructions_line_<wbr>number =3D JI=
T_self_instructions_line_<wbr>number-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # It&#39;s the line above the first JIT call w=
hen running with<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # --tree=3Dcaller<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jit_total_instructions_line_<wbr>number =3D \<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 jit_self_instructions_line_<wbr>=
number-1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Get the JIT self + inclusive number of =
instructions<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 JIT_total_instructions_line_<wbr>data =3D \<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data[JIT_total_<wbr>in=
structions_line_number]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 JIT_total_instructions =3D JIT_total_instructi=
ons_line_<wbr>data.split()[0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 JIT_total_instructions =3D int(JIT_total_instr=
uctions.<wbr>replace(&#39;,&#39;, &#39;&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jit_total_instructions_line_<wbr>data =3D \<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callgrind_data[jit_total_<wbr>in=
structions_line_number]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jit_total_instructions =3D jit_total_instructi=
ons_line_<wbr>data.split()[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jit_total_instructions =3D int(jit_total_instr=
uctions.<wbr>replace(&#39;,&#39;, &#39;&#39;))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Calculate number of instructions in hel=
pers and code generation<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 helpers_instructions =3D JIT_total_instruction=
s-JIT_<wbr>self_instructions<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 code_generation_instructions =3D total_instruc=
tions-JIT_total_<wbr>instructions<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 helpers_instructions =3D jit_total_instruction=
s-jit_<wbr>self_instructions<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 code_generation_instructions =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_instructions-jit_total_<wb=
r>instructions<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Print results (Insert commas in large n=
umbers)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Print total number of instructions<br>
@@ -149,12 +162,12 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&#39;{:&lt;20}{:&gt;20}\t{:&gt;6.3f=
}%<wbr>&#39;.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format(&quot;Code Ge=
neration:&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 format(code_generation_<wbr>instructions, &quot;,&quot;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(code_generation_instructions / total_instructions) * 100))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Print JIT instructions and percentage<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(code_generation_instructions/<wbr>total_instructions)*100))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Print jit instructions and percentage<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&#39;{:&lt;20}{:&gt;20}\t{:&gt;6.3f=
}%<wbr>&#39;.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format(&quot;JIT Executio=
n:&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0format(JIT_self_instructions, &quot;,&quot;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(JIT_self_instructions / total_instructions) * 100))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format(&quot;jit Executio=
n:&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0format(jit_self_instructions, &quot;,&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(jit_self_instructions / total_instructions) * 100))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Print helpers instructions and percenta=
ge<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&#39;{:&lt;20}{:&gt;20}\t{:&gt;6.3f=
}%<wbr>&#39;.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format(&quot;Helpers=
:&quot;,<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--000000000000a3c13b05ae50b4a3--

