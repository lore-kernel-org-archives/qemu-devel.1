Received: from eggs.gnu.org ([2001:4830:134:3::10]:53717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ea2XS-0005Fu-OJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ea2XR-0002nh-1i
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:50:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ea2XQ-0002mo-RE
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:50:40 -0500
Date: Fri, 12 Jan 2018 16:50:29 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180112165029.GP17392@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
	<20180112125854.18261-13-kraxel@redhat.com>
	<CAFEAcA94QnxHqnhwEzY=U4eiSs5agnEbi8TSViQ8kk=ywEW5Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA94QnxHqnhwEzY=U4eiSs5agnEbi8TSViQ8kk=ywEW5Dg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 12, 2018 at 04:40:32PM +0000, Peter Maydell wrote:
> On 12 January 2018 at 12:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> 
> Hi Dan: just FYI:
> 
> > The previous patches fix problems with throttling of forced framebuffer updates
> > and audio data capture that would cause the QEMU output buffer size to grow
> > without bound. Those fixes are graceful in that once the client catches up with
> > reading data from the server, everything continues operating normally.
> 
> 12345678901234567890123456789012345678901234567890123456789012345678901234567890
>          1         2         3         4         5         6         7         8
> 
> Your wrap settings on your editor for git commit messages seem to be a
> bit mis-set -- wrapping around 72 cols or so is recommended.
> 
> I've applied the pullreq but noticed in passing that git log wraps
> a bit awkwardly on an 80-column xterm.

Thanks, I'll see about fixing that

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
