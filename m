Received: from eggs.gnu.org ([2001:4830:134:3::10]:46843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gUR1n-0007KZ-9s
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 01:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gUR1i-0000Xu-8k
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 01:51:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gUR1i-0000R6-1h
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 01:51:18 -0500
Date: Wed, 5 Dec 2018 07:51:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181205065114.o77qsagqxu5w34ry@sirius.home.kraxel.org>
References: <20181201123056.432-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201123056.432-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [RFC 0/5] ui/cocoa: Use OSX's main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>

  Hi,

> NB: the code to asynchronously run code blocks on the
> main thread uses dispatch_get_main_queue(), which is a
> 10.10-or-later function. If we're going to go with this
> refactoring I think the benefit in clarity-of-code is a
> worthwhile gain for dropping support for ancient OSX versions.
> 
> Patchset structure:
>  * patch 1 does the "make sure we have the iothread lock for
>    calls into QEMU" (which is effectively a no-op initially
>    since we'll already be holding that lock when our refresh
>    etc callbacks are called)
>  * patch 2 makes switchSurface directly take the pixman image
>    (which is refcounted) rather than the DisplaySurface (which
>    is not), so we can make the calls to it asynchronous later
>  * patches 3 and 4 are just trivial code motion
>  * patch 5 does the bulk of the work (and can't really be split
>    further without the UI being broken at the intermediate point)

DisplaySurface / pixman changes look sane to me.
Can't really comment on the cocoa changes.

cheers,
  Gerd
