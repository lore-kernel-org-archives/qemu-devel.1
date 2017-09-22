Received: from eggs.gnu.org ([2001:4830:134:3::10]:45453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvR2l-0005YW-DB
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvR2j-00063M-6f
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:43:11 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:47535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvR2i-00061G-NO
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:43:08 -0400
Received: by mail-wr0-x236.google.com with SMTP id k20so1354927wre.4
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:43:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-8-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 17:42:46 +0100
Message-ID: <CAFEAcA-uWrGNn=8--NEFXFeJe613CZv04a9Jo5eNrvM-3J87eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/34] i386/hax: remove duplicated includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yu Ning <yu.ning@linux.intel.com>, Vincent Palatin <vpalatin@chromium.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 22 September 2017 at 16:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> applied using ./scripts/clean-includes
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/sysemu/hax.h      | 1 -
>  target/i386/hax-darwin.h  | 3 ---
>  target/i386/hax-windows.h | 2 --
>  target/i386/hax-darwin.c  | 8 ++------
>  4 files changed, 2 insertions(+), 12 deletions(-)

I suspect the includes in hax-windows.h could be trimmed a bit
more (since we're guaranteed that if CONFIG_WIN32 then we've
included sysemu/os-win32.h), but this is fine as it stands.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
