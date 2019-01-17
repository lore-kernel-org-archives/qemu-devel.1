Received: from eggs.gnu.org ([209.51.188.92]:57820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk67F-0006Ry-P0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk67F-0005n6-4A
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:45 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gk67E-0005mN-MM
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:45 -0500
Received: by mail-oi1-x241.google.com with SMTP id u18so5877097oie.10
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 03:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20190116041712.130183-1-aik@ozlabs.ru>
	<20190116124748.7c64c90e.cohuck@redhat.com>
	<96b377b0-7104-f123-c02d-a93364a3e119@redhat.com>
In-Reply-To: <96b377b0-7104-f123-c02d-a93364a3e119@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 11:25:31 +0000
Message-ID: <CAFEAcA8ZQSM6-cz2ZsDGqOzwYOtKy8s0h4x6b6XzTNDJrWN+mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH qemu 0/2] linux-headers: Update to v5.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 16 Jan 2019 at 11:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 16/01/19 12:47, Cornelia Huck wrote:
> > On Wed, 16 Jan 2019 15:17:10 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >
> >> Here is the update script update and what it did to the v5.0-rc2 kernel.
> >>
> >> This is based on sha1
> >> a0a8bff Greg Kurz "target/ppc/kvm: Drop useless include directive".
> >>
> >> Please comment. Thanks.
> >
> > Hm, Paolo had already posted an update to -rc1 (including an update of
> > the script). Not sure what the status of that one is?
>
> It's queued in my next pull request.

Does the pullreq also have a fix for the virtio_balloon_get_config()
bug that will manifest when the kernel headers get extra fields
in struct virtio_balloon_config ?

thanks
-- PMM
