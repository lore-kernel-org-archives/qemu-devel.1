Received: from eggs.gnu.org ([2001:4830:134:3::10]:49805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFEGh-0006Xv-WC
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFEGc-0000WA-Eh
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:07:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFEGc-0000UK-5f
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:07:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9288628
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 07:07:16 +0000 (UTC)
Date: Thu, 16 Nov 2017 08:07:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171116070713.resbxe7c3gkz53o7@sirius.home.kraxel.org>
References: <20171115121932.x4oh4aok5j5x6kxr@sirius.home.kraxel.org>
	<20171116000853.GA14771@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171116000853.GA14771@lemon>
Subject: Re: [Qemu-devel] building user interfaces as modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Nov 16, 2017 at 08:08:53AM +0800, Fam Zheng wrote:
> On Wed, 11/15 13:19, Gerd Hoffmann wrote:
> > 
> > For SDL we already have sdl.mo defined in ui/Makefile.objs. so I tried
> > that first.  Just flipping CONFIG_SDL from 'y' to 'm' doesn't work
> > though.  sdl support isn't build, neither with nor without
> > --enable-modules.
> 
> Perhaps you're missing a
> 
>     common-obj-m += ui/
> 
> line in Makefile?

Adding that helps indeed.

thanks,
  Gerd
