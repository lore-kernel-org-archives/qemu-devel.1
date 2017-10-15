Received: from eggs.gnu.org ([2001:4830:134:3::10]:40533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1e3jUE-0005ak-D1
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 10:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1e3jUB-0005Es-CT
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 10:01:50 -0400
Date: Sun, 15 Oct 2017 16:01:41 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20171015160141.75690306@naga>
In-Reply-To: <CAFEAcA9Vmrz3NTfJcSteyxvRvtb3VuCXZd=aOTL-GrWL3cm8bg@mail.gmail.com>
References: <CA+J4q6dO+V32yF11jFD2jAizigYoZS6eECyuDTgRVfe+a_JUJQ@mail.gmail.com>
	<1507878038.21465.3.camel@redhat.com>
	<CAFEAcA9Vmrz3NTfJcSteyxvRvtb3VuCXZd=aOTL-GrWL3cm8bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU without X11 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, hanji unit <hanjiunit@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss <qemu-discuss@nongnu.org>

On Fri, 13 Oct 2017 17:08:49 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 13 October 2017 at 08:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > On Thu, 2017-10-12 at 16:25 -0400, hanji unit wrote:  
> >> Hello, is it possible to run (or rebuild modifying build flags)
> >> QEMU without support for X11 window system integration?  
> >
> > ./configure --disable-gtk --disable-sdl --disable-opengl  
> 
> You can also use the runtime -display options (assuming
> your development environment has the libraries
> and your runtime environment has them installed, there's
> no harm in having a QEMU that was built with gtk support
> and not using the gtk UI.)
> 
> There are a couple of parts to this:
>  (1) does your guest OS require a graphics device?
> (eg typically Windows does, ARM Linux will happily use
> a serial port)
>  (2) if you do need a graphics device, where does the
> output go?
> (eg you can tell QEMU to just not show graphics at
> all with -display none, use -display vnc to for a VNC
> server, etc. Some of the -display options will use
> X11, and some won't.)

iirc you also need to specify -nographic so qemu does not try to use the
X11 GUI to display your serial output.

HTH

Michal
