Received: from eggs.gnu.org ([2001:4830:134:3::10]:46734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEE1I-0002Kf-P9
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEE1E-00044z-Rp
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:39:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEE1E-00044e-LH
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:39:16 -0500
Date: Mon, 13 Nov 2017 13:39:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171113123914.qvj7bjhdx4h5rx4d@sirius.home.kraxel.org>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
	<20171112193032.9724-2-makovick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171112193032.9724-2-makovick@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] sdl2: Fix broken display updating
 after the window is hidden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>

On Sun, Nov 12, 2017 at 08:30:25PM +0100, Jindrich Makovicka wrote:
> With SDL 2.0.6, calling SDL_ShowWindow during SDL_WINDOWEVENT_HIDDEN
> blocks all subsequent display updates.
> 
> Instead of trying to override the change, just update the scon->hidden
> flag.

Has for me the side effect that sometimes I have to press ctrl-alt-2
twice.  Showing window first time works.  Hiding the window works too.
Showing it the second time needs the double keypress.

Added fprintfs to figure why [1].  Reason for that seems to be a suspious
SDL_WINDOWEVENT_SHOWN event from SDL, so qemu thinks the window is
visible even though it actually is hidden.

Have a slightly older SDL version (2.0.3).  Do you see that effect with
2.0.6 too?

cheers,
  Gerd

https://www.kraxel.org/cgit/qemu/commit/?h=testing/sdl&id=8235bfb66e7c82870ff1b1f47bdaaf4f522c5444
