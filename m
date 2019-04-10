Received: from eggs.gnu.org ([209.51.188.92]:50027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEGVg-0005dY-2x
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEGVf-00080M-1G
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:55:39 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEGVe-0007zf-OJ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:55:38 -0400
Received: by mail-oi1-x242.google.com with SMTP id j132so2397042oib.2
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 09:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190410162918.9343-1-mreitz@redhat.com>
	<aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
	<3620d581-c849-f768-b9d4-239ff09f174f@redhat.com>
In-Reply-To: <3620d581-c849-f768-b9d4-239ff09f174f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 17:55:25 +0100
Message-ID: <CAFEAcA-iOuvsPoUGNOCaJFBsaC-D7WcxM3X_2FNw1r_gsb8SxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotests: Let 245 pass on tmpfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 10 Apr 2019 at 17:40, Max Reitz <mreitz@redhat.com> wrote:
>
> On 10.04.19 18:39, Eric Blake wrote:
> > On 4/10/19 11:29 AM, Max Reitz wrote:
> >> tmpfs does not support O_DIRECT.  Detect this case, and skip flipping
> >> @direct if the filesystem does not support it.
> >>
> >> Fixes: bf3e50f6239090e63a8ffaaec971671e66d88e07
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  tests/qemu-iotests/245 | 10 ++++++++--
> >>  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > Are you trying to get this in 4.0-rc3? (As a test, it has no bearing on
> > the actual binaries; fewer testsuite failures are nice if we squeeze it
> > in, but at the same time it is not enough to delay the release if it
> > does not get fixed until 4.1).
> >
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>
> If there are other patches for rc3, we could take this as well.  But
> there is no point in making a pull request just for this.

rc3 has been tagged already, I'm afraid. rc4 will be only
if something release-critical crops up.

thanks
-- PMM
