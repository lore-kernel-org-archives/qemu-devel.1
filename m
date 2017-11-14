Received: from eggs.gnu.org ([2001:4830:134:3::10]:35801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEVIL-00038J-L2
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEVIH-0000dZ-DX
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:06:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEVIH-0000bm-7D
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:06:01 -0500
Date: Tue, 14 Nov 2017 08:05:58 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171114070558.kydby4zt5hhnser4@sirius.home.kraxel.org>
References: <CAOvnNvYpQSdM5PXoBZXwf6op+FVNd3j0CPBnKGqxfa2V3pnJjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOvnNvYpQSdM5PXoBZXwf6op+FVNd3j0CPBnKGqxfa2V3pnJjA@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu+virgl on systems without dmabuf and/or GBM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joe Kniss <djmk@google.com>
Cc: qemu-devel@nongnu.org, Dave Airlie <airlied@redhat.com>

On Mon, Nov 13, 2017 at 04:15:30PM -0800, Joe Kniss wrote:
> Hi,
> 
>   I am developing using qemu with virglrenderer on linux systems that
> do not support dmabufs or GBM.   I have been successful making this
> work using glx and ignoring egl/dmabuf/gbm use in qemu.

nvidia?
Which user interface?

> Unfortunately, there is currently no way to configure qemu to use
> opengl but disable egl/dmabuf/gbm.

Wrong.  dmabuf support is purely optional.  And egl is required (at
runtime) only in case qemu creates the opengl context by itself.  qemu
happily uses opengl contexts created by sdl2 or gtk (3.16+ GtkGlArea)
even if they are glx contexts.  dmabuf sharing obviously doesn't work
then, but you don't need that for virgl + local display.

> 1) Check for gbm in configure, if it is unavailable disable ui/egl*
> since this egl implementation depends on gbm.
> 2) Check for gbm in configure, modify ui/egl* to work when gbm is missing.
> 3) Add disable-egl flag to configure, ignore gbm package when egl is disabled.

I don't think any of this is needed.  Also this should be decided at
runtime not compile time.

cheers,
  Gerd
