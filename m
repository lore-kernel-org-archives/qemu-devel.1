Received: from eggs.gnu.org ([2001:4830:134:3::10]:38354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxAC2-0000Gc-0n
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 08:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxAC1-0001XU-3s
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 08:12:25 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fxAC0-0001WM-SO
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 08:12:24 -0400
Received: by mail-oi0-x242.google.com with SMTP id t68-v6so6143599oie.12
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 05:12:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ed01225b-b948-9429-a2d7-f9a5095499de@redhat.com>
References: <1536044538-22507-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8uVksn0w5Z6WBS8jXc8KtZjMgNuTk+TOPtsVgnXK4C0A@mail.gmail.com>
	<ed01225b-b948-9429-a2d7-f9a5095499de@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Sep 2018 13:12:02 +0100
Message-ID: <CAFEAcA9xt9+pnt4MSuuvzhCWv3-bpata6BG0RiD86Joo3zH4dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Save PKG_CONFIG_LIBDIR and
 WINDRES in config.status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>

On 4 September 2018 at 11:53, Thomas Huth <thuth@redhat.com> wrote:
> But still, I think at least the PKG_CONFIG_LIBDIR part could be useful,
> since the same problem e.g. also occurs when trying do a 32-bit build on
> a 64-bit host, i.e. when running configure with "--extra-cflags=-m32".
> Or is there also another configure switch that can help to get
> PKG_CONFIG_LIBDIR right here?

Personally I think the neatest way to handle 32-bit-build-on-64-bit-host
is to treat it like any other non-native build, ie have the distro
ship compiler, pkg-config, etc so that --cross-prefix=i686-linux-gnu-
works :-)

thanks
-- PMM
