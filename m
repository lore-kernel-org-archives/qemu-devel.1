Received: from eggs.gnu.org ([2001:4830:134:3::10]:39162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej072-00036U-Op
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej071-0004Mm-UW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:04:28 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:42431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej071-0004MU-Oi
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:04:27 -0500
Received: by mail-ot0-x229.google.com with SMTP id a7so1185300otk.9
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 02:04:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206095526.26436.86301.stgit@pasha-VirtualBox>
References: <20180206095526.26436.86301.stgit@pasha-VirtualBox>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 10:04:06 +0000
Message-ID: <CAFEAcA9+H_WYPUgORtcVLKMHj1D=Fqah_ibVFp-G2LOQ1n5jdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ PATCH ] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Laurent Vivier <laurent@vivier.eu>

On 6 February 2018 at 09:55, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> wro=
te:
> This set of patches includex fixes from Alex Benn=C3=A9e for fixing
> BQL and replay locks after inventing the MTTCG. It also includes some
> additional replay patches that makes this set of fixes working.
> It is also fixes some vmstate creation (and loading) issues
> in record/replay modes:
>  - VM start/stop fixes in replay mode
>  - overlay creation for blkreplay filter
>  - fixes for vmstate save/load in record/replay mode
>  - fixes for host clock vmstate

This cover letter text doesn't seem to match the patch
description?

> Pavel Dovgalyuk (1):
>       m68k: implement movep instruction
>
>
>  target/m68k/translate.c |   53 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 53 insertions(+)

thanks
-- PMM
