Received: from eggs.gnu.org ([2001:4830:134:3::10]:37348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e32WQ-0005U0-AG
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e32WP-0002bP-5D
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:09:14 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:48743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e32WO-0002a3-Tx
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:09:13 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i124so22301416wmf.3
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:09:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507878038.21465.3.camel@redhat.com>
References: <CA+J4q6dO+V32yF11jFD2jAizigYoZS6eECyuDTgRVfe+a_JUJQ@mail.gmail.com>
	<1507878038.21465.3.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Oct 2017 17:08:49 +0100
Message-ID: <CAFEAcA9Vmrz3NTfJcSteyxvRvtb3VuCXZd=aOTL-GrWL3cm8bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU without X11 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: hanji unit <hanjiunit@gmail.com>, qemu-discuss <qemu-discuss@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 October 2017 at 08:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Thu, 2017-10-12 at 16:25 -0400, hanji unit wrote:
>> Hello, is it possible to run (or rebuild modifying build flags) QEMU
>> without support for X11 window system integration?
>
> ./configure --disable-gtk --disable-sdl --disable-opengl

You can also use the runtime -display options (assuming
your development environment has the libraries
and your runtime environment has them installed, there's
no harm in having a QEMU that was built with gtk support
and not using the gtk UI.)

There are a couple of parts to this:
 (1) does your guest OS require a graphics device?
(eg typically Windows does, ARM Linux will happily use
a serial port)
 (2) if you do need a graphics device, where does the
output go?
(eg you can tell QEMU to just not show graphics at
all with -display none, use -display vnc to for a VNC
server, etc. Some of the -display options will use
X11, and some won't.)
 (3) do you want to specifically avoid any dynamic
library dependency between QEMU and the X11 libs,
or do you just not want to have to use X11 to
display?
(see above about compiling out if necessary)

thanks
-- PMM
