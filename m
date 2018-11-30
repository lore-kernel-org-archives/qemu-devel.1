Received: from eggs.gnu.org ([2001:4830:134:3::10]:41476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSgxt-0006OH-OR
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSgxp-0006DH-VQ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:28:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gSgxp-0006Cd-OA
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:28:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27ECA70D6E
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 11:28:04 +0000 (UTC)
Date: Fri, 30 Nov 2018 12:28:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181130112802.tbessg2nohhccgif@sirius.home.kraxel.org>
References: <20181129123502.30129-1-kraxel@redhat.com>
	<b647b71a-ac53-f256-3e16-efa4806b4f7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b647b71a-ac53-f256-3e16-efa4806b4f7d@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-devel for-3.1?] [PATCH] egl-headless: add
 egl_create_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Nov 29, 2018 at 08:09:56AM -0600, Eric Blake wrote:
> On 11/29/18 6:35 AM, Gerd Hoffmann wrote:
> > We must set the correct context (via eglMakeCurrent) before
> > calling qemu_egl_create_context, so we need a thin wrapper and can't
> > hook qemu_egl_create_context directly as ->dpy_gl_ctx_create callback.
> > 
> > Reported-by: Frederik Carlier <frederik.carlier@quamotion.mobi>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   ui/egl-headless.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> How severe is this? Is it something that would warrant 3.1-rc4, or are we
> safe deferring it to 4.0?

Fixes segfaults (should probably update the commit message to say so),
therefore 3.1 material IMHO.

cheers,
  Gerd
