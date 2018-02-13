Received: from eggs.gnu.org ([2001:4830:134:3::10]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elXSx-0002ZV-MV
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elXSw-0004wU-Mu
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:05:35 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:42560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elXSw-0004wE-EY
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:05:34 -0500
Received: by mail-ot0-x22c.google.com with SMTP id a7so16829447otk.9
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 02:05:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180213072150.32252-1-richard.henderson@linaro.org>
References: <20180213072150.32252-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 10:05:12 +0000
Message-ID: <CAFEAcA_Nj8ToSr2cDZja9qMiTVanhGAwLcj4LNFW4z2MjJpNmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] scripts: Add decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 February 2018 at 07:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> To be used to decode ARM SVE, but could be used for any fixed-width ISA.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>  create mode 100755 scripts/decodetree.py
>  create mode 100755 tests/decode/check.sh
>  create mode 100644 tests/decode/err_argset1.def
>  create mode 100644 tests/decode/err_argset2.def
>  create mode 100644 tests/decode/err_field1.def
>  create mode 100644 tests/decode/err_field2.def
>  create mode 100644 tests/decode/err_field3.def
>  create mode 100644 tests/decode/err_field4.def
>  create mode 100644 tests/decode/err_field5.def
>  create mode 100644 tests/decode/err_init1.def
>  create mode 100644 tests/decode/err_init2.def
>  create mode 100644 tests/decode/err_init3.def
>  create mode 100644 tests/decode/err_init4.def
>  create mode 100644 tests/decode/err_overlap1.def
>  create mode 100644 tests/decode/err_overlap2.def
>  create mode 100644 tests/decode/err_overlap3.def
>  create mode 100644 tests/decode/err_overlap4.def
>  create mode 100644 tests/decode/err_overlap5.def
>  create mode 100644 tests/decode/err_overlap6.def
>  create mode 100644 tests/decode/err_overlap7.def
>  create mode 100644 tests/decode/err_overlap8.def
>  create mode 100644 tests/decode/err_overlap9.def
>

Trivial-but-important nit: all these new files are missing
copyright-and-license comment headers.

thanks
-- PMM
