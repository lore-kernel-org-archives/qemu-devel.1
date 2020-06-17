Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C5BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E9720786
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riRFYKt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E9720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlX0b-0002dp-1z
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 08:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlWzX-0002CL-Ky
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:16:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlWzT-0000WA-SC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:16:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id p5so2076326wrw.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 05:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=h9ZYTaMTAbymGYiu+Ec55XZKBmDOY2VQk2+M+APm2Hk=;
 b=riRFYKt1UlKrEtK0MsIk0Tm8Wl2IHnCO8isJk7OC6yQqCZIOEoPfy3Xf0/F5UhFmUF
 o1ZzOCl0wvUDN10E/VOjR3m9arCF+uxpP+UFw/wRrcTdrSifCl5dGCFFp8W6UXml+3vR
 zBBvngMNvHbKbwFtfzWfM4odiS/Z0g52xMu1foYYEMxZM9DIazCQR0uBSZf9YNqd2TqU
 X+BVVzJIcOK+ewYQX9LoUf9Fkon0GM0AzQMJei8MAKvpJuoWoQTu8jVaq9mZuCN1XGDN
 CgGI15PHSMQCPQMP6PhA1rEnJkZ4E/Q/YXp4uh+Jl0ybTsgm+3ZbdyUDdLmCMvwy59fq
 FCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=h9ZYTaMTAbymGYiu+Ec55XZKBmDOY2VQk2+M+APm2Hk=;
 b=VHw2vPLWxdAsxUS0MfcwX8OXAUUjJUGcPb7cIms/l6DGjBLymMY9DApFRiQmn4T3Y5
 lbuRtzZq6BstlRL7X9GgygtsI/S7CLPlRiHYewn7XjLXW1QSA3NgW8lOgLHIL4slTfL4
 oH4rYq46KTbC87WVw3+ynAH9Pe5pDP+7irccTZtObbfLpVaBj2DE9ovlouza19uLsbIz
 VefiHRX2ApMKO4gKssMamchShFljIA99KdL5o9NtA2ag8riFZWG0IY3YcHeGk/7NRK2o
 arlS/1YBBSQX0vg9rFjiwMbtdK59yGu2deM19j2ctj2O3XDNazHeeRqFaPm4dRMKJFcr
 tilA==
X-Gm-Message-State: AOAM5323evZatOubebq5GZOUzQd5B5ALnMbC38w/CmjI4DEbq8jyC0Xt
 FfLSHmTaggfa0ywg2UwlejcXUw==
X-Google-Smtp-Source: ABdhPJziWtQZW8HWbgo7BkHDoa1HEQxu6nAZVelyQ5WxLF/XLkJ69BlnN0LSjMTY9KxQi/kIV+5kPA==
X-Received: by 2002:adf:fd8b:: with SMTP id d11mr6893627wrr.371.1592396185986; 
 Wed, 17 Jun 2020 05:16:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm232118wmy.0.2020.06.17.05.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 05:16:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DCB671FF7E;
 Wed, 17 Jun 2020 13:16:23 +0100 (BST)
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-3-ahmedkhaledkaraman@gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Subject: Re: [PATCH 2/3] scripts/performance: Add callgrind_top_25.py script
In-reply-to: <20200616231204.8850-3-ahmedkhaledkaraman@gmail.com>
Date: Wed, 17 Jun 2020 13:16:23 +0100
Message-ID: <874kr9yjjc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: ldoktor@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, crosa@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:

> Python script that prints the top 25 most executed functions in QEMU
> using callgrind.
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  scripts/performance/callgrind_top_25.py | 95 +++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 scripts/performance/callgrind_top_25.py
>
> diff --git a/scripts/performance/callgrind_top_25.py b/scripts/performanc=
e/callgrind_top_25.py
> new file mode 100644

You will want the script to be +x if the user is to execute it.

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

Why limit to 25, make the name generic and maybe just default to 25
unless the user specifies a different option.

> +#
> +#  This file is a part of the project "TCG Continuous Benchmarking".
> +#
> +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.=
com>
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

I would recommend using:

  from argparse import ArgumentParser

from the start as adding options with hand parsing will be a pain. I
would suggest a specific option for the qemu binary and then using a
positional argument that can be read after -- so you don't confuse
options.

> +
> +# Run callgrind and callgrind_annotate
> +os.system('valgrind --tool=3Dcallgrind --callgrind-out-file=3Dcallgrind.=
data {} {} \
> +            2 > / dev / null & & callgrind_annotate callgrind.data \
> +            > tmp.callgrind.data'.
> +          format(qemu, executable))

Direct os.system calls are discouraged, you tend to get weird effects
like:

  ../../scripts/performance/callgrind_top_25.py ./aarch64-linux-user/qemu-a=
arch64 ./tests/tcg/aarch64-linux-user/fcvt
  sh: 1: Syntax error: "&" unexpected
  Traceback (most recent call last):
    File "../../scripts/performance/callgrind_top_25.py", line 52, in <modu=
le>
      with open('tmp.callgrind.data', 'r') as data:
  FileNotFoundError: [Errno 2] No such file or directory: 'tmp.callgrind.da=
ta'

I would:

  - check for valgrind in path and fail gracefully if not found
  - use os.subprocess API for launching (with or without the shell)

> +
> +# Line number with the total number of instructions
> +number_of_instructions_line =3D 20
> +
> +# Line number with the top function
> +first_func_line =3D 25

for example

    parser.add_argument('-n', dest=3D"top", type=3Dint, default=3D25,
                        help=3D"Hottest n functions")

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

There is no harm in having your steps split out a little.

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
> +                               first_func_line + number_of_top_functions]
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

os.unlink()

--=20
Alex Benn=C3=A9e

