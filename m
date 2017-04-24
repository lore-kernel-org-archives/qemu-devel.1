Received: from eggs.gnu.org ([2001:4830:134:3::10]:34530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2loU-0003Oy-Pn
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 17:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2loT-0001Ey-SE
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 17:46:30 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2loT-0001EP-Ky
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 17:46:29 -0400
Received: by mail-wm0-x236.google.com with SMTP id r190so80289415wme.1
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 14:46:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1704241423030.16723@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<CAFEAcA-F4mKWyknfRWhJfymJxbsYPvWH20CSecTmY8-kq-dipA@mail.gmail.com>
	<alpine.DEB.2.10.1704241423030.16723@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 22:46:07 +0100
Message-ID: <CAFEAcA8CWYCxVauuWSsmuQw4YG1O0DO+rYASm2aVhirp3Z3mZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/21] Please pull xen-20170421-tag for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On 24 April 2017 at 22:25, Stefano Stabellini <sstabellini@kernel.org> wrote:
> diff --git a/hw/9pfs/xen-9pfs.h b/hw/9pfs/xen-9pfs.h
> new file mode 100644
> index 0000000..18f0ec0
> --- /dev/null
> +++ b/hw/9pfs/xen-9pfs.h
> @@ -0,0 +1,14 @@
> +/*
> + * Xen 9p backend
> + *
> + * Copyright Aporeto 2017
> + *
> + * Authors:
> + *  Stefano Stabellini <stefano@aporeto.com>
> + *
> + */

Trivial file, but I prefer it if we have a brief license
statement in every file, just to be clear (it might
accumulate more code later).

> +
> +#include <xen/io/protocols.h>
> +#include "hw/xen/io/ring.h"
> +
> +DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);

Is it worth a comment to dissuade people from thinking they can
inline the file back into xen-9p-backend.c ?

thanks
-- PMM
