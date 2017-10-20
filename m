Received: from eggs.gnu.org ([2001:4830:134:3::10]:45806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5Uqz-00052e-3P
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5Uqy-0005xN-EL
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:48:37 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5Uqy-0005ws-7D
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:48:36 -0400
Received: by mail-wm0-x243.google.com with SMTP id u138so21820752wmu.4
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 03:48:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171020101219.2378-1-pbonzini@redhat.com>
References: <20171020101219.2378-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2017 11:48:14 +0100
Message-ID: <CAFEAcA9uEmoxgF4Ra9+u==kyou3GHw9BzuXJn1RGuraikY1h3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] build: disable -Wmissing-braces on older
 compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

On 20 October 2017 at 11:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
> GCC 4.9 and newer stopped warning for missing braces around the
> "universal" C zero initializer {0}.  One such initializer sneaked
> into scsi/qemu-pr-helper.c and is breaking the build with such
> older GCC versions.
>
> Detect the lack of support for the idiom, and disable the warning
> in that case.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

AFAIK "{}" will work and not be warned about anywhere (we
use it extensively already) so you don't need to fall back to
memset...

thanks
-- PMM
