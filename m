Received: from eggs.gnu.org ([209.51.188.92]:36702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gzV75-0005uq-Rb
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 18:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gzV74-0005Cj-FS
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 18:29:15 -0500
MIME-Version: 1.0
References: <20190228202537.4638-1-alex.bennee@linaro.org>
	<20190228202537.4638-8-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-8-alex.bennee@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 28 Feb 2019 15:29:01 -0800
Message-ID: <CAMo8BfKw-ewHXQPfz6XDFBqoxPk1vTGaEhjVEdKLm3-diuTUmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/16] tests/tcg/xtensa: enable system
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Hi Alex,

On Thu, Feb 28, 2019 at 12:25 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:

[...]

> diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa/=
Makefile.softmmu-target
> new file mode 100644
> index 0000000000..1a4014506f
> --- /dev/null
> +++ b/tests/tcg/xtensa/Makefile.softmmu-target
> @@ -0,0 +1,40 @@
> +#
> +# Xtensa softmmu tests
> +#
> +
> +ifneq ($(TARGET_WORDS_BIGENDIAN),y)

I've recently posted a series that makes it possible to run
TCG tests on wider variety of xtensa cores, including
big-endian cores:
http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg04843.html

--=20
Thanks.
-- Max
