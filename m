Received: from eggs.gnu.org ([2001:4830:134:3::10]:49260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea2Nz-0007H5-Fm
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea2Ny-0002YC-Mk
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:40:55 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:43013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea2Ny-0002XG-JF
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:40:54 -0500
Received: by mail-oi0-x22c.google.com with SMTP id t16so4284843oif.10
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 08:40:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180112125854.18261-13-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
	<20180112125854.18261-13-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 16:40:32 +0000
Message-ID: <CAFEAcA94QnxHqnhwEzY=U4eiSs5agnEbi8TSViQ8kk=ywEW5Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 12/14] ui: place a hard cap on VNC server
 output buffer size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 12 January 2018 at 12:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>

Hi Dan: just FYI:

> The previous patches fix problems with throttling of forced framebuffer updates
> and audio data capture that would cause the QEMU output buffer size to grow
> without bound. Those fixes are graceful in that once the client catches up with
> reading data from the server, everything continues operating normally.

12345678901234567890123456789012345678901234567890123456789012345678901234567890
         1         2         3         4         5         6         7         8

Your wrap settings on your editor for git commit messages seem to be a
bit mis-set -- wrapping around 72 cols or so is recommended.

I've applied the pullreq but noticed in passing that git log wraps
a bit awkwardly on an 80-column xterm.

thanks
-- PMM
