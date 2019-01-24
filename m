Received: from eggs.gnu.org ([209.51.188.92]:56713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmdPw-0002S1-TL
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmdPm-0006YR-U5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:43:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmdPf-0006E4-3z
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:43:17 -0500
Date: Thu, 24 Jan 2019 12:43:05 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124114305.bdxz76bsxk5lvc3d@sirius.home.kraxel.org>
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190124011554.25418-5-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/display/milkymist-tmu2: Move
 inlined code from header to source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>

On Thu, Jan 24, 2019 at 02:15:54AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Move the complexity of milkymist_tmu2_create() into the
> source file. Doing so we avoid to include the X11/OpenGL
> headers in all LM32 devices, and we also avoid the duplicate
> declaration of glx_fbconfig_attr[] (it is already declared
> in hw/display/milkymist-tmu2.c).
> Since TYPE_MILKYMIST_TMU2 is now accessible, use it.

Oops, fails the build:

  LINK    lm32-softmmu/qemu-system-lm32
hw/lm32/milkymist.o: In function `milkymist_init':
milkymist.c:(.text+0xb0f): undefined reference to `milkymist_tmu2_create'

cheers,
  Gerd
