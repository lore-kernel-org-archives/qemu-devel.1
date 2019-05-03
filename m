Received: from eggs.gnu.org ([209.51.188.92]:52691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMTKh-0002sR-Oy
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMTKg-00017b-NL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:14:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hMTKg-00016d-HY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:14:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id t76so5992582wmt.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 01:14:14 -0700 (PDT)
Date: Fri, 3 May 2019 10:14:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190503081410.kzdcwk4yei4qa7fc@steredhat>
References: <20190425133503.30847-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425133503.30847-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] security.rst: add Security Guide to
 developer docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Otubo <otubo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Thu, Apr 25, 2019 at 02:35:03PM +0100, Stefan Hajnoczi wrote:
> At KVM Forum 2018 I gave a presentation on security in QEMU:
> https://www.youtube.com/watch?v=YAdRf_hwxU8 (video)
> https://vmsplice.net/~stefan/stefanha-kvm-forum-2018.pdf (slides)
> 
> This patch adds a security guide to the developer docs.  This document
> covers things that developers should know about security in QEMU.  It is
> just a starting point that we can expand on later.  I hope it will be
> useful as a resource for new contributors and will save code reviewers
> from explaining the same concepts many times.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Added mention of passthrough USB and PCI devices [philmd]
>  * Reworded resource limits [philmd]
>  * Added qemu_log_mask(LOG_GUEST_ERROR) [philmd]
> ---
>  docs/devel/index.rst    |   1 +
>  docs/devel/security.rst | 225 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 226 insertions(+)
>  create mode 100644 docs/devel/security.rst
> 

Very useful docs!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
