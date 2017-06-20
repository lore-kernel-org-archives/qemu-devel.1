Received: from eggs.gnu.org ([2001:4830:134:3::10]:41981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJwb-00026W-0t
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJwa-00013f-4E
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:15:49 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJwZ-00013a-U7
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:15:48 -0400
Received: by mail-wr0-x235.google.com with SMTP id y25so53651422wrd.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:15:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-12-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-12-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:15:26 +0100
Message-ID: <CAFEAcA8qFt0LDA7EnTZ9xHVLu92-VCHgWrx0DjVLz-ch0vtkzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 11/13] risu: add support compressed
 tracefiles
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

On 19 June 2017 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> This uses the magic of zlib's gzread/write interface to wrap the
> tracefile in compression. The code changes are tiny. I spent more time
> messing about with the configure/linker stuff to auto-detect bits.
>
> As you need decent multi-arch support or a correctly setup cross
> toolchain we fall back if we can't compile with zlib. This
> unfortunately needs some #ifdef hackery around the zlib bits in
> risu.c.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(it would be nice if we could just mandate gzip, but
we could spend a lot of time messing about here that
doesn't seem worthwhile.)

thanks
-- PMM
