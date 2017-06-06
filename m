Received: from eggs.gnu.org ([2001:4830:134:3::10]:49098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIBF2-00005g-KF
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIBF1-0008Gl-Ug
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:57:36 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIBF1-0008GQ-OB
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:57:35 -0400
Received: by mail-wr0-x229.google.com with SMTP id v104so51734931wrb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 02:57:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170602160848.4913-6-alex.bennee@linaro.org>
References: <20170602160848.4913-1-alex.bennee@linaro.org>
	<20170602160848.4913-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 10:57:14 +0100
Message-ID: <CAFEAcA_g6u+bsmb2JkqmBmy-N14BHFcTJTsvUTO27_q1nmbYgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v4 05/10] risu: paramterise
 send/receive functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 June 2017 at 17:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> This is a precursor to record/playback support. Instead of passing the
> socket fd we now pass helper functions for reading/writing and
> responding. This will allow us to do the rest of the record/playback
> cleanly outside of the main worker function.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> -        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
> +         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
>              /* register mismatch */
>              resp =3D 2;
> -
> -        } else if (op =3D=3D OP_TESTEND) {
> +         } else if (op =3D=3D OP_TESTEND) {
>              resp =3D 1;
> -        }

[etc]

If you're going to fix the indent can you put that in
its own patch, please? Much easier to review that way.

thanks
-- PMM
