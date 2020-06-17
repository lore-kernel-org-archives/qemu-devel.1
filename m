Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A06C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F32F204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk+plKkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F32F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlQsy-0005R2-Fu
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlQqh-0002Dr-4F
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:42:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlQqe-00031Y-99
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:42:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id j10so889169wrw.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 22:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ZcARCQNh2MkN3aur9VIUppPiUf1K86ydGfLNis+3Gxc=;
 b=Qk+plKkB+W22nX19sDzTgP5O+zPEiY8MnkU23Ncy2+lRqogv7eh4fFqMIgse0PEEM0
 9aVAcYcEun/QZ33scStKZJpnfnWq52MRYU3pf3x+LhjTyw/K1usym1uQXN2N+hR7OEK1
 h2l9kg01+kCrS/Tkq7M2VeSldo8jZ4TsY8cY6Zc+HVb6nsd/53Xm/31QlAIZN08ECjdr
 UF02ClHdMWljZA256rEiqMq+CUeT6ev5hXAMU6lSxhukXlIn03AqRurC+mv6DG54T6l5
 tPJNfl+7rPpt5LConmNk9MoZd+rWLV8CoN4gX7F4SiNxPoFJAX8OExmKjHdaazrHKoMX
 sjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ZcARCQNh2MkN3aur9VIUppPiUf1K86ydGfLNis+3Gxc=;
 b=BG9jrPYH4G62rG4wRWj20Yh9xah0Styoette0pJcV8o2hqN5TOAsfDXxqFbS/I7YDa
 A84TgzZoL/Bm16OiZU38RA/QYeR5FE2iBq5f5OaGSL5pt4z21WTVmIYI0DbtHJPBfycT
 qBEql3dbJiegTW5nJ7MKuCpCDgCOPM+skI+qIYRWIOcuVZGQSLN/ARMyn4LlbUt2ugtH
 oshcNe5s9iRhj9IWCEqk4arZm5V52un2sAOvU7bnYknA1vD7RdbsImTkRQ2J5v1FU2Li
 aEyUeloBib2T1bFvjQR8yyeo98E99VBioSw6gFhZIXXgDCPn8jLN9LgHHGnadzm8u8zS
 NfUw==
X-Gm-Message-State: AOAM530Kz+ff/utuOvfQ8/h+pkJT2YewvmBSh6SgFZGV72x8z/paku8e
 LI/tuq6vcTwwgfF8nLVeuEc0iUWu24fM94edYKY=
X-Google-Smtp-Source: ABdhPJzw2hucFCbZNZ+QhnJniCqDcIo6KaHHwkgp7aKQuOZ4PgOgyqPrkNdl/Op1dENw3ZfeJzqLHuMjZ45Q44Obrdw=
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr6415050wrv.162.1592372574669; 
 Tue, 16 Jun 2020 22:42:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Tue, 16 Jun 2020 22:42:54 -0700 (PDT)
In-Reply-To: <20200616231204.8850-3-ahmedkhaledkaraman@gmail.com>
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-3-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 17 Jun 2020 07:42:54 +0200
Message-ID: <CAHiYmc5BNb5h2mfdGaoR2-4QseNXhvSSrir_m3TzjgcSvA4LrA@mail.gmail.com>
Subject: Re: [PATCH 2/3] scripts/performance: Add callgrind_top_25.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a9ce1205a8412126"
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

--000000000000a9ce1205a8412126
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Ahmed Karaman=
 <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> Python script that prints the top 25 most executed functions in QEMU
> using callgrind.
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---


I think you should add an example of script usage in the commit message
(even though you mention such example in the comments of the script),
together with the script output for that example.

Thanks,
Aleksandar



>  scripts/performance/callgrind_top_25.py | 95 +++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 scripts/performance/callgrind_top_25.py
>
> diff --git a/scripts/performance/callgrind_top_25.py
> b/scripts/performance/callgrind_top_25.py
> new file mode 100644
> index 0000000000..03b089a96d
> --- /dev/null
> +++ b/scripts/performance/callgrind_top_25.py
> @@ -0,0 +1,95 @@
> +#!/usr/bin/env python3
> +
> +#  Print the top 25 most executed functions in QEMU using callgrind.
> +#  Example Usage:
> +#  callgrind_top_25.py <qemu-build>/x86_64-linux-user/qemu-x86_64
> executable
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
> +import os
> +import sys
> +
> +# Ensure sufficient arguments
> +if len(sys.argv) < 3:
> +    print('Insufficient Script Arguments!')
> +    sys.exit(1)
> +
> +# Get the qemu path and the executable + its arguments
> +(qemu, executable) =3D (sys.argv[1], ' '.join(sys.argv[2:]))
> +
> +# Run callgrind and callgrind_annotate
> +os.system('valgrind --tool=3Dcallgrind --callgrind-out-file=3Dcallgrind.=
data
> {} {} \
> +            2 > / dev / null & & callgrind_annotate callgrind.data \
> +            > tmp.callgrind.data'.
> +          format(qemu, executable))
> +
> +# Line number with the total number of instructions
> +number_of_instructions_line =3D 20
> +
> +# Line number with the top function
> +first_func_line =3D 25
> +
> +# callgrind_annotate output
> +callgrind_data =3D []
> +
> +# Open callgrind_annotate output and store it in callgrind_data
> +with open('tmp.callgrind.data', 'r') as data:
> +    callgrind_data =3D data.readlines()
> +
> +# Get the total number of instructions
> +total_number_of_instructions =3D int(
> +    callgrind_data[number_of_instructions_line].split('
> ')[0].replace(',', ''))
> +
> +# Number of functions recorded by callgrind
> +number_of_functions =3D len(callgrind_data) - first_func_line
> +
> +# Limit the number of top functions to 25
> +number_of_top_functions =3D (25 if number_of_functions >
> +                           25 else number_of_instructions_line)
> +
> +# Store the data of the top functions in top_functions[]
> +top_functions =3D callgrind_data[first_func_line:
> +                               first_func_line + number_of_top_functions=
]
> +# Print information headers
> +print('{:>4}  {:>10}  {:<25}  {}\n{}  {}  {}  {}'.format('No.',
> +                                                         'Percentage',
> +                                                         'Name',
> +                                                         'Source File',
> +                                                         '-' * 4,
> +                                                         '-' * 10,
> +                                                         '-' * 25,
> +                                                         '-' * 30,
> +                                                         ))
> +
> +# Print top 25 functions
> +for (index, function) in enumerate(top_functions, start=3D1):
> +    function_data =3D function.split()
> +    # Calculate function percentage
> +    percentage =3D (float(function_data[0].replace(
> +        ',', '')) / total_number_of_instructions) * 100
> +    # Get function source path and name
> +    path, name =3D function_data[1].split(':')
> +    # Print extracted data
> +    print('{:>4}  {:>9.3f}%  {:<25}  {}'.format(index,
> +                                                round(percentage, 3),
> +                                                name,
> +                                                path))
> +
> +# Remove intermediate files
> +os.system('rm callgrind.data tmp.callgrind.data')
> --
> 2.17.1
>
>

--000000000000a9ce1205a8412126
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Ahmed=
 Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhaledkar=
aman@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Python script that prin=
ts the top 25 most executed functions in QEMU<br>
using callgrind.<br>
<br>
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---</blockquote><div><br></div><div>I think you should add an example of sc=
ript usage in the commit message (even though you mention such example in t=
he comments of the script), together with the script output for that exampl=
e.</div><div><br></div><div>Thanks,</div><div>Aleksandar</div><div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0scripts/performance/callgrind_<wbr>top_25.py | 95 +++++++++++++++++++=
++++++<br>
=C2=A01 file changed, 95 insertions(+)<br>
=C2=A0create mode 100644 scripts/performance/callgrind_<wbr>top_25.py<br>
<br>
diff --git a/scripts/performance/<wbr>callgrind_top_25.py b/scripts/perform=
ance/<wbr>callgrind_top_25.py<br>
new file mode 100644<br>
index 0000000000..03b089a96d<br>
--- /dev/null<br>
+++ b/scripts/performance/<wbr>callgrind_top_25.py<br>
@@ -0,0 +1,95 @@<br>
+#!/usr/bin/env python3<br>
+<br>
+#=C2=A0 Print the top 25 most executed functions in QEMU using callgrind.<=
br>
+#=C2=A0 Example Usage:<br>
+#=C2=A0 callgrind_top_25.py &lt;qemu-build&gt;/x86_64-linux-<wbr>user/qemu=
-x86_64 executable<br>
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
+import os<br>
+import sys<br>
+<br>
+# Ensure sufficient arguments<br>
+if len(sys.argv) &lt; 3:<br>
+=C2=A0 =C2=A0 print(&#39;Insufficient Script Arguments!&#39;)<br>
+=C2=A0 =C2=A0 sys.exit(1)<br>
+<br>
+# Get the qemu path and the executable + its arguments<br>
+(qemu, executable) =3D (sys.argv[1], &#39; &#39;.join(sys.argv[2:]))<br>
+<br>
+# Run callgrind and callgrind_annotate<br>
+os.system(&#39;valgrind --tool=3Dcallgrind --callgrind-out-file=3D<wbr>cal=
lgrind.data {} {} \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 &gt; / dev / null &amp; &amp; =
callgrind_annotate callgrind.data \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; tmp.callgrind.data&#39;.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format(qemu, executable))<br>
+<br>
+# Line number with the total number of instructions<br>
+number_of_instructions_line =3D 20<br>
+<br>
+# Line number with the top function<br>
+first_func_line =3D 25<br>
+<br>
+# callgrind_annotate output<br>
+callgrind_data =3D []<br>
+<br>
+# Open callgrind_annotate output and store it in callgrind_data<br>
+with open(&#39;tmp.callgrind.data&#39;, &#39;r&#39;) as data:<br>
+=C2=A0 =C2=A0 callgrind_data =3D data.readlines()<br>
+<br>
+# Get the total number of instructions<br>
+total_number_of_instructions =3D int(<br>
+=C2=A0 =C2=A0 callgrind_data[number_of_<wbr>instructions_line].split(&#39;=
 &#39;)[0].replace(&#39;,&#39;, &#39;&#39;))<br>
+<br>
+# Number of functions recorded by callgrind<br>
+number_of_functions =3D len(callgrind_data) - first_func_line<br>
+<br>
+# Limit the number of top functions to 25<br>
+number_of_top_functions =3D (25 if number_of_functions &gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A025 else number_of_instructions_line)<br>
+<br>
+# Store the data of the top functions in top_functions[]<br>
+top_functions =3D callgrind_data[first_func_<wbr>line:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0first_func_line + number_of_top_funct=
ions]<br>
+# Print information headers<br>
+print(&#39;{:&gt;4}=C2=A0 {:&gt;10}=C2=A0 {:&lt;25}=C2=A0 {}\n{}=C2=A0 {}=
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 25,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 30,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0))<br>
+<br>
+# Print top 25 functions<br>
+for (index, function) in enumerate(top_functions, start=3D1):<br>
+=C2=A0 =C2=A0 function_data =3D function.split()<br>
+=C2=A0 =C2=A0 # Calculate function percentage<br>
+=C2=A0 =C2=A0 percentage =3D (float(function_data[0].<wbr>replace(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;,&#39;, &#39;&#39;)) / total_number_of_in=
structions) * 100<br>
+=C2=A0 =C2=A0 # Get function source path and name<br>
+=C2=A0 =C2=A0 path, name =3D function_data[1].split(&#39;:&#39;)<br>
+=C2=A0 =C2=A0 # Print extracted data<br>
+=C2=A0 =C2=A0 print(&#39;{:&gt;4}=C2=A0 {:&gt;9.3f}%=C2=A0 {:&lt;25}=C2=A0=
 {}&#39;.format(index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 round(percentage, 3),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 path))<br>
+<br>
+# Remove intermediate files<br>
+os.system(&#39;rm callgrind.data tmp.callgrind.data&#39;)<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--000000000000a9ce1205a8412126--

