Received: from eggs.gnu.org ([2001:4830:134:3::10]:44605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dz60F-0006RZ-Q1
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dz60E-00051R-QG
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:03:43 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:49587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dz60E-0004zb-J7
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:03:42 -0400
Received: by mail-wm0-x235.google.com with SMTP id b189so8552877wmd.4
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 12:03:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922160111.31885-11-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-11-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 2 Oct 2017 15:03:40 -0400
Message-ID: <CAFXwXrnnvn0MStu=bPvtTVJbE7TXX-j9t6qaKGeqQTL7OnCwBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 33/34] hw/alpha: remove old i386 dependency
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
List-ID: <qemu-devel.nongnu.org>

2017-09-22 12:01 GMT-04:00 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>:

> diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
> index b6d8369ed7..ac685c1c46 100644
> --- a/hw/alpha/alpha_sys.h
> +++ b/hw/alpha/alpha_sys.h
> @@ -5,8 +5,6 @@
>
>  #include "target/alpha/cpu-qom.h"
>  #include "hw/pci/pci.h"
> -#include "hw/pci/pci_host.h"
> -#include "hw/ide.h"
>

Why are you deleting pci/pci_host.h here?
Alternately, why are you leaving pci/pci.h?


> diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
> index 8dde637bfe..c370762ea6 100644
> --- a/hw/alpha/pci.c
> +++ b/hw/alpha/pci.c
> @@ -8,6 +8,8 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_host.h"
>

One way we have a double-include of pci/pci.h here,
the other way we shouldn't re-include either.


r~
