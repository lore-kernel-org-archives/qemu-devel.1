Received: from eggs.gnu.org ([2001:4830:134:3::10]:40767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW5Kh-0001lL-61
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW5Kg-00059i-Em
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:56:39 -0500
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d]:33127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW5Kg-00059I-A5
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:56:38 -0500
Received: by mail-vk0-x22d.google.com with SMTP id k127so117000073vke.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:56:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170124192723-mutt-send-email-mst@kernel.org>
References: <CAF++6APW69OBEzfUaWXK-kXLY5euu8aJjvFrYzwFT1tes-W=gA@mail.gmail.com>
	<CAFEAcA-aEA9cNzd6cJchrdojyX7xKr4eOKECkMEen=fhGucCPA@mail.gmail.com>
	<20170124192723-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 17:56:17 +0000
Message-ID: <CAFEAcA8tuP_O=HJ6f1=-H1tz_c+ZUw-OOK=WS362XKt-qcvu3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] changeset b0cb0a66d broken - missing
 QEMU_OPTION_enable_hax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: James Hanley <jhanley@dgtlrift.com>, Vincent Palatin <vpalatin@chromium.org>, qemu-devel <qemu-devel@nongnu.org>

On 24 January 2017 at 17:28, Michael S. Tsirkin <mst@redhat.com> wrote:
> Maybe we should change the include order to always prefer
> the build tree files if there?

If we can do that it would be nice.

> An alternative is to do what Linux does, create a
> file in tree when doing a build, and then make an
> out of tree one fail and suggest distclean.

We already try to do that -- Makefile looks for
config-host.mak in the source tree and suggests a
rune involving distclean. The check isn't perfect,
though (and nor is the Linux kernel's -- I lost an
hour or so the other week to a problem that turned
out to be stale junk in the kernel source tree that I
fixed with a 'make mrproper').

thanks
-- PMM
