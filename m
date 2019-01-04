Received: from eggs.gnu.org ([208.118.235.92]:60734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfO7d-0007tz-Eh
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfO7c-0006zB-Lg
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:58:41 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfO7c-0006wl-90
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:58:40 -0500
Received: by mail-ot1-x343.google.com with SMTP id v23so31889505otk.9
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 03:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20190104082731.24967-1-pbonzini@redhat.com>
	<20190104082731.24967-2-pbonzini@redhat.com>
	<20190104102655.3bf599f5.cohuck@redhat.com>
	<c60f6b8a-810a-cf50-aafd-8ca3991e23c2@redhat.com>
In-Reply-To: <c60f6b8a-810a-cf50-aafd-8ca3991e23c2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 11:58:28 +0000
Message-ID: <CAFEAcA-SC_XLAmreYz61CczMdvheDvtLifnioQyY7SF_uOUhpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] scripts/update-linux-headers.sh:
 adjust for Linux 4.21-rc1 (or 5.0-rc1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 4 Jan 2019 at 11:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/01/19 10:26, Cornelia Huck wrote:
> > On Fri,  4 Jan 2019 09:27:30 +0100
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> >> There are three new indirect inclusions: vhost_types.h, which we'll
> >> shortly put to use as a portable header and thus is copied to
> >> standard-headers; and new per-subtarget versions of MIPS unistd.h
> >> and PowerPC unistd.h.
> >>
> >> Because vhost.h includes vhost_types.h, we also need a proxy include
> >> from linux/vhost.h to standard-headers.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>  scripts/update-linux-headers.sh | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >
> > I still think we could squash this change (and the description :) with
> > the headers update, but I don't object to a separate change, either.
>
> Me too, but I figured I'd rather not pull another tantrum like I did for
> multiline comments...

I do find it more easily reviewable this way, so thanks for doing
the split. Admittedly this is partly because my mail client's UI is
not very good for long messages, so this biases me towards
preferring shorter patches rather than ones which are longer
but where only a subsection of them requires close review.

I notice that we now have 3 uses of
+cat <<EOF >$output/linux-headers/linux/foo.h
+#include "standard-headers/linux/foo.h"
+EOF

(for virtio_config.h, virtio_ring.h and vhost_types.h);
next time we add one we could probably switch to a for loop,
but it doesn't make enough benefit to justify respinning
this patch.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
