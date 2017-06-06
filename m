Received: from eggs.gnu.org ([2001:4830:134:3::10]:50750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIEnd-0003EN-Mm
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIEnc-00089u-SI
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:45:33 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIEnc-00089g-L2
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:45:32 -0400
Received: by mail-wm0-x235.google.com with SMTP id 7so97960395wmo.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 06:45:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170602160848.4913-9-alex.bennee@linaro.org>
References: <20170602160848.4913-1-alex.bennee@linaro.org>
	<20170602160848.4913-9-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 14:45:10 +0100
Message-ID: <CAFEAcA-ZYs-JHrK1S==UKmOD99CJOEHKPyHMHMkacNGh2XDguQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v4 08/10] risu: add support compressed
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

On 2 June 2017 at 17:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
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
>
> --
> v4
>   - removed redundant config.h output, added HAVE_ZLIB
>   - added BUILD_INC to deal with out-of-tree builds

I thought the trace files were so enormous that zlib was
basically mandatory for the record/replay to be useful?
I'm wondering if we should use a submodule for zlib and
just build it locally. That would let us just make it a
hard requirement (and avoid the need to do things with
docker).

thanks
-- PMM
