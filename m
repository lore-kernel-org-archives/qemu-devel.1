Received: from eggs.gnu.org ([2001:4830:134:3::10]:56986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egDrA-0002fD-TM
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egDr6-0004Lc-UL
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:08:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egDr6-0004LD-Nq
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:08:32 -0500
Date: Mon, 29 Jan 2018 19:08:30 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180129180830.tinzwowiarfolyfr@sirius.home.kraxel.org>
References: <20180117145029.28736-1-tournier.elie@gmail.com>
	<20180129161155.GA25994@Nikki.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129161155.GA25994@Nikki.localdomain>
Subject: Re: [Qemu-devel] [RFC 0/2] Use SDL to create an OpenGL ES context
 for virglrenderer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elie Tournier <tournier.elie@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

  Hi,

> > In order to use this feature, we need to create a gles context.
> > This series add an option (`-display sdl,gles=on`) in the SDL display to create that context.
> 
> Humble ping.
> I didn't get any comment on this series.

Well, display configuration is going to be rewritten, and while that is
in flight adding new config options isn't a good idea b/c things will
conflict ...

Beside that:  Is a new config option actually needed in the first place?

Ideally qemu (or sdl) would figure on its own that a full core context
isn't available and try fallback to gles then.

cheers,
  Gerd
