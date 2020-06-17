Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA06AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3536B2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCZib9b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3536B2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlX5O-0006rU-4D
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 08:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlX44-0005Da-K8
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:21:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlX42-0001K5-8t
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:21:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id q25so1778410wmj.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3ffSbh7MDvIAomAUIQQj25oEPz06XLK3ktbJDVls1Tg=;
 b=pCZib9b56zqTsJxWEyU/qv9OB3VWcoTfY+EbNdLe8KRQvw4oKgnlAfQv5PywtFsy17
 VeNGowZBXye2v3MQnH+Oz+nLGfFhDZut+wUD6fnZbzjk6j5wzaOAhJlKLiL0rYeDxNj/
 YIF+L8MHaK0LY8n8sWB2BWpaNiEzEzcD55U3jVnIdaWW8awBPyS53V2YSNSoCQWu8LtU
 pt+3lfGsRdiIRAAQG1XrLv0IxOvChGYdOjR6NhQs6ZKqFqI2sty0QCS+zMGY5DZL6rMQ
 Xq2CPhdwsgcEUCfxM42gsCdlHHd2kZTQ1mkb5NZPFbfodOlvBLlyes7U1h/FFADESb+0
 3P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3ffSbh7MDvIAomAUIQQj25oEPz06XLK3ktbJDVls1Tg=;
 b=RrCkeXfYkwfgxpOkkc6gbS0Qs28SiOekop6vji2HqwQ8XXkXBmTcWoUV82mNw8Xhxj
 suwEjtevuQYLeEynDSxzDLcM5S79HFvZPBjowbtxQKzBEmHy4usT1jbZfPFK5lU9ihfu
 g4792XYBGu037lPLkMMjdiRjMwiQJOXlPznLpf2y3ZdfW/yMvU2S9Opj3feChSk5ughY
 MFnKxRymRTy7h4+D/TjtlSslHctb84iOycB9HLkul3jvuV8VahDMMJVKq1wX8KJ/HZf2
 92qaMuiVRPargaJeSGltcYZuwqHhYzkE8dLN9K1i1duIg19/eum1DMakIxqwj0zv2ifV
 ukag==
X-Gm-Message-State: AOAM5319jUmrvtTkPUGlIKXc82AXgTM0FgtwiLz7vGMM26OEE4GLZgGX
 wb79BJQOm7en3NZxPAPWdDbvFw==
X-Google-Smtp-Source: ABdhPJxoIFURkjxqwAFIspo+9GiM0P27ilhDygM9gwlC4o3+n4Xju6l8jKGa04wi0PxFnUQqIxVhNg==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr7858566wmi.7.1592396468570;
 Wed, 17 Jun 2020 05:21:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x66sm185030wmb.40.2020.06.17.05.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 05:21:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5BC3C1FF7E;
 Wed, 17 Jun 2020 13:21:06 +0100 (BST)
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-4-ahmedkhaledkaraman@gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Subject: Re: [PATCH 3/3] scripts/performance: Add perf_top_25.py script
In-reply-to: <20200616231204.8850-4-ahmedkhaledkaraman@gmail.com>
Date: Wed, 17 Jun 2020 13:21:06 +0100
Message-ID: <871rmdyjbh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
> using perf.
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  scripts/performance/perf_top_25.py | 82 ++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 scripts/performance/perf_top_25.py
>
> diff --git a/scripts/performance/perf_top_25.py b/scripts/performance/per=
f_top_25.py
> new file mode 100644
> index 0000000000..eaa8cce3c3
> --- /dev/null
> +++ b/scripts/performance/perf_top_25.py
> @@ -0,0 +1,82 @@
> +#!/usr/bin/env python3
> +
> +#  Print the top 25 most executed functions in QEMU using perf.
> +#  Example Usage:
> +#  perf_top_25.py <qemu-build>/x86_64-linux-user/qemu-x86_64 executable
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
> +(qemu_path, executable) =3D (sys.argv[1], ' '.join(sys.argv[2:]))

Same comments as other script.

> +
> +# Run perf repcord and report
> +os.system('sudo perf record {} {} 2> /dev/null \
> +            && sudo perf report --stdio > tmp.perf.data'
> +          .format(qemu_path, executable))

Why sudo?

Also redirecting just stderr? why?

I think you could separate the steps (as well as use the subprocess
api).

> +
> +# Line number with the top function
> +first_func_line =3D 11
> +
> +# Perf report output
> +perf_data =3D []
> +
> +# Open perf report output and store it in perf_data
> +with open('tmp.perf.data', 'r') as data:
> +    perf_data =3D data.readlines()
> +
> +# Number of functions recorded by perf
> +number_of_functions =3D len(perf_data) - first_func_line
> +
> +# Limit the number of top functions to 25
> +number_of_top_functions =3D (25 if number_of_functions >
> +                           25 else number_of_functions)
> +
> +# Store the data of the top functions in top_functions[]
> +top_functions =3D perf_data[first_func_line:first_func_line
> +                          + number_of_top_functions]
> +
> +# Print information headers
> +print('{:>4}  {:>10}  {:<25}  {}\n{}  {}  {}  {}'.format('No.',
> +                                                         'Percentage',
> +                                                         'Name',
> +                                                         'Caller',
> +                                                         '-' * 4,
> +                                                         '-' * 10,
> +                                                         '-' * 25,
> +                                                         '-' * 25,
> +                                                         ))
> +
> +# Print top 25 functions
> +for (index, function) in enumerate(top_functions, start=3D1):
> +    function_data =3D function.split()
> +    print('{:>4}  {:>10}  {:<25}  {}'.format(index,
> +                                             function_data[0],
> +                                             function_data[-1],
> +                                             ' '.join(function_data[2:-2=
])))
> +
> +# Remove intermediate files
> +os.system('sudo rm perf.data tmp.perf.data')

Again os.unlink()

--=20
Alex Benn=C3=A9e

